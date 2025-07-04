import 'package:equatable/equatable.dart';

enum RxStatus { loading, success, empty, error }

class BaseState<T> extends Equatable {
  final RxStatus status;
  final T? data;
  final String? errorMessage;

  const BaseState({
    this.status = RxStatus.loading,
    this.data,
    this.errorMessage,
  });

  BaseState<T> copyWith({
    RxStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
