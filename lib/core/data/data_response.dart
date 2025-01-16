import '../errors.dart';
class DataResponse<TContent> {
  /// Gets a value indicating whether the response is successful, e.g. true if
  /// successful; otherwise, false.
  final bool isSuccessful;

  /// Gets the content of the response.
  final TContent? content;

  /// Gets the failure object.
  final Failure? failure;

  /// Initializes a new instance of [DataResponse] class that is successful and returns the [content] object.
  const DataResponse.success(this.content)
      : isSuccessful = true,
        failure = null;

  /// Initializes a new instance of [DataResponse] class that is failed and returns the [failure] object.
  const DataResponse.failure(this.failure)
      : isSuccessful = false,
        content = null;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DataResponse<TContent> && other.isSuccessful == isSuccessful && other.content == content && other.failure == failure);
  }

  @override
  int get hashCode => isSuccessful.hashCode ^ content.hashCode ^ failure.hashCode;
}
