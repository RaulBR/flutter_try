import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/category_model.g.dart';

@HiveType(typeId: 2)
// ignore: must_be_immutable
class AuditCategory extends Equatable {
  @HiveField(0)
  String id;
  @HiveField(1)
  String category;
  AuditCategory({this.id, this.category});

  Map<String, dynamic> toJson() => {"id": id, "category": category};

  AuditCategory.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }
    id = parsedJson['id'] ?? null;
    category = parsedJson['category'].toString() ?? null;
  }

  @override
  List<Object> get props => [id, category];
}
