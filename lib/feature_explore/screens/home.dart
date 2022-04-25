import 'package:flutter/material.dart';
import 'package:so_frontend/feature_explore/widgets/map_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}