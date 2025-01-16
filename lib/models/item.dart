import 'package:expense/models/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Item {
  int id = 0;
  final String name;
  final double price;
  
  // relationship
  final user = ToOne<User>();
  
  Item({required this.name, required this.price});

}
