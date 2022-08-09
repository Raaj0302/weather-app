import 'package:weather/screens/location.dart';
import 'package:weather/screens/networking.dart';
import 'networking.dart';

const apiid = 'f66747dc1b0dc2afd3bea20e5ba5a628';
const mapurl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  double latitude = 0.0;
  double longitude = 0.0;
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getlocation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper helper = NetworkHelper(
        '$mapurl?lat=$latitude&lon=$longitude&appid=$apiid&units=metric');

    var decoded = await helper.getData();
    return decoded;
  }

  Future<dynamic> getCityWeather(String cityname) async {
    NetworkHelper helper = NetworkHelper('$mapurl?q=$cityname&appid=$apiid&units=metric');
      var decoded = await helper.getData();
    return decoded;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
