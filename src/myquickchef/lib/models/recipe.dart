// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Recipe {
  final String name;
  final String category;
  final String summary;
  final String preparationTime;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.name,
    required this.category,
    required this.summary,
    required this.preparationTime,
    required this.ingredients,
    required this.steps,
  });

  Recipe copyWith({
    String? name,
    String? category,
    String? summary,
    String? preparationTime,
    List<String>? ingredients,
    List<String>? steps,
  }) {
    return Recipe(
      name: name ?? this.name,
      category: category ?? this.category,
      summary: summary ?? this.summary,
      preparationTime: preparationTime ?? this.preparationTime,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'summary': summary,
      'preparationTime': preparationTime,
      'ingredients': ingredients,
      'steps': steps,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
        name: map['name'] as String,
        category: map['category'] as String,
        summary: map['summary'] as String,
        preparationTime: map['preparationTime'] as String,
        ingredients: List<String>.from(map['ingredients']),
        steps: List<String>.from(map['steps']));
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recipe(name: $name, category: $category, summary: $summary, preparationTime: $preparationTime, ingredients: $ingredients, steps: $steps)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.category == category &&
        other.summary == summary &&
        other.preparationTime == preparationTime &&
        listEquals(other.ingredients, ingredients) &&
        listEquals(other.steps, steps);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        category.hashCode ^
        summary.hashCode ^
        preparationTime.hashCode ^
        ingredients.hashCode ^
        steps.hashCode;
  }
}
