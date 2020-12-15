import 'package:clima/myweather.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:math' as math;

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  var locationWeather;

  LocationScreen(this.locationWeather);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  var myTemp;
  String weatherIcon;
  String cityName;
  String message;

  @override
  void initState() {
    super.initState();
    // mytemp = getmytemp(widget.locationWeather);
    updateUi(widget.locationWeather);
  }

  void updateUi(var weatherData) {
    setState(() {
      if (weatherData == null) {
        myTemp = 0;
        weatherIcon = "error";
        message = "";
        cityName = "cant find the weather";
        return;
      }
      myTemp = weatherData.main.temp.ceil();
      int condition = weatherData.weather[0].id;
      cityName = weatherData.name;
      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(myTemp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherdata = await weatherModel.getLocationWeather();
                        updateUi(weatherdata);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: ()async {
                        var typedName =await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));
                        if(typedName!=null) {
                          var cityWeather =await weatherModel.getCityWeather(typedName);
                          updateUi(cityWeather);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$myTemp°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0,left: 15.0,top: 30.0),
                  child: Text(
                    "$message in $cityName",
                    textAlign: TextAlign.left,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
