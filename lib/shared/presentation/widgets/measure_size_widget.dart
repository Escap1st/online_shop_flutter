import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeWidget extends SingleChildRenderObjectWidget {
  const MeasureSizeWidget({
    required this.onChange,
    required Widget super.child,
    super.key,
  });

  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}

class MeasureSizeRenderObject extends RenderProxyBox {
  MeasureSizeRenderObject(this.onChange);

  final OnWidgetSizeChange onChange;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (_oldSize == newSize) {
      return;
    }

    _oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}
