// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';

class ConfirmationMessage extends StatefulWidget {
  final String image;
  const ConfirmationMessage({Key? key, required this.image}) : super(key: key);

  @override
  State<ConfirmationMessage> createState() => _ConfirmationMessageState();
}

class _ConfirmationMessageState extends State<ConfirmationMessage> {
  APICalls api = APICalls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Text('Congratulations'.tr() + ' 🎉',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            const SizedBox(height: 20),
            Text('createdeventsuccessfully',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 18))
                .tr(),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: FittedBox(
                  child: Image.network(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Sharefriends', style: TextStyle(fontWeight: FontWeight.w500))
                .tr()
          ])),
    );
  }
}
