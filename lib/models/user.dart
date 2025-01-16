import 'package:expense/models/item.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;
  final String name;
  double cash = 0;

  // Relationship
  final items = ToMany<Item>();
  User({required this.name});
}
