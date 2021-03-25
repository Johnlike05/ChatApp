import 'package:chatquick/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

abstract class StreamApiRepository {
  //traer la lista de los usuarios de chat
  Future<List<ChatUser>> getChatUsers();
  //token para pruebas de dessarrollo
  Future<String> getToken(String userId);
  //si el usuario ya existe no vuelvo a crear uno en streamchat
  Future<bool> connectIfExist(String userId);
  //conecto el usuario por primera vez
  Future<ChatUser> connectUser(ChatUser user, String token);
  Future<Channel> createGroupChat(String channelId, String name, List<String> members, {String image});
  Future<Channel> createSimpleChat(String frienId);
  Future<void> logout();
}