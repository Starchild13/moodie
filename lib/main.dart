import 'package:material_ui/material_ui.dart';
import 'introduction_screen.dart';
import 'moodboard_screen.dart';

// Main entry point for the Moodie application.
void main() {
  runApp(const MyApp());
}

// Root widget of the Moodie application, configuring themes and primary routing.
class MyApp extends StatelessWidget {
  // Creates the root [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodie',
      // Configure light theme colors with soft purple primary seed.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9B8AE6)),
        brightness: Brightness.light,
      ),
      // Configure dark theme colors with soft purple primary seed.
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9B8AE6),
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Welcome to Moodie'),
    );
  }
}

// Home screen welcoming the user and initiating the mood check-in journey.
class MyHomePage extends StatefulWidget {
  // Creates the home screen widget.
  const MyHomePage({super.key, required this.title});

  // The title displayed in the home page header.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State implementation for [MyHomePage].
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EFFB),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circular container housing the app avatar icon
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_emotions_rounded,
                    size: 80,
                    color: Color(0xFF9B8AE6),
                  ),
                ),
                const SizedBox(height: 32),
                // Welcome header text
                const Text(
                  "Hello, I'm Moodie!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF514477),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Subtitle description
                const Text(
                  'A little space to check in with how you feel.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF71658C),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                // Button navigating to the Introduction screen
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IntroductionScreen(),
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
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Button navigating directly to the Moodboard screen
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoodboardScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF514477),
                    side: const BorderSide(color: Color(0xFF9B8AE6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  icon: const Icon(Icons.grid_view_rounded),
                  label: const Text(
                    'My Moodboard 🎨',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
