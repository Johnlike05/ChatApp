import 'dart:io';

abstract class ImagePickerRepository {
  //me retorna una imagen
  Future<File> pickImage();
}