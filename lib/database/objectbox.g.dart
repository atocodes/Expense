// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../models/item.dart';
import '../models/log.dart';
import '../models/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 1740319503048471226),
      name: 'Item',
      lastPropertyId: const obx_int.IdUid(13, 3030105850092988308),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1463137079717028477),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 163934219429307329),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2877265473450838610),
            name: 'price',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5411584650679651936),
            name: 'quantity',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 908334633253646714),
            name: 'priority',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4164341782222223966),
            name: 'purchasedDate',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 5277950340716544229),
            name: 'purchased',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 1849373271121132284),
            name: 'userId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(1, 119913058186381578),
            relationTarget: 'User'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(12, 373322064754079293),
            name: 'cashType',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(13, 3030105850092988308),
            name: 'total',
            type: 8,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(22, 6059838292768538145),
      name: 'User',
      lastPropertyId: const obx_int.IdUid(6, 4785410688906156844),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8927650047049383836),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4246292039591325183),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 7868503676237551122),
            name: 'totalCash',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 8023269755447512997),
            name: 'savingCash',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 4399671976564971561),
            name: 'expenseCash',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4785410688906156844),
            name: 'pocketCash',
            type: 8,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(name: 'items', srcEntity: 'Item', srcField: '')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(23, 890805507302320321),
      name: 'Log',
      lastPropertyId: const obx_int.IdUid(4, 5129346156108876906),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 530613270452187323),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4517479276148436900),
            name: 'data',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8577237457132720313),
            name: 'time',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5129346156108876906),
            name: 'logType',
            type: 6,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(23, 890805507302320321),
      lastIndexId: const obx_int.IdUid(1, 119913058186381578),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [
        1736320567931279762,
        2323239912186338673,
        8513461110550614844,
        5049940561047440395,
        7843559435235917961,
        125770054109563467,
        188045540771274105,
        3701972689754614520,
        4534372675216420830,
        1513985557628057323,
        3334076413914033373,
        2216422801829716839,
        2929873611402255677,
        549107847924463359,
        3178896210119187799,
        641571083789349638,
        7098208033158707814,
        424146076338921323,
        3280736044689919108,
        1955808374244386468
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        602696199589774630,
        920756743339520094,
        4425831273803598331,
        6363139375243209489,
        8796875910710385210,
        5627749105199242517,
        4472580000116125498,
        2014532710407835039,
        2603221380007521173,
        1630470969099889705,
        8784796548043240658,
        7485349100500269490,
        8042573306002607309,
        413727746267492854,
        5717910308883506351,
        316541795254784957,
        5476310738841134783,
        4874969617325509476,
        5015401657851960776,
        3544618334337092248,
        157871931798205972,
        1033320619816925816,
        6866966258273063424,
        2282369597488479072,
        7154568941562708965,
        5540910192541685871,
        3226260588597176332,
        4438737345500583681,
        5974783801463901505,
        2402254621066958408,
        5084867346962137698,
        4488358650806152882,
        451226795702122549,
        2853432636457949077,
        3961177834784540820,
        1320235976526185845,
        5443198896020357162,
        5387352936260632537,
        3199203196032706834,
        6220341367716576236,
        7433971422700835510,
        1635487372582195559,
        1910118435620917174,
        7996341509022924352,
        7564064842524244386,
        7383203317660315309,
        698249379652304789,
        8429237786645116787,
        6184859034722733141,
        4879153511802365802,
        5570918299108373753,
        1846412240605180902,
        4211035832636052612,
        4737551136218813149,
        3028108124998459335,
        2933317324732637935,
        2602209845437390634,
        6095182344504264616,
        6833919215319626280,
        635048825124504700,
        3099504318296312857,
        3203882345720198047,
        2767524431836562600,
        6417614107012977199,
        2509401069076649559,
        8560620316588888228,
        3155266371969048158,
        6049257635413425410,
        8449913734042226073,
        442646157922362893,
        1370289445093326111,
        2978983808473874454,
        2523527381025879495,
        1695037938840749120,
        8723214478491683009,
        7075612068598271616,
        957059906045297848,
        1265343371225331821,
        7512650059255946583,
        8909154062760188026,
        1833126961777705788,
        7436182647217341672,
        4437992722685085292,
        7015861618964649916,
        6041325492209930659,
        2922097159715102705,
        5955176049283292504,
        1037800047531607507,
        7351951875273922723,
        6458395616331544019,
        8866145462011041434,
        4796208179080220519,
        4000953136829400169,
        3811726072473049084
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Item: obx_int.EntityDefinition<Item>(
        model: _entities[0],
        toOneRelations: (Item object) => [object.user],
        toManyRelations: (Item object) => {},
        getId: (Item object) => object.id,
        setId: (Item object, int id) {
          object.id = id;
        },
        objectToFB: (Item object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(14);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addFloat64(2, object.price);
          fbb.addInt64(3, object.quantity);
          fbb.addFloat64(4, object.priority);
          fbb.addInt64(5, object.purchasedDate?.millisecondsSinceEpoch);
          fbb.addBool(6, object.purchased);
          fbb.addInt64(7, object.user.targetId);
          fbb.addInt64(11, object.cashType);
          fbb.addFloat64(12, object.total);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final purchasedDateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 14);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final priceParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final purchasedDateParam = purchasedDateValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(purchasedDateValue);
          final quantityParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final priorityParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0);
          final cashTypeParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 26, 0);
          final object = Item(
              id: idParam,
              name: nameParam,
              price: priceParam,
              purchasedDate: purchasedDateParam,
              quantity: quantityParam,
              priority: priorityParam,
              cashType: cashTypeParam)
            ..purchased =
                const fb.BoolReader().vTableGet(buffer, rootOffset, 16, false)
            ..total =
                const fb.Float64Reader().vTableGet(buffer, rootOffset, 28, 0);
          object.user.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0);
          object.user.attach(store);
          return object;
        }),
    User: obx_int.EntityDefinition<User>(
        model: _entities[1],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {
              obx_int.RelInfo<Item>.toOneBacklink(
                      8, object.id, (Item srcObject) => srcObject.user):
                  object.items
            },
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addFloat64(2, object.totalCash);
          fbb.addFloat64(3, object.savingCash);
          fbb.addFloat64(4, object.expenseCash);
          fbb.addFloat64(5, object.pocketCash);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final totalCashParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final savingCashParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final expenseCashParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0);
          final pocketCashParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 14, 0);
          final object = User(
              name: nameParam,
              id: idParam,
              totalCash: totalCashParam,
              savingCash: savingCashParam,
              expenseCash: expenseCashParam,
              pocketCash: pocketCashParam);
          obx_int.InternalToManyAccess.setRelInfo<User>(
              object.items,
              store,
              obx_int.RelInfo<Item>.toOneBacklink(
                  8, object.id, (Item srcObject) => srcObject.user));
          return object;
        }),
    Log: obx_int.EntityDefinition<Log>(
        model: _entities[2],
        toOneRelations: (Log object) => [],
        toManyRelations: (Log object) => {},
        getId: (Log object) => object.id,
        setId: (Log object, int id) {
          object.id = id;
        },
        objectToFB: (Log object, fb.Builder fbb) {
          final dataOffset = fbb.writeString(object.data);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, dataOffset);
          fbb.addInt64(2, object.time.millisecondsSinceEpoch);
          fbb.addInt64(3, object.logType);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dataParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final logTypeParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final timeParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0));
          final object = Log(
              data: dataParam, logType: logTypeParam, time: timeParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Item] entity fields to define ObjectBox queries.
