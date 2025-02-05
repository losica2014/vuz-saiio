import 'package:flutter/material.dart';
import 'package:saiio_lab/lab3/page.dart';

import 'lab1/page.dart';
import 'lab2/page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'САиИО',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/lab1': (context) => const HabitatPage(),
        '/lab2': (context) => const PumpStationPage(),
        '/lab3': (context) => const BuildingPage(),
      },
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              Text('МИНИСТЕРСТВО ЦИФРОВОГО РАЗВИТИЯ, СВЯЗИ И МАССОВЫХ КОММУНИКАЦИЙ РОССИЙСКОЙ ФЕДЕРАЦИИ', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
              Text('Ордена Трудового Красного Знамени Федеральное государственное бюджетное образовательное\nучреждение высшего образования "Московский технический университет связи и информатики"', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
              Spacer(),
              Text('Кафедра "Системное программирование"', style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
              Spacer(),
              Text('Лабораторные работы\nпо дисциплине "Системный анализ и исследование операций"', style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
              Spacer(),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  FilledButton.tonal(
                    onPressed: () => Navigator.pushNamed(context, '/lab1'),
                    child: Text("Лабораторная работа 1"),
                  ),
                  FilledButton.tonal(
                    onPressed: () => Navigator.pushNamed(context, '/lab2'),
                    child: Text("Лабораторная работа 2"),
                  ),
                  FilledButton.tonal(
                    onPressed: () => Navigator.pushNamed(context, '/lab3'),
                    child: Text("Лабораторная работа 3"),
                  ),
                ],
              ),
              Spacer(),
              Text("Выполнил студент группы БФИ2202\nЛозицкий А. Д.", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.right,),
              Spacer(),
              Text("Москва\n2025", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
            ]
          ),
        ),
      ),
    );
  }
}