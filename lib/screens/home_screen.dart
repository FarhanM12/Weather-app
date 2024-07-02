import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/screens/weather_details.dart';
import '../widgets/search_bar.dart' as custom_widgets;
import '../utils/constants.dart';
import '../services/weather_service.dart';
import '../models/weather.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String? _lastSearchedCity;

  @override
  void initState() {
    super.initState();
    _loadLastSearchedCity();
  }

  void _loadLastSearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastSearchedCity = prefs.getString('lastSearchedCity');
    });
  }

  void _saveLastSearchedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
  }

  void _searchWeather(String city) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final WeatherService weatherService = WeatherService();
      final Weather weather = await weatherService.fetchWeather(city);
      setState(() {
        _isLoading = false;
      });
      _saveLastSearchedCity(city);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailsScreen(
            cityName: weather.cityName,
            temperature: weather.temperature,
            weatherCondition: weather.condition,
            humidity: weather.humidity,
            windSpeed: weather.windSpeed,
            onRefresh: () => _searchWeather(city),
          ),
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(
            color: kDarkGrayColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kTealColor,
        elevation: 4,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search for a City',
              style: TextStyle(
                color: kTealColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            custom_widgets.SearchBar(
              onSearch: _searchWeather,
            ),
            if (_isLoading) ...[
              SizedBox(height: 20.0),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kTealColor),
              ),
            ],
          ],
        ),
      ),
      backgroundColor: kDarkGrayColor,
    );
  }
}
