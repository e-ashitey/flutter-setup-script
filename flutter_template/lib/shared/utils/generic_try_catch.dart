// generic try catch block(function) to handle network exceptions
import 'package:flutter_template/app/app_exports.dart' show NetworkException;
import 'package:dartz/dartz.dart';

Future<Either<NetworkException, T>> tryCatch<T>(
    Future<T> Function() function) async {
  try {
    final response = await function();
    return Right(response);
  } catch (error) {
    if (error is NetworkException) {
      return Left(error);
    }

    return Left(NetworkException(error.toString()));
  }
}