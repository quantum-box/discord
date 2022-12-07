import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoadingStream<T> extends HookWidget {
  const LoadingStream({
    super.key,
    required this.builder,
    required this.stream,
  });

  final Widget Function(BuildContext context, T data) builder;
  final Stream<T> Function() stream;

  @override
  Widget build(BuildContext context) {
    final Stream<T> memoStream = useMemoized(stream);
    final snapshot = useStream(memoStream);

    if (snapshot.hasError) {
      return Center(
        child: Text("error: ${snapshot.error.toString()}"),
      );
    }

    return Container(
      child: snapshot.hasData
          ? Builder(builder: (context) => builder(context, snapshot.data as T))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
