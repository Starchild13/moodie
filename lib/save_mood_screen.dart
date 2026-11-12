import 'package:material_ui/material_ui.dart';
import 'character_reveal_screen.dart';
import 'moodboard_screen.dart';

// Screen allowing users to name and save their custom Moodie character.
class SaveMoodScreen extends StatefulWidget {
  // The list of selected emotion strings to be saved with the Moodie.
  final List<String> selectedEmotions;

  // Creates a [SaveMoodScreen] given [selectedEmotions].
  const SaveMoodScreen({super.key, required this.selectedEmotions});

  @override
  State<SaveMoodScreen> createState() => _SaveMoodScreenState();
}

// State implementation for [SaveMoodScreen].
class _SaveMoodScreenState extends State<SaveMoodScreen> {
  // Controller for managing text input in the Moodie name field.
  final TextEditingController nameController = TextEditingController();

  // List of suggested names for quick selection.
  final List<String> nameSuggestions = [
    'Sparkle ✨',
    'Sunny ☀️',
    'Hope 🌟',
    'Cloudie ☁️',
    'Blossom 🌸',
    'Mellow 😌',
    'Zen 🧘',
  ];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // Maps emotion strings to color representations for character preview gradient.
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

  // Fills in a suggested name into the text controller.
  void _selectSuggestion(String rawSuggestion) {
    // Strip emojis for a clean name input
    final cleanName = rawSuggestion.replaceAll(RegExp(r'[^\w\s]+'), '').trim();
    setState(() {
      nameController.text = cleanName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = getCharacterColors(widget.selectedEmotions);
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

    return Scaffold(
      backgroundColor: const Color(0xFFF3EFFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3EFFB),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF514477)),
        actions: [
          // Action button navigating to Moodboard
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            tooltip: 'View Moodboard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoodboardScreen(),
                ),
              );
            },
          ),
          // Action button popping back to root home screen
          IconButton(
            icon: const Icon(Icons.home_rounded),
            tooltip: 'Home',
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Step Badge Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF9B8AE6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 16,
                      color: Color(0xFF514477),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Step 2 of 2: Name Your Character',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF514477),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Screen header title
              const Text(
                'Save Your Moodie 💜',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF514477),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Give your character a special name before adding it to your Moodboard gallery.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF71658C),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // Moodie Preview Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9B8AE6).withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Render Moodie Character Visual Avatar
                    SizedBox(
                      height: 130,
                      width: 150,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: FullMoodieCharacter(
                          gradientColors: gradientColors,
                          gradientStops: gradientStops,
                          primaryColor: primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Selected Feelings',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF71658C),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Chips displaying selected emotions
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children:
                          widget.selectedEmotions.map((emotion) {
                            return Chip(
                              backgroundColor: const Color(0xFFE8E0FA),
                              side: const BorderSide(color: Color(0xFFD6C7F5)),
                              label: Text(
                                emotion,
                                style: const TextStyle(
                                  color: Color(0xFF514477),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Name Input Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9B8AE6).withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.edit_note_rounded,
                          color: Color(0xFF514477),
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Moodie Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF514477),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Styled Text field for custom Moodie name
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        color: Color(0xFF514477),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'e.g. Sunny, Hope or Sparkle',
                        hintStyle: const TextStyle(
                          color: Color(0xFF9AA6B8),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F6FC),
                        prefixIcon: const Icon(
                          Icons.face_rounded,
                          color: Color(0xFF9B8AE6),
                        ),
                        suffixIcon:
                            nameController.text.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                    color: Color(0xFF71658C),
                                  ),
                                  onPressed: () {
                                    nameController.clear();
                                    setState(() {});
                                  },
                                )
                                : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFF9B8AE6),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Quick Name Suggestions
                    const Text(
                      'Suggested names:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF71658C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          nameSuggestions.map((suggestion) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => _selectSuggestion(suggestion),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3EFFB),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFD6C7F5),
                                  ),
                                ),
                                child: Text(
                                  suggestion,
                                  style: const TextStyle(
                                    color: Color(0xFF514477),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Button submitting the named Moodie to MoodRepository
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    final moodName = nameController.text.trim();
                    if (moodName.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please give your Moodie a name!'),
                        ),
                      );
                    } else {
                      // Insert new mood entry into MoodRepository in-memory store
                      MoodRepository.savedMoods.insert(
                        0,
                        SavedMood(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: moodName,
                          emotions: List.from(widget.selectedEmotions),
                          date: DateTime.now(),
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '$moodName is saved to your Moodboard! 💜',
                          ),
                        ),
                      );

                      // Navigate directly to MoodboardScreen replacing current screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoodboardScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF514477),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_add_rounded, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Save to My Moodboard 💜',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Navigation shortcuts row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoodboardScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.grid_view_rounded,
                      color: Color(0xFF514477),
                      size: 18,
                    ),
                    label: const Text(
                      'View Moodboard',
                      style: TextStyle(
                        color: Color(0xFF514477),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(
                      Icons.home_rounded,
                      color: Color(0xFF514477),
                      size: 18,
                    ),
                    label: const Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0xFF514477),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
