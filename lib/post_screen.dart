import 'package:dynamic_link_demo/item_post_widget.dart';
import 'package:dynamic_link_demo/post_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends StatefulWidget {
  final Post post;
  const PostScreen(this.post);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.post.title),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ExtendedImage.network(widget.post.image, width: Get.width * 0.9, fit: BoxFit.cover, height: Get.width*0.4,),
            const SizedBox(height: 20,),
            Text(widget.post.content)
          ],
        ),
      ),
    );
  }
}
