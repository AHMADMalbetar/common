import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../const/failure.dart';
import '../models/error_model.dart';

mixin HandlingException {
  Future<Either<Failure, T>> wrapHandlingException<T>({required Future<T> Function() tryCall}) async {
    try {
      final result = await tryCall();
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = ServerFailure(
        message: error.toString(),
        statusCode: ResponseCode.badRequestServer,
      );
    }
  }

  Failure _handleError(DioException error) {
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
        return DataSource.Default.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.badRequest.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
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
            return ServerFailure(message: ErrorMessageModel.fromJson(error.response?.data).statusMessage, statusCode: ResponseCode.badContent);
          case ResponseCode.badRequestServer:
            return ServerFailure(message: ErrorMessageModel.fromJson(error.response?.data).statusMessage, statusCode: ResponseCode.badRequestServer);
          default:
            return ServerFailure(
              message: error.response?.data["message"] ?? error.response?.data["errors"]?.toString() ?? '',
              statusCode: error.response?.statusCode ?? ResponseCode.badRequest,
            );
        }
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return ServerFailure(statusCode: ResponseCode.success, message: ResponseMessage.SUCCESS.tr());
      case DataSource.noInternet:
        return ServerFailure(statusCode: ResponseCode.noContent, message: ResponseMessage.NO_CONTENT.tr());
      case DataSource.badRequest:
        return ServerFailure(statusCode: ResponseCode.badRequest, message: ResponseMessage.BAD_REQUEST.tr());
      case DataSource.forBidden:
        return ServerFailure(statusCode: ResponseCode.forBidden, message: ResponseMessage.FORBIDDEN.tr());
      case DataSource.unAuthorized:
        return ServerFailure(statusCode: ResponseCode.unAuthorized, message: ResponseMessage.UNAUTORISED.tr());
      case DataSource.notFound:
        return ServerFailure(statusCode: ResponseCode.notFound, message: ResponseMessage.NOT_FOUND.tr());
      case DataSource.internetServerError:
        return ServerFailure(statusCode: ResponseCode.internalServerError, message: ResponseMessage.INTERNAL_SERVER_ERROR.tr());
      case DataSource.connectTimeOut:
        return ServerFailure(statusCode: ResponseCode.connectTimeOut, message: ResponseMessage.CONNECT_TIMEOUT.tr());
      case DataSource.cancel:
        return ServerFailure(statusCode: ResponseCode.cancel, message: ResponseMessage.CANCEL.tr());
      case DataSource.receiveTimeOut:
        return ServerFailure(statusCode: ResponseCode.receiveTimeOut, message: ResponseMessage.RECIEVE_TIMEOUT.tr());
      case DataSource.sendTimeOut:
        return ServerFailure(statusCode: ResponseCode.sendTimeOut, message: ResponseMessage.SEND_TIMEOUT.tr());
      case DataSource.cashError:
        return ServerFailure(statusCode: ResponseCode.cashError, message: ResponseMessage.CACHE_ERROR.tr());
      case DataSource.noInternetConnection:
        return ServerFailure(statusCode: ResponseCode.noInternetConnection, message: ResponseMessage.NO_INTERNET_CONNECTION.tr());
      case DataSource.Default:
        return ServerFailure(statusCode: ResponseCode.Default, message: ResponseMessage.DEFAULT.tr());
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // ServerFailure, API rejected request
  static const int unAuthorized = 401; // failure, user is not authorised
  static const int forBidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found
  static const int notAllowed = 405; // failure, not allowed
  static const int blocked = 420; // failure,blocked
  static const int badContent = 422; // failure, Bad_Content
  static const int badRequestServer = 402; // ServerFailure, API rejected request

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cashError = -5;
  static const int noInternetConnection = -6;
  static const int Default = -7;
}

class ResponseMessage {
  static const String SUCCESS = AppConstants.success; // success with data
  static const String NO_CONTENT = AppConstants.success; // success with no data (no content)
  static const String BAD_REQUEST = AppConstants.badRequestError; // failure, API rejected request
  static const String UNAUTORISED = AppConstants.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN = AppConstants.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR = AppConstants.internalServerError; // failure, crash in server side
  static const String NOT_FOUND = AppConstants.notFoundError; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppConstants.timeoutError;
  static const String CANCEL = AppConstants.defaultError;
  static const String RECIEVE_TIMEOUT = AppConstants.timeoutError;
  static const String SEND_TIMEOUT = AppConstants.timeoutError;
  static const String CACHE_ERROR = AppConstants.cacheError;
  static const String NO_INTERNET_CONNECTION = AppConstants.noInternetError;
  static const String DEFAULT = AppConstants.defaultError;
}

class AppConstants {
  AppConstants._();

  // error handler
  static const String success = 'success';
  static const String badRequestError = 'Bad request';
  static const String noContent = 'No Content';
  static const String forbiddenError = 'Forbidden user';
  static const String unauthorizedError = 'Un Authorized user'; //"unauthorized_error";
  static const String notFoundError = '404 not found';
  static const String conflictError = 'Conflict Error';
  static const String blockedError = 'Blocked User';
  static const String internalServerError = 'Server Error'; //"internal_server_error";
  static const String notAllowed = 'Not allowed'; //"internal_server_error";

  static const String unknownError = 'Error';
  static const String timeoutError = 'Timed Out Error'; //"timeout_error"
  static const String defaultError = 'Error';
  static const String cacheError = 'No Cash Error';
  static const String noInternetError = 'You are offline'; //"no_internet_error"
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}

// ignore_for_file: constant_identifier_names
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
  Default,
}
