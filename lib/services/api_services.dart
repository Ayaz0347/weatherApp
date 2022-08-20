import 'package:http/http.dart' as http;
import 'package:weatherapp/const/strings.dart';
import 'package:weatherapp/current_weather_model.dart';


var link = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey";

Future getCurrentWeather() async{
  var res = await http.get(Uri.parse(link));

  if(res.statusCode == 200){
    var data = currentWeatherDataFromJson(res.body.toString());
    print("Data is received");
    return data;
  }
}
