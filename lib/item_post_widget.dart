import 'package:dynamic_link_demo/post_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ItemPostWidget extends StatelessWidget {
  final Post post;
  const ItemPostWidget(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(post.content),
          ],
        ),
      ),
      ExtendedImage.network(post.image, fit: BoxFit.contain)
    ]);
  }
}
