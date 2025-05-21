import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/core/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
