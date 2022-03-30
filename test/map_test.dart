// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:so_frontend/feature_home/screens/home.dart';
import 'package:so_frontend/feature_map/screens/map.dart';

import 'package:mockito/mockito.dart';
class MockNavigatorObserver extends Mock implements NavigatorObserver {}


void main() {

  testWidgets('Encontrar botón del mapa y navegar hacia el mapa', (WidgetTester tester) async {
    
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      MaterialApp(
        home: const HomeScreen(),
        routes: {
          '/map_screen': (_) => const MapScreen(),
        },
        navigatorObservers: [mockObserver]
      ),
    );

    

    expect(find.byType(InkWell), findsOneWidget);
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();
    expect(find.byType(MapScreen), findsOneWidget);
  });


}

