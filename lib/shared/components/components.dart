import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../cubit/ShopCubit/cubit/cubit.dart';
import '../Styles/Colors.dart';
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required  function,
  @required  text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defultTextButton({
    @required String? text,
    @required function}
    )=> TextButton(onPressed: function, child:Text(text!.toUpperCase()));


Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? type,
   onSubmit,
   onChange,
   onTap,
  bool isPassword = false,
  @required  validate,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
   suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted:onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget myDivider()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);


void navigateTo(context,Widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>Widget),
);
void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>Widget)
    , (route) => false);
void ShowToast({
  @required String? title,
   TextStyle? style,
  @required String? description,
  direction=ORIENTATION.rtl,
  animationType=ANIMATION.fromRight,
  @required context,
  @required Color? color,
  double width=300,
  required int time,
  required IconData icon
}){
  return MotionToast(
    toastDuration: Duration(seconds:time ),
    title:  Text("$title",style: style,),
    description:Text("$description",maxLines: 2,overflow: TextOverflow.ellipsis,) ,
    width:width, primaryColor: color!, icon: icon,
    layoutOrientation: direction,
    animationType: ANIMATION.fromRight,

  ).show(context);

}
Widget buildSearchItem( model , context )=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(

          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),

          ],
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: defultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),

                  const Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context).favourite[model.id]??false  ? defultColor : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).ChangeFavourite(model.id!);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
