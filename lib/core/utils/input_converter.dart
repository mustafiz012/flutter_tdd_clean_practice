import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_practice/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String stringNumber) {
    try {
      final number = int.parse(stringNumber);
      if (number < 0) {
        throw const FormatException();
      } else {
        return Right(number);
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
