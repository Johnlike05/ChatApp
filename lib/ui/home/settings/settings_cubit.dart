import 'package:chatquick/domain/usecases/Logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsSwitchCubit extends Cubit<bool>{
  //le pasamos deacuerdo al cubit de encima
  SettingsSwitchCubit(bool state) : super(state);
  void onChangeDarkMode(bool isDark)=>emit(isDark);
}

class SettingsLogoutCubit extends Cubit<void>{
  //le pasamos deacuerdo al cubit de encima
  SettingsLogoutCubit(this._logoutUseCase) : super(null);

  final LogoutUseCase _logoutUseCase;
  void logOut() async {
    await _logoutUseCase.logout();
    emit(null);
  }
}