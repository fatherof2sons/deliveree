import 'package:flutter/foundation.dart';

class Shop {
  Shop({
    @required this.name,
    @required this.photo,
    @required this.type,
    @required this.phone,
    @required this.viber,
  })  : assert(name != null),
        assert(phone != null),
        assert(viber != null);

  final String? name;
  final String? photo;
  final String? type;

  final int? phone;
  final int? viber;

  @override
  String toString() =>
      "name: $name,\nphoto: $photo \ntypr: $type \nphone: $phone,\nviber: $viber";
}
