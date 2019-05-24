import 'package:uitest/model/userInfo.dart';
import 'package:uitest/redux/actions/action.dart';
import 'package:uitest/redux/actions/actions.dart';

class UserInfoAction extends ReduxAction {
  final UserInfo userInfo;
  final bool save;
  UserInfoAction({
    this.userInfo,
    this.save=false
  }):super(type:ReduxActions.UserInfo);
}