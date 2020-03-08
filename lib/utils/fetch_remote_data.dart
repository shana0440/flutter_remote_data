import 'package:remote_data/models/remote_data.dart';

Stream<RemoteData> fetchRemoteData<T>(Future<T> Function() fn) async* {
  yield Loading();
  try {
    final value = await fn();
    yield Success(value);
  } catch (e) {
    yield Failure(e);
  }
}
