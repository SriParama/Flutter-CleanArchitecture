import 'package:equatable/equatable.dart';

void main() {
  print(user(name: "surendhar", id: 1));
  print(user(name: "surendhar", id: 1) == (user(name: "surenr", id: 1)));
}

class user extends Equatable {
  final String name;
  final int id;

  user({required this.name, required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}

class Student {
  final String name;
  final int id;

  Student({required this.name, required this.id});
}
