import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/app/spinner/dual_ring.dart';
import 'package:turismo_upala/features/lodge/bloc/lodge_bloc.dart';
import 'package:turismo_upala/features/lodge/pages/lodge_form_page.dart';
import 'package:turismo_upala/features/lodge/pages/lodge_home_page.dart';

class ListExperiencesPage extends StatelessWidget {
  const ListExperiencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LodgeBloc, LodgeState>(
        listener: (context, state) {
          if (state.react == LodgeReact.deleteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Huvo un error al eliminar')),
            );
          }

          if (state.react == LodgeReact.deleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Eliminado')),
            );
          }
        },
        builder: (context, state) {
          if (state.react == React.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminado',
              ),
            );
          }

          if (state.react == React.getLoading) {
            return const Center(
              child: DualRing(
                message: 'Cargando Experiencias',
              ),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 600,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 0.8,
                mainAxisExtent: 80),
            itemCount: state.filterLodges.length,
            itemBuilder: (context, index) {
              final item = state.filterLodges[index];
              return ListTile(
                tileColor: Colors.teal.withOpacity(0.1),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LodgeHomePage(model: item),
                    ),
                  );
                },
                title: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LodgeFormPage(),
            ),
          );
        },
      ),
    );
  }
}
