import 'package:flutter/material.dart';
import 'package:flutter_weather/services/constants.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory weatherFactory = WeatherFactory(openWeatherKey);
  Weather? weather;

  @override
  void initState() {
    super.initState();
    weatherFactory.currentWeatherByCityName('London').then((w) {
      setState(() {
        weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: weather == null
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locationHeader(),
            dateTime(),
            weatherIcon(),
            currentTemp(),
          ],
        ),
      ),
    );
  }

  Widget locationHeader() {
    return Text(
      weather?.areaName ?? '',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget dateTime() {
    DateTime now = weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat('hh:mm').format(now),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              DateFormat('EEEE').format(now),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "  ${DateFormat('d.m.y').format(now)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://openweathermap.org/img/wn/${weather
                    ?.weatherIcon}@4x.png',),
              )
          ),
        ),
        Text(weather?.weatherDescription??'',style: const TextStyle(
          fontSize: 20,fontWeight: FontWeight.bold
        ),),
      ],
    );
  }
  Widget currentTemp(){
    return Text("${weather?.temperature?.celsius?.toStringAsFixed(0)} ℃");
  }

}
