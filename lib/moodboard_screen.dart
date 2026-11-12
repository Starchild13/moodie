import 'package:material_ui/material_ui.dart';
import 'character_reveal_screen.dart';

// Data class representing a saved Moodie character entry.
class SavedMood {
  // Unique identifier for the saved mood.
  final String id;

  // Given name of the Moodie character.
  final String name;

  // List of emotion names selected for this Moodie.
  final List<String> emotions;

  // Timestamp when the mood was recorded.
  final DateTime date;

  // Creates a [SavedMood] record instance.
  SavedMood({
    required this.id,
    required this.name,
    required this.emotions,
    required this.date,
  });
}

// In-memory repository for storing and managing saved Moodie characters.
class MoodRepository {
  // Global in-memory list storing saved Moodie entries.
  static final List<SavedMood> savedMoods = [
    SavedMood(
      id: '1',
      name: 'Sparkle',
      emotions: ['🤩 Excitement', '🥰 Love'],
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SavedMood(
      id: '2',
      name: 'Hopeful Cloud',
      emotions: ['🌟 Hope', '😌 Calm'],
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    SavedMood(
      id: '3',
      name: 'Bittersweet',
      emotions: ['😊😢 Happy but Sad'],
      date: DateTime.now(),
    ),
  ];

  // Deletes a saved mood entry matching the specified [id].
  static void deleteMood(String id) {
    savedMoods.removeWhere((mood) => mood.id == id);
  }
}

// Screen displaying a compact grid of all saved Moodie characters as a Moodboard.
class MoodboardScreen extends StatefulWidget {
  // Creates an instance of [MoodboardScreen].
  const MoodboardScreen({super.key});

  @override
  State<MoodboardScreen> createState() => _MoodboardScreenState();
}

// State implementation for [MoodboardScreen].
class _MoodboardScreenState extends State<MoodboardScreen> {
  // Displays a confirmation dialog before deleting a saved [mood].
  void _confirmDelete(BuildContext context, SavedMood mood) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete Moodie?',
          style: TextStyle(
            color: Color(0xFF514477),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${mood.name}" from your moodboard?',
          style: const TextStyle(color: Color(0xFF71658C)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF71658C)),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                MoodRepository.deleteMood(mood.id);
              });
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${mood.name} deleted'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFFE98282),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Maps emotion strings to color representations for character gradients.
  List<Color> getCharacterColors(List<String> emotions) {
    if (emotions.isEmpty) {
      return [const Color(0xFF9B8AE6)];
    }

    final singleEmotionColors = {
      '🤩 Excitement': const Color(0xFFFFA94D),
      '🥰 Love': const Color(0xFFF2A6C2),
      '😌 Calm': const Color(0xFF91CDB5),
      '🙏 Gratitude': const Color(0xFFFFC6A5),
      '😎 Confidence': const Color(0xFF8E9FE6),
      '🌟 Hope': const Color(0xFFFFD98E),
      '😢 Sadness': const Color(0xFF8FAADC),
      '😟 Anxiety': const Color(0xFFFFAD8F),
      '😠 Anger': const Color(0xFFE98282),
      '😨 Fear': const Color(0xFF9B8ACD),
      '🥺 Loneliness': const Color(0xFF8095B5),
      '🖤 Grief': const Color(0xFF7189B9),
      '😣 Frustration': const Color(0xFFE99B78),
      '😔 Disappointment': const Color(0xFF9AA6B8),
      '😵 Overwhelm': const Color(0xFFB39BC8),
      '😞 Guilt': const Color(0xFF9A9B80),
      '🤔 Confusion': const Color(0xFFB5A0D5),
      '🔍 Curiosity': const Color(0xFF75C9D1),
      '😐 Boredom': const Color(0xFFB0B0B0),
      '🌙 Nostalgia': const Color(0xFFD5A6BD),
      '😊Happiness': const Color(0xFFFFD166),
    };

    final combinationColors = {
      '🤩😰 Excited but Nervous': [
        const Color(0xFFFFA94D),
        const Color(0xFFFFAD8F),
      ],
      '😊😢 Happy but Sad': [const Color(0xFFFFD166), const Color(0xFF8FAADC)],
      '🥰🥺 Loved but Lonely': [
        const Color(0xFFF2A6C2),
        const Color(0xFF8095B5),
      ],
      '😠💔 Angry and Hurt': [const Color(0xFFE98282), const Color(0xFF7189B9)],
      '🌟😟 Hopeful but Anxious': [
        const Color(0xFFFFD98E),
        const Color(0xFFFFAD8F),
      ],
      '😊🤩😰 Happy, Excited & Nervous': [
        const Color(0xFFFFD166),
        const Color(0xFFFFA94D),
        const Color(0xFFFFAD8F),
      ],
      '🥰😢🌙 Loving, Sad & Nostalgic': [
        const Color(0xFFF2A6C2),
        const Color(0xFF8FAADC),
        const Color(0xFFD5A6BD),
      ],
      '😟😣💭 Anxious, Frustrated & Overwhelmed': [
        const Color(0xFFFFAD8F),
        const Color(0xFFE99B78),
        const Color(0xFFB39BC8),
      ],
      '🌟😌🥺 Hopeful, Calm & Lonely': [
        const Color(0xFFFFD98E),
        const Color(0xFF91CDB5),
        const Color(0xFF8095B5),
      ],
      '🖤😢❤️‍🩹 Grieving, Sad & Healing': [
        const Color(0xFF7189B9),
        const Color(0xFF8FAADC),
        const Color(0xFFFFA94D),
      ],
    };

    List<Color> resolvedColors = [];

    for (final item in emotions) {
      if (combinationColors.containsKey(item)) {
        resolvedColors.addAll(combinationColors[item]!);
      } else if (singleEmotionColors.containsKey(item)) {
        resolvedColors.add(singleEmotionColors[item]!);
      } else {
        bool found = false;
        for (final entry in singleEmotionColors.entries) {
          if (item.contains(
            entry.key.replaceAll(RegExp(r'[^\w\s]+'), '').trim(),
          )) {
            resolvedColors.add(entry.value);
            found = true;
            break;
          }
        }
        if (!found) {
          resolvedColors.add(const Color(0xFF9B8AE6));
        }
      }
    }

    if (resolvedColors.isEmpty) {
      return [const Color(0xFF9B8AE6)];
    }

    return resolvedColors;
  }

