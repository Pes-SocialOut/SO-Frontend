import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/screens/map.dart';

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
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen())
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width/1.2,
                  height: MediaQuery.of(context).size.height/4,
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadius.all(Radius.circular(20))
                    
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.asset('assets/map_preview.png'),
                    
                  )
                )
              )
            ),
          ),
        ],
      )
    );
  }
}