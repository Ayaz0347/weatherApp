import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/const/images.dart';
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
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Peshawar"
                        .text
                        .xl3
                        .color(theme.primaryColor)
                        .fontFamily("Poppins-Bold")
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/icons/sunny.png",
                          width: 80,
                          height: 80,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "37$degree",
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 64,
                                fontFamily: "Poppins",
                              ),
                            ),
                            TextSpan(
                              text: "Sunny",
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
                            label: "41$degree"
                                .text
                                .color(theme.primaryColor)
                                .make()),
                        TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.expand_more_rounded,
                              color: theme.primaryColor,
                            ),
                            label: "27$degree"
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
                          var values = ["70%", "40%", "3.5 km/h"];
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
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 2),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  "${index + 1} AM".text.gray200.make(),
                                  Image.asset(
                                    "assets/icons/couldson.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                  "38$degree"
                                      .text
                                      .color(
                                        theme.primaryColor,
                                      )
                                      .white
                                      .make(),
                                ],
                              ),
                            );
                          }),
                    ),
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
