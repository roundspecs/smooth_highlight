import 'package:flutter/material.dart';
import 'package:smooth_highlight/smooth_highlight.dart';

class ValueChangeHighlight<T> extends StatefulWidget {
  const ValueChangeHighlight({
    super.key,
    required this.value,
    required this.child,
    required this.highlightColor,
    this.disableValues,
    this.padding = EdgeInsets.zero,
    this.useInitialHighLight = false,
  });

  final T? value;
  final List<T>? disableValues;
  final Widget child;
  final Color highlightColor;
  final bool useInitialHighLight;
  final EdgeInsets padding;

  @override
  State<ValueChangeHighlight> createState() => _ValueChangeHighlight<T>();
}

class _ValueChangeHighlight<T> extends State<ValueChangeHighlight>
    with SingleTickerProviderStateMixin {
  T? _previousValue;
  bool _valueChanged = false;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant ValueChangeHighlight oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_previousValue == widget.value) {
      _valueChanged = false;
      return;
    }

    final disableValues = widget.disableValues ?? [];
    _valueChanged = disableValues.contains(_previousValue) == false;
    _previousValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SmoothHighlight(
      enabled: _valueChanged,
      padding: widget.padding,
      highlightColor: widget.highlightColor,
      child: widget.child,
    );
  }
}
