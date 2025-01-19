import 'package:hogastos/models/create_category.dart';

class Category extends CreateCategory {
  final int id;

  Category(
    this.id,
    super.description,
    super.color,
    super.icon,
  );
}