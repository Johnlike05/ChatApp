import 'dart:io';
import 'package:chatquick/data/image_picker_repository.dart';
import 'package:chatquick/data/stream_api_repository.dart';
import 'package:chatquick/domain/models/chat_user.dart';
import 'package:chatquick/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ProfileState {
  const ProfileState (
  this.file, {
    this.success = false,
    this.loading = false});
  final File file;
  final bool success;
  final bool loading;
}

//cuando seleccione la imagen refrescar la pantalla con ese estado
class ProfileVerifyCubit extends Cubit<ProfileState>{
  ProfileVerifyCubit(
  
    this._imagePickerRepository,
     this._profileSignInUseCase
     ): super(ProfileState(null));
  
  final nameController = TextEditingController();
  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting() async{
    
   emit(ProfileState(state.file, loading:true));
    final file = state.file;
    //este nombre ayuda cuando vaya al servicio de stream chat
    //acá crea el usuario
    final  name = nameController.text;
    await _profileSignInUseCase.verify(ProfileInput(
      imageFile: file,
      name: name
      ));
      
    emit(ProfileState(file, success: true, loading: false));
  }
  void pickImage() async{
    //TODO: call services
    final file =  await _imagePickerRepository.pickImage();
    emit(ProfileState(file));
   
  }
}