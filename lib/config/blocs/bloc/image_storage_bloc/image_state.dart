part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImagePickerInProgress extends ImageState {}

class ImagePickerSuccessful extends ImageState {
  File image;
  ImagePickerSuccessful(this.image);

  @override
  List<Object> get props => [image];
}

class ImagePickerFailed extends ImageState {
  String message;

  ImagePickerFailed(this.message);

  @override
  List<Object> get props => [message];
}

class SaveInterestInProgress extends ImageState {}

class SaveInterestSuccessful extends ImageState {
  // File image;
  // SaveInterestSuccessful(this.image);

  // @override
  // List<Object> get props => [image];
}

class SaveInterestFailed extends ImageState {
  String message;

  SaveInterestFailed(this.message);

  @override
  List<Object> get props => [message];
}
