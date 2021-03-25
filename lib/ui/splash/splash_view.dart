import 'package:chatquick/navigator_utils.dart';
import 'package:chatquick/ui/common/initial_background_view.dart';
import 'package:chatquick/ui/home/home_view.dart';
import 'package:chatquick/ui/profile_verify/profile_verify_view.dart';
import 'package:chatquick/ui/sign_in/sign_in_view.dart';
import 'package:chatquick/ui/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//este splash valida si el usuario ya esta conectado, si esta logueado en firebase conecta a stream chat

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       //busca el usecase mas cercano y lo inyecta
      create: (context) => SplashCubit(context.read())..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if (snapshot == SplashState.none) {
            pushAndReplaceToPage(context, SignInView());
          } else if (snapshot == SplashState.existing_user) {
            pushAndReplaceToPage(context, HomeView());
          } else {
            pushAndReplaceToPage(context, ProfileVerifyView());
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              //InitialBackgroundView(),
              Center(
                child: Hero(
                  tag: 'logo_hero',
                  child: Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
