import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/ShopCubit/cubit/cubit.dart';
import 'package:news_app/cubit/ShopCubit/state/state.dart';
import 'package:news_app/shared/components/components.dart';
class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(builder: (Context,state){
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                defaultFormField(controller: searchController,
                    type: TextInputType.text,
                    validate: (String value){
                    if (value.isEmpty){
                      return "you must put some words";
                    }
                    return null ;
                    },
                    label: "Search",
                    prefix: Icons.search,
                onChange: (String text){
                  if(formkey.currentState!.validate()){
                    ShopCubit.get(context).SearchData(text);
                  }
                }),
                const SizedBox(height: 10,),
               if(state is SearchLoding)
               const LinearProgressIndicator(),
                const SizedBox(height: 20,),
                if(state is SearchSuccess)
                  Expanded(
                    child: ListView.separated(itemBuilder: (context, index) => buildSearchItem(ShopCubit.get(context).model.data!.data![index],context),
                      separatorBuilder: (context,index)=>myDivider(),
                      itemCount: ShopCubit.get(context).model.data!.data!.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    }, listener: (Context,state){}) ;
  }
}
