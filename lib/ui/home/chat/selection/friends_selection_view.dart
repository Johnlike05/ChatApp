
import 'package:chatquick/navigator_utils.dart';
import 'package:chatquick/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:chatquick/ui/home/chat/selection/group_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


import '../chat_view.dart';

class FriendsSelectitonView extends StatelessWidget {

  void _createFriendChannel( BuildContext context, ChatUserState chatUserState) async {
   final channel = await context.read<FriendSelectionCubit>().createFriendChannel(chatUserState);
   pushAndReplaceToPage(
  context, 
   Scaffold(
     body: StreamChannel(
       channel: channel,
       child: ChannelPage(),
   ),
   ),
   );
  }
  @override
  Widget build(BuildContext context) {
  
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FriendSelectionCubit(context.read())..init()),
        BlocProvider(create: (_) => FriendsGroupCubit()),
      ],
      
          child: BlocBuilder<FriendsGroupCubit, bool>(
           
            builder: (context, isGroup) {
              return BlocBuilder<FriendSelectionCubit, List<ChatUserState>>(
               
                builder: (context, snapshot) {

                  final selectedUsers = context.read<FriendSelectionCubit>().selectedUsers;

                  return Scaffold(
                      floatingActionButton: isGroup && selectedUsers.isNotEmpty
                  ? FloatingActionButton(onPressed: (){
                    //le pasamos selected users para que lo pueda pintar en la siguiente pagina
                    pushAndReplaceToPage(context, GroupSelectionView(selectedUsers));
                  })
                  :null,
                  body: Column(
                    children:[
                      if(isGroup)
                      Row(
                        children: [
                          BackButton(
                            onPressed: () {
                             context.read<FriendsGroupCubit>().changeToGroup();
                            },
                            ),
                            Text('Nuevo grupo')
                        ],
                      )
                      else 
                      Row(
                        children: [
                          BackButton(
                            onPressed: Navigator.of(context).pop,
                            ),
                            Text('Personas'),
                        ],
                      ),
                      if(!isGroup)
                      ElevatedButton(
                        child: Text('Crear Grupo'),
                        onPressed: (){
                          context.read<FriendsGroupCubit>().changeToGroup();
                        },
                        )
                        else if(isGroup && selectedUsers.isEmpty)
                        Column(
                          mainAxisSize:MainAxisSize.min,
                          children: [
                            CircleAvatar(),
                            Text('Añadir amigo'),

                          ],
                        )
                        else 
                         SizedBox(
                           height:100,
                           child: ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: selectedUsers.length,
                             itemBuilder: (context, index){
                               final chatUserState = selectedUsers[index];
                               return Stack(
                                 children: [
                                   
                                   Column(
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       CircleAvatar(),
                                       Text(chatUserState.chatUser.name),
                                     ],

                                   ),
                                   IconButton(
                                     onPressed: () {
                                       context.read<FriendSelectionCubit>().selectUser(chatUserState);
                                     }, icon: Icon(Icons.delete),
                                     ),
                                 ],
                                 );
                             })),
                             Expanded(child: ListView.builder(
                               itemCount: snapshot.length,
                               itemBuilder: (context, index){
                                 final chatUserState = snapshot [index];
                                 
                                 return ListTile(
                                   
                                   onTap: () {
                                     _createFriendChannel(context, chatUserState);
                                   },
                                   
                                   leading: 
                                   
                                   CircleAvatar(
                                     backgroundImage: NetworkImage(chatUserState.chatUser.image),
                                   ),
                                   title: Text(chatUserState.chatUser.name),
                                   trailing: isGroup
                                   ? Checkbox(
                                     value: chatUserState.selected,
                                      onChanged: (val) {
                                        print('select user for group');
                                        //cada vez que yo hago un check
                                        context.read<FriendSelectionCubit>().selectUser(chatUserState);
                                      },
                                      )
                                      :null,
                                 );
                               }))
                    ]
                  ),
      );
                }
              );
            }
          ),
    );
  }
}