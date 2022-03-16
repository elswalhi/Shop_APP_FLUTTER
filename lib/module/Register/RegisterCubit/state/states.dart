// ignore: camel_case_types
import '../../../../model/login_model/model.dart';
abstract class shopRegisterStates{}

// ignore: camel_case_types
class shopRegisterInitial extends shopRegisterStates{}
// ignore: camel_case_types
class shopRegisterLoading extends shopRegisterStates{}
// ignore: camel_case_types
class shopRegisterSuccess extends shopRegisterStates{
  // ignore: non_constant_identifier_names
  final UserModel LoginModel;
  shopRegisterSuccess( this.LoginModel);
}
// ignore: camel_case_types
class shopRegisterError extends shopRegisterStates{
  final String? error;
  shopRegisterError(this.error){
    print(" the error is ${error.toString()}");
  }
}
class RegisterVisiblePassword extends shopRegisterStates{}