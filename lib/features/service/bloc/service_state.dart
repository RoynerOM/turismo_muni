part of 'service_bloc.dart';

class ServiceState<T> {
  final ServicesReact? react;
  final List<ServiceModel> services;
  final List<ServiceModel> filterServices;
  final List<ServiceModel> lodges;

  ServiceState({
    this.react,
    this.lodges = const [],
    this.services = const [],
    this.filterServices = const [],
  });

  ServiceState<T> copyWith(
    ServiceState state, {
    ServicesReact? react,
    List<ServiceModel>? services,
    List<ServiceModel>? filterServices,
    List<ServiceModel>? lodges,
  }) =>
      ServiceState<T>(
        react: react ?? state.react,
        lodges: lodges ?? state.lodges,
        filterServices: filterServices ?? state.filterServices,
        services: services ?? state.services,
      );
}

enum ServicesReact {
  initial,
  getLoading,
  getSuccess,
  getError,

  postLoading,
  postSuccess,
  postError,

  updateLoading,
  updateSuccess,
  updateError,

  deleteLoading,
  deleteSuccess,
  deleteError,
}
