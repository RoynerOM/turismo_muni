part of 'attraction_bloc.dart';

abstract class AttractionEvent {}

class LoadAttractionEvent extends AttractionEvent {}

class LoadLodgeAttractionEvent extends AttractionEvent {}

class CreateAttractionEvent extends AttractionEvent {
  final AttractionsModel lodge;
  CreateAttractionEvent({required this.lodge});
}

class UpdateAttractionEvent extends AttractionEvent {}

class DeleteAttractionEvent extends AttractionEvent {}
