part of 'new_order_cubit.dart';

class NewOrderState extends Equatable {
  final List<OrderItem> items;
  final OrderDeliverer deliverer;
  final OrderStatus status;
  final OrderPlatform platform;

  final TextInput name;
  final Email email;
  final Phone phone;
  final TextInput address;

  final FormzStatus formzStatus;
  final String? errorMessage;

  const NewOrderState({
    this.items = const [],
    this.deliverer = OrderDeliverer.inpostLocker,
    this.status = OrderStatus.waitning,
    this.platform = OrderPlatform.instagram,
    this.name = const TextInput.pure(),
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.address = const TextInput.pure(),
    this.formzStatus = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        items,
        deliverer,
        status,
        platform,
        name,
        email,
        phone,
        address,
        formzStatus,
      ];
}
