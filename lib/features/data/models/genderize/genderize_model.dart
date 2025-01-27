import 'package:genderize/features/domain/entities/genderize/genderize.dart';

class GenderizeModel extends Genderize {
  const GenderizeModel({
    required String? name,
    required String? gender,
  }) : super(name: name, gender: gender);

  factory GenderizeModel.fromJson(Map<String, dynamic> json) {
    return GenderizeModel(
      name: json['name'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
    };
  }
}
