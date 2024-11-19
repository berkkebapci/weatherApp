import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
      child: Column(
        children: [
          BasicTextField(
            hint: "İl Giriniz",
            hintColor: UIColor.white,
            labelColor: UIColor.white,
            controller: controller.searchController,
            onSubmitted: (p0) async {
              p0?.length != "" ? await controller.fetchWeather(p0 ?? "") : null;
            },
            onChanged: (p0) {
              p0?.length == 0 ? controller.fetchWeatherByLocation() : null;
            },
            suffixIcon: GestureDetector(
              onTap: () async {
                if (controller.searchController.text.isNotEmpty) {
                  controller.searchController.clear();
                  await controller.fetchWeatherByLocation();
                }
              },
              child: Icon(
                Icons.close,
                color: UIColor.white,
              ),
            ),
          ),
          Obx(() {
            final weather = controller.weatherData.value;
            if (weather == null) {
              return TextBasic(text: "Hava durumu bilgisi yok");
            }
            return controller.isBusy.value
                ? Center(child: WidgetActivityIndicator())
                : Column(
                    children: [
                      TextBasic(
                        text: "${weather.name}",
                        fontSize: 24,
                        color: UIColor.white,
                        fontWeight: FontWeight.w500,
                      ),
                      TextBasic(
                        text: "${weather.main.temp.toStringAsFixed(0)}°",
                        fontSize: 52,
                        color: UIColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                      TextBasic(
                        text: "${weather.weather[0].description[0].toUpperCase()}${weather.weather[0].description.substring(1)}",
                        color: UIColor.white,
                        fontSize: 18,
                      ),
                    ],
                  );
          }),
        ],
      ),
    );
  }
}