  @override
  Widget build(BuildContext context) {
    final moods = MoodRepository.savedMoods;

    return Scaffold(
      backgroundColor: const Color(0xFFF3EFFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3EFFB),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF514477)),
        title: const Text(
          'My Moodboard 🎨',
          style: TextStyle(
            color: Color(0xFF514477),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_rounded),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SafeArea(
        child:
            moods.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 80,
                        color: Color(0xFF9B8AE6),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your Moodboard is empty',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF514477),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Check in with how you feel to create your first Moodie!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF71658C),
                        ),
                      ),
                    ],
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    itemCount: moods.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                    itemBuilder: (context, index) {
                      final mood = moods[index];
                      final colors = getCharacterColors(mood.emotions);
                      final primaryColor = colors.first;

                      List<Color> gradientColors = [];
                      List<double> gradientStops = [];

                      final n = colors.length;
                      for (int i = 0; i < n; i++) {
                        final start = i / n;
                        final end = (i + 1) / n;
                        gradientColors.add(colors[i]);
                        gradientColors.add(colors[i]);
                        gradientStops.add(start);
                        gradientStops.add(end);
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF9B8AE6,
                              ).withValues(alpha: 0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Full Moodie Character with body (scaled to fit compact card)
                                SizedBox(
                                  height: 70,
                                  width: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: FullMoodieCharacter(
                                      gradientColors: gradientColors,
                                      gradientStops: gradientStops,
                                      primaryColor: primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  mood.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF514477),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  mood.emotions.join(', '),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF71658C),
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            // Delete Mood icon button at top right
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => _confirmDelete(context, mood),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.delete_outline_rounded,
                                      size: 16,
                                      color: Colors.red.shade300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
      ),
    );
  }
}
