import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/screens/result_screen.dart';
import 'package:myquickchef/widgets/recipe_card.dart';

import 'styles/style_guide.dart';

import 'package:myquickchef/models/recipe.dart';

void main() {
  runApp(
    MaterialApp(
      title: "MyQuickChef",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: buildColorSchemeTheme(),
        textTheme: buildTextTheme(),
      ),
      home: const SafeArea(
        child: ResultScreen(),
      ),
    ),
  );
}

List<Recipe> recipes = [
  Recipe(
      name: 'Pancake al Cioccolato',
      category: 'Dolce',
      presentation:
          'Mix nutriente di quinoa cotta al dente, avocado cremoso, pomodorini succosi, cetrioli croccanti e foglie di spinaci fresche, il tutto condito con una vinaigrette leggera.',
      preparationTime: '45 min',
      ingredients: ['ing1', 'ing2', 'ing3'],
      steps: ['step1', 'step2', 'step3']),
  Recipe(
      name: 'Insalata di avocado e pomodorini',
      category: 'Vegetali',
      presentation:
          'L’insalata di pomodori e avocado è un piatto fresco, leggero, dal sapore estivo. Una ricetta che non richiede cottura, quindi ideale per quando fa tanto caldo e non si ha voglia di accendere i fornelli.',
      preparationTime: '10 min',
      ingredients: ['ing1', 'ing2', 'ing3'],
      steps: ['step1', 'step2', 'step3']),
  Recipe(
      name: 'Big Burger con guacamole',
      category: 'Panini',
      presentation:
          'Il Big Burger con guacamole è una variante del classico hamburger da fast-food, arricchito in questo caso dalla presenza del guacamole, che rende tutto più cremoso e dal sapore ancora più particolare.',
      preparationTime: '15 min',
      ingredients: ['ing1', 'ing2', 'ing3'],
      steps: ['step1', 'step2', 'step3'])
]; // Lista delle ricette
