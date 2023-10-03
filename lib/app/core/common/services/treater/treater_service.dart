import 'dart:developer';

import 'package:anime_app_tv/app/core/common/errors/exceptions.dart';
import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/common/services/connection/connection_checker_plus_service_impl.dart';
import 'package:dartz/dartz.dart';

class TreaterService {
  Future<Either<Failure, T>> call<T>(
    Future<T> Function() code, {
    String? errorIdentification,
    bool online = true,
  }) async {
    if (await ConnectionCheckerPlusServiceImpl().isConnected || !online) {
      try {
        return Right(await code());
      } on ServerException catch (e) {
        log(e.toString(), stackTrace: e.stackTrace);

        return Left(
          Failure(
            message: e.message ?? errorIdentification ?? '',
            stackTrace: e.stackTrace,
          ),
        );
      } on Exception catch (e) {
        log(e.toString(), stackTrace: StackTrace.current);

        return Left(
          Failure(
            message: e.toString(),
          ),
        );
      } on Failure catch (e) {
        log(e.toString(), stackTrace: e.stackTrace);

        return Left(e);
      } catch (e) {
        if (e is TypeError) {
          log(e.toString(), error: e, stackTrace: e.stackTrace, name: 'TypeError');
        } else {
          log(e.toString(), error: e);
        }
        if (e is ServerException) {
          return Left(
            ServerFailure(
              message: e.message ?? '',
            ),
          );
        }
        return Left(
          Failure(
            message: e.toString(),
          ),
        );
      }
    } else {
      return const Left(Failure(message: 'Sem conexão com a internet'));
    }
  }
}
