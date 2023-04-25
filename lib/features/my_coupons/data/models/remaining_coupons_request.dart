import 'package:equatable/equatable.dart';

const remainingConsultsQueryLimit = 15;

class RemainingCouponsRequest extends Equatable {
  final int limit;
  final int page;
  final String type;
  final String userId;

  const RemainingCouponsRequest(
      {required this.limit,
      required this.page,
      required this.type,
      required this.userId});

  Map<String, dynamic> getQueryMap() =>
      {'limit': limit, 'page': page, 'type': type};

  @override
  List<Object> get props => [limit, page, type, userId];
}
