import 'package:chatquick/navigator_utils.dart';
import 'package:chatquick/ui/home/home_view.dart';
import 'package:chatquick/ui/profile_verify/profile_verify_view.dart';
import 'package:chatquick/ui/sign_in/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(context.read()),
          child: BlocConsumer<SignInCubit,SignInState>(              
            listener: (context, snapshot) {
              if (snapshot == SignInState.none){
                  pushAndReplaceToPage(context,ProfileVerifyView());
                  
                         }else {
                pushAndReplaceToPage(context, HomeView());
              }
            
            },

            builder: (context,snapshot){
              return Scaffold(
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bienvenido a QuickChat'),
              ElevatedButton(
                child: Text('Login with Google'),
                onPressed: (){
                 context.read<SignInCubit>().signIn();
                },
              )
            ],),
        ),
      );
            },
            
    ),
    );
  }
}