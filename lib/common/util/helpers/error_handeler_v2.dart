import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../const/failure.dart';
import '../models/error_model.dart';

// todo: this file is for testing

mixin HandlingExceptionV2 {
  Future<Either<Failure, T>> wrapHandlingExceptionV2<T>({
    required Future<T> Function() tryCall,
  }) async {
    try {
      final result = await tryCall();
      return Right(result);
    } catch (e, stackTrace) {
      _logError(e, stackTrace);
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  void _logError(dynamic error, StackTrace stackTrace) {
    print("Error: $error");
    print("StackTrace: $stackTrace");
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  // Constructor to handle different types of errors.
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleDioError(error);
    } else if (error is FormatException) {
      failure = ServerFailure(
        message: 'Invalid data format received.',
        statusCode: ResponseCode.badRequestServer,
      );
    } else {
      failure = ServerFailure(
        message: error.toString(),
        statusCode: ResponseCode.badRequestServer,
      );
    }
  }

  // Handle Dio errors more specifically.
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeOut.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeOut.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeOut.getFailure();
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.unknown:
        return DataSource.def.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.badRequest.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      default:
        return DataSource.def.getFailure();
    }
  }

  // Handle bad HTTP responses with custom error mapping.
  Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return DataSource.def.getFailure();
    }

    switch (response.statusCode) {
      case ResponseCode.internalServerError:
        return DataSource.internetServerError.getFailure();
      case ResponseCode.notFound:
        return DataSource.notFound.getFailure();
      case ResponseCode.forBidden:
        return DataSource.forBidden.getFailure();
      case ResponseCode.blocked:
        return UserBlockedFailure(message: AppConstants.blockedError.tr());
      case ResponseCode.notAllowed:
        return UserNotAllowedFailure(message: AppConstants.notAllowed.tr());
      case ResponseCode.badContent:
        return ServerFailure(
          message: ErrorMessageModel.fromJson(response.data).statusMessage,
          statusCode: ResponseCode.badContent,
        );
      case ResponseCode.badRequestServer:
        return ServerFailure(
          message: ErrorMessageModel.fromJson(response.data).statusMessage,
          statusCode: ResponseCode.badRequestServer,
        );
      default:
        return ServerFailure(
          message: response.data?["message"] ?? response.data?["errors"]?.toString() ?? '',
          statusCode: response.statusCode ?? ResponseCode.badRequest,
        );
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return ServerFailure(statusCode: ResponseCode.success, message: ResponseMessage.success.tr());
      case DataSource.noInternet:
        return ServerFailure(statusCode: ResponseCode.noContent, message: ResponseMessage.noConnect.tr());
      case DataSource.badRequest:
        return ServerFailure(statusCode: ResponseCode.badRequest, message: ResponseMessage.badRequest.tr());
      case DataSource.forBidden:
        return ServerFailure(statusCode: ResponseCode.forBidden, message: ResponseMessage.forbidden.tr());
      case DataSource.unAuthorized:
        return ServerFailure(statusCode: ResponseCode.unAuthorized, message: ResponseMessage.unauthorized.tr());
      case DataSource.notFound:
        return ServerFailure(statusCode: ResponseCode.notFound, message: ResponseMessage.notFound.tr());
      case DataSource.internetServerError:
        return ServerFailure(statusCode: ResponseCode.internalServerError, message: ResponseMessage.internetServerError.tr());
      case DataSource.connectTimeOut:
        return ServerFailure(statusCode: ResponseCode.connectTimeOut, message: ResponseMessage.connectTimeOut.tr());
      case DataSource.cancel:
        return ServerFailure(statusCode: ResponseCode.cancel, message: ResponseMessage.cancel.tr());
      case DataSource.receiveTimeOut:
        return ServerFailure(statusCode: ResponseCode.receiveTimeOut, message: ResponseMessage.receiveTimeOut.tr());
      case DataSource.sendTimeOut:
        return ServerFailure(statusCode: ResponseCode.sendTimeOut, message: ResponseMessage.sendTimeOut.tr());
      case DataSource.cashError:
        return ServerFailure(statusCode: ResponseCode.cashError, message: ResponseMessage.cacheError.tr());
      case DataSource.noInternetConnection:
        return ServerFailure(statusCode: ResponseCode.noInternetConnection, message: ResponseMessage.noInternetConnection.tr());
      case DataSource.def:
        return ServerFailure(statusCode: ResponseCode.def, message: ResponseMessage.def.tr());
    }
  }
}

// Response codes and messages remain the same
// You can add other HTTP status codes or extend messages if needed.

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unAuthorized = 401;
  static const int forBidden = 403;
  static const int internalServerError = 500;
  static const int notFound = 404;
  static const int notAllowed = 405;
  static const int blocked = 420;
  static const int badContent = 422;
  static const int badRequestServer = 402;
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cashError = -5;
  static const int noInternetConnection = -6;
  static const int def = -7;
}

class ResponseMessage {
  static const String success = AppConstants.success;
  static const String noConnect = AppConstants.success;
  static const String badRequest = AppConstants.badRequestError;
  static const String unauthorized = AppConstants.unauthorizedError;
  static const String forbidden = AppConstants.forbiddenError;
  static const String internetServerError = AppConstants.internalServerError;
  static const String notFound = AppConstants.notFoundError;
  static const String connectTimeOut = AppConstants.timeoutError;
  static const String cancel = AppConstants.defaultError;
  static const String receiveTimeOut = AppConstants.timeoutError;
  static const String sendTimeOut = AppConstants.timeoutError;
  static const String cacheError = AppConstants.cacheError;
  static const String noInternetConnection = AppConstants.noInternetError;
  static const String def = AppConstants.defaultError;
}

class AppConstants {
  AppConstants._();
  static const String success = 'success';
  static const String badRequestError = 'Bad request';
  static const String noContent = 'No Content';
  static const String forbiddenError = 'Forbidden user';
  static const String unauthorizedError = 'Un Authorized user';
  static const String notFoundError = '404 not found';
  static const String blockedError = 'Blocked User';
  static const String notAllowed = 'Not allowed';
  static const String internalServerError = 'Server Error';
  static const String timeoutError = 'Timed Out Error';
  static const String defaultError = 'Error';
  static const String cacheError = 'No Cache Error';
  static const String noInternetError = 'You are offline';
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failed = 1;
}

enum DataSource {
  success,
  noInternet,
  badRequest,
  forBidden,
  unAuthorized,
  notFound,
  internetServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cashError,
  noInternetConnection,
  def,
}
