part of 'lodge_bloc.dart';

abstract class LodgeEvent {}

class LoadLodgeEvent extends LodgeEvent {}

class CreateLodgeEvent extends LodgeEvent {
  final Lodge lodge;
  final Contact contact;
  final List<Service> services;
  final List<GalleryImage> images;
  final List<Information> information;

  CreateLodgeEvent({
    required this.lodge,
    required this.contact,
    required this.services,
    required this.images,
    required this.information,
  });
}

class UpdateLodgeEvent extends LodgeEvent {}

class DeleteLodgeEvent extends LodgeEvent {}
