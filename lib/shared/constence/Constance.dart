import 'package:news_app/module/login/login.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/shared/components/components.dart';

void SignOut(context){

  CacheHelper.removeData(key: "token").then((value){
    if(value){
      navigateAndFinish(context, login());
    }
  });
}
String token='';