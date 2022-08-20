// To parse this JSON data, do
//
//     final currentWeatherData = currentWeatherDataFromJson(jsonString);

import 'dart:convert';

CurrentWeatherData currentWeatherDataFromJson(String str) =>
    CurrentWeatherData.fromJson(json.decode(str));

class CurrentWeatherData {
  CurrentWeatherData({
    this.weather,
    this.main,
    this.wind,
    this.clouds,
    this.dt,
    this.name,
  });

  List<Weather>? weather;
  Main? main;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  String? name;

  factory CurrentWeatherData.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherData(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        name: json["name"],
      );

}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}


class Main {
  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  double? temp;
  double? tempMin;
  double? tempMax;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}


class Weather {
  Weather({
    this.main,
    this.icon,
  });

  String? main;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
        icon: json["icon"],
      );
}

class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  double? speed;
  int? deg;
  double? gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        gust: json["gust"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}
