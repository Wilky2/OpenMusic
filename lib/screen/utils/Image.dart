import 'package:flutter/material.dart';

class ShowNetWorkImage extends StatelessWidget {

  const ShowNetWorkImage({
    required this.thumbnail,
  });

  final String? thumbnail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        thumbnail??"",
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            "assets/image/audio.webp",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
          );
        },
      ),
    );
  }
}