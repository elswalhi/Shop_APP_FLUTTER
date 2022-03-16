import 'package:news_app/model/ChangeFavourite/ChangeFavourite.dart';

import '../../../model/login_model/model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ChangeBottomItem extends ShopStates{}

class ShopGetDataSuccess extends ShopStates{}

class ShopGetDataError extends ShopStates{}

class ShopGetDataLoading extends ShopStates{}

class ShopGetCategoriesSuccess extends ShopStates{}

class ShopGetCategoriesError extends ShopStates{}

class ChangeFavouriteSuccess extends ShopStates{
  final ChangeFavouriteModel model;

  ChangeFavouriteSuccess(this.model);
}

class ChangeFavorite extends ShopStates{}

class ChangeFavouriteError extends ShopStates{}

class GetFavoritesSuccess extends ShopStates{}

class GetFavouritesError extends ShopStates{}

class GetFavouritesLoading extends ShopStates{}

class GetProfileSuccess extends ShopStates{}

class GetProfileError extends ShopStates{}

class GetProfileLoading extends ShopStates{}

class updateProfileSuccess extends ShopStates{
    final UserModel LoginModel;

  updateProfileSuccess(this.LoginModel);
}

class updateProfileError extends ShopStates{}

class updateProfileLoading extends ShopStates{}

class SearchLoding extends ShopStates{}

class SearchSuccess extends ShopStates{}

class SearchError extends ShopStates{}