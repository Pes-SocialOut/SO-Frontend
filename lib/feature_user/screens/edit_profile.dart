import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';

class EditarProfile extends StatefulWidget {
  const EditarProfile({Key? key}) : super(key: key);

  @override
  State<EditarProfile> createState() => _EditarProfileState();
}

class _EditarProfileState extends State<EditarProfile> {
  final formKey = GlobalKey<FormState>();
  late String username;
  late String description;
  late String hobbies;
  List<dynamic> idiomas = [];
  bool colorInit = false;
  bool colorInit2 = false;
  bool colorInit3 = false;
  Color primary = Colors.white;
  Color secundary = Colors.black;
  Color primary2 = Colors.white;
  Color secundary2 = Colors.black;
  Color primary3 = Colors.white;
  Color secundary3 = Colors.black;
  Map user = {};
  String idProfile = "0";
  APICalls ac = APICalls();

  String getCurrentUser() {
    return ac.getCurrentUser();
  }

  Future<int> updateUser(Map<String, dynamic> body) async {
    final response =
        await ac.putItem('/v1/users/:0', [ac.getCurrentUser()], body);
    return response.statusCode;
  }

  Future<void> getUser() async {
    final response = await ac.getItem("/v2/users/:0", [idProfile]);
    setState(() {
      user = json.decode(response.body);
      idiomas = user["languages"];
      username = user["username"];
      description = user["description"];
      hobbies = user["hobbies"];
    });
  }

  @override
  void initState() {
    super.initState();
    idProfile = getCurrentUser();
    getUser();
  }

  Widget builWidgetText(String labelText2, String placeHolder) {
    return TextFormField(
      initialValue: placeHolder,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 30),
        labelText: labelText2,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(29),
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some ' + labelText2;
        }
        return null;
      },
      onSaved: (value) {
        if (labelText2 == "Username") {
          setState(() {
            username = value.toString();
          });
        } else if (labelText2 == "description") {
          setState(() {
            description = value.toString();
          });
        } else if (labelText2 == "hobbies") {
          setState(() {
            hobbies = value.toString();
          });
        }
      },
    );
  }

  Widget _buildLanguages() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "preferred languages",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 112, 108, 108)),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: colorInit
                        ? Theme.of(context).colorScheme.primary
                        : primary,
                    onPrimary: colorInit
                        ? Theme.of(context).colorScheme.onPrimary
                        : secundary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(100, 50)),
                onPressed: () {
                  colorInit = !colorInit;
                  if (!colorInit) {
                    idiomas.remove("spanish");
                  } else {
                    idiomas.add("spanish");
                  }
                  setState(() {
                    primary = nuevoColor(colorInit, "primary");
                    secundary = nuevoColor(colorInit, "secondary");
                  });
                },
                child: const Text(
                  "spanish",
                  style: TextStyle(
                      height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: colorInit2
                        ? Theme.of(context).colorScheme.primary
                        : primary2,
                    onPrimary: colorInit2
                        ? Theme.of(context).colorScheme.onPrimary
                        : secundary2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(100, 50)),
                onPressed: () {
                  colorInit2 = !colorInit2;
                  if (!colorInit2) {
                    idiomas.remove("english");
                  } else {
                    idiomas.add("english");
                  }
                  setState(() {
                    primary2 = nuevoColor(colorInit2, "primary");
                    secundary2 = nuevoColor(colorInit2, "secondary");
                  });
                },
                child: const Text(
                  "english",
                  style: TextStyle(
                      height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: colorInit3
                        ? Theme.of(context).colorScheme.primary
                        : primary3,
                    onPrimary: colorInit3
                        ? Theme.of(context).colorScheme.onPrimary
                        : secundary3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(100, 50)),
                onPressed: () {
                  colorInit3 = !colorInit3;
                  if (!colorInit3) {
                    idiomas.remove("catalan");
                  } else {
                    idiomas.add("catalan");
                  }
                  setState(() {
                    primary3 = nuevoColor(colorInit3, "primary");
                    secundary3 = nuevoColor(colorInit3, "secondary");
                  });
                },
                child: const Text(
                  "catalan",
                  style: TextStyle(
                      height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color nuevoColor(initColor, String priority) {
    Color colorRetorno;
    if (priority == "primary") {
      if (!initColor) {
        colorRetorno = Colors.white;
      } else {
        colorRetorno = Theme.of(context).colorScheme.primary;
      }
    } else {
      if (!initColor) {
        colorRetorno = Colors.black;
      } else {
        colorRetorno = Theme.of(context).colorScheme.onPrimary;
      }
    }
    return colorRetorno;
  }

  SnackBar mensajeMuestra(String mensaje) {
    return SnackBar(
      content: Text(mensaje),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user.isEmpty) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      if (idiomas.contains("spanish")) {
        colorInit = true;
      }
      if (idiomas.contains("english")) {
        colorInit2 = true;
      }
      if (idiomas.contains("catalan")) {
        colorInit3 = true;
      }
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("edit profile",
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
        body: Padding(
          padding:
              const EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 15),
                Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 4.0,
                            style: BorderStyle.solid,
                          ),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.6),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/dog.jpg'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          iconSize: 24,
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          ),
                          onPressed: () {
                            // editar foto de perfil
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                builWidgetText("Username", username),
                const SizedBox(height: 15),
                builWidgetText("description", description),
                const SizedBox(height: 15),
                builWidgetText("hobbies", hobbies),
                const SizedBox(height: 15),
                _buildLanguages(),
                const SizedBox(height: 55),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.secondary,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(200, 40),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            Map<String, dynamic> bodyAux = {
                              "username": username,
                              "languages": idiomas,
                              "description": description,
                              "hobbies": hobbies
                            };
                            var ap = await updateUser(bodyAux);
                            if (ap == 200) {
                              getUser();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(mensajeMuestra("updated data"));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  mensajeMuestra(
                                      "update error, some language is needed"));
                            }
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              height: 1.0,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
