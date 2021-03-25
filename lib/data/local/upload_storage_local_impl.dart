import 'dart:io';
import 'package:chatquick/data/upload_storage_repository.dart';

class UploadStorageLocalImpl extends UploadStorageRepository {
  @override
  Future<String> uploadPhoto(File file, String path) async {
    return 'https://ui-avatars.com/api/?name=johnde';
  }
}