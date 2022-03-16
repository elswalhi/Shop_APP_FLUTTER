import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/ShopCubit/cubit/cubit.dart';
import 'package:news_app/cubit/ShopCubit/state/state.dart';
import 'package:news_app/module/ShopModules/SearchScreen/SearchScreen.dart';
import 'package:news_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
              navigateTo(context,  SearchScreen());
        }, icon:const Icon(Icons.search)
              )],
            title: const Text(
              "Salla",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: cubit.Screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.ChangeScreen(index);
            },
            currentIndex:cubit.currentindex ,
            items: const [
            BottomNavigationBarItem(icon:Icon(Icons.home),label: "Products"),
            BottomNavigationBarItem(icon:Icon(Icons.apps),label: "Categories"),
            BottomNavigationBarItem(icon:Icon(Icons.favorite),label: "Favorite"),
            BottomNavigationBarItem(icon:Icon(Icons.settings),label: "Settings"),

          ],),
        );
      },

    );
  }
}
