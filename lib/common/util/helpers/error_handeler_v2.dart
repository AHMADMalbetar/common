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
      return Left(ErrorHandlerV2.handle(e).failure);
    }
  }

  void _logError(dynamic error, StackTrace stackTrace) {
    print("Error: $error");
    print("StackTrace: $stackTrace");
  }
}

class ErrorHandlerV2 implements Exception {
  late Failure failure;

  // Constructor to handle different types of errors.
  ErrorHandlerV2.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleDioError(error);
    } else if (error is FormatException) {
      failure = ServerFailure(
        message: 'Invalid data format received.',
        statusCode: ResponseCodeV2.badRequestServer,
      );
    } else {
      failure = ServerFailure(
        message: error.toString(),
        statusCode: ResponseCodeV2.badRequestServer,
      );
    }
  }

  // Handle Dio errors more specifically.
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSourceV2.connectTimeOut.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSourceV2.sendTimeOut.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSourceV2.receiveTimeOut.getFailure();
      case DioExceptionType.cancel:
        return DataSourceV2.cancel.getFailure();
      case DioExceptionType.unknown:
        return DataSourceV2.def.getFailure();
      case DioExceptionType.badCertificate:
        return DataSourceV2.badRequest.getFailure();
      case DioExceptionType.connectionError:
        return DataSourceV2.noInternetConnection.getFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      default:
        return DataSourceV2.def.getFailure();
    }
  }

  // Handle bad HTTP responses with custom error mapping.
  Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return DataSourceV2.def.getFailure();
    }

    switch (response.statusCode) {
      case ResponseCodeV2.internalServerError:
        return DataSourceV2.internetServerError.getFailure();
      case ResponseCodeV2.notFound:
        return DataSourceV2.notFound.getFailure();
      case ResponseCodeV2.forBidden:
        return DataSourceV2.forBidden.getFailure();
      case ResponseCodeV2.blocked:
        return UserBlockedFailure(message: AppConstants.blockedError.tr());
      case ResponseCodeV2.notAllowed:
        return UserNotAllowedFailure(message: AppConstants.notAllowed.tr());
      case ResponseCodeV2.badContent:
        return ServerFailure(
          message: ErrorMessageModel.fromJson(response.data).statusMessage,
          statusCode: ResponseCodeV2.badContent,
        );
      case ResponseCodeV2.badRequestServer:
        return ServerFailure(
          message: ErrorMessageModel.fromJson(response.data).statusMessage,
          statusCode: ResponseCodeV2.badRequestServer,
        );
      default:
        return ServerFailure(
          message: response.data?["message"] ?? response.data?["errors"]?.toString() ?? '',
          statusCode: response.statusCode ?? ResponseCodeV2.badRequest,
        );
    }
  }
}

extension DataSourceExtensionV2 on DataSourceV2 {
  Failure getFailure() {
    switch (this) {
      case DataSourceV2.success:
        return ServerFailure(statusCode: ResponseCodeV2.success, message: ResponseMessageV2.success.tr());
      case DataSourceV2.noInternet:
        return ServerFailure(statusCode: ResponseCodeV2.noContent, message: ResponseMessageV2.noConnect.tr());
      case DataSourceV2.badRequest:
        return ServerFailure(statusCode: ResponseCodeV2.badRequest, message: ResponseMessageV2.badRequest.tr());
      case DataSourceV2.forBidden:
        return ServerFailure(statusCode: ResponseCodeV2.forBidden, message: ResponseMessageV2.forbidden.tr());
      case DataSourceV2.unAuthorized:
        return ServerFailure(statusCode: ResponseCodeV2.unAuthorized, message: ResponseMessageV2.unauthorized.tr());
      case DataSourceV2.notFound:
        return ServerFailure(statusCode: ResponseCodeV2.notFound, message: ResponseMessageV2.notFound.tr());
      case DataSourceV2.internetServerError:
        return ServerFailure(statusCode: ResponseCodeV2.internalServerError, message: ResponseMessageV2.internetServerError.tr());
      case DataSourceV2.connectTimeOut:
        return ServerFailure(statusCode: ResponseCodeV2.connectTimeOut, message: ResponseMessageV2.connectTimeOut.tr());
      case DataSourceV2.cancel:
        return ServerFailure(statusCode: ResponseCodeV2.cancel, message: ResponseMessageV2.cancel.tr());
      case DataSourceV2.receiveTimeOut:
        return ServerFailure(statusCode: ResponseCodeV2.receiveTimeOut, message: ResponseMessageV2.receiveTimeOut.tr());
      case DataSourceV2.sendTimeOut:
        return ServerFailure(statusCode: ResponseCodeV2.sendTimeOut, message: ResponseMessageV2.sendTimeOut.tr());
      case DataSourceV2.cashError:
        return ServerFailure(statusCode: ResponseCodeV2.cashError, message: ResponseMessageV2.cacheError.tr());
      case DataSourceV2.noInternetConnection:
        return ServerFailure(statusCode: ResponseCodeV2.noInternetConnection, message: ResponseMessageV2.noInternetConnection.tr());
      case DataSourceV2.def:
        return ServerFailure(statusCode: ResponseCodeV2.def, message: ResponseMessageV2.def.tr());
    }
  }
}

// Response codes and messages remain the same
// You can add other HTTP status codes or extend messages if needed.

class ResponseCodeV2 {
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

class ResponseMessageV2 {
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

class ApiInternalStatusV2 {
  static const int success = 0;
  static const int failed = 1;
}

enum DataSourceV2 {
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
