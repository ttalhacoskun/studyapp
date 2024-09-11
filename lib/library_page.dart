import 'package:flutter/material.dart';
import 'package:studyapp/comp/set_card.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        title: Text("L I B R A R Y"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  children: [
                    StudySetCard(
                      title: 'Microbiology',
                      flashcards: 246,
                      explanations: 195,
                      exercises: 163,
                      author: 'Dr. Smith',
                      color: Color(0xFF4285F4),
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      onTap: () {},
                    ),
                    StudySetCard(
                      title: 'Artificial Intelligence',
                      flashcards: 305,
                      explanations: 294,
                      exercises: 201,
                      author: 'Prof. Johnson',
                      color: Color(0xFFEA4335),
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      onTap: () {},
                    ),
                    StudySetCard(
                      title: 'Entrepreneurship',
                      flashcards: 260,
                      explanations: 154,
                      exercises: 182,
                      author: 'Ms. Wilson',
                      color: Color(0xFF34A853),
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      onTap: () {},
                    ),
                    StudySetCard(
                      title: 'Political Science',
                      flashcards: 194,
                      explanations: 126,
                      exercises: 109,
                      author: 'Mr. Carter',
                      color: Color(0xFFFBBC05),
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                _showCreateStudySetBottomSheet(
                    context); // Alt taraftan açılan form
              },
              icon: Icon(
                Icons.add_circle,
                size: 24,
                color: Colors.white,
              ),
              label: Text(
                'Add Plan',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Arka plan rengi
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12), // Buton boyutu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // Butonun kenarlarını yuvarlıyoruz
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Alt taraftan açılan form için fonksiyon
  void _showCreateStudySetBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Tam ekran boyutunu kaplaması için
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.5, // Minimum ekran yüksekliği (yarısı)
          maxChildSize:
              0.75, // Maksimum ekran yüksekliği (isteğe bağlı daha fazla açılabilir)
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CreateStudySetForm(), // Form bileşeni
              ),
            );
          },
        );
      },
    );
  }
}

// Create Study Set formu
class CreateStudySetForm extends StatefulWidget {
  @override
  _CreateStudySetFormState createState() => _CreateStudySetFormState();
}

class _CreateStudySetFormState extends State<CreateStudySetForm> {
  String? _selectedSubject;
  bool _isPublic = false;
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Create Study Set',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Study Set Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedSubject,
            onChanged: (value) {
              setState(() {
                _selectedSubject = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: ['Computer Science', 'Mathematics', 'Biology', 'Physics']
                .map((subject) {
              return DropdownMenuItem(
                value: subject,
                child: Text(subject),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          Text('Color'),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildColorCircle(Colors.red),
              _buildColorCircle(Colors.purple),
              _buildColorCircle(Colors.green),
              _buildColorCircle(Colors.blue),
              _buildColorCircle(Colors.orange),
            ],
          ),
          SizedBox(height: 16),
          SwitchListTile(
            title: Text('Make Study Set Public'),
            value: _isPublic,
            onChanged: (bool value) {
              setState(() {
                _isPublic = value;
              });
            },
          ),
          SizedBox(height: 8),
          Text(
            'This will make the study set visible to the community, and cannot be reversed.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Cancel tuşuna basılınca modal kapatılır
                },
                child: Text('Cancel'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Create işlemi burada yapılacak
                },
                child: Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Renk seçimi için küçük yuvarlak butonlar
  Widget _buildColorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: CircleAvatar(
        backgroundColor: color,
        radius: 20,
        child: _selectedColor == color
            ? Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}
