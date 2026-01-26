import 'package:bills_control/cubits/gastos_cubits.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/screens/add_bils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

TextEditingController motivoController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController newAmountController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController idUpdateController = TextEditingController();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Control de Gastos"),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewControl()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GastosCubits, List<Gasto>>(
          builder: (context, state) {
            print('------------------------------------------------');
            print(state.toString());
            print('------------------------------------------------');
            if (state.isEmpty) {
              return Container(
                alignment: Alignment.center,
                height: 100.h,
                child: const Center(child: Text("No hay gastos")),
              );
            } else {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      state[index].motivo,
                      style: TextStyle(fontSize: 5.w, color: Colors.white),
                    ),
                    subtitle: Text(
                      "${state[index].amount} \$",
                      style: TextStyle(fontSize: 3.w, color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<GastosCubits>().dellGasto(state[index].id);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
