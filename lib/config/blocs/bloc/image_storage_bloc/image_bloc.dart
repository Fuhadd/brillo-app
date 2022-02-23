import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brilloapp/config/repositories/firease_storage_repository.dart';
import 'package:brilloapp/config/repositories/firestore_repository.dart';
import 'package:equatable/equatable.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  FirebaseStorageRepository firebaseStorageRepository;
  FirestoreRepository firestoreRepository;
  ImageBloc(this.firebaseStorageRepository, this.firestoreRepository)
      : super(ImageInitial()) {
    on<ImagePickerEvent>(_handleImagePicking);
    on<SaveInterestsEvent>(_handleSaveInterests);
  }

  FutureOr<void> _handleImagePicking(
      ImagePickerEvent event, Emitter<ImageState> emit) async {
    try {
      emit(ImagePickerInProgress());
      final imagePath = await firebaseStorageRepository.pickImageFromGallery();
      if (imagePath.isNotEmpty) {
        File image = File(imagePath);
        //emit(ImagePickerSuccessful(image));
        await firebaseStorageRepository.uploadImage(image);

        emit(ImagePickerSuccessful(image));
      } else {
        emit(ImagePickerFailed('No Image Selected'));
      }
    } catch (error) {
      emit(ImagePickerFailed(error.toString()));
    }
  }

  FutureOr<void> _handleSaveInterests(
      SaveInterestsEvent event, Emitter<ImageState> emit) async {
    try {
      emit(SaveInterestInProgress());
      await firestoreRepository.saveInterests(event.interests);
      emit(SaveInterestSuccessful());
    } catch (error) {
      emit(SaveInterestFailed(error.toString()));
    }
  }
}
