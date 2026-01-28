import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/cubits/data_cubits_models.dart';

class CateHomeCubit extends Cubit<List<CatType>> {
  CateHomeCubit()
    : super([
        CatType('Mercado'),
        CatType('Transporte'),
        CatType('Hospedaje'),
        CatType('Alimentacion'),
        CatType('Salud'),
        CatType('Colegio'),
        CatType('Hogar'),
        CatType('Jardin'),
        CatType('Joyeria'),
        CatType('Libros'),
        CatType('Mascotas'),
        CatType('Salon'),
        CatType('Tecnologia'),
        CatType('Turismo'),
        CatType('Vestuario'),
        CatType('Servicios'),
        CatType('Otro'),
      ]);
}

class CateWorkCubit extends Cubit<List<CatType>> {
  CateWorkCubit()
    : super([
        CatType('Transporte'),
        CatType('Alimentacion'),
        CatType('Hospedaje'),
        CatType('Materiales'),
        CatType('Snacks'),
        CatType('Servicios'),
        CatType('Miscelaneos'),
        CatType('Otros'),
      ]);
}
