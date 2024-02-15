import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant.freezed.dart';
part 'restaurant.g.dart';

@freezed
class Restaurant with _$Restaurant {
  const factory Restaurant({
    required String id,
    required String name,
    required String cuisine,
    required String address,
    required double rating,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
}
