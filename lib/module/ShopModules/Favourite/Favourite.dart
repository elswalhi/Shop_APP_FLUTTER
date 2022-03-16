import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/module/login/loginCubit/state/states.dart';

import '../../../cubit/ShopCubit/cubit/cubit.dart';
import '../../../cubit/ShopCubit/state/state.dart';
import '../../../model/getFavoriteModel/getfavorite.dart';
import '../../../shared/Styles/Colors.dart';
import '../../../shared/components/components.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return   ConditionalBuilder(
          condition:state is! shopLoginLoading,
          builder:(context)=> ListView.separated(itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoriteModel!.data!.data![index],context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: ShopCubit.get(context).favoriteModel!.data!.data!.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildFavItem(FavoriteData model , context )=>Padding(
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
                image: NetworkImage('${model.product!.image}'),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if (model.product!.discount! > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.product!.name}',
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
                      '${model.product!.price}',
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
                    if (model.product!.discount! != 0)
                      Text(
                        '${model.product!.oldPrice!}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favourite[model.product!.id]??false  ? defultColor : Colors.grey,
                      child: IconButton(
                          onPressed: () {
                             ShopCubit.get(context).ChangeFavourite(model.product!.id!);
                          },
                          icon: Icon(
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
}
