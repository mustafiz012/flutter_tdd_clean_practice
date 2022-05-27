part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  const GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object?> get props => [];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  @override
  List<Object?> get props => [];
}
