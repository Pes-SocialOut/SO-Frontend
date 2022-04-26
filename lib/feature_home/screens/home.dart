import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/widgets/map_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SocialOut',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).colorScheme.background,
              )),
          elevation: 1,
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
              icon: const Icon(
                Icons.account_circle_sharp,
                color: Colors.black,
              ),
              onPressed: () {}),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Search your near events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              MapButton()
            ],
          ),
        ));
  }
}
