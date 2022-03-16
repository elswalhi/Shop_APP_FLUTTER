import 'package:flutter/material.dart';
import 'package:news_app/module/login/login.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/shared/Styles/Colors.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BordingModel{
   final String? img;
  final String? title;
  final String? body;
      BordingModel({
        @required this.img,
        @required this.title,
        @required this.body,
      });
}
class onBordingScreen extends StatefulWidget {
   onBordingScreen({Key? key}) : super(key: key);

  @override
  State<onBordingScreen> createState() => _onBordingScreenState();
}

class _onBordingScreenState extends State<onBordingScreen> {
  List<BordingModel> boarding=[
    BordingModel(img: 'assets/img/onboard_1.jpg', title: "on Borad 1 title", body: "on Borad 1 body"),
    BordingModel(img: 'assets/img/onboard_1.jpg', title: "on Borad 2 title", body: "on Borad 2 body"),
    BordingModel(img: 'assets/img/onboard_1.jpg', title: "on Borad 3 title", body: "on Borad 3 body")

  ];

   bool isLast=false;

  var boardController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: Text('SKIP',style: TextStyle(fontSize: 16),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index==(boarding.length-1)){
                    setState(() {
                      isLast=true;
                    });
                  }
                  else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics:const BouncingScrollPhysics() ,
                itemBuilder: (context, index) =>PageViewBuilder(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                 SmoothPageIndicator(
                    controller: boardController,
                    effect:const ExpandingDotsEffect(
                    activeDotColor:defultColor,
                        dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,

                    ) ,
                     count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defultColor,
                  onPressed: (){
                    submit();
                    isLast? navigateAndFinish(context,  login()) :boardController.nextPage(duration: const Duration(
                          milliseconds: 750,
                        ),curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child:const Icon(Icons.arrow_forward_ios) ,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget PageViewBuilder(BordingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(

          image: AssetImage('${model.img}'),
        ),
      ),
      const SizedBox(height: 15,),
      Text("${model.title}",style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      const SizedBox(height: 15,),
      Text("${model.body}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      const SizedBox(height: 15,),

    ],
  );

  void submit(){
    CacheHelper.SaveData(
        key: 'onBoarding',
        value: true
    ).then((value) {
      if(value){
        navigateAndFinish(
            context,
            login()
        );
      }
    });
  }
}
