import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/cubits/data_cubits_models.dart';

class CateHomeBrCubit extends Cubit<List<CatType>> {
  CateHomeBrCubit()
    : super([
        CatType('Mercado'),
        CatType('Transporte'),
        CatType('Hospedagem'),
        CatType('Alimentação'),
        CatType('Saúde'),
        CatType('Escola'),
        CatType('Casa'),
        CatType('Jardim'),
        CatType('Joalheria'),
        CatType('Livros'),
        CatType('Pets'),
        CatType('Salão'),
        CatType('Tecnologia'),
        CatType('Turismo'),
        CatType('Vestuário'),
        CatType('Serviços'),
        CatType('Outros'),
      ]);
}

class CateWorkBrCubit extends Cubit<List<CatType>> {
  CateWorkBrCubit()
    : super([
        CatType('Transporte'),
        CatType('Alimentação'),
        CatType('Hospedagem'),
        CatType('Materiais'),
        CatType('Lanches'),
        CatType('Serviços'),
        CatType('Diversos'),
        CatType('Outros'),
      ]);
}
