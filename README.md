# remote_data

A Flutter package use to handle remote data, inspired by [remote-data-ts](https://github.com/devexperts/remote-data-ts).

## How to use

When we fetching remote data, we will have four states.

- NotAsked
- Loading
- Success
- Failure

To render each states, we have `RemoteDataBuilder` and `StreamRemoteDataBuilder`. However, I recommand using `StreamRemoteDataBuilder`, to avoid `setState` frequency.

### StreamRemoteDataBuilder

```dart
import 'package:remote_data/remote_data.dart';

class Home extends StatelessWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<RemoteData> _remoteData;

  void _search(String keyword) {
    setState(() => _remoteData = _doSearch(keyword));
  }

  Stream<RemoteData> _doSearch(String keyword) async* {
    yield Loading();
    try {
      final String value = await _fetchSomeData();
      yield Success(value);
    } catch (error) {
      yield Failure(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: _search,
        ),
        StreamRemoteDataBuilder<String>(
          stream: _remoteData,
          notAskedBuilder: (context) => Text("not asked"),
          loadingBuilder: (context) => Text("loading"),
          successBuilder: (context, value) => Text(value),
          failureBuilder: (context, error) => Text(error.toString()),
        ),
      ],
    );
  }
}
```
