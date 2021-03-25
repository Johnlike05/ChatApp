import 'dart:convert';

import 'package:chatquick/data/stream_api_repository.dart';
import 'package:chatquick/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:http/http.dart' as http;

class StreamApiImpl extends StreamApiRepository {
  StreamApiImpl(this._client);

  final StreamChatClient _client;

  @override
  Future<ChatUser> connectUser(ChatUser user, String token) async {
    Map<String, dynamic> extraData = {};
    if (user.image != null) {
      extraData['image'] = user.image;
    }
    if (user.name != null) {
      extraData['name'] = user.name;
    }
    await _client.disconnect();
    await _client.connectUser(
      User(id: user.id, extraData: extraData),
      token,
    );
    return user;
  }

  @override
  Future<List<ChatUser>> getChatUsers() async {
    final result = await _client.queryUsers();
    final chatUsers = result.users
    //listar la lista de usuarios sin que yo este
    .where((element) => element.id != _client.state.user.id && element.id != 'dos')
    .map(
      (e) => ChatUser(
        id: e.id,
        name: e.name,
        image: e.extraData['image'],
      ),
    )
    .toList();
    return chatUsers;
  }

  @override
  Future<String> getToken(String userId) async {
    //obtememos el token con un cloud function creado
    final response = await http.post(
      'acá puedes poner tu funcion para obtener token en backend',
      body: jsonEncode(<String, String>{'id': userId}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final token = jsonDecode(response.body)['token'];



    return token;
  }

  @override
  Future<Channel> createGroupChat(String id, String name, List<String> members, {String image}) async {
    final channel = _client.channel('messaging', id: id, extraData: {
      'name': name,
      'image': image,
      'members': [_client.state.user.id, ...members],
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<Channel> createSimpleChat(String friendId) async {
    final channel =
        _client.channel('messaging', id: '${_client.state.user.id.hashCode}${friendId.hashCode}', extraData: {
      'members': [
        friendId,
        _client.state.user.id,
      ],
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<void> logout() async {
    return _client.disconnect();
  }

  @override
  Future<bool> connectIfExist(String userId) async {
    final token = await getToken(userId);
    await _client.connectUser(
      User(id: userId),
      token,
    );
    //if de validacion sirve para que no asigne como nombre el id del usuario
    return _client.state.user.name != null && _client.state.user.name != userId;
   
  }
}
