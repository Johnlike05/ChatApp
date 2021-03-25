import 'dart:io';
//esto me va a ayudar a subir la foto para firebase, path es donde lo voy a guaardar en el storage
abstract class UploadStorageRepository{
  Future<String> uploadPhoto(File file, String path);
}