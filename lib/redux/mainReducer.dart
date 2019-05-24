import 'package:uitest/config/localStorage.dart';
import 'package:uitest/redux/models/appstate.dart';
import 'package:uitest/redux/actions/userinfoAction.dart';

AppState mainReducer(AppState state,dynamic action) {
  if(action is UserInfoAction) {
    state.userInfo= action.userInfo;
    if(action.save) {
      LocalStorage.setUserInfo(state.userInfo);
    }
  }
  return state;
}
