import 'dart:convert';

abstract class JsonConvert<T> {
  Map<String, dynamic> toJson();
}

String serialize<T extends JsonConvert>(
  T model,
) => json.encode(model.toJson());

T deserialize<T extends JsonConvert>(
  String json,
  T Function(Map<String, dynamic> data) factory,
) => factory(jsonDecode(json) as Map<String, dynamic>);