class Item_ {
  /// See [Item.id].
  static final id = obx.QueryIntegerProperty<Item>(_entities[0].properties[0]);

  /// See [Item.name].
  static final name = obx.QueryStringProperty<Item>(_entities[0].properties[1]);

  /// See [Item.price].
  static final price =
      obx.QueryDoubleProperty<Item>(_entities[0].properties[2]);

  /// See [Item.quantity].
  static final quantity =
      obx.QueryIntegerProperty<Item>(_entities[0].properties[3]);

  /// See [Item.priority].
  static final priority =
      obx.QueryDoubleProperty<Item>(_entities[0].properties[4]);

  /// See [Item.purchasedDate].
  static final purchasedDate =
      obx.QueryDateProperty<Item>(_entities[0].properties[5]);

  /// See [Item.purchased].
  static final purchased =
      obx.QueryBooleanProperty<Item>(_entities[0].properties[6]);

  /// See [Item.user].
  static final user =
      obx.QueryRelationToOne<Item, User>(_entities[0].properties[7]);

  /// See [Item.cashType].
  static final cashType =
      obx.QueryIntegerProperty<Item>(_entities[0].properties[8]);

  /// See [Item.total].
  static final total =
      obx.QueryDoubleProperty<Item>(_entities[0].properties[9]);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// See [User.id].
  static final id = obx.QueryIntegerProperty<User>(_entities[1].properties[0]);

  /// See [User.name].
  static final name = obx.QueryStringProperty<User>(_entities[1].properties[1]);

  /// See [User.totalCash].
  static final totalCash =
      obx.QueryDoubleProperty<User>(_entities[1].properties[2]);

  /// See [User.savingCash].
  static final savingCash =
      obx.QueryDoubleProperty<User>(_entities[1].properties[3]);

  /// See [User.expenseCash].
  static final expenseCash =
      obx.QueryDoubleProperty<User>(_entities[1].properties[4]);

  /// See [User.pocketCash].
  static final pocketCash =
      obx.QueryDoubleProperty<User>(_entities[1].properties[5]);

  /// see [User.items]
  static final items = obx.QueryBacklinkToMany<Item, User>(Item_.user);
}

/// [Log] entity fields to define ObjectBox queries.
class Log_ {
  /// See [Log.id].
  static final id = obx.QueryIntegerProperty<Log>(_entities[2].properties[0]);

  /// See [Log.data].
  static final data = obx.QueryStringProperty<Log>(_entities[2].properties[1]);

  /// See [Log.time].
  static final time = obx.QueryDateProperty<Log>(_entities[2].properties[2]);

  /// See [Log.logType].
  static final logType =
      obx.QueryIntegerProperty<Log>(_entities[2].properties[3]);
}
