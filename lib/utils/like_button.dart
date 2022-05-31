import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:skeletons/skeletons.dart';

class LikeButton extends StatefulWidget {
  final String id;
  const LikeButton({ Key? key, required this.id}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {

  APICalls api = APICalls();

  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getItem('/v3/events/:0/:1/:2', [api.getCurrentUser(), 'like', widget.id]),
      builder:(BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var response = [json.decode(snapshot.data.body)];
          _liked = response[0]["message"] == "Le ha dado like";
          return IconButton(
            iconSize:20,
            color: _liked ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.favorite),
            onPressed: ()  {
              if (_liked) {
                api.postItem('/v3/events/:0/:1', [widget.id, 'dislike'], {"user_id":api.getCurrentUser()}).then((value) => {
                  setState(() {
                    _liked = false;
                  })
                });
              }
              else {
                api.postItem('/v3/events/:0/:1', [widget.id, 'like'], {"user_id":api.getCurrentUser()}).then((value) => {
                  setState(() {
                    _liked = true;
                  })
                });
              }
            });
        }
        else {
          return const SkeletonItem(
            child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    shape: BoxShape.circle, width: 20, height: 20),
              ),
          );
        }
      } 
    );
  }
}