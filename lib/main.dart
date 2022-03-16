import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/APPCubit/Cubit/cubit.dart';
import 'package:news_app/cubit/APPCubit/state/state.dart';
import 'package:news_app/cubit/ShopCubit/cubit/cubit.dart';
import 'package:news_app/cubit/bloc_observer.dart';
import 'package:news_app/layout/Home_layout/Home_layout.dart';
import 'package:news_app/module/login/login.dart';
import 'package:news_app/module/login/loginCubit/cubit/cubit.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/Styles/thems/themes.dart';
import 'package:news_app/shared/constence/Constance.dart';
import 'module/Register/RegisterCubit/cubit/cubit.dart';
import 'module/onBoarding/onboarding.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Widget widget;

  await CacheHelper.init();
  BlocOverrides.runZoned(
        () {
          APPCubit();
    },
    blocObserver: MyBlocObserver()
  );
   token= CacheHelper.getData(key: "token");
  bool? onBoarding=CacheHelper.getData(key:'onBoarding');
  if(onBoarding!=null){
        if(token!=null){
        widget=HomeLayout();
  }
        else{
          widget=login();
        }
  }
  else{
    widget=onBordingScreen();
  }

  onBoarding==null?onBoarding=false:onBoarding;
  runApp(MyApp(startWidget:widget ,));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;

    MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => shopLoginCubit()),
            BlocProvider(create: (BuildContext context) => ShopCubit()..GetProfile()..GetHomeData()..GetCategories()..GetFavorites() ),
            BlocProvider(create: (BuildContext context)=>APPCubit(),),
            BlocProvider(create: (BuildContext context)=>shopRegisterCubit(),),

          ],
          child: BlocConsumer<APPCubit,AppStates>(
            listener: ( context, state) {
            },
            builder: ( context, state) {
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                home:startWidget,
              );
            },

          ),
        );
  }
}