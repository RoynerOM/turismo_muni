import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/features/lodge/models/loadge_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:turismo_upala/features/lodge/models/lodge_list_model.dart';

part 'lodge_event.dart';
part 'lodge_state.dart';

typedef React = LodgeReact;
typedef Emit = Emitter<LodgeState>;

class LodgeBloc extends Bloc<LodgeEvent, LodgeState> {
  LodgeBloc() : super(LodgeState(react: React.initial)) {
    on<CreateLodgeEvent>((event, emit) async {
      emit(LodgeState(react: React.postLoading));
      try {
        final lodgeResponse = await http.post(
          Uri.parse('https://muniupala.go.cr/turismo/api/lodges.php'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(event.lodge.toJson()),
        );

        if (lodgeResponse.statusCode != 200) {
          throw Exception('Error al enviar lodge: ${lodgeResponse.statusCode}');
        }

        String? generatedId = jsonDecode(lodgeResponse.body)['id'];
        await Future.wait([
          onCreateContact(event, emit, int.parse(generatedId ?? '0')),
          onCreateService(event, emit, int.parse(generatedId ?? '0')),
          onCreateImages(event, emit, int.parse(generatedId ?? '0')),
          onCreateInformation(event, emit, int.parse(generatedId ?? '0')),
        ]);

        emit(LodgeState(react: React.postSuccess));
      } catch (e) {
        emit(LodgeState(react: React.postError));
      }
    });

    on<LoadLodgeEvent>((event, emit) async {
      emit(LodgeState(react: React.getLoading));
      await onLoadLodge(event, emit);
    });
  }

  Future<void> onLoadLodge(LoadLodgeEvent evt, Emit emit) async {
    List<LodgeModel> list = [];
    try {
      final contactResponse = await http.get(
        Uri.parse('https://muniupala.go.cr/turismo/api/lodges.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (contactResponse.statusCode == 200) {
        list = lodgeModelFromJson(contactResponse.body);
      }

      emit(
        LodgeState(
          react: React.getSuccess,
          lodges: list,
          filterLodges: list,
        ),
      );
    } catch (e) {
      emit(LodgeState(react: React.getError));
    }
  }

  Future<void> onCreateContact(CreateLodgeEvent evt, Emit emit, int? id) async {
    try {
      final contactResponse = await http.post(
        Uri.parse('https://muniupala.go.cr/turismo/api/contact.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(evt.contact.toJson(id)),
      );

      if (contactResponse.statusCode != 200 &&
          contactResponse.statusCode != 201) {
        throw Exception(
          'Error al enviar contacto: ${contactResponse.statusCode}',
        );
      }
    } catch (e) {
      emit(LodgeState(react: React.postError));
    }
  }

  Future<void> onCreateService(CreateLodgeEvent evt, Emit emit, int? id) async {
    try {
      for (Service service in evt.services) {
        final serviceResponse = await http.post(
          Uri.parse('https://muniupala.go.cr/turismo/api/services.php'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(service.toJson(id)),
        );

        if (serviceResponse.statusCode != 200 &&
            serviceResponse.statusCode != 201) {
          throw Exception(
              'Error al enviar servicio: ${serviceResponse.statusCode}');
        }
      }
    } catch (e) {
      emit(LodgeState(react: React.postError));
    }
  }

  Future<void> onCreateImages(CreateLodgeEvent evt, Emit emit, int? id) async {
    try {
      for (GalleryImage image in evt.images) {
        final imageResponse = await http.post(
          Uri.parse('https://muniupala.go.cr/turismo/api/gallery.php'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(image.toJson(id)),
        );

        if (imageResponse.statusCode != 200 &&
            imageResponse.statusCode != 201) {
          throw Exception(
              'Error al enviar imagen: ${imageResponse.statusCode}');
        }
      }
    } catch (e) {
      emit(LodgeState(react: React.postError));
    }
  }

  Future<void> onCreateInformation(
      CreateLodgeEvent evt, Emit emit, int? id) async {
    try {
      for (Information info in evt.information) {
        final infoResponse = await http.post(
          Uri.parse('https://muniupala.go.cr/turismo/api/info.php'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(info.toJson(id)),
        );

        if (infoResponse.statusCode != 200 && infoResponse.statusCode != 201) {
          throw Exception(
              'Error al enviar información: ${infoResponse.statusCode}');
        }
      }
    } catch (e) {
      emit(LodgeState(react: React.postError));
    }
  }
}
