import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosptial_project/patient/patient_ui/search/Cubit_Search/States.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super (SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  void search(){

  }
}