import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AppUtils {
  pickImages() async {
    List<File> images = [];

    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    try {
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }

        return images;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
