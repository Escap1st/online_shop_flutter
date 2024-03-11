import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef OnWidgetConstraintsChange = void Function(BoxConstraints constraints)?;

class MeasureConstraintsWidget extends SingleChildRenderObjectWidget {
  const MeasureConstraintsWidget({
    required super.child,
    required this.onChange,
    super.key,
  });

  final OnWidgetConstraintsChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureConstraintsRenderObject(onChange);
  }
}

class MeasureConstraintsRenderObject extends RenderProxyBox {
  MeasureConstraintsRenderObject(this.onChange);

  BoxConstraints? oldConstraints;
  final OnWidgetConstraintsChange onChange;

  @override
  void performLayout() {
    super.performLayout();

    if (oldConstraints == constraints) {
      return;
    }

    oldConstraints = constraints;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange?.call(constraints);
    });
  }
}
