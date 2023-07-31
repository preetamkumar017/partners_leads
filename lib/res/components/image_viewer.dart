import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyImageView extends StatelessWidget {
  Map data;
   MyImageView({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image"),
      ),
      body:  PhotoView(
       imageProvider:NetworkImage(data['image'],)
        ),
    );
  }
}