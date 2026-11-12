import 'package:material_ui/material_ui.dart';
import 'save_mood_screen.dart';

// Displays the custom cartoon Moodie character generated from the user's selected emotions.
class CharacterRevealScreen extends StatelessWidget {
  // The list of emotion names selected by the user.
  final List<String> selectedEmotions;

  // Creates a [CharacterRevealScreen] given a list of [selectedEmotions].
  const CharacterRevealScreen({super.key, required this.selectedEmotions});

  // Resolves the list of [Color] values corresponding to each selected emotion or combination.
  List<Color> getCharacterColors() {
    if (selectedEmotions.isEmpty) {
      return [const Color(0xFF9B8AE6)];
    }

    // Mapping of individual emotion strings to their characteristic colors.
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

    // Mapping of combination emotion titles to multi-color gradient lists.
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

    for (final item in selectedEmotions) {
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

  // Returns the character facial expression icon.
  IconData getCharacterIcon() {
    return Icons.sentiment_satisfied_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final colors = getCharacterColors();
    final primaryColor = colors.first;

    // Generate discrete steps for multi-color linear gradients.
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cartoon Character Stack featuring full Moodie character body
                FullMoodieCharacter(
                  gradientColors: gradientColors,
                  gradientStops: gradientStops,
                  primaryColor: primaryColor,
                  icon: getCharacterIcon(),
                ),
                const SizedBox(height: 20),
                // Header announcement
                const Text(
                  'Your Moodie is here!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF514477),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your selected emotions:',
                  style: TextStyle(fontSize: 18, color: Color(0xFF71658C)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A little character made from all your feelings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF71658C),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Formatted list of selected emotions
                Text(
                  selectedEmotions.join(', '),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9B8AE6),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Button to proceed to the Save Mood screen
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SaveMoodScreen(
                                selectedEmotions: selectedEmotions,
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B8AE6),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Save my Moodie 💜',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget rendering the complete Moodie character including head, face icon, torso, clothes, arms, hands, legs, and shoes.
class FullMoodieCharacter extends StatelessWidget {
  // The gradient colors applied to Moodie's body parts.
  final List<Color> gradientColors;

  // The gradient color stop positions.
  final List<double> gradientStops;

  // The primary color used for head backing tint.
  final Color primaryColor;

  // The facial expression icon.
  final IconData icon;

  // Rendered width of the character widget box.
  final double width;

  // Rendered height of the character widget box.
  final double height;

  // Creates a [FullMoodieCharacter] with configurable sizing and colors.
  const FullMoodieCharacter({
    super.key,
    required this.gradientColors,
    required this.gradientStops,
    required this.primaryColor,
    this.icon = Icons.sentiment_satisfied_rounded,
    this.width = 200,
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Left Arm & Hand
          Positioned(
            left: 38,
            top: 95,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 22,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    stops: gradientStops,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: -4,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right Arm & Hand
          Positioned(
            right: 38,
            top: 95,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 22,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    stops: gradientStops,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: -4,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Left Leg & Shoe
          Positioned(
            left: 68,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 25,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      stops: gradientStops,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 26,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF514477),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          ),
          // Right Leg & Shoe
          Positioned(
            right: 68,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 25,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      stops: gradientStops,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 26,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF514477),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          ),
          // Torso / Body with Clothes (Cute T-shirt overlay)
          Positioned(
            top: 85,
            child: Container(
              width: 90,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  stops: gradientStops,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9B8AE6).withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 36,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          // Head (Face) on top
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.20),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9B8AE6).withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      colors: gradientColors,
                      stops: gradientStops,
                    ).createShader(bounds),
                child: Icon(
                  icon,
                  size: 85,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
