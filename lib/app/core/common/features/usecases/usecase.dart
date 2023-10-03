import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:anime_app_tv/app/core/common/errors/failures.dart';

abstract class Usecase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

abstract class StreamUsecase<ReturnType, Params> {
  Future<Either<Failure, Stream<ReturnType>>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
