import 'package:bills_control/cubits/constant_es_cubits.dart';
import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/cubits/data_cubits_models.dart';
import 'package:bills_control/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelector extends StatelessWidget {
  final TextEditingController controller;

  const CategorySelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.texto_categoria,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.arrow_drop_down),
      ),
      onTap: () async {
        final selectedCategory = await showModalBottomSheet<String>(
          context: context,
          builder: (context) => const CategorySelectionSheet(),
        );

        if (selectedCategory != null) {
          controller.text = selectedCategory;
        }
      },
    );
  }
}

class CategorySelectionSheet extends StatelessWidget {
  const CategorySelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.texto_hogar),
              Tab(text: AppLocalizations.of(context)!.texto_trabajo),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              children: AppLocalizations.of(context)!.texto_hogar == 'Hogar'
                  ? [
                      _CategoryList<CateHomeEsCubit>(),
                      _CategoryList<CateWorkEsCubit>(),
                    ]
                  : AppLocalizations.of(context)!.texto_hogar == 'Casa'
                  ? [
                      _CategoryList<CateHomeBrCubit>(),
                      _CategoryList<CateWorkBrCubit>(),
                    ]
                  : [
                      _CategoryList<CateHomeEnCubit>(),
                      _CategoryList<CateWorkEnCubit>(),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryList<T extends Cubit<List<CatType>>> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, List<CatType>>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final category = state[index];
            return ListTile(
              title: Text(category.name),
              onTap: () {
                Navigator.pop(context, category.name);
              },
            );
          },
        );
      },
    );
  }
}
