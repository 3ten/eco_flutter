import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({Key? key, this.onPickImage}) : super(key: key);

  final Function(XFile image)? onPickImage;

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          final XFile? image =
              await _picker.pickImage(source: ImageSource.gallery);
          if (image != null && widget.onPickImage != null) {
            print(image.path);
            widget.onPickImage!(image);
          }

        },
        child: const SizedBox(
          height: 100,
          width: 100,
          child: Icon(
            Icons.add_photo_alternate,
            color: Color(0xFF565656),
            size: 32,
          ),
        ),
      ),
    );
  }
}
