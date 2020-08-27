import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImageViewr extends StatefulWidget {
  List<File> image;
  final int index;
  final Function setStateMain;
  ImageViewr(this.image, {this.setStateMain, this.index});
  @override
  _ImageViewrState createState() => _ImageViewrState();
}

class _ImageViewrState extends State<ImageViewr> {
  final picker = ImagePicker();
  File image;

  Future getImage() async {
    try {    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
      if(widget.image.isEmpty || widget.image.length <= widget.index)
        widget.image.add(image);
      else
        widget.image[widget.index]=(image) ;

      this.widget.setStateMain((){

      });
    });
    }catch(ex){}


  }
  @override
  Widget build(BuildContext context) {
    if(widget.image.length > widget.index)
      image= widget.image[widget.index];

    return Stack(
      children: [

        InkWell(
          onTap: getImage,
          child: Container(
            height: 80.0,
            width: 80.0,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white),
                image: DecorationImage(
                  image: image==null?AssetImage('assets/Img/weAjar.png'): FileImage(image),
                  fit: BoxFit.contain,
                )),
          ),
        ),
        if(image!=null)
          Positioned(child: IconButton(
            onPressed: (){setState(() {
              image = null;
              widget.image[widget.index] = null;
            });;},
            icon: Icon(Icons.remove_circle),
          ),top: -10,
            left: -10,)
      ],
    );
  }
}

