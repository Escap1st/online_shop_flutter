import 'package:flutter/widgets.dart';

class Gap extends SizedBox {
  const Gap._({super.key, super.height, super.width});

  const Gap.v(double height, {Key? key}) : this._(height: height, key: key);

  const Gap.h(double width, {Key? key}) : this._(width: width, key: key);
}
