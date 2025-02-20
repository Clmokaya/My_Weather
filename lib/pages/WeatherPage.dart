import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:my_weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
//api key
  final _weatherService = WeatherService('426ab5e9be8c744f8d4dd8476d581219');
  Weather? _weather;

//fetch weather
  _fetchWeather() async {
//get the current city
    String cityName = await _weatherService.getCurrentCity();

//get weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

//weather animations
  String getWeatherAnimations(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loading city.."),
            //animation
            Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),
            //temperature
            Text('${_weather?.temperature.round().toString()}+°C'),
            //weather condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
