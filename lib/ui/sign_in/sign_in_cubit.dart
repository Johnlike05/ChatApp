import 'package:chatquick/domain/exceptions/auth_exception.dart';
import 'package:chatquick/domain/usecases/login_usecase.dart';
import 'package:chatquick/ui/splash/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignInState{
  none,
  existing_user,
}

class SignInCubit extends Cubit <SignInState>{
  SignInCubit(
    this._loginUseCase,
    ) : super(SignInState.none);
 //dar un delay para que de la apariencia de que esta haciendo una consulta
  final LoginUseCase _loginUseCase;
  void signIn() async {
    try{
    final result =  await _loginUseCase.validateLogin();
    if(result){
      emit(SignInState.existing_user);
    }

  }catch (ex) {
     final result =  await _loginUseCase.signIn();
     if(result != null){
       emit(SignInState.none);
    }
    }
    
 
   
 

  }
   
    
  }

