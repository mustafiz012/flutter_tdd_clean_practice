import 'package:flutter_tdd_clean_practice/core/utils/input_converter.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:get_it/get_it.dart';

import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

void init() {
  /// Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
        inputConverter: sl()),
  );

  // User cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  /// Core
  sl.registerLazySingleton(() => InputConverter());

  ///
  /// External
}
