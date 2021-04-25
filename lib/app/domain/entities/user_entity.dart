import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String token;

  List get props => [token];

  UserEntity({@required this.token});
}
