import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/controller_home.dart';
import 'package:weather_app/shared/uicolor.dart';
import 'package:weather_app/widgets/widget_activity_indicator.dart';
import 'package:weather_app/widgets/widget_text.dart';
import 'package:weather_app/widgets/widget_textfield.dart';

class ViewHome extends StatelessWidget {
  final ControllerHome controller = Get.put(ControllerHome());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(backgroundColor: Colors.blue, body: getBody()));
  }

  Widget getBody() {
    return Obx(
      () => controller.isBusy.value
          ? Center(child: WidgetActivityIndicator())
          : SingleChildScrollView(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
                    child: Column(
                      children: [
                        getSearch(controller),
                        getNowWeather(controller),
                        getFiveDayForecastTitle(controller),
                      ],
                    ),
                  ),
                  getFiveDayForecast(controller),
                ],
              ),
          ),
    );
  }
}

Widget getSearch(ControllerHome controller) {
  return BasicTextField(
    hint: "Ara",
    hintColor: UIColor.white,
    labelColor: UIColor.white,
    controller: controller.searchController,
    onSubmitted: (p0) async {
      p0?.length != "" ? await controller.fetchWeather(p0 ?? "") : null;
      p0?.length != "" ? await controller.fetchForecast(p0 ?? "") : null;
    },
    onChanged: (p0) {
      p0?.length == 0 ? controller.fetchWeatherByLocation() : null;
      p0?.length == 0 ? controller.fetchForecastByLocation() : null;
    },
    suffixIcon: GestureDetector(
      onTap: () async {
        if (controller.searchController.text.isNotEmpty) {
          controller.searchController.clear();
          await controller.init();
        }
      },
      child: Icon(
        Icons.close,
        color: UIColor.white,
      ),
    ),
  );
}

Widget getNowWeather(ControllerHome controller) {
  return Obx(() {
    final weather = controller.weatherData.value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          TextBasic(
            text: "${weather?.name}",
            fontSize: 24,
            color: UIColor.white,
            fontWeight: FontWeight.w500,
          ),
          TextBasic(
            text: "${weather?.main.temp.toStringAsFixed(0)}°",
            fontSize: 52,
            color: UIColor.white,
            fontWeight: FontWeight.w700,
          ),
          TextBasic(
            text: "${weather?.weather[0].description[0].toUpperCase()}${weather?.weather[0].description.substring(1)}",
            color: UIColor.white,
            fontSize: 18,
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  });
}

Widget getFiveDayForecastTitle(ControllerHome controller) {
  return Obx(
    () => controller.forecastList.isEmpty
        ? Container()
        : Align(
            alignment: Alignment.centerLeft,
            child: TextBasic(
              text: "5 Günlük Hava Durumu",
              color: UIColor.white,
              fontSize: 18,
            )),
  );
}

Widget getFiveDayForecast(ControllerHome controller) {
  return Obx(() => SizedBox(
        height: 240,
        child: controller.isBusy.value
            ? Center(
                child: WidgetActivityIndicator(),
              )
            : ListView.builder(
                itemCount: controller.forecastList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final forecast = controller.forecastList[index];
                  return getForecastItem(forecast);
                },
              ),
      ));
}

Widget getForecastItem(forecast) {
  return Container(
    width: 160,
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Card(
      color: Colors.grey.withOpacity(.5),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextBasic(
              text: DateFormat("d MMMM", "tr").format(DateTime.parse(forecast.dt_txt)),
              color: UIColor.white,
              fontSize: 14,
            ),
            const SizedBox(height: 8),
            TextBasic(
              text: "${forecast.main.temp.toStringAsFixed(0)}°",
              fontSize: 32,
              color: UIColor.white,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 4),
            Image.network(
              "https://openweathermap.org/img/wn/${forecast.weather[0].icon}@2x.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 8),
            TextBasic(
              text: forecast.weather.isNotEmpty && forecast.weather[0].description.isNotEmpty
                  ? "${forecast.weather[0].description[0].toUpperCase()}${forecast.weather[0].description.substring(1)}"
                  : "Bilinmiyor",
              color: UIColor.white,
              fontSize: 14,
              maxLines: 2,
            ),
          ],
        ),
      ),
    ),
  );
}
