import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class ShareMenuFriend extends StatefulWidget {
  final String url;
  const ShareMenuFriend({Key? key, required this.url}) : super(key: key);

  @override
  State<ShareMenuFriend> createState() => _ShareMenuState();
}

class _ShareMenuState extends State<ShareMenuFriend> {
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
            Text('Add your friend via',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary)),
            const SizedBox(height: 20),
            QrImage(
              data: widget.url,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.height / 4.5,
            ),
            const SizedBox(height: 20),
            Text('or',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 20),
            TextButton(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  SnackBar snackBar = SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    content: Text('Copied link to clipboard!',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background)),
                  );
                  Clipboard.setData(ClipboardData(
                    text: widget.url,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                },
                child: const Text('COPY TO CLIPBOARD'))
          ],
        ));
  }
}
