part of 'upload_product_bloc.dart';

abstract class UploadProductState extends Equatable {
  const UploadProductState();

  @override
  List<Object> get props => [];
}

class UploadProductInitial extends UploadProductState {}

class UploadProductLoading extends UploadProductState {}

class UploadProductSuccess extends UploadProductState {
  final String message;
  const UploadProductSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class UploadProductFailed extends UploadProductState {
  final String message;
  const UploadProductFailed({required this.message});
  @override
  List<Object> get props => [message];
}
