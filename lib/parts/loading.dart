import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoadingStream<T> extends HookWidget {
  const LoadingStream({
    super.key,
    required this.builder,
    required this.stream,
    this.keys = const [],
    this.customLoading,
  });

  final Widget Function(BuildContext context, T data) builder;
  final Stream<T> Function() stream;
  final List<Object?> keys;
  final Widget? customLoading;

  @override
  Widget build(BuildContext context) {
    final Stream<T> memoStream = useMemoized(stream, keys);
    final snapshot = useStream(memoStream);

    if (snapshot.hasError) {
      return Center(
        child: Text("error: ${snapshot.error.toString()}"),
      );
    }

    return Container(
      child: snapshot.hasData
          ? Builder(builder: (context) => builder(context, snapshot.data as T))
          : customLoading ??
              const Center(
                child: CircularProgressIndicator(),
              ),
    );
  }
}
