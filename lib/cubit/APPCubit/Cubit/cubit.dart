import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/APPCubit/state/state.dart';

class APPCubit extends Cubit<AppStates>{
  APPCubit() : super(APPInitialState());
  static APPCubit get(context)=>BlocProvider.of(context);

}