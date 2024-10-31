import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/app/spinner/dual_ring.dart';
import 'package:turismo_upala/features/lodge/models/lodge_list_model.dart'
    as exp;
import 'package:turismo_upala/features/lodge/pages/lodge_home_page.dart';
import 'package:turismo_upala/features/service/bloc/service_bloc.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});
  final List<Map<String, String>> services = [
    {
      'image':
          'https://muniupala.go.cr/imagenes/turismo/img_671e753777c837.44950034.jpg',
      'title': 'Tour de Flora',
      'description':
          'Explora la biodiversidad de plantas únicas en nuestra región.'
    },
    {
      'image':
          'https://muniupala.go.cr/imagenes/turismo/img_671e753777c837.44950034.jpg',
      'title': 'Fauna Silvestre',
      'description': 'Descubre la fauna autóctona en su hábitat natural.'
    },
    {
      'image':
          'https://muniupala.go.cr/imagenes/turismo/img_671e753777c837.44950034.jpg',
      'title': 'Gastronomía Local',
      'description':
          'Disfruta de un tour gastronómico con platos típicos de la región.'
    },
    {
      'image':
          'https://muniupala.go.cr/imagenes/turismo/img_671e753777c837.44950034.jpg',
      'title': 'Hospedaje Eco-Friendly',
      'description':
          'Relájate en un alojamiento sostenible rodeado de naturaleza.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
        if (state.react == React.getLoading) {
          return const Center(
            child: DualRing(
              message: 'Cargando Servicios',
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(60, 24, 60, 24),
          itemCount: state.filterServices.length,
          itemBuilder: (context, index) {
            final model = state.filterServices[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LodgeHomePage(
                      model: exp.LodgeModel.fromJson(model.toJson()),
                    ),
                  ),
                );
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.gallery.isNotEmpty)
                      Image.network(
                        model.gallery.first.url,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        model.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        model.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 575,
            mainAxisExtent: 400,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
        );
      },
    );
  }
}
