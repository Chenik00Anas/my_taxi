// lib/src/screens/FeedbackScreen.dart
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  int rating = 0;

  void submitFeedback() {
    final String email = emailController.text;
    final String feedback = feedbackController.text;

    if (email.isEmpty || feedback.isEmpty || rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs.')),
      );
      return;
    }

    print('Email: $email');
    print('Feedback: $feedback');
    print('Rating: $rating');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Merci pour votre avis !')),
    );

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
              }),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Couleur de fond du bouton
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Style du texte
                ),
                child: const Text('Soumettre', style: TextStyle(color: Colors.white)), // Texte du bouton
              ),
            ),
          ],
        ),
      ),
    );
  }
}