import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/widgets/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const MapWidget(),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  right: 8,
                  left: 8,
                  bottom: 8
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                width: 44,
                height: 44,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_left_outlined,
                    size: 33
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ),
            ],
          )
        ]
      )
    );
  }
}