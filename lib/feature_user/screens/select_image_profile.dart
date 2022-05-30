import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/services/externalService.dart';

class ImagePage extends StatefulWidget {
  final String url;
  final String idUser;
  const ImagePage({Key? key, required this.idUser, required this.url})
      : super(key: key);

  @override
  ImagePageState createState() => ImagePageState();
}

class ImagePageState extends State<ImagePage> {
  final ExternServicePhoto es = ExternServicePhoto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView(children: <Widget>[
        const SizedBox(height: 75),
        Center(
          child: Image.network(widget.url),
        ),
        const SizedBox(height: 75),
        Container(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(250, 50),
            ),
            onPressed: () async {
              var resposta = await es.postAPhoto(widget.idUser, widget.url);
              if (resposta['resposta'] == 1) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/edit_profile', (route) => false);
                //Navigator.of(context).pushNamed('/edit_profile');
              }
            },
            child: const Text(
              "Select",
              style: TextStyle(
                  height: 1.0, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ]),
    );
  }
}
