import 'package:flutter/material.dart';

class ProjectImage extends StatelessWidget {
  const ProjectImage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.network(
           url,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );

  }
}
