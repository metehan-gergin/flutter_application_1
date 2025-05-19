import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseListPage extends StatelessWidget {
  const ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF1565C0);

    final List<Map<String, String>> exercises = [
      {
        'name': 'Squat',
        'description': 'Bacak kasları için temel egzersiz.',
        'gifUrl': 'https://github.com/metehan-gergin/flutter_application1/blob/main/gifs/Girl%20Fitness%20GIF%20by%208fit.gif?raw=true',
      },
      {
        'name': 'Push Up',
        'description': 'Göğüs ve kol kaslarını çalıştırır.',
        'gifUrl': 'https://github.com/metehan-gergin/flutter_application1/blob/main/gifs/Working%20Out%20GIF%20by%20VICE%20WORLD%20OF%20SPORTS.gif?raw=true',
      },
      {
        'name': 'Plank',
        'description': 'Karın kaslarını güçlendirir.',
        'gifUrl': 'https://github.com/metehan-gergin/flutter_application1/blob/main/gifs/Plank%20GIF%20by%20Crossfit%20Boran.gif?raw=true',
      },
      {
        'name': 'Burpee',
        'description': 'Yağ yakmanızı sağlar.',
        'gifUrl': 'https://raw.githubusercontent.com/metehan-gergin/flutter_application1/refs/heads/main/gifs/Burpee%20GIF%20by%20CrossFit%20LLC.gif',
      },
      {
        'name': 'Pull up',
        'description': 'Sırt kaslarınızı geliştirmenizi sağlar.',
        'gifUrl': 'https://github.com/metehan-gergin/flutter_application1/blob/main/gifs/pull%20up%20weight%20loss%20GIF%20by%208fit.gif?raw=true',
      },
      {
        'name': 'Lunge',
        'description': 'Bacak kaslarınızı geliştirmeyi sağlar.',
        'gifUrl': 'https://github.com/metehan-gergin/flutter_application1/blob/main/gifs/fitness%20strengthen%20GIF.gif?raw=true',
      },
      {
        'name': 'Leg raise',
        'description': 'Hem bacak hem karın kasınızı geliştirmeyi sağlar',
        'gifUrl': 'https://github.com/metehan-gergin/flutter_application1/blob/main/gifs/Leg%20Raise%20GIF%20by%20Crossfit%20Boran.gif?raw=true',
      },
      {
        'name': 'Russian Twist',
        'description': 'Bölgesel karın kaslarınızın çalışmasını sağlar',
        'gifUrl': 'https://github.com/metehan-gergin/flutter_application1/blob/main/gifs/Calisthenics%20Exercises%20GIF.gif?raw=true',
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Egzersiz Listesi'),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise['name']!,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exercise['description']!,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      exercise['gifUrl']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text("GIF yüklenemedi")),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // İsteğe bağlı detay ekranı
                      },
                      style: TextButton.styleFrom(foregroundColor: primaryBlue),
                      child: const Text('Detay'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
