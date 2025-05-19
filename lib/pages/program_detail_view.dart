import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayDetailViewPage extends StatelessWidget {
  final Map<String, dynamic> day;

  const DayDetailViewPage({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF1565C0);
    final Color backgroundWhite = Colors.white;

    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: Text(day['name']),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gün başlığı
            Text(
              day['name'],
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Gün içeriği (egzersizler)
            Expanded(
              child: ListView.builder(
                itemCount: day['exercises']?.length ?? 0,
                itemBuilder: (context, index) {
                  final exercise = day['exercises'][index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        exercise['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(exercise['reps']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
