part of 'edit_cubit.dart';

class EditState extends Equatable {
  final Price purchasePrice;
  final Price allegroPrice;
  final Quantity quantity;
  final FormzStatus status;
  final String? errorMessage;

  final Product product;

  const EditState({
    required this.product,
    this.purchasePrice = const Price.pure(),
    this.allegroPrice = const Price.pure(),
    this.quantity = const Quantity.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        product,
        purchasePrice,
        allegroPrice,
        quantity,
        status,
      ];

  EditState copyWith({
    Price? purchasePrice,
    Price? allegroPrice,
    FormzStatus? status,
    Quantity? quantity,
    String? errorMessage,
    Product? product,
  }) {
    return EditState(
      purchasePrice: purchasePrice ?? this.purchasePrice,
      allegroPrice: allegroPrice ?? this.allegroPrice,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      errorMessage: errorMessage ?? this.errorMessage,
      product: product ?? this.product,
    );
  }
}
