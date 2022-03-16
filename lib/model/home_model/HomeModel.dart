// ignore_for_file: non_constant_identifier_names

class HomeModel{
   bool? status;
    HomeDataModel? data;
  HomeModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}
class HomeDataModel{
   List<BannersModel> banners=[];
   List<ProductModel> products=[];

  HomeDataModel.fromjson(Map<String,dynamic> json){
      json['banners'].forEach((element){
        banners.add(BannersModel.fromjson(element));
      });
      json['products'].forEach((element){
        products.add(ProductModel.fromjson(element));
      });
    }
}
class BannersModel
{
   int? id;
   String? img;
    BannersModel.fromjson(Map<String,dynamic> json){
        id=json['id'];
        img=json['image'];
    }
}
class ProductModel{
   int? id;
   dynamic price;
   dynamic old_price;
   dynamic discount;
    String? img;
   String? name ;
   bool? in_favorite;
   bool? in_cart;
  ProductModel.fromjson(Map<String,dynamic> json){
    id= json['id'];
    price =json['price'];
    old_price=  json['old_price'];
    discount=  json['discount'];
    img=json['image'];
    in_favorite=json['in_favorites'];
    in_cart=json['in_cart'];
    name=json['name'];

  }
}