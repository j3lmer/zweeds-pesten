import 'package:flutter/material.dart';

void main() {
  runApp(const ZweedsPesten());
}

class ZweedsPesten extends StatelessWidget {
  const ZweedsPesten({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zweeds Pesten',
      theme: ThemeData(
        // FIXED: Added 'ColorScheme' before '.fromSeed'
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HoofdMenu(title: 'Zweeds Pesten'),
    );
  }
}

class HoofdMenu extends StatefulWidget {
  const HoofdMenu({super.key, required this.title});

  final String title;

  @override
  State<HoofdMenu> createState() => _HoofdMenuState();
}

enum GameType { fiends, bot }

class _HoofdMenuState extends State<HoofdMenu> {
  // Navigation helper
  void _openGame(GameType gameType) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Game(title: "Into da game"),
      ),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsMenu(title: "Instellings"),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // FIXED: Added 'MainAxisAlignment' before '.center'
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welkom bij Zweeds Pesten!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _openGame(GameType.bot),
              child: const Text('V.S. Bot'),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _openGame(GameType.fiends),
              child: const Text('V.S. Vrienden'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _openSettings,
              child: const Text('Instellingen'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- SETTINGS MENU ---
class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key, required this.title});
  final String title;

  @override
  // FIXED: Changed State type to _SettingsMenuState
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const Center(child: Text("Instellingen")),
    );
  }
}

// --- GAME SCREEN ---
class Game extends StatefulWidget {
  const Game({super.key, required this.title});
  final String title;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const Center(child: Text("Hier komt het kaartspel!")),
    );
  }
}
