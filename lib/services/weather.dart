import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = "e3de2979df0f2e236af07281338521fd";
const openWeatherUrl = "http://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = "$openWeatherUrl?q=$cityName&lang=en&appid=$apiKey&units=metric";
    NetWorkHelper netWorkHelper2 = NetWorkHelper(url);
    var weatherData = await netWorkHelper2.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetWorkHelper netWorkHelper = NetWorkHelper(
        "$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&lang=en&appid=$apiKey&units=metric");
    var weatherData = await netWorkHelper.getData();

    return weatherData;
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
