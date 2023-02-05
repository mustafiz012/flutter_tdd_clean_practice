import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tdd_clean_practice/core/usecases/usecase.dart';
import 'package:flutter_tdd_clean_practice/core/utils/app_constants.dart';
import 'package:flutter_tdd_clean_practice/core/utils/input_converter.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../../../../core/error/failures.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaState get initialState => Empty();

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final Either inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      await inputEither.fold(
        (failure) async => emit(Error(message: cInvalidInputFailureMessage)),
        (integer) async {
          emit(Loading());
          emit(CacheLoaded(
              trivia: const NumberTrivia("Cached trivia for 11", 11)));
          await Future.delayed(const Duration(seconds: 2));
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          _eitherLoadedOrFailure(failureOrTrivia, emit);
        },
      );
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      _eitherLoadedOrFailure(failureOrTrivia, emit);
    });
  }

  void _eitherLoadedOrFailure(Either<Failure, NumberTrivia> failureOrTrivia,
      Emitter<NumberTriviaState> emit) {
    failureOrTrivia.fold(
      (failure) => emit(Error(
        message: _mapFailureToMessage(failure),
      )),
      (trivia) {
        emit(Loaded(trivia: trivia));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return cServerFailureMessage;
      case CacheFailure:
        return cCacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
