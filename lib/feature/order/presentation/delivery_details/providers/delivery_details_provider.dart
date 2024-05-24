import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/order_delivery_details.dart';

final deliveryDetailsProvider = StateProvider<OrderDeliveryDetails?>((ref) => null);
