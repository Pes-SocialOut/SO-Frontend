import 'package:flutter/material.dart';
import 'package:so_frontend/feature_explore/widgets/map_button.dart';
import 'package:so_frontend/feature_explore/widgets/recommended_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Search your near events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const MapButton(),
              const SizedBox(height: 30),
              Text('Recommended for you',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize:18, color: Theme.of(context).colorScheme.surface)
              ),
              const SizedBox(height:10),
              const RecommendedList()
            ],
          ),
      ),
    );
  }
}