import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:chatquick/data/upload_storage_repository.dart';

class UploadStorageImpl extends UploadStorageRepository {
  @override
  Future<String> uploadPhoto(File file, String path) async {
    //path para saber donde lo va a subir
    print('se subio la imagen : $path');
    final ref = firebase_storage.FirebaseStorage.instance.ref(path);
    final uploadTask = ref.putFile(file);
    await uploadTask;
    return await ref.getDownloadURL();
    
  }
}
