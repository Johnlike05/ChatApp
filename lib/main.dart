import 'package:firebase_core/firebase_core.dart';
import 'package:chatquick/dependencies.dart';

import 'package:chatquick/ui/app_theme_cubit.dart';
import 'package:chatquick/ui/splash/splash_view.dart';
//import 'package:chatquick/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  final _streamChatClient = StreamChatClient('here ur key streamchat');
  
  
 
  
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiRepositoryProvider(
          providers: buildRepositories(_streamChatClient),
          child: BlocProvider(
        create: (context) => AppThemeCubit(context.read())..init(),
                  child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
          return MaterialApp(
          debugShowCheckedModeBanner:false,
          title: 'QuickChat',
          home: SplashView(),
          theme: snapshot ? ThemeData.dark() : ThemeData.light(),
          builder: (context, child){
          return StreamChat(child: child, client: _streamChatClient);
          },
        );
      }),
      ),
    );
  }
}
