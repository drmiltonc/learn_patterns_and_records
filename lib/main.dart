import 'package:flutter/material.dart';
import 'block_widget.dart';
import 'document.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DocumentScreen(Document()),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  const DocumentScreen(this.document, {super.key});

  final Document document;

  String formatDate(DateTime dateTime) {
    final today = DateTime.now();
    final difference = dateTime.difference(today);

    return switch (difference) {
      Duration(inDays: 0) => 'today',
      Duration(inDays: 1) => 'tomorrow',
      Duration(inDays: -1) => 'yesterday',
      Duration(inDays: final days) when days > 7 =>
        '${days ~/ 7} weeks from now',
      Duration(inDays: final days) when days < -7 =>
        '${days.abs() ~/ 7} weeks ago',
      Duration(inDays: final days, isNegative: true) =>
        '${days.abs() ~/ 7} days ago',
      Duration(inDays: final days) => '$days days ago'
    };
  }

  @override
  Widget build(BuildContext context) {
    final (title, :modified) = document.getMetadata();
    final formatedDate = formatDate(modified);
    final blocks = document.getBlocks(); // New

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text('Last modified: $formatedDate'),
          Expanded(
            child: ListView.builder(
              itemCount: blocks.length,
              itemBuilder: (context, index) {
                return BlockWidget(blocks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

