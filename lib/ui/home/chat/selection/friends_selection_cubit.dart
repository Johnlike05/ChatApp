import 'package:chatquick/data/stream_api_repository.dart';
import 'package:chatquick/domain/models/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState {
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser chatUser;
  final bool selected;
}
//esto va a emitir un listado de chatuserstate
class FriendSelectionCubit extends Cubit <List<ChatUserState>>{

  FriendSelectionCubit(this._streamApiRepository) : super([]);

  final StreamApiRepository _streamApiRepository;

  //en base a todos los que tengo los que estan con selected marcados retornan
  List<ChatUserState> get selectedUsers => 
  
  state.where((element) => element.selected).toList();

  Future<void> init() async {
    
    final chatUsers = (await _streamApiRepository.getChatUsers()).map((e) => ChatUserState(e)).toList();

    //emitir la lista para que refresque
    emit(chatUsers);
  }

  void selectUser(ChatUserState chatUser){
    //del estado que ya tenia usuarios selecciono el usuario al momento de hacer check
    final index = state.indexWhere((element) => element.chatUser.id == chatUser.chatUser.id);
    //cambio el estado y emito una nueva lista para que refresque
    state[index] = ChatUserState(state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async {
      return await _streamApiRepository.createSimpleChat(chatUserState.chatUser.id);
  }
}

class FriendsGroupCubit extends Cubit<bool>{
  FriendsGroupCubit() : super(false);
  //emitir el valor al reves para cambiar
  void changeToGroup() => emit(!state);
}