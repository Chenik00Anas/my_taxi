import 'package:flutter/material.dart';
import 'dart:io'; // Pour la gestion des fichiers
import 'dart:convert'; // Pour encoder/décoder JSON
import 'package:path_provider/path_provider.dart'; // Pour obtenir un chemin d'accès valide

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  int rating = 0;

  // Chemin du fichier JSON dans le dossier Documents
  late File commentsFile;

  @override
  void initState() {
    super.initState();
    // Initialiser le fichier JSON au démarrage
    _initCommentsFile();
  }

  // Initialiser le fichier JSON
  Future<void> _initCommentsFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      print('Documents directory: ${directory.path}');
      commentsFile = File('${directory.path}/comments.json');
      print('Comments file path: ${commentsFile.path}');

      if (!await commentsFile.exists()) {
        await commentsFile.writeAsString('[]');
        print('File created with empty list.');
      }
    } catch (e) {
      print('Error initializing comments file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing comments file: $e')),
      );
    }
  }

  // Sauvegarder les commentaires dans le fichier JSON
  void _saveComments(String email, String feedback, int rating) async {
    try {
      // Lire les commentaires existants
      List<Map<String, dynamic>> comments = [];
      if (await commentsFile.exists()) {
        String contents = await commentsFile.readAsString();
        if (contents.isNotEmpty) {
          comments = List<Map<String, dynamic>>.from(json.decode(contents));
        }
      }

      // Ajouter le nouveau commentaire
      comments.add({
        'email': email,
        'feedback': feedback,
        'rating': rating,
        'timestamp': DateTime.now().toString(), // Ajouter un horodatage
      });

      // Écrire les commentaires dans le fichier JSON
      await commentsFile.writeAsString(json.encode(comments));
      print('Comment saved: ${comments.last}');
    } catch (e) {
      print('Error saving comments: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving comment: $e')),
      );
    }
  }

  void submitFeedback() {
    final String email = emailController.text;
    final String feedback = feedbackController.text;

    if (email.isEmpty || feedback.isEmpty || rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs.')),
      );
      return;
    }

    // Sauvegarder les commentaires dans le fichier JSON
    _saveComments(email, feedback, rating);

    // Afficher un message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Merci pour votre avis !')),
    );

    // Réinitialiser les champs
    emailController.clear();
    feedbackController.clear();
    setState(() {
      rating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donnez votre avis'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Votre e-mail :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Entrez votre e-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Votre avis :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: feedbackController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Entrez votre commentaire',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Notez notre service :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                );
              })),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('Soumettre', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}