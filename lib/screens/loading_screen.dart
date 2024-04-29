import 'package:basic_weather_app/screens/locatoin_screen.dart';
import 'package:basic_weather_app/services/location.dart';
import 'package:basic_weather_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String apiKey = '852efc50594b42b7713e94681e4a314b';
Location myLocation = Location();

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocation(context);
    super.initState();
  }

  void getLocation(context) async {
    await myLocation.getCurrentLocation();
    NetworkingHelper netWorkingHelper = NetworkingHelper(
        url:
            'https://samples.openweathermap.org/data/2.5/weather?lat=${myLocation.latidude}&lon=${myLocation.longitude}&appid=$apiKey&units=imperial');
    var weatherData = await netWorkingHelper.getData();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitFadingCircle(
      size: 50,
      color: Colors.white,
    );

    return Scaffold(
      body: spinkit,
    );
  }
}
