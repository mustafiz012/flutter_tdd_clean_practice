import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_practice/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_practice/core/error/failures.dart';
import 'package:flutter_tdd_clean_practice/core/platform/network_info.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../datasources/number_trivia_local_data_source.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTrivia> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final lastTrivia = await localDataSource.getLastNumberTrivia();
        return Right(lastTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
