// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class ShareMenu extends StatefulWidget {
  final String url;
  const ShareMenu({Key? key, required this.url}) : super(key: key);

  @override
  State<ShareMenu> createState() => _ShareMenuState();
}

class _ShareMenuState extends State<ShareMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text('Shareyoureventvia',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary))
                .tr(),
            const SizedBox(height: 20),
            QrImage(
              data: widget.url,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.height / 4.5,
            ),
            const SizedBox(height: 20),
            Text('OR',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface))
                .tr(),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary),
              onPressed: () {
                SnackBar snackBar = SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  content: Text('Copiedlinktoclipboard',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.background))
                      .tr(),
                );
                Clipboard.setData(ClipboardData(
                  text: widget.url,
                ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              },
              child: Text('COPYTOCLIPBOARD'),
            )
          ],
        ));
  }
}
