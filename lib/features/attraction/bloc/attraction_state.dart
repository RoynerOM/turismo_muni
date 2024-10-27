part of 'attraction_bloc.dart';

class AttractionState<T> {
  final AttractionsReact? react;
  final List<AttractionsModel> attractions;
  final List<AttractionsModel> filterAttractions;
  final List<LodgeModel> lodges;

  AttractionState({
    this.react,
    this.lodges = const [],
    this.attractions = const [],
    this.filterAttractions = const [],
  });

  AttractionState<T> copyWith(
    AttractionState state, {
    AttractionsReact? react,
    List<LodgeModel>? lodges,
    List<AttractionsModel>? filterAttractions,
    List<AttractionsModel>? attractions,
  }) =>
      AttractionState<T>(
        react: react ?? state.react,
        lodges: lodges ?? state.lodges,
        filterAttractions: filterAttractions ?? state.filterAttractions,
        attractions: attractions ?? state.attractions,
      );
}

enum AttractionsReact {
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
