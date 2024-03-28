import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/fading_edge_scroll_view.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import 'providers/order_details_provider.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  late final _nameKey = GlobalKey<FormFieldState<String>>();
  late final _surnameKey = GlobalKey<FormFieldState<String>>();
  late final _addressKey = GlobalKey<FormFieldState<String>>();
  late final _nameTextController = TextEditingController();
  late final _surnameTextController = TextEditingController();
  late final _addressTextController = TextEditingController();
  late final _scrollController = ScrollController();

  var _isNameValid = false;
  var _isSurnameValid = false;
  var _isAddressValid = false;

  @override
  void initState() {
    final orderDetailsState = ref.read(orderDetailsProvider);
    if (orderDetailsState != null) {
      _nameTextController.text = orderDetailsState.name;
      _surnameTextController.text = orderDetailsState.surname;
      _addressTextController.text = orderDetailsState.address;
      _isNameValid = true;
      _isSurnameValid = true;
      _isAddressValid = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _surnameTextController.dispose();
    _addressTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order details'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FadingEdgeScrollView(
                scrollController: _scrollController,
                startEdge: StartFadingEdge(
                  color: Theme.of(context).colorScheme.background,
                  size: 32,
                  offset: 0.3,
                ),
                endEdge: EndFadingEdge(
                  color: Theme.of(context).colorScheme.background,
                  size: 32,
                  offset: 0.3,
                ),
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      key: _nameKey,
                      controller: _nameTextController,
                      decoration: inputDecoration.copyWith(
                        labelText: 'Name',
                      ),
                      validator: _nonEmptyValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (_) {
                        if (_nameKey.currentState?.isValid != _isNameValid) {
                          setState(() => _isNameValid ^= true);
                        }
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap.v(12),
                    TextFormField(
                      key: _surnameKey,
                      controller: _surnameTextController,
                      decoration: inputDecoration.copyWith(
                        labelText: 'Surname',
                      ),
                      validator: _nonEmptyValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (_) {
                        if (_surnameKey.currentState?.isValid != _isSurnameValid) {
                          setState(() => _isSurnameValid ^= true);
                        }
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap.v(12),
                    TextFormField(
                      key: _addressKey,
                      controller: _addressTextController,
                      decoration: inputDecoration.copyWith(
                        labelText: 'Address',
                      ),
                      validator: _nonEmptyValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (_) {
                        if (_addressKey.currentState?.isValid != _isAddressValid) {
                          setState(() => _isAddressValid ^= true);
                        }
                      },
                      minLines: 5,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ElevatedButton(
                onPressed: _areFieldsValid()
                    ? () {
                        ref.read(orderDetailsProvider.notifier).state = OrderDetailsState(
                          name: _nameTextController.text,
                          surname: _surnameTextController.text,
                          address: _addressTextController.text,
                        );
                        const OrderConfirmationRoute().go(context);
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _nonEmptyValidator(String? value) =>
      (value?.isEmpty ?? true) ? 'Should not be empty' : null;

  bool _areFieldsValid() {
    return _isNameValid && _isSurnameValid && _isAddressValid;
  }
}
