import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/cubits/data_cubits_models.dart';

class CateHomeEnCubit extends Cubit<List<CatType>> {
  CateHomeEnCubit()
    : super([
        CatType('Market'),
        CatType('Transport'),
        CatType('Lodging'),
        CatType('Food'),
        CatType('Health'),
        CatType('School'),
        CatType('Home'),
        CatType('Garden'),
        CatType('Jewelry'),
        CatType('Books'),
        CatType('Pets'),
        CatType('Salon'),
        CatType('Technology'),
        CatType('Tourism'),
        CatType('Clothing'),
        CatType('Services'),
        CatType('Other'),
      ]);
}

class CateWorkEnCubit extends Cubit<List<CatType>> {
  CateWorkEnCubit()
    : super([
        CatType('Transport'),
        CatType('Food'),
        CatType('Lodging'),
        CatType('Materials'),
        CatType('Snacks'),
        CatType('Services'),
        CatType('Miscellaneous'),
        CatType('Other'),
      ]);
}
