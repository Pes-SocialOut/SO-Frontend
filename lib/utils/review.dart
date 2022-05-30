import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/review.dart';


showReviewMenu(String id, BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0)
    ),
    context: context, 
    builder: (BuildContext context) {
     return ReviewMenu(id: id);
    });
}