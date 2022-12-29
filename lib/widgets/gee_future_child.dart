import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class GeeFutureChild extends StatefulWidget {
  const GeeFutureChild({
    Key? key,
    required this.loaded,
    this.error,
    required this.status,
  }) : super(key: key);
  final Function loaded;
  final FutureStatus status;
  final Function? error;

  @override
  State<GeeFutureChild> createState() => _GeeFutureChildState();
}

class _GeeFutureChildState extends State<GeeFutureChild> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.status) {
      case FutureStatus.pending:
        return const Center(child: CircularProgressIndicator());
      case FutureStatus.fulfilled:
        return widget.loaded();
      default:
        return const Text("Request rejected");
    }
  }
}
