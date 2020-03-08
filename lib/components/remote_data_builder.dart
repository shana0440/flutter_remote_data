import 'package:flutter/material.dart';
import 'package:remote_data/exceptions/not_matched_state_exception.dart';
import 'package:remote_data/models/remote_data.dart';

typedef NotAskedBuilder = Widget Function(BuildContext);
typedef LoadingBuilder = Widget Function(BuildContext);
typedef SuccessBuilder<T> = Widget Function(BuildContext, T);
typedef FailureBuilder = Widget Function(BuildContext, Error);

class RemoteDataBuilder<T> extends StatelessWidget {
  final RemoteData remoteData;
  final NotAskedBuilder notAskedBuilder;
  final LoadingBuilder loadingBuilder;
  final SuccessBuilder<T> successBuilder;
  final FailureBuilder failureBuilder;

  const RemoteDataBuilder({
    Key key,
    @required this.remoteData,
    @required this.notAskedBuilder,
    @required this.loadingBuilder,
    @required this.successBuilder,
    @required this.failureBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final internalResult = remoteData;
    if (internalResult is NotAsked) {
      return notAskedBuilder(context);
    }

    if (internalResult is Loading) {
      return loadingBuilder(context);
    }

    if (internalResult is Success) {
      return successBuilder(context, internalResult.value);
    }

    if (internalResult is Failure) {
      return failureBuilder(context, internalResult.error);
    }

    return ErrorWidget(
      NotMatchedStateException(
        "$remoteData is not one of NotAsked, Loading, Success, Failure",
      ),
    );
  }
}
