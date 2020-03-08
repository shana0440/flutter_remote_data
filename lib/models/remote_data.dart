abstract class RemoteData {
  static Stream<RemoteData> result<T>(Future<T> Function() fn) async* {
    yield Loading();
    try {
      final value = await fn();
      yield Success(value);
    } catch (e) {
      yield Failure(e);
    }
  }
}

class NotAsked extends RemoteData {}

class Loading extends RemoteData {}

class Success<T> extends RemoteData {
  final T value;

  Success(this.value);
}

class Failure extends RemoteData {
  final Error error;

  Failure(this.error);
}
