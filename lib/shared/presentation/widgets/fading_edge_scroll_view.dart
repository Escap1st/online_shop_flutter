import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class FadingEdgeScrollView extends StatefulWidget {
  const FadingEdgeScrollView({
    super.key,
    required this.child,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.reversed = false,
    this.startEdge,
    this.endEdge,
    this.height,
    this.width,
  });

  final ScrollController? scrollController;
  final Axis scrollDirection;
  final bool reversed;
  final Widget child;
  final StartFadingEdge? startEdge;
  final EndFadingEdge? endEdge;
  final double? height;
  final double? width;

  @override
  State<FadingEdgeScrollView> createState() => _FadingEdgeScrollState();
}

class _FadingEdgeScrollState extends State<FadingEdgeScrollView> {
  late var _startOpacity = (widget.startEdge?.initiallyShown ?? false) ? 1.0 : 0.0;
  late var _endOpacity = (widget.endEdge?.initiallyShown ?? false) ? 1.0 : 0.0;

  ScrollController? get _controller => widget.scrollController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollListener();
    });
    if (_controller != null) {
      _controller!.addListener(_scrollListener);
    } else {
      _startOpacity = 1.0;
      _endOpacity = 1.0;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          widget.child,
          if (widget.startEdge != null)
            _FadingEdge(
              config: widget.startEdge!,
              scrollDirection: widget.scrollDirection,
              reversed: widget.reversed,
              opacity: _startOpacity,
            ),
          if (widget.endEdge != null)
            _FadingEdge(
              config: widget.endEdge!,
              scrollDirection: widget.scrollDirection,
              reversed: widget.reversed,
              opacity: _endOpacity,
            ),
        ],
      ),
    );
  }

  void _scrollListener() {
    if (_controller == null) {
      return;
    }

    if (_controller!.positions.isEmpty) {
      return;
    }

    if (_controller!.position.maxScrollExtent != 0) {
      if (widget.startEdge != null) {
        final newStartOpacity = max(
          0.0,
          min(
            1.0,
            _controller!.position.pixels / widget.startEdge!.size,
          ),
        );
        if (newStartOpacity != _startOpacity) {
          setState(() {
            _startOpacity = newStartOpacity;
          });
        }
      }

      if (widget.endEdge != null) {
        final newEndOpacity = max(
          0.0,
          min(
            1.0,
            (_controller!.position.maxScrollExtent - _controller!.position.pixels) /
                widget.endEdge!.size,
          ),
        );
        if (newEndOpacity != _endOpacity) {
          setState(() {
            _endOpacity = newEndOpacity;
          });
        }
      }
    } else {
      setState(() {
        _startOpacity = 0.0;
        _endOpacity = 0.0;
      });
    }
  }
}

class _FadingEdge extends StatefulWidget {
  _FadingEdge({
    required this.config,
    this.scrollDirection = Axis.vertical,
    this.reversed = false,
    this.opacity = 1.0,
  })  : assert(config.offset >= 0 && config.offset <= 1.0),
        assert(config.size >= 0);
  final _FadingEdgeConfig config;
  final Axis scrollDirection;
  final bool reversed;
  final double opacity;

  @override
  _FadingEdgeState createState() => _FadingEdgeState();
}

class _FadingEdgeState extends State<_FadingEdge> with WidgetsBindingObserver {
  bool _isKeyboardShown = false;

  @override
  void initState() {
    if (!widget.config.showWithOpenedKeyboard) {
      WidgetsBinding.instance.addObserver(this);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (!widget.config.showWithOpenedKeyboard) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final isKeyboardCurrentlyShown =
        RendererBinding.instance.renderViews.first.flutterView.viewInsets.bottom != 0;
    if (isKeyboardCurrentlyShown != _isKeyboardShown) {
      setState(() {
        _isKeyboardShown = isKeyboardCurrentlyShown;
      });
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.config.showWithOpenedKeyboard && _isKeyboardShown) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: _alignment,
      child: IgnorePointer(
        child: Container(
          height: _isVertical ? widget.config.size : null,
          width: _isVertical ? null : widget.config.size,
          decoration: BoxDecoration(
            gradient: startColor != endColor
                ? (_isVertical ? _verticalGradient : _horizontalGradient)
                : null,
          ),
        ),
      ),
    );
  }

  Color get startColor => widget.config.color.withOpacity(widget.opacity);

  Color get endColor => widget.config.color.withOpacity(0.0);

  LinearGradient get _verticalGradient => LinearGradient(
        colors: [startColor, endColor],
        begin: FractionalOffset(
          0.5,
          _isVisuallyAtStart ? widget.config.offset : 1 - widget.config.offset,
        ),
        end: FractionalOffset(0.5, _isVisuallyAtStart ? 1.0 : 0.0),
        stops: const [0.0, 1.0],
      );

  LinearGradient get _horizontalGradient => LinearGradient(
        colors: [startColor, endColor],
        begin: FractionalOffset(
          _isVisuallyAtStart ? widget.config.offset  : 1 - widget.config.offset,
          0.5,
        ),
        end: FractionalOffset(_isVisuallyAtStart ? 1.0 : 0.0, 0.5),
        stops: const [0.0, 1.0],
      );

  bool get _isVertical => widget.scrollDirection == Axis.vertical;

  bool get _isStartEdge => widget.config.type == _FadingEdgeType.start;

  bool get _isVisuallyAtStart => _isStartEdge ^ widget.reversed;

  Alignment get _alignment {
    if (widget.scrollDirection == Axis.vertical) {
      return _isVisuallyAtStart ? Alignment.topCenter : Alignment.bottomCenter;
    } else {
      return _isVisuallyAtStart ? Alignment.centerRight : Alignment.centerLeft;
    }
  }
}

class EndFadingEdge extends _FadingEdgeConfig {
  EndFadingEdge({
    required super.color,
    required super.size,
    super.showWithOpenedKeyboard = true,
    super.offset,
    super.initiallyShown,
  }) : super(type: _FadingEdgeType.end);
}

class StartFadingEdge extends _FadingEdgeConfig {
  StartFadingEdge({
    required super.color,
    required super.size,
    super.showWithOpenedKeyboard = true,
    super.offset,
    super.initiallyShown,
  }) : super(type: _FadingEdgeType.start);
}

enum _FadingEdgeType { start, end }

class _FadingEdgeConfig {
  _FadingEdgeConfig({
    required this.type,
    required this.color,
    required this.size,
    this.offset = 0.0,
    this.initiallyShown = false,
    this.showWithOpenedKeyboard = true,
  });

  final _FadingEdgeType type;
  final Color color;
  final double size;
  final double offset;
  final bool initiallyShown;
  final bool showWithOpenedKeyboard;
}
