import 'package:chatquick/navigator_utils.dart';
import 'package:chatquick/ui/app_theme_cubit.dart';
import 'package:chatquick/ui/common/avatar_image_view.dart';
import 'package:chatquick/ui/home/home_view.dart';

import 'package:chatquick/ui/home/settings/settings_cubit.dart';
import 'package:chatquick/ui/profile_verify/profile_edit_view.dart';

import 'package:chatquick/ui/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.user;
    final image = user?.extraData['image'];
    final textColor = Theme.of(context).appBarTheme.color;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SettingsSwitchCubit(context.read<AppThemeCubit>().isDark),
        ),
        BlocProvider(
          create: (_) => SettingsLogoutCubit(context.read()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          title:  Row(
                        children: [
                          Container(
                            height: 20,
                            child: FloatingActionButton(
                              child: Icon(Icons.keyboard_backspace),
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
                              onPressed: (){
                                  pushToPage(context, HomeView());
                              }
                              ),
                          ),
                            Text('People'),
                        ],
                      ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
               
                AvatarImageView(
                  
                  onTap: () => null,
                  child: image != null
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.person_outline,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                ),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.nights_stay_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    Spacer(),
                    BlocBuilder<SettingsSwitchCubit, bool>(builder: (context, snapshot) {
                      return Switch(
                        value: snapshot,
                        onChanged: (val) {
                          context.read<SettingsSwitchCubit>().onChangeDarkMode(val);
                          context.read<AppThemeCubit>().updateTheme(val);
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 15),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: context.read<SettingsLogoutCubit>().logOut,
                    child: BlocListener<SettingsLogoutCubit, void>(
                      listener: (context, snapshot) {
                        popAllAndPush(context, SignInView());
                      },
                      child: Row(children: [
                        Icon(Icons.logout),
                        const SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_right),
                      ]),
                    ),
                  );
                }),
                 Builder(
                    builder: (context) {
                    return BlocListener<SettingsLogoutCubit, void>(
                      listener: (context, snapshot){
                         popAllAndPush(context, SignInView());
                      },
                                      child: ElevatedButton(
                        child: Text('Editar perfil'),
                        onPressed: () {
                          pushAndReplaceToPage(context, ProfileVerifyView());
                         
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
