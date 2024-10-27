import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/app/spinner/dual_ring.dart';
import 'package:turismo_upala/features/attraction/bloc/attraction_bloc.dart';
import 'package:turismo_upala/features/attraction/pages/form_page.dart';

class ListAtractionPage extends StatelessWidget {
  const ListAtractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AttractionBloc, AttractionState>(
        listener: (context, state) {
          if (state.react == React.deleteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Huvo un error al eliminar')),
            );
          }

          if (state.react == React.deleteSuccess) {
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
              mainAxisExtent: 120,
            ),
            itemCount: state.filterAttractions.length,
            itemBuilder: (context, index) {
              final item = state.filterAttractions[index];
              return ListTile(
                tileColor: Colors.teal.withOpacity(0.1),
                onTap: () {},
                leading: Text(item.lodgeId),
                title: Text(
                  item.category,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
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
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AttractionsFormPage(),
            ),
          );
        },
      ),
    );
  }
}
