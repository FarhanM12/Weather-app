import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final Function(String) onSearch;

  SearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: kDarkGrayColor,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.teal),
            onPressed: () {
              final city = _controller.text;
              if (city.isNotEmpty) {
                onSearch(city);
              }
            },
          ),
        ],
      ),
    );
  }
}
