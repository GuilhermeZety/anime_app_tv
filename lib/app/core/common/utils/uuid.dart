import 'package:ulid/ulid.dart';

class Uuid {
  static String gen() {
    return Ulid().toUuid();
  }
}
