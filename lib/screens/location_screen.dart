import 'package:flutter/material.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/services/weather.dart';
import '/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/services/location.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weathericon = '';
  String cityname = '';
  String msg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateui(widget.locationWeather);
  }

  void updateui(dynamic weatherData) {
    double temp2;
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weathericon = 'Error';
        msg = 'Unable to get weather data';
        cityname = '';
        
        return;
      }
      else
      {
var condition = weatherData['weather'][0]['id'];
      temp2 = weatherData['main']['temp'];
      cityname = weatherData['name'];
      temperature = temp2.toInt();
      weathericon = weather.getWeatherIcon(condition);
      msg = weather.getMessage(temperature);
      }  
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateui(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typed = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typed != null) {
                        print(typed);
                        var weatherdata = await weather.getCityWeather(typed);
                        updateui(weatherdata);
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
                      '$temperature C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  " $msg  in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  //  int condition = decoded['weather'][0]['id'];
  //   double temperature = decoded['main']['temp'];
  //   String cityname = decoded['name'];