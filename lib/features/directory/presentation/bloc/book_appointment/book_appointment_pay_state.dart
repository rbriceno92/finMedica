import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

const nullItem = CartItem(amount: 0, id: '', quantity: 0);

class BookAppointmentPayState extends Equatable {
  final LoadingState loading;
  final CartItem item;
  final String paymentIntentClientSecret;
  final String customerId;
  final String customerEphemeralKeySecret;
  final bool isPayded;
  final String errorMessage;

  const BookAppointmentPayState({
    this.loading = LoadingState.dispose,
    this.item = nullItem,
    this.paymentIntentClientSecret = '',
    this.customerId = '',
    this.customerEphemeralKeySecret = '',
    this.isPayded = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        loading,
        item,
        paymentIntentClientSecret,
        customerId,
        customerEphemeralKeySecret,
        isPayded,
        errorMessage
      ];

  BookAppointmentPayState copyWith({
    LoadingState? loading,
    CartItem? item,
    String? paymentIntentClientSecret,
    String? customerId,
    String? customerEphemeralKeySecret,
    bool? isBookedAppointment,
    bool? isPayded,
    String? errorMessage,
  }) {
    return BookAppointmentPayState(
      loading: loading ?? this.loading,
      item: item ?? this.item,
      paymentIntentClientSecret:
          paymentIntentClientSecret ?? this.paymentIntentClientSecret,
      customerId: customerId ?? this.customerId,
      customerEphemeralKeySecret:
          customerEphemeralKeySecret ?? this.customerEphemeralKeySecret,
      isPayded: isPayded ?? this.isPayded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
