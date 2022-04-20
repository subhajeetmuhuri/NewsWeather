import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: url ?? 'https://picsum.photos/id/1021/1',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => _placeholderImage(),
        errorWidget: (context, url, error) => _placeholderImage(),
      );

  Widget _placeholderImage() => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1x1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      );
}
