import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";
import "objectbox.g.dart";

class ObjectBox{

  // The Store of this app
  late final Store store;

  ObjectBox._create(this.store);

  // Create an instance of objectbox to use throughout the app
  static Future<ObjectBox>create() async{
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path,"expense-app-db"));
    return ObjectBox._create(store);
  }
}