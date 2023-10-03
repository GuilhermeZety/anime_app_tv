part of 'initial_cubit.dart';

sealed class InitialState extends Equatable {
  const InitialState();

  @override
  List<Object> get props => [];
}

final class InitialInitial extends InitialState {}

final class InitialSetState extends InitialState {}
