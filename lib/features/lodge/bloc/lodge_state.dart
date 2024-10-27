part of 'lodge_bloc.dart';

class LodgeState<T> {
  final LodgeReact? react;
  final List<LodgeModel> lodges;
  final List<LodgeModel> filterLodges;
  final LodgeModel? lodge;

  LodgeState({
    this.react,
    this.lodges = const [],
    this.filterLodges = const [],
    this.lodge,
  });

  LodgeState<T> copyWith(
    LodgeState state, {
    LodgeReact? react,
    List<LodgeModel>? lodges,
    List<LodgeModel>? filterLodges,
    LodgeModel? lodge,
  }) =>
      LodgeState<T>(
        react: react ?? state.react,
        lodges: lodges ?? state.lodges,
        filterLodges: filterLodges ?? state.filterLodges,
        lodge: lodge ?? state.lodge,
      );
}

enum LodgeReact {
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
