// ignore: camel_case_types
import 'package:news_app/model/login_model/model.dart';

abstract class shopLoginStates{}

// ignore: camel_case_types
class shopLoginInitial extends shopLoginStates{}
// ignore: camel_case_types
class shopLoginLoading extends shopLoginStates{}
// ignore: camel_case_types
class shopLoginSuccess extends shopLoginStates{
  // ignore: non_constant_identifier_names
  final UserModel LoginModel;
  shopLoginSuccess(this.LoginModel);
}
// ignore: camel_case_types
class shopLoginError extends shopLoginStates{
  final String? error;
  shopLoginError(this.error){
    print(" the error is ${error.toString()}");
  }
}
class LoginVisiblePassword extends shopLoginStates{}