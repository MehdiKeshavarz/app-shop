import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  double radius;
  CachedImage({Key? key, this.imageUrl, this.radius = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl ??
            'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/78q8w901e6iipuk/rectangle_63_7kADbEzuEo.png',
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(color: Colors.red[200]),
        placeholder: (context, url) => Container(color: Colors.grey[300]),
      ),
    );
  }
}
