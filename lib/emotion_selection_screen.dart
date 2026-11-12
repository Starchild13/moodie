import 'package:material_ui/material_ui.dart';
import 'character_reveal_screen.dart';

// Screen enabling users to select single or combination emotion chips.
class EmotionSelectionScreen extends StatefulWidget {
  // Creates an instance of [EmotionSelectionScreen].
  const EmotionSelectionScreen({super.key});

  @override
  State<EmotionSelectionScreen> createState() {
    return _EmotionSelectionScreenState();
  }
}

// State implementation for [EmotionSelectionScreen].
class _EmotionSelectionScreenState extends State<EmotionSelectionScreen> {
  // List holding currently selected emotion strings.
  List<String> selectedEmotions = [];

  // Active search query string.
  String searchQuery = '';

  // Currently active category tab filter.
  String selectedCategoryFilter = 'All';

  // Controller for search text input field.
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Toggles an emotion in the [selectedEmotions] list.
  void toggleEmotion(String emotion) {
    setState(() {
      if (selectedEmotions.contains(emotion)) {
        selectedEmotions.remove(emotion);
      } else {
        selectedEmotions.add(emotion);
      }
    });
  }

  // Maps emotion strings to color representations for live character preview.
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

  // Custom helper widget building styled emotion chips.
  // Unselected: Light purple background with dark purple text.
  // Selected: Dark purple background with white bold text & checkmark.
  Widget _buildChip(String emotion) {
    final isSelected = selectedEmotions.contains(emotion);

    return FilterChip(
      label: Text(emotion),
      selected: isSelected,
      onSelected: (_) => toggleEmotion(emotion),
      backgroundColor: const Color(0xFFE8E0FA), // Light purple
      selectedColor: const Color(0xFF514477), // Dark purple when selected
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF514477),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
        fontSize: 14,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFF514477) : const Color(0xFFD6C7F5),
          width: 1.5,
        ),
      ),
      elevation: isSelected ? 3 : 0,
      shadowColor: const Color(0xFF514477).withValues(alpha: 0.3),
    );
  }

  // Section card wrapper for clean grouping of emotion categories.
  Widget _buildCategoryCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> emotions,
    String? subtitle,
  }) {
    // Filter list based on active search query
    final filtered =
        emotions.where((e) {
          if (searchQuery.trim().isEmpty) return true;
          return e.toLowerCase().contains(searchQuery.toLowerCase().trim());
        }).toList();

    if (filtered.isEmpty) {
      return const SizedBox.shrink();
    }

    // Count how many items in this category are selected
    final selectedCount =
        filtered.where((e) => selectedEmotions.contains(e)).length;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9B8AE6).withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF514477),
                  ),
                ),
              ),
              if (selectedCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF514477),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$selectedCount selected',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF71658C),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: filtered.map((e) => _buildChip(e)).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generate live Moodie gradient colors
    final colors = getCharacterColors(selectedEmotions);
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
        title: const Text(
          'Check-in',
          style: TextStyle(
            color: Color(0xFF514477),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Banner
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF9B8AE6,
                              ).withValues(alpha: 0.15),
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
                                  'Step 1 of 2: Express Yourself',
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
                          const Text(
                            'How are you feeling?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF514477),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Choose as many emotions as describe your current state.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF71658C),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Live Moodie Character Preview & Selected emotions summary banner
                    if (selectedEmotions.isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF514477),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF514477,
                              ).withValues(alpha: 0.25),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Live Moodie Character Avatar preview
                                Container(
                                  width: 54,
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: FullMoodieCharacter(
                                      gradientColors: gradientColors,
                                      gradientStops: gradientStops,
                                      primaryColor: primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Your Moodie Preview ✨',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${selectedEmotions.length} ${selectedEmotions.length == 1 ? 'emotion' : 'emotions'} blended',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFE8E0FA),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedEmotions.clear();
                                    });
                                  },
                                  child: const Text(
                                    'Clear all',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFC6A5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  selectedEmotions.map((emotion) {
                                    return Chip(
                                      label: Text(emotion),
                                      backgroundColor: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      deleteIcon: const Icon(
                                        Icons.close_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      onDeleted: () => toggleEmotion(emotion),
                                      labelStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                      side: BorderSide.none,
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
                    ],

                    // Search field for filtering emotions
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF9B8AE6,
                            ).withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            searchQuery = val;
                          });
                        },
                        style: const TextStyle(
                          color: Color(0xFF514477),
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search emotions (e.g. Hope, Sadness...)',
                          hintStyle: const TextStyle(
                            color: Color(0xFF9AA6B8),
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF9B8AE6),
                          ),
                          suffixIcon:
                              searchQuery.isNotEmpty
                                  ? IconButton(
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                      color: Color(0xFF71658C),
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {
                                        searchQuery = '';
                                      });
                                    },
                                  )
                                  : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Category Filters Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterCategoryTab('All', Icons.grid_view_rounded),
                          const SizedBox(width: 8),
                          _buildFilterCategoryTab('Positive', Icons.wb_sunny_rounded),
                          const SizedBox(width: 8),
                          _buildFilterCategoryTab('Mixed', Icons.auto_awesome_rounded),
                          const SizedBox(width: 8),
                          _buildFilterCategoryTab('Difficult', Icons.cloud_rounded),
                          const SizedBox(width: 8),
                          _buildFilterCategoryTab('Reflections', Icons.psychology_rounded),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Category Cards rendering
                    if (selectedCategoryFilter == 'All' ||
                        selectedCategoryFilter == 'Positive')
                      _buildCategoryCard(
                        title: 'Positive & Uplifting',
                        icon: Icons.wb_sunny_rounded,
                        iconColor: const Color(0xFFFFA94D),
                        emotions: [
                          '🤩 Excitement',
                          '🥰 Love',
                          '😌 Calm',
                          '🙏 Gratitude',
                          '😎 Confidence',
                          '🌟 Hope',
                        ],
                      ),

                    if (selectedCategoryFilter == 'All' ||
                        selectedCategoryFilter == 'Mixed')
                      _buildCategoryCard(
                        title: 'Complex & Mixed Feelings',
                        subtitle:
                            'Can\'t pinpoint a single feeling? Mix & match combined emotions!',
                        icon: Icons.auto_awesome_rounded,
                        iconColor: const Color(0xFF9B8AE6),
                        emotions: [
                          '🤩😰 Excited but Nervous',
                          '😊😢 Happy but Sad',
                          '🥰🥺 Loved but Lonely',
                          '😠💔 Angry and Hurt',
                          '🌟😟 Hopeful but Anxious',
                          '😊🤩😰 Happy, Excited & Nervous',
                          '🥰😢🌙 Loving, Sad & Nostalgic',
                          '😟😣💭 Anxious, Frustrated & Overwhelmed',
                          '🌟😌🥺 Hopeful, Calm & Lonely',
                          '🖤😢❤️‍🩹 Grieving, Sad & Healing',
                        ],
                      ),

                    if (selectedCategoryFilter == 'All' ||
                        selectedCategoryFilter == 'Difficult')
                      _buildCategoryCard(
                        title: 'Heavy & Difficult Feelings',
                        icon: Icons.cloud_rounded,
                        iconColor: const Color(0xFF8FAADC),
                        emotions: [
                          '😢 Sadness',
                          '😟 Anxiety',
                          '😠 Anger',
                          '😨 Fear',
                          '🥺 Loneliness',
                          '🖤 Grief',
                          '😣 Frustration',
                          '😔 Disappointment',
                          '😵 Overwhelm',
                          '😞 Guilt',
                        ],
                      ),

                    if (selectedCategoryFilter == 'All' ||
                        selectedCategoryFilter == 'Reflections')
                      _buildCategoryCard(
                        title: 'Reflections & Other Feelings',
                        icon: Icons.psychology_rounded,
                        iconColor: const Color(0xFF75C9D1),
                        emotions: [
                          '🤔 Confusion',
                          '🔍 Curiosity',
                          '😐 Boredom',
                          '🌙 Nostalgia',
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Action Bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                      selectedEmotions.isEmpty
                          ? null
                          : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CharacterRevealScreen(
                                      selectedEmotions: List.from(
                                        selectedEmotions,
                                      ),
                                    ),
                              ),
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF514477),
                    disabledBackgroundColor: const Color(
                      0xFFD6C7F5,
                    ).withValues(alpha: 0.5),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: const Color(0xFF71658C),
                    elevation: selectedEmotions.isEmpty ? 0 : 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedEmotions.isEmpty
                            ? 'Select at least 1 emotion'
                            : 'Create My Moodie (${selectedEmotions.length})',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (selectedEmotions.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget building category filter pills.
  Widget _buildFilterCategoryTab(String categoryName, IconData icon) {
    final isSelected = selectedCategoryFilter == categoryName;

    return ChoiceChip(
      avatar: Icon(
        icon,
        size: 16,
        color: isSelected ? Colors.white : const Color(0xFF514477),
      ),
      label: Text(categoryName),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            selectedCategoryFilter = categoryName;
          });
        }
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF514477),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF514477),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide(
        color: isSelected ? const Color(0xFF514477) : const Color(0xFFD6C7F5),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
