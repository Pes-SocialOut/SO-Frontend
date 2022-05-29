// ignore_for_file: file_names, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';

class FormRegisterCS extends StatefulWidget {
  final String accessToken;
  final String type;
  const FormRegisterCS(this.accessToken, this.type, {Key? key})
      : super(key: key);
  @override
  _FormRegisterCSState createState() => _FormRegisterCSState();
}

class _FormRegisterCSState extends State<FormRegisterCS> {
  final formKey = GlobalKey<FormState>();
  final userAPI uapi = userAPI();
  late String accessToken = widget.accessToken;
  late String username;
  late String description;
  late String hobbies;
  late String verification;
  bool incorrectCode = false;
  List<String> idiomas = [];
  bool colorInit = true;
  bool colorInit2 = true;
  bool colorInit3 = true;
  Color primary = Colors.white;
  Color secundary = Colors.black;
  Color primary2 = Colors.white;
  Color secundary2 = Colors.black;
  Color primary3 = Colors.white;
  Color secundary3 = Colors.black;

  Widget _buildUsername() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Username".tr(),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'enterUsername'.tr();
        }
        return null;
      },
      onSaved: (value) {
        username = value.toString();
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Description".tr(),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'enterDescription'.tr();
        }
        return null;
      },
      onSaved: (value) {
        description = value.toString();
      },
    );
  }

  SnackBar mensajeMuestra(String mensaje) {
    return SnackBar(
      content: Text(mensaje),
    );
  }

  Widget _buildLanguages() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 260,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primary,
                  onPrimary: secundary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(80, 50)),
              onPressed: () {
                colorInit = !colorInit;
                if (!colorInit) {
                  idiomas.add("spanish");
                } else {
                  idiomas.remove("spanish");
                }
                setState(() {
                  primary = nuevoColor(colorInit, "primary");
                  secundary = nuevoColor(colorInit, "secondary");
                });
              },
              child: Text(
                "Spanish".tr(),
                style: const TextStyle(
                    height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primary2,
                  onPrimary: secundary2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(80, 50)),
              onPressed: () {
                colorInit2 = !colorInit2;
                if (!colorInit2) {
                  idiomas.add("english");
                } else {
                  idiomas.remove("english");
                }
                setState(() {
                  primary2 = nuevoColor(colorInit2, "primary");
                  secundary2 = nuevoColor(colorInit2, "secondary");
                });
              },
              child: Text(
                "English".tr(),
                style: const TextStyle(
                    height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primary3,
                  onPrimary: secundary3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(80, 50)),
              onPressed: () {
                colorInit3 = !colorInit3;
                if (!colorInit3) {
                  idiomas.add("catalan");
                } else {
                  idiomas.remove("catalan");
                }
                setState(() {
                  primary3 = nuevoColor(colorInit3, "primary");
                  secundary3 = nuevoColor(colorInit3, "secondary");
                });
              },
              child: Text(
                "Catalan".tr(),
                style: const TextStyle(
                    height: 1.0, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color nuevoColor(initColor, String priority) {
    Color colorRetorno;
    if (priority == "primary") {
      if (initColor) {
        colorRetorno = Colors.white;
      } else {
        colorRetorno = Theme.of(context).colorScheme.primary;
      }
    } else {
      if (initColor) {
        colorRetorno = Colors.black;
      } else {
        colorRetorno = Theme.of(context).colorScheme.onPrimary;
      }
    }
    return colorRetorno;
  }

  Widget _buildHobbies() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "hobbies".tr(),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'enterhobbie'.tr();
        }
        return null;
      },
      onSaved: (value) {
        hobbies = value.toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Userregister").tr(),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 25),
                _buildUsername(),
                const SizedBox(height: 15),
                _buildDescription(),
                const SizedBox(height: 15),
                _buildHobbies(),
                const SizedBox(height: 15),
                Text(
                  "preferredlanguages".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 112, 108, 108)),
                ),
                const SizedBox(height: 5),
                _buildLanguages(),
                const SizedBox(height: 20),

                // Button submit
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(250, 50)),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        int ap = 0;
                        if (widget.type == "google") {
                          ap = await uapi.finalRegistrerGoogle(accessToken,
                              username, description, idiomas, hobbies);
                        } else if (widget.type == "facebook") {
                          ap = await uapi.finalRegistrerFacebook(accessToken,
                              username, description, idiomas, hobbies);
                        }
                        if (ap == 200) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (route) => false);
                        }
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ).tr(),
                  ),
                ),

                //button cancelar
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0x00c8c8c8),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(150, 50)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: Text("cancelsubscription").tr(),
                          content: Text("cancelSubscr").tr(),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed('/welcome'),
                                child: Text("Ok").tr()),
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Cancel").tr()),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ).tr(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
