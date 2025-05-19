import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/datas/programs_data.dart';

class ProgramDetailPage extends StatelessWidget {
  final Map<String, dynamic> program;

  const ProgramDetailPage({super.key, required this.program});

  Map<String, dynamic>? getFullProgramByTitle(String title) {
    return exercisePrograms.firstWhere(
          (prog) => prog['title'] == title,
      orElse: () => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF1565C0);
    final Color backgroundWhite = Colors.white;

    final fullProgram = getFullProgramByTitle(program['title']) ?? {};
    final List days = fullProgram['days'] ?? [];

    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: Text(program['title']),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              program['title'],
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Süre: ${program['duration']} · Seviye: ${program['level']}',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Günlerin ve egzersizlerin detaylı listesi
            Expanded(
              child: ListView.builder(
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final List exercises = day['exercises'] ?? [];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        day['name'] ?? 'Gün ${index + 1}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: primaryBlue,
                        ),
                      ),
                      subtitle: Text(
                        "${exercises.length} hareket · Yaklaşık ${exercises.length * 10} dk",
                      ),
                      children: exercises.map<Widget>((exercise) {
                        return ListTile(
                          title: Text(
                            exercise['name'] ?? 'Hareket',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          subtitle: Text(exercise['description'] ?? ''),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () async {
                final uid = FirebaseAuth.instance.currentUser?.uid;
                if (uid == null) return;

                await FirebaseFirestore.instance.collection('users').doc(uid).update({
                  'activeProgram': program,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Program aktif hale getirildi")),
                );

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Programı Başlat",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: backgroundWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
