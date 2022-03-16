import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/ShopCubit/cubit/cubit.dart';
import 'package:news_app/cubit/ShopCubit/state/state.dart';
import 'package:news_app/shared/components/components.dart';

import '../../../shared/constence/Constance.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formkey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).User;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).User != null,
          builder: (context) {
            return Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(state is updateProfileLoading)
                      LinearProgressIndicator(),
                    const SizedBox(height: 20,),
                    // name
                    Container(
                      child: defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: "Name",
                          prefix: Icons.person),
                    ),
                    // Email
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: "Email",
                          prefix: Icons.email),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // phone
                    Container(
                      child: defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          label: "Phone",
                          prefix: Icons.phone),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: defaultButton(
                          function: () {
                            if(formkey.currentState!.validate()){
                              ShopCubit.get(context).EditProfile(name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: "Edit Profile"),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      child: defaultButton(
                        background:HexColor("915556"),
                          function: () {
                            SignOut(context);
                          },
                          text: "sign out"),
                    ),
                    //button
                  ],
                ),
              ),
            );
          },
          fallback: (context) => CircularProgressIndicator(),
        );
      },
    );
  }
}
