import 'package:equatable/equatable.dart';

class RouteDefinition<T> extends Equatable {
  final String name;

  const RouteDefinition({required this.name});

  @override
  List<Object> get props => [name];
}