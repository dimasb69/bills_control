import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/cubits/data_cubits_models.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelector extends StatelessWidget {
  final TextEditingController controller;

  const CategorySelector({Key? key, required this.controller})
    : super(key: key);

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
  const CategorySelectionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.texto_hogar),
              Tab(text: AppLocalizations.of(context)!.texto_trabajo),
              Tab(text: AppLocalizations.of(context)!.texto_personalizado),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              children: [
                AppLocalizations.of(context)!.texto_hogar == 'Hogar'
                    ? const _CategoryList<CateHomeEsCubit>()
                    : AppLocalizations.of(context)!.texto_hogar == 'Casa'
                        ? const _CategoryList<CateHomeBrCubit>()
                        : const _CategoryList<CateHomeEnCubit>(),
                AppLocalizations.of(context)!.texto_hogar == 'Hogar'
                    ? const _CategoryList<CateWorkEsCubit>()
                    : AppLocalizations.of(context)!.texto_hogar == 'Casa'
                        ? const _CategoryList<CateWorkBrCubit>()
                        : const _CategoryList<CateWorkEnCubit>(),
                const _CustomCategoryList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              AppLocalizations.of(context)!.category_notice,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryList<T extends Cubit<List<CatType>>> extends StatelessWidget {
  const _CategoryList({Key? key}) : super(key: key);
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

class _CustomCategoryList extends StatefulWidget {
  const _CustomCategoryList({Key? key}) : super(key: key);

  @override
  State<_CustomCategoryList> createState() => _CustomCategoryListState();
}

class _CustomCategoryListState extends State<_CustomCategoryList> {
  final TextEditingController _newCategoryController = TextEditingController();

  @override
  void dispose() {
    _newCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newCategoryController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.label_new_category,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  if (_newCategoryController.text.isNotEmpty) {
                    context.read<CategoriasCustomCubit>().addCategoria(
                      _newCategoryController.text,
                    );
                    _newCategoryController.clear();
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<CategoriasCustomCubit, List<Categoria>>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final category = state[index];
                  return ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<CategoriasCustomCubit>().removeCategoria(
                          category.id,
                        );
                      },
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                      Navigator.pop(context, category.name);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
