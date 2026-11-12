import 'package:material_ui/material_ui.dart';
import 'emotion_selection_screen.dart';

// Screen that welcomes the user and explains the core concept of Moodie.
class IntroductionScreen extends StatelessWidget {
  // Creates an instance of [IntroductionScreen].
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EFFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3EFFB),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF514477)),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Heart icon illustrating emotional check-in
                const Icon(
                  Icons.favorite_rounded,
                  size: 65,
                  color: Color(0xFF9B8AE6),
                ),
                const SizedBox(height: 20),
                // Title text
                const Text(
                  'Discover Moodie',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF514477),
                  ),
                ),
                const SizedBox(height: 16),
                // Introductory description statement
                const Text(
                  'Your feelings tell a story. Moodie helps you explore it, one check-in at a time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF71658C),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                // Action button to proceed to emotion selection
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmotionSelectionScreen(),
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
                    child: const Text('Continue'),
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
