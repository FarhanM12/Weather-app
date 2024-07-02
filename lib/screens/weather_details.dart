import 'package:flutter/material.dart';
import '../utils/constants.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final int humidity;
  final double windSpeed;
  final VoidCallback onRefresh;

  WeatherDetailsScreen({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
    required this.humidity,
    required this.windSpeed,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Details',
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
      body: Container(
        color: kDarkGrayColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: kDarkGrayColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cityName,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: kTealColor,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh, color: kTealColor),
                          onPressed: onRefresh,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${temperature.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: kTealColor,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      weatherCondition,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: kTealColor,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Divider(color: kTealColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.water_drop, color: kTealColor),
                            SizedBox(height: 5.0),
                            Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kTealColor,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '$humidity%',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: kTealColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.air, color: kTealColor),
                            SizedBox(height: 5.0),
                            Text(
                              'Wind Speed',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kTealColor,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '${windSpeed.toStringAsFixed(1)} m/s',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: kTealColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
