import '../errors.dart';

/// Defines the the base class for implementation of failure objects for use by
/// the [DataResponse] and other objects.
///
/// Failures should represent high-level errors happening in the top-level services providing data, such as AppSettings,
/// ApiClient, etc. and not, for example SharedPreferencesFailure, as we are not interested in communicating low-level
/// implementation-related errors. The aim of Failures is to communicate success/failure to the state management classes
/// that will communicate issue to the user, idealy in a recoverable manner, e.g. with retries, or remediation
/// recommendations

class NoInternetFailure extends Failure {
  const NoInternetFailure();
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class FailureWithParam implements Failure {
  final String? errMsg;

  const FailureWithParam({this.errMsg = ''});

  @override
  String toString() => 'FailureWithParam: $errMsg';
}
