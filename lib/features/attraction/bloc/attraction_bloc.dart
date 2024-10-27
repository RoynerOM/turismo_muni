import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/features/attraction/models/attraction_model.dart';
import 'package:turismo_upala/features/attraction/models/lodge_model.dart';
import 'package:http/http.dart' as http;

part 'attraction_event.dart';
part 'attraction_state.dart';

typedef React = AttractionsReact;
typedef Emit = Emitter<AttractionState>;

class AttractionBloc extends Bloc<AttractionEvent, AttractionState> {
  AttractionBloc() : super(AttractionState(react: React.initial)) {
    on<CreateAttractionEvent>((event, emit) async {
      emit(AttractionState(react: React.postLoading));
      try {
        final lodgeResponse = await http.post(
          Uri.parse('https://muniupala.go.cr/turismo/api/attractions.php'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(event.lodge.toJson()),
        );

        if (lodgeResponse.statusCode != 200) {
          throw Exception('Error al enviar lodge: ${lodgeResponse.statusCode}');
        }

        emit(AttractionState(react: React.postSuccess));
      } catch (e) {
        emit(AttractionState(react: React.postError));
      }
    });
    on<LoadAttractionEvent>((event, emit) async {
      emit(AttractionState(react: React.getLoading));
      await onLoadAttractions(event, emit);
    });
  }

  Future<void> onLoadAttractions(LoadAttractionEvent evt, Emit emit) async {
    List<LodgeModel> list = [];
    List<AttractionsModel> attrations = [];
    try {
      final response = await Future.wait([
        http.get(
          Uri.parse('https://muniupala.go.cr/turismo/api/lodges.php'),
          headers: {'Content-Type': 'application/json'},
        ),
        http.get(
          Uri.parse('https://muniupala.go.cr/turismo/api/attractions.php'),
          headers: {'Content-Type': 'application/json'},
        )
      ]);

      if (response[0].statusCode == 200 && response[1].statusCode == 200) {
        list = lodgeModelFromJson(response[0].body);
        attrations = attractiveModelFromJson(response[1].body);
      } else {
        throw Exception('Error en la respuesta de la API');
      }

      emit(
        AttractionState(
          react: React.getSuccess,
          attractions: attrations,
          filterAttractions: attrations,
          lodges: list,
        ),
      );
    } catch (e) {
      emit(AttractionState(react: React.getError));
    }
  }
}
