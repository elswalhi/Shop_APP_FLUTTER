class ChangeFavouriteModel{
  bool? status;
  String? message;
  ChangeFavouriteModel.fromJason(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}