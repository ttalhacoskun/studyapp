import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [
    {
      'questionController': TextEditingController(),
      'optionControllers': [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ],
      'selectedOption': null
    }
  ];

  final TextEditingController exerciseTitleController =
      TextEditingController(); // Controller for exercise title input

  void _saveQuestion() {
    bool allQuestionsFilled = true;
    for (var questionData in questions) {
      String question = questionData['questionController'].text;
      List<TextEditingController> optionControllers =
          List<TextEditingController>.from(questionData['optionControllers']);
      List<String> options =
          optionControllers.map((controller) => controller.text).toList();
      int? correctAnswer = questionData['selectedOption'];

      if (question.isEmpty ||
          options.any((option) => option.isEmpty) ||
          correctAnswer == null) {
        allQuestionsFilled = false;
        break;
      }
    }

    if (allQuestionsFilled) {
      // Show the modal to save the exercise with a title
      _showSaveExerciseModal();
    } else {
      // Show error message
      print('Please fill in all fields and select the correct answer.');
    }
  }

  void _showSaveExerciseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ensures the modal goes above the keyboard
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjusts for the keyboard
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content
            children: [
              Text(
                'Save Exercises',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: exerciseTitleController,
                decoration: InputDecoration(
                  labelText: 'Exercise Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal.withOpacity(0.1),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _finalizeSaveExercise();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _finalizeSaveExercise() {
    String exerciseTitle = exerciseTitleController.text.trim();

    if (exerciseTitle.isNotEmpty) {
      // Logic for saving the exercise with the given title
      print('Exercise Title: $exerciseTitle');
      Navigator.pop(context); // Close the modal
      // You can proceed with saving the exercise here
    } else {
      // Handle the case where no title is entered
      print('Please enter an exercise title');
    }
  }

  void _addNewQuestion() {
    setState(() {
      questions.add({
        'questionController': TextEditingController(),
        'optionControllers': [
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ],
        'selectedOption': null
      });
    });
  }

  void _cancel() {
    for (var questionData in questions) {
      questionData['questionController'].clear();
      for (var controller in questionData['optionControllers']) {
        controller.clear();
      }
      questionData['selectedOption'] = null;
    }
    setState(() {
      questions = [
        {
          'questionController': TextEditingController(),
          'optionControllers': [
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
          ],
          'selectedOption': null
        }
      ];
    });
  }

  void _deleteQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Create Exercises'),
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(questions.length, (questionIndex) {
                      var questionData = questions[questionIndex];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Question ${questionIndex + 1}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              if (questionIndex > 0)
                                IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    _deleteQuestion(questionIndex);
                                  },
                                ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(24),
                            child: TextField(
                              controller: questionData['questionController'],
                              decoration: InputDecoration(
                                hintText: 'Enter the question',
                                border: InputBorder.none,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: 16),
                          ...List.generate(4, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${String.fromCharCode(65 + index)}.',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: TextField(
                                              controller: questionData[
                                                  'optionControllers'][index],
                                              decoration: InputDecoration(
                                                hintText: 'Answer',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        questionData['selectedOption'] = index;
                                      });
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              questionData['selectedOption'] ==
                                                      index
                                                  ? Colors.green
                                                  : Colors.grey,
                                          width: 2,
                                        ),
                                        color: questionData['selectedOption'] ==
                                                index
                                            ? Colors.green
                                            : Colors.transparent,
                                      ),
                                      child: questionData['selectedOption'] ==
                                              index
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 16,
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          if (questionIndex == questions.length - 1 &&
                              questionData['questionController']
                                  .text
                                  .isNotEmpty &&
                              (List<TextEditingController>.from(
                                      questionData['optionControllers']))
                                  .every((controller) =>
                                      controller.text.isNotEmpty) &&
                              questionData['selectedOption'] != null)
                            TextButton(
                              onPressed: _addNewQuestion,
                              child: Text('+ Add New'),
                            ),
                          SizedBox(height: 16),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.teal),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: _cancel,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: _saveQuestion,
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
