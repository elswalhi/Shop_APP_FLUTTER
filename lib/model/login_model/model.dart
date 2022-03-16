class UserModel{
 late bool status;
 late String message;
  UserModelData? data;
  UserModel.FromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null ?  UserModelData.FromJson(json['data']) : null;

  }
}
class UserModelData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? img;
  int? points ;
  int? credit ;
  String? token;
//   UserModelData({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.img,
//     this.points,
//     this.credit,
//     this.token,
// });
  // named constructor
UserModelData.FromJson(Map<String,dynamic> json){
  id=json['id'];
  name=json['name'];
  email=json['email'];
  phone=json['phone'];
  img=json['img'];
  points=json['points'];
  credit=json['credit'];
  token=json['token'];

}
}