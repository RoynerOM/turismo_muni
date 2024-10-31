import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/features/service/model/service_model.dart';
import 'package:http/http.dart' as http;

part 'service_event.dart';
part 'service_state.dart';

typedef React = ServicesReact;
typedef Emit = Emitter<ServiceState>;

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceState(react: React.initial)) {
    on<LoadServiceEvent>((event, emit) async {
      emit(ServiceState(react: React.getLoading));
      await onLoadServices(event, emit);
    });
  }

  Future<void> onLoadServices(LoadServiceEvent evt, Emit emit) async {
    List<ServiceModel> list = [];

    try {
      final response = await http.get(
        Uri.parse('https://muniupala.go.cr/turismo/api/lodges.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 && response.statusCode == 200) {
        list = serviceModelFromJson(response.body);
      } else {
        throw Exception('Error en la respuesta de la API');
      }

      emit(
        ServiceState(
          react: React.getSuccess,
          services: list,
          filterServices: list,
          lodges: list,
        ),
      );
    } catch (e) {
      emit(ServiceState(react: React.getError));
    }
  }
}
