

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:news_app/cubit/ShopCubit/cubit/cubit.dart';
import 'package:news_app/cubit/ShopCubit/state/state.dart';
import 'package:news_app/model/categories/categories.dart';
import 'package:news_app/model/home_model/HomeModel.dart';
import 'package:news_app/shared/Styles/Colors.dart';
import 'package:news_app/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ChangeFavouriteSuccess){
          if(!state.model.status!){
            ShowToast(title: 'Avadakdafra',
                direction: ORIENTATION.ltr,
                style:const TextStyle(fontWeight: FontWeight.bold) ,
                description: state.model.message,
                context: context,
                color: Colors.red,
                time: 3,
                icon: Icons.error);

          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&ShopCubit.get(context).categoriesModel != null,
          builder: (context) =>
              ProductsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget ProductsBuilder(HomeModel model, CategoriesModel categoriesModel,context) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.img?? 'https://www.coywolf.news/wp-content/uploads/2020/05/og-shop-app.png'}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlay: true,
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BuildCategoriesItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel.data!.data.length),
                ),
                const SizedBox(height: 30,),
                const Text(
                  "New Products",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30,),

              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.58,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(model.data!.products.length,
                  (index) => ProductBuilder(model.data!.products[index],context)),
            ),
          ),
        ],
      ),
    );

Widget ProductBuilder(ProductModel model ,context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.img}'),
              width: double.infinity,
              height: 200,
            ),
            if (model.discount > 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
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
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
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
                  if (model.discount != 0)
                    Text(
                      '${model.old_price.round()}',
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
                    backgroundColor: ShopCubit.get(context).favourite[model.id]!  ? defultColor : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                           ShopCubit.get(context).ChangeFavourite(model.id!);
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
  );
}

Widget BuildCategoriesItem(DataModel model) => Stack(
      children: [
        Image(
          image: NetworkImage('${model.img }'),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.78),
          child: Text("${model.name}",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      alignment: AlignmentDirectional.bottomCenter,
    );
