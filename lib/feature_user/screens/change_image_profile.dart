import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/screens/select_image_profile.dart';
import 'package:so_frontend/feature_user/services/externalService.dart';

class PerfilImage extends StatefulWidget {
  final String idUser;
  const PerfilImage({Key? key, required this.idUser}) : super(key: key);

  @override
  PerfilImageState createState() => PerfilImageState();
}

class PerfilImageState extends State<PerfilImage> {
  final ExternServicePhoto es = ExternServicePhoto();
  // ignore: non_constant_identifier_names
  List Imagenes = [];

  Future<void> getAllImages() async {
    final response = await es.getAllPhotos();
    final data = json.decode(response.body);
    List aux = [];
    data.forEach((map) => print(map['nom'].toString()));
    data.forEach((map) => aux.add(map['foto']));
    print(data);
    setState(() {
      Imagenes = aux;
    });
    print(Imagenes);
  }

  @override
  void initState() {
    super.initState();
    getAllImages();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.idUser);
    print(Imagenes);
    print("CANTIDAD DE IMAGENES: " + Imagenes.length.toString());
    if (Imagenes.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile Image',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface, fontSize: 16)),
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            iconSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImagePage(
                            url: Imagenes[index], idUser: widget.idUser)));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Image.network(
                      Imagenes[index],
                      fit: BoxFit.cover,
                    ),
                  )),
              itemCount: Imagenes.length,
            )),
      );
    }
  }
}
