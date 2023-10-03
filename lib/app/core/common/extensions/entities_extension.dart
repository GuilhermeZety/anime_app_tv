import 'package:equatable/equatable.dart';

extension As on Equatable{
  Type as<Type>() => this as Type;
}
extension Ass on Object{
  Type as<Type>() => this as Type;
}