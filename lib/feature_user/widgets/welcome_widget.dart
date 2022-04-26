import 'package:flutter/material.dart';
import 'package:so_frontend/utils/theme.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/map_screen');
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: FittedBox(
                child: Image.asset('assets/frontpage/frontpage_1_small.png'), 
                fit: BoxFit.fill
              ),
              
            )
          )
        )
      ),
    );
  }
}