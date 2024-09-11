import 'package:flutter/material.dart';

class CreateFlashcardsPage extends StatefulWidget {
  @override
  _CreateFlashcardsPageState createState() => _CreateFlashcardsPageState();
}

class _CreateFlashcardsPageState extends State<CreateFlashcardsPage> {
  final List<Map<String, String>> _flashcards = [];
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _addFlashcard() {
    if (_questionController.text.isNotEmpty &&
        _answerController.text.isNotEmpty) {
      setState(() {
        _flashcards.add({
          'question': _questionController.text,
          'answer': _answerController.text,
        });
      });
      _questionController.clear();
      _answerController.clear();
    }
  }

  void _showSaveDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SaveFlashcardsModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Create Flashcards", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black),
            onPressed: _showSaveDialog,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Flashcard input fields
            Expanded(
              child: ListView.builder(
                itemCount: _flashcards.length + 1,
                itemBuilder: (context, index) {
                  if (index == _flashcards.length) {
                    // Input form for adding a new flashcard
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}', // Dynamically showing question number
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5), // Light grey background
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _questionController,
                            decoration: InputDecoration(
                              hintText: 'Enter your question',
                              border:
                                  InputBorder.none, // No border for the input
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Answer',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5), // Light grey background
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _answerController,
                            decoration: InputDecoration(
                              hintText: 'Enter the answer',
                              border:
                                  InputBorder.none, // No border for the input
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Add New button style update
                        GestureDetector(
                          onTap: _addFlashcard,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline,
                                  color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                "Add New",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  // Display flashcards
                  return FlashcardDisplay(
                    question: _flashcards[index]['question']!,
                    answer: _flashcards[index]['answer']!,
                    index: index + 1,
                  );
                },
              ),
            ),
            // Save and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel", style: TextStyle(color: Colors.teal)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.teal),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _showSaveDialog,
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FlashcardDisplay extends StatelessWidget {
  final String question;
  final String answer;
  final int index;

  FlashcardDisplay(
      {required this.question, required this.answer, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question $index",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5), // Light grey background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(question, style: TextStyle(fontSize: 16)),
          ),
          SizedBox(height: 8),
          Text("Answer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5), // Light grey background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(answer, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class SaveFlashcardsModal extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Save Flashcards",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5), // Light grey for input field
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(12),
            child: TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Flashcard Title",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel", style: TextStyle(color: Colors.teal)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.teal),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle save logic here
                  Navigator.pop(context);
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
