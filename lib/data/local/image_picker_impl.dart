import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:chatquick/data/image_picker_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ImagePickerImpl extends ImagePickerRepository {
  @override
  Future<File> pickImage() async {
    
    //plugin image picker, para usar este plugin imagepicker, vamos a la documentacion y nos dice que cosas agregar para los permisos
    final picker = ImagePicker();
    
   
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth:400);
    return File(pickedFile.path);
  }
}