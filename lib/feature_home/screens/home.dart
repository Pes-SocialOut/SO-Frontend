import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/widgets/map_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SocialOut', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.lightBlueAccent,
          backgroundColor: Colors.white,
        )),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Search your near events',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            MapButton()
          ],
        ),
      )
    );
  }
}