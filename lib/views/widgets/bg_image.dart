import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BGImage extends StatelessWidget {
  const BGImage({
    Key? key,
    required Animation<double> animation,
  })  : _animation = animation,
        super(key: key);

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          "https://media.istockphoto.com/photos/businesswoman-using-computer-in-dark-office-picture-id557608443?k=6&m=557608443&s=612x612&w=0&h=fWWESl6nk7T6ufo4sRjRBSeSiaiVYAzVrY-CLlfMptM=",
      placeholder: (context, url) => Image.asset(
        'assets/images/wallpaper.jpg',
        fit: BoxFit.fill,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      alignment: FractionalOffset(_animation.value, 0),
    );
  }
}
