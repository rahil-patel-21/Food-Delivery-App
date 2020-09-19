import 'package:food_delivery/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:food_delivery/ModelClass/ModelUserLogin.dart';

class UserLoginData extends BaseBloc<UserLogin> {
  Stream<UserLogin> get loginData => fetcher.stream;
  fetchUserDataWithLogin(String url, dynamic param) async {
    UserLogin userData = await repository.fetchUserLogin(url, param);
    fetcher.sink.add(userData);
  }
}

final userLoginBloc = UserLoginData();
