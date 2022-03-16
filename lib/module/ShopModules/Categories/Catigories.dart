import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/ShopCubit/cubit/cubit.dart';
import 'package:news_app/cubit/ShopCubit/state/state.dart';
import 'package:news_app/model/categories/categories.dart';

import '../../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return   ListView.separated(itemBuilder: (context, index) => BuildCategoriesItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=>myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
        );
      },
    );
  }
}

Widget BuildCategoriesItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(image: NetworkImage('${model.img}'),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20,),
      Text("${model.name}",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
      Spacer(),
      Icon(Icons.arrow_forward_ios),
    ],
  ),
);