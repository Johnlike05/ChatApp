import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child:ChannelListView(
          filter:{
            'members': {
              '\$in' : [StreamChat.of(context).user?.id]
            }
          },
          sort: [SortOption('last_message_at')],
          channelWidget: ChannelPage(),
          ), 
        ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children:[
          Expanded(
            child: MessageListView(),
            ),
            MessageInput(),
        ]
      ),
    );
  }
}