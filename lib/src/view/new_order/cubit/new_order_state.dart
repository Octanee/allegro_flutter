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
  String toString() {
    return 'NewOrderState(items: ${items.length}, deliverer: $deliverer, status: $status, platform: $platform, name: $name, email: $email, phone: $phone, address: $address, formzStatus: $formzStatus, errorMessage: $errorMessage)';
  }

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

  NewOrderState copyWith({
    List<OrderItem>? items,
    OrderDeliverer? deliverer,
    OrderStatus? status,
    OrderPlatform? platform,
    TextInput? name,
    Email? email,
    Phone? phone,
    TextInput? address,
    FormzStatus? formzStatus,
    String? errorMessage,
  }) {
    return NewOrderState(
      items: items ?? this.items,
      deliverer: deliverer ?? this.deliverer,
      status: status ?? this.status,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      formzStatus: formzStatus ?? this.formzStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
