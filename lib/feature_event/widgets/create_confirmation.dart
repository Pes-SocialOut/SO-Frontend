import 'package:flutter/material.dart';

class ConfirmationMessage extends StatefulWidget {
  const ConfirmationMessage({ Key? key }) : super(key: key);

  @override
  State<ConfirmationMessage> createState() => _ConfirmationMessageState();
}

class _ConfirmationMessageState extends State<ConfirmationMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Congratulations! 🎉', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height:20),
            const Text('You created the event successfully', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 18)),
            const SizedBox(height:20),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              height: MediaQuery.of(context).size.height/3,
              child: const Center(
                child: Text('Foto')
              )
            ),
            const SizedBox(height:20),
            const Text('Share it with your friends!', style: TextStyle(fontWeight: FontWeight.w500))
          ]
        )
      ),
    );
  }
}