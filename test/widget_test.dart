import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:moodie/character_reveal_screen.dart';
import 'package:moodie/main.dart';
import 'package:moodie/moodboard_screen.dart';

void main() {
  /// Verifies that the app successfully renders the main landing home screen.
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text("Hello, I'm Moodie!"), findsOneWidget);
    expect(find.text('My Moodboard 🎨'), findsOneWidget);
  });

  /// Verifies that the MoodboardScreen displays full Moodie characters and deletes mood entries on tap.
  testWidgets('MoodboardScreen displays full Moodie characters and deletes mood', (WidgetTester tester) async {
    // Reset initial saved moods in MoodRepository
    MoodRepository.savedMoods.clear();
    MoodRepository.savedMoods.addAll([
      SavedMood(
        id: '1',
        name: 'Sparkle',
        emotions: ['🤩 Excitement', '🥰 Love'],
        date: DateTime.now(),
      ),
      SavedMood(
        id: '2',
        name: 'Hopeful Cloud',
        emotions: ['🌟 Hope', '😌 Calm'],
        date: DateTime.now(),
      ),
    ]);

    // Build the Moodboard screen within a MaterialApp container
    await tester.pumpWidget(
      const MaterialApp(
        home: MoodboardScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify initial saved moods are rendered with full character widgets
    expect(find.text('Sparkle'), findsOneWidget);
    expect(find.text('Hopeful Cloud'), findsOneWidget);
    expect(find.byType(FullMoodieCharacter), findsNWidgets(2));

    // Tap delete button on the first Moodie card
    final deleteButtons = find.byIcon(Icons.delete_outline_rounded);
    expect(deleteButtons, findsNWidgets(2));

    await tester.tap(deleteButtons.first);
    await tester.pumpAndSettle();

    // Verify confirmation dialog appears
    expect(find.text('Delete Moodie?'), findsOneWidget);

    // Tap 'Delete' button inside the dialog
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Verify that 'Sparkle' was removed from the Moodboard
    expect(find.text('Sparkle'), findsNothing);
    expect(find.text('Hopeful Cloud'), findsOneWidget);
    expect(find.byType(FullMoodieCharacter), findsOneWidget);
  });
}
