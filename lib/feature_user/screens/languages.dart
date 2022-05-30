import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguagesOptions extends StatefulWidget {
  const LanguagesOptions({Key? key}) : super(key: key);
  @override
  LanguagesOptionsState createState() => LanguagesOptionsState();
}

class LanguagesOptionsState extends State<LanguagesOptions> {
  late bool english;
  late bool catalan;
  late bool spanish;

  SnackBar mensajeMuestra(String mensaje) {
    return SnackBar(
      content: Text(mensaje),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Localizations.localeOf(context).languageCode.toString() == 'en') {
      english = true;
      catalan = false;
      spanish = false;
    } else if (Localizations.localeOf(context).languageCode.toString() ==
        'ca') {
      english = false;
      catalan = true;
      spanish = false;
    } else if (Localizations.localeOf(context).languageCode.toString() ==
        'es') {
      english = false;
      catalan = false;
      spanish = true;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Applicationlanguage',
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
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 17, 92, 153)),
        ),
        body: ListView(children: <Widget>[
          ListTile(
            style: ListTileStyle.list,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            textColor: english
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.black26,
            tileColor:
                english ? Theme.of(context).colorScheme.primary : Colors.white,
            title: const Text(
              'English',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            onTap: () => {
              context.setLocale(const Locale('en')),
              ScaffoldMessenger.of(context)
                  .showSnackBar(mensajeMuestra("updatedlanguage".tr())),
              setState(() {})
            },
            enabled: true,
            dense: true,
            selected: false,
          ),
          const SizedBox(height: 5),
          ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            textColor: spanish
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.black26,
            tileColor:
                spanish ? Theme.of(context).colorScheme.primary : Colors.white,
            title: const Text(
              'Spanish',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            onTap: () => {
              context.setLocale(const Locale('es', 'ES')),
              ScaffoldMessenger.of(context)
                  .showSnackBar(mensajeMuestra("updatedlanguage".tr())),
              setState(() {})
            },
            enabled: true,
            dense: true,
            selected: false,
          ),
          const SizedBox(height: 5),
          ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            textColor: catalan
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.black26,
            tileColor:
                catalan ? Theme.of(context).colorScheme.primary : Colors.white,
            title: const Text(
              'Catalan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            onTap: () => {
              context.setLocale(const Locale('ca', 'ES')),
              ScaffoldMessenger.of(context)
                  .showSnackBar(mensajeMuestra("updatedlanguage".tr())),
            },
            enabled: true,
            dense: true,
            selected: false,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            textColor: catalan
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.black26,
            tileColor:
                catalan ? Theme.of(context).colorScheme.primary : Colors.white,
            title: const Text(
              'Chino',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            onTap: () => {
              context.setLocale(const Locale('zh', 'CN')),
              ScaffoldMessenger.of(context)
                  .showSnackBar(mensajeMuestra("updatedlanguage".tr())),
            },
            enabled: true,
            dense: true,
            selected: false,
          ),
        ]));
  }
}
