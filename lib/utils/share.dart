import 'package:flutter/material.dart';
import 'package:so_frontend/utils/share_menu.dart';

showShareMenu(String url, BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0)
    ),
    context: context, 
    builder: (BuildContext context) {
      return ShareMenu(url: url);
    });
}