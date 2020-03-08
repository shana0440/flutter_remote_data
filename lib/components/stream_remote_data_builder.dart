import 'package:flutter/material.dart';
import 'package:remote_data/components/remote_data_builder.dart';
import 'package:remote_data/models/remote_data.dart';

class StreamRemoteDataBuilder<T> extends StatelessWidget {
  final Stream<RemoteData> stream;
  final NotAskedBuilder notAskedBuilder;
  final LoadingBuilder loadingBuilder;
  final SuccessBuilder<T> successBuilder;
  final FailureBuilder failureBuilder;

  const StreamRemoteDataBuilder({
    Key key,
    this.stream,
    this.notAskedBuilder,
    this.loadingBuilder,
    this.successBuilder,
    this.failureBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: NotAsked(),
      stream: stream,
      builder: (context, snapshot) {
        return RemoteDataBuilder<T>(
          remoteData: snapshot.data,
          notAskedBuilder: notAskedBuilder,
          loadingBuilder: loadingBuilder,
          successBuilder: successBuilder,
          failureBuilder: failureBuilder,
        );
      },
    );
  }
}
