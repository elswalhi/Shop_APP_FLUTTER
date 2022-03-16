import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/module/Register/RegisterCubit/state/states.dart';
import 'package:news_app/network/Endpoint.dart';
import 'package:news_app/network/remote/dio_helper.dart';

import '../../../../model/login_model/model.dart';

// ignore: camel_case_types
class shopRegisterCubit extends Cubit<shopRegisterStates>{
  shopRegisterCubit() : super(shopRegisterInitial());
  static shopRegisterCubit get(context)=>BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  late UserModel LoginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(shopRegisterLoading());

    DioHelper.postData(
      url: Register,
      data:
      {
        'name': name,
        'phone':phone,
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      LoginModel= UserModel.FromJson(value.data);
      emit(shopRegisterSuccess(LoginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(shopRegisterError(error.toString()));
    });
  }

  bool isPassword=true;
  IconData suffix=Icons.remove_red_eye;
  void visiblePass(){
    isPassword=!isPassword;
     suffix=isPassword? Icons.remove_red_eye:Icons.visibility_off;
    emit(RegisterVisiblePassword());
    print(isPassword);
  }
}
