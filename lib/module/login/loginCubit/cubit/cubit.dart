import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/module/login/loginCubit/state/states.dart';
import 'package:news_app/model/login_model/model.dart';
import 'package:news_app/network/Endpoint.dart';
import 'package:news_app/network/remote/dio_helper.dart';

// ignore: camel_case_types
class shopLoginCubit extends Cubit<shopLoginStates>{
  shopLoginCubit() : super(shopLoginInitial());
  static shopLoginCubit get(context)=>BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  late UserModel LoginModel;
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(shopLoginLoading());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {

      LoginModel= UserModel.FromJson(value.data);
      emit(shopLoginSuccess(LoginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(shopLoginError(error.toString()));
    });
  }

  bool isPassword=true;
  IconData suffix=Icons.remove_red_eye;
  void visiblePass(){
    isPassword=!isPassword;
     suffix=isPassword? Icons.remove_red_eye:Icons.visibility_off;
    emit(LoginVisiblePassword());
    print(isPassword);
  }
}
