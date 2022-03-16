import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/ShopCubit/state/state.dart';
import 'package:news_app/model/ChangeFavourite/ChangeFavourite.dart';
import 'package:news_app/model/Searchmodel/Search.dart';
import 'package:news_app/model/categories/categories.dart';
import 'package:news_app/model/getFavoriteModel/getfavorite.dart';
import 'package:news_app/model/home_model/HomeModel.dart';
import 'package:news_app/module/ShopModules/Categories/Catigories.dart';
import 'package:news_app/module/ShopModules/Favourite/Favourite.dart';
import 'package:news_app/module/ShopModules/Products/Products.dart';
import 'package:news_app/module/ShopModules/Setting/Setting.dart';
import 'package:news_app/network/Endpoint.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/constence/Constance.dart';

import '../../../model/login_model/model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit( ) : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<Widget> Screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  void ChangeScreen(index) {
    currentindex = index;
    emit(ChangeBottomItem());
  }
  Map<int,bool> favourite={};
  HomeModel? homeModel;
   void GetHomeData() {
    emit(ShopGetDataLoading());
    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value) {
      print(token);
      homeModel = HomeModel.fromJson(value!.data);
      homeModel!.data!.products.forEach((element) {
        favourite.addAll(
          {element.id!:element.in_favorite!},
        );

      });
      emit(ShopGetDataSuccess());
    }).catchError((error) {
      // ignore: avoid_print
      print("the get error ${error.toString()}");
      emit(ShopGetDataError());
    });
  }
  ChangeFavouriteModel? ChangeFavouriteS;
  CategoriesModel? categoriesModel;
  void GetCategories() {
    DioHelper.getData(
      url: get_categories,
      token:token,
    ).then((value) {
      categoriesModel= CategoriesModel.fromjson(value!.data);
      emit(ShopGetCategoriesSuccess());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(ShopGetCategoriesError());
    });

}
  void ChangeFavourite(int id){
     favourite[id]=!favourite[id]!;
     emit(ChangeFavorite());
     DioHelper.postData(url: Favorite,
        token: token,
         data:{
          "product_id":id
        } ).then((value){
      ChangeFavouriteS =ChangeFavouriteModel.fromJason(value.data);
      if(!ChangeFavouriteS!.status!){
        favourite[id]=!favourite[id]!;
      }else{
        GetFavorites();
      }
      print(ChangeFavouriteS!.message);
      print(favourite[id]);
      emit(ChangeFavouriteSuccess(ChangeFavouriteS!));
    }).catchError((error){
      print(error.toString());
       favourite[id]=!favourite[id]!;
       emit(ChangeFavouriteError());
    });
  }
    FavoriteModel? favoriteModel;
  void GetFavorites() {
    emit(GetFavouritesLoading());
    DioHelper.getData(
      url: Favorite,
      token:token,
    ).then((value) {
      favoriteModel=FavoriteModel.fromJson(value!.data);

      emit(GetFavoritesSuccess());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(GetFavouritesError());
    });
  }
  UserModel? User;
  void GetProfile() {
    emit(GetProfileLoading());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      User=UserModel.FromJson(value!.data);
      print(User!.data!.name);
      emit(GetProfileSuccess());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(GetProfileError());
    });
  }
  void EditProfile({
    required String name,
    required String email,
    required String phone,
}){
    emit(updateProfileLoading());
    DioHelper.putData(url: update_profile,
        token: token,
        data:{
      "name":name,
      "email":email,
      "phone":phone

        } ).then((value){

      User=UserModel.FromJson(value.data);

      emit(updateProfileSuccess(User!));
    }).catchError((error){
      print(error.toString());

      emit(updateProfileError());
    });
  }
  late SearchModel model;
  void SearchData(String text){
    emit(SearchLoding());
    DioHelper.postData(url: Search,
        token: token,
        data: {
      'text':text
        }).then((value){
          model=SearchModel.fromJson(value.data);
          print(model);
          emit(SearchSuccess());
    }).catchError((error){
      print("error is search $error");
      emit(SearchError());
    });
  }
}
