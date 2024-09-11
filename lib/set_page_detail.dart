import 'package:flutter/material.dart';
import 'package:studyapp/flashcard/quiz/flash_card.dart';
import 'package:studyapp/set_details/quizpage.dart';
import 'package:studyapp/summary_card.dart';
import 'model/flash_card.dart';
import 'model/summary_card.dart';
import 'model/quiz_question.dart';

class StudyPage extends StatefulWidget {
  final String title;

  StudyPage({required this.title});

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'share':
        print("Share clicked");
        break;
      case 'reset':
        print("Reset Progress clicked");
        break;
      case 'remove':
        _showRemoveDialog(); // Show the confirmation dialog
        break;
    }
  }

  void _showRemoveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            'Remove from Library',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sure you want to remove this study set from library?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "You won't lose your progress, and you can add study sets back to the library later.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAdded = false; // Logic for removing from library
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text("Yes, Remove"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            icon: Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.black),
                    SizedBox(width: 10),
                    Text("Share"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.refresh, color: Colors.black),
                    SizedBox(width: 10),
                    Text("Reset Progress"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'remove',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 10),
                    Text("Remove from Library",
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMaterialTab(screenHeight, screenWidth),
          Center(child: Text('Progress tab')),
        ],
      ),
      bottomNavigationBar: _buildAddToLibraryButton(screenWidth),
    );
  }

  Widget _buildMaterialTab(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Flashcards', 46),
            _buildListItem(
                'Cell Anatomy & Structure', '15 flashcards', screenWidth, [
              Flashcard(
                  term: 'Cell Membrane',
                  explanation:
                      'The cell membrane is the outer lining of the cell.'),
              Flashcard(
                  term: 'Cytoplasm',
                  explanation:
                      'The cytoplasm is a jelly-like fluid inside the cell.'),
            ]),
            _buildListItem('Cell Membranes', '20 flashcards', screenWidth, [
              Flashcard(
                  term: 'Cell Membrane',
                  explanation:
                      'The cell membrane is the outer lining of the cell.'),
              Flashcard(
                  term: 'Cytoplasm',
                  explanation:
                      'The cytoplasm is a jelly-like fluid inside the cell.'),
            ]),
            SizedBox(height: screenHeight * 0.02),
            _buildSectionHeader('Explanations', 13),
            _buildListItemWithIcon(
                'Microbial Physiology',
                'Microbial Physiology Description',
                screenWidth,
                Icons.description_outlined, [
              SummaryCard(
                  title: 'Microbial Physiology Overview',
                  description:
                      'This is an introduction to microbial physiology.'),
              SummaryCard(
                  title: 'Metabolism',
                  description:
                      'Description of microbial metabolism and its functions.'),
            ]),
            _buildListItemWithIcon(
                'The Structure and Function of Cells',
                'Explanation for Structure and Function of Cells',
                screenWidth,
                Icons.description_outlined, [
              SummaryCard(
                  title: 'Cell Functions Overview',
                  description:
                      'An overview of the structure and function of cells.'),
              SummaryCard(
                  title: 'Organelles',
                  description:
                      'Details of various organelles and their roles in cells.'),
            ]),
            SizedBox(height: screenHeight * 0.02),
            _buildSectionHeader('Exercises', 21),
            _buildListItemForQuiz(
                'Cell Division & Mitosis', '10 questions', screenWidth, [
              QuizQuestion(
                  question: 'What is the purpose of mitosis?',
                  options: [
                    'Growth',
                    'Repair',
                    'Reproduction',
                    'All of the above'
                  ],
                  correctAnswer: 'All of the above'),
              QuizQuestion(
                  question: 'In which phase of mitosis do chromosomes align?',
                  options: ['Prophase', 'Metaphase', 'Anaphase', 'Telophase'],
                  correctAnswer: 'Metaphase'),
            ]),
            _buildListItemForQuiz('Cell Division and Genetics Practice',
                '20 questions', screenWidth, []),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title ($count)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                    color: Color(0xFF1A2136), fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward, color: Color(0xFF1A2136), size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(String title, String subtitle, double screenWidth,
      List<Flashcard> flashcards) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          if (flashcards.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashcardPage(flashcards: flashcards),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildListItemWithIcon(String title, String subtitle,
      double screenWidth, IconData icon, List<SummaryCard> summaryCards) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummaryCardPage(summaryCards: summaryCards),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListItemForQuiz(String title, String subtitle,
      double screenWidth, List<QuizQuestion> questions) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          if (questions.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPage(questions: questions),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAddToLibraryButton(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isAdded = !isAdded;
          });
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 16, horizontal: screenWidth * 0.2),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              isAdded ? Colors.white : Color(0xFF1A2136)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Color(0xFF1A2136)),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isAdded ? Icons.check : Icons.add,
              color: isAdded ? Color(0xFF1A2136) : Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              isAdded ? 'Added to My Library' : 'Add to My Library',
              style: TextStyle(
                color: isAdded ? Color(0xFF1A2136) : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
