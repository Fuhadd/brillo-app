part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class ImagePickerEvent extends ImageEvent {}

class SaveInterestsEvent extends ImageEvent {
  List<String> interests;
  SaveInterestsEvent({required this.interests});
}
