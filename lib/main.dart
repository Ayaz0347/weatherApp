import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/const/images.dart';
import 'package:weatherapp/current_weather_model.dart';
import 'package:weatherapp/hourly_weather_model.dart';
import 'package:weatherapp/out_themes.dart';
import 'const/colors.dart';
import 'const/strings.dart';
import 'package:velocity_x/velocity_x.dart';
import 'controllers/main_controller.dart';
import 'package:intl/intl.dart';

main() => runApp(const MyApp());

var controller = Get.put(MainController());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WeatherApp(),
      title: "Weather App",
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var date = DateTime.now();
    var theme = Theme.of(context);
    var date = DateFormat.yMMMMd('en_US').format(DateTime.now());
    var controller = Get.put(MainController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: date.text.color(theme.primaryColor).xl.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                // Get.changeThemeMode(ThemeMode.dark);
                controller.changeTheme();
              },
              icon: Icon(
                  controller.isDark.value ? Icons.light_mode : Icons.dark_mode),
              color: theme.iconTheme.color,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              color: theme.iconTheme.color),
        ],
      ),
      body: FutureBuilder(
        future: controller.currentWeatherData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print('-----------------------------------------------');
            CurrentWeatherData data = snapshot.data;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${data.name}"
                        .toUpperCase()
                        .text
                        .xl3
                        .color(theme.primaryColor)
                        .fontFamily("Poppins-Bold")
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/weather/${data.weather![0].icon}.png",
                          width: 80,
                          height: 80,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "${data.main!.temp}$degree",
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 64,
                                fontFamily: "Poppins",
                              ),
                            ),
                            TextSpan(
                              text: "${data.weather![0].main}",
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 14,
                                letterSpacing: 3,
                                fontFamily: "Poppins-Light",
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.expand_less_rounded,
                              color: theme.primaryColor,
                            ),
                            label: "${data.main!.tempMin}$degree"
                                .text
                                .color(theme.primaryColor)
                                .make()),
                        TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.expand_more_rounded,
                              color: theme.primaryColor,
                            ),
                            label: "${data.main!.tempMax}$degree"
                                .text
                                .color(
                                  theme.primaryColor,
                                )
                                .make()),
                      ],
                    ),
                    10.heightBox,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(3, (index) {
                          var iconList = [clouds, humidity, windSpeed];
                          var values = [
                            "${data.clouds!.all}%",
                            "${data.main!.humidity}%",
                            "${data.wind!.speed} km/h"
                          ];
                          return Column(
                            children: [
                              Image.asset(
                                iconList[index],
                                height: 80,
                                width: 80,
                              )
                                  .box
                                  .color(Vx.gray200)
                                  .padding(const EdgeInsets.all(8))
                                  .roundedSM
                                  .make(),
                              10.heightBox,
                              values[index].text.gray400.make(),
                            ],
                          );
                        })),
                    const Divider(),
                    10.heightBox,
                    FutureBuilder(
                        future: controller.hourlyWeatherData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            print("-==========================================-");
                            HourlyWeatherData hourlyData = snapshot.data;
                            print("-==========================================-");
                            return SizedBox(
                              height: 160,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: hourlyData.list!.length > 6
                                      ? 6
                                      : hourlyData.list!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var time = DateFormat().add_jm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            hourlyData.list![index].dt!
                                                    .toInt() *
                                                1000));
                                    return Container(
                                      margin: const EdgeInsets.only(right: 2),
                                      decoration: BoxDecoration(
                                        color: cardColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          "${time}".text.bold.gray100.make(),
                                          Image.asset(
                                            "assets/weather/${hourlyData.list![index].weather![0].icon}.png",
                                            height: 80,
                                            width: 80,
                                          ),
                                          "${hourlyData.list![index].main!.temp}$degree"
                                              .text
                                              .bold
                                              .color(
                                                theme.primaryColor,
                                              )
                                              .white
                                              .make(),
                                        ],
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Next 7 Days"
                            .text
                            .color(
                              theme.primaryColor,
                            )
                            .semiBold
                            .size(16)
                            .make(),
                        TextButton(
                            onPressed: () {}, child: "View All".text.make()),
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          var day = DateFormat("EEEE").format(
                              DateTime.now().add(Duration(days: index + 1)));
                          return Card(
                            color: theme.cardColor,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: day.text
                                        .color(
                                          theme.primaryColor,
                                        )
                                        .make(),
                                  ),
                                  Expanded(
                                    child: TextButton.icon(
                                        onPressed: null,
                                        icon: Image.asset(
                                          "assets/icons/moon.png",
                                          width: 40,
                                        ),
                                        label: "21$degree"
                                            .text
                                            .color(
                                              theme.primaryColor,
                                            )
                                            .make()),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "37$degree /",
                                          style: TextStyle(
                                            color: Vx.gray800,
                                            fontFamily: "poppins",
                                            fontSize: 16,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "26$degree ",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            fontFamily: "poppins",
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
