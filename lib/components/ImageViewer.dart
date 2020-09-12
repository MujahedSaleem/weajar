import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewr extends StatefulWidget {
  List<File> image;
  final int index;
  final Function setStateMain;
  final String text;
  final double height;
  final double width;
  ImageViewr(this.image,
      {this.setStateMain, this.index, this.text, this.height, this.width});
  @override
  _ImageViewrState createState() => _ImageViewrState();
}

class _ImageViewrState extends State<ImageViewr> {
  final picker = ImagePicker();
  File image;

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        image = File(pickedFile.path);
        if (widget.image.isEmpty || widget.image.length <= widget.index)
          widget.image.add(image);
        else
          widget.image[widget.index] = (image);

        this.widget.setStateMain(() {});
      });
    } catch (ex) {}
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image.length > widget.index) image = widget.image[widget.index];

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          children: [
            InkWell(
              onTap: getImage,
              child: Container(
                height: widget.height ?? 80.0,
                width: widget.width ?? 80.0,
                child: widget.text == null
                    ? image == null
                        ? Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50,
                          )
                        : null
                    : image == null
                        ? Padding(
                            padding: EdgeInsets.only(left: 5,right: 7,top: 40),
                            child: Text(
                              widget.text,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : null,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white),
                    image: image == null
                        ? null
                        : DecorationImage(
                            image: FileImage(image),
                            fit: BoxFit.fill,
                          )),
              ),
            ),
            if (image != null)
              Positioned(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      image = null;
                      widget.image[widget.index] = null;
                    });
                    ;
                  },
                  icon: Icon(Icons.remove_circle),
                ),
                top: -10,
                left: -10,
              )
          ],
        ));
  }
}
