import 'package:equatable/equatable.dart';

class Genderize extends Equatable {
  final String name;
  final String gender;

  Genderize({required this.name, required this.gender});

  @override
  List<Object?> get props => [name, gender];
}
