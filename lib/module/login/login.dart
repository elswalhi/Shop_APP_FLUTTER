import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:news_app/layout/Home_layout/Home_layout.dart';
import 'package:news_app/module/login/loginCubit/cubit/cubit.dart';
import 'package:news_app/module/login/loginCubit/state/states.dart';
import 'package:news_app/module/Register/register.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/shared/constence/Constance.dart';
import '../../shared/components/components.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';

import '../login/login.dart';
// ignore: camel_case_types, must_be_immutable
class login extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>shopLoginCubit(),
      child: BlocConsumer<shopLoginCubit,shopLoginStates>(
        listener: (context,state){
          if(state is shopLoginSuccess){
            if(state.LoginModel.status){
              CacheHelper.SaveData(key: 'token', value: state.LoginModel.data!.token)
                  .then((value) => {
                token=state.LoginModel.data!.token!,
                navigateAndFinish(context, HomeLayout())
              });
            }
            else
            {
              ShowToast(
                  direction: ORIENTATION.ltr,
                  animationType: ANIMATION.fromLeft,
                  title: "FAILED",
                  description: state.LoginModel.message,
                  context: context,
                  color: Colors.red,
                  icon: Icons.sms_failed_outlined,
                  style: const TextStyle(fontSize: 16),
                  time:10);
            }
          }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //text
                        Text("LOGIN"
                          ,style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),),
                        Text("LOGIN now to get our offers ",style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),),
                        const SizedBox(height: 30,),
                        //email
                        Container(
                          child: defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value){
                                if(value!.isEmpty){
                                  return 'please Enter your Email Adress ';
                                }
                                return null;
                              },
                              label: 'EmailAdress',
                              prefix: Icons.email_outlined
                          ),
                        ),
                        //password
                        const SizedBox(height: 15,),
                        //button
                        Container(
                          child: defaultFormField(
                            controller: passwordController,
                            onSubmit: (value){
                              if(formkey.currentState!.validate()){

                                shopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }

                            },
                            type: TextInputType.visiblePassword,
                            isPassword: shopLoginCubit.get(context).isPassword,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'please Enter your password ';
                              }
                              return null;
                            },
                            label: 'password',
                            prefix: Icons.lock_open_outlined,
                            suffix: shopLoginCubit.get(context).suffix,
                            suffixPressed: (){
                              shopLoginCubit.get(context).visiblePass();
                            },

                          ),
                        ),
                        const SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state is! shopLoginLoading,
                          builder:(context)=> defaultButton(function: (){
                            if(formkey.currentState!.validate()){

                              shopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }


                          }, text: "LOGIN")
                          ,
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            //Reg now text Button
                            Container(
                              child: defultTextButton(text: "Register NOW"
                                  , function: (){
                                    navigateTo(context, Register());
                                  }),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}