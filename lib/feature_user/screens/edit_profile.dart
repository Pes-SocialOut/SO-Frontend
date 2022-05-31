// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_navigation/screens/profile.dart';
import 'package:so_frontend/feature_user/screens/change_image_profile.dart';
import 'package:so_frontend/feature_user/services/externalService.dart';
import 'package:so_frontend/utils/api_controller.dart';

//import '../services/sharedPreferencesHelper.dart';

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
  late String idUsuar;
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
  String urlProfilePhoto = "";
  APICalls ac = APICalls();
  final ExternServicePhoto es = ExternServicePhoto();

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
      idUsuar = user["id"];
    });
    getProfilePhoto(idUsuar);
    print(json.decode(response.body));
  }

  Future<void> getProfilePhoto(String idUsuar) async {
    final response = await es.getAPhoto(idUsuar);
    if (response != 'Fail') {
      print("ENTRO A FAIL");
      setState(() {
        urlProfilePhoto = response;
      });
    }
    print(response);
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
          return 'pleaseEnter'.tr() + labelText2;
        }
        return null;
      },
      onSaved: (value) {
        if (labelText2 == "Username".tr()) {
          setState(() {
            username = value.toString();
          });
        } else if (labelText2 == "Description".tr()) {
          setState(() {
            description = value.toString();
          });
        } else if (labelText2 == "hobbies".tr()) {
          setState(() {
            hobbies = value.toString();
          });
        }
      },
    );
  }

  Widget _buildLanguages() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary:
                    colorInit ? Theme.of(context).colorScheme.primary : primary,
                onPrimary: colorInit
                    ? Theme.of(context).colorScheme.onPrimary
                    : secundary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(80, 50)),
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
            child: Text(
              "Spanish",
              style: TextStyle(
                  height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
            ).tr(),
          ),
          const SizedBox(width: 5),
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
                minimumSize: const Size(80, 50)),
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
            child: Text(
              "English",
              style: TextStyle(
                  height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
            ).tr(),
          ),
          const SizedBox(width: 5),
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
                minimumSize: const Size(80, 50)),
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
            child: Text(
              "Catalan",
              style: TextStyle(
                  height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
            ).tr(),
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
          title: Text("editprofile",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 16))
              .tr(),
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (urlProfilePhoto == "")
                                ? AssetImage('assets/noProfileImage.png')
                                : NetworkImage(urlProfilePhoto)
                                    as ImageProvider,
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
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PerfilImage(idUser: idUsuar)));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                builWidgetText("Username".tr(), username),
                const SizedBox(height: 15),
                builWidgetText("Description".tr(), description),
                const SizedBox(height: 15),
                builWidgetText("hobbies".tr(), hobbies),
                const SizedBox(height: 15),
                Text(
                  "preferredlanguages",
                  textAlign: TextAlign.center,
                ).tr(),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  mensajeMuestra("updateddata".tr()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  mensajeMuestra("updateerror".tr()));
                            }
                          }
                        },
                        child: Text(
                          'Update'.tr(),
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
