import 'package:chatquick/domain/exceptions/auth_exception.dart';
import 'package:chatquick/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState{
  none,
  existing_user,
  new_user,
}

class SplashCubit extends Cubit <SplashState>{
  SplashCubit(
    this._loginUseCase) : super(SplashState.none);

  final LoginUseCase _loginUseCase;

  //mientras mas dependencias mas inyecciones hacemos acá
 
  
 //dar un delay para que de la apariencia de que esta haciendo una consulta
  void init() async {
  try{
    final result =  await _loginUseCase.validateLogin();
    print('result: $result');
    if(result){
      emit(SplashState.existing_user);
    }

  }on AuthException catch (ex){
    //si no esta autenticado lo mando a none y si esta a existing user
    if(ex.error == AuthErrorCode.not_auth){
      emit(SplashState.none);
    }else {
      emit(SplashState.new_user);
    }
  }
    
  }

}