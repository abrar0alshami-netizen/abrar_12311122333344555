import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام تعليمي ذكي',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();

  void _login() {
    if (_controller.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UnitsPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال الاسم')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) => Transform.scale(scale: value, child: child),
            child: Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.school, size: 70, color: Colors.deepPurple),
                    const SizedBox(height: 20),
                    const Text(
                      'نظام تعليمي ذكي',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'اسم الطالب',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: const Text('دخول', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  final List<Map<String, String>> units = const [
    {'id': '1', 'title': 'الوحدة الأولى: الأعداد'},
    {'id': '2', 'title': 'الوحدة الثانية: العمليات الحسابية'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخريطة التعليمية'),
        backgroundColor: Colors.deepPurple,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: units.asMap().entries.map((entry) {
          final index = entry.key;
          final unit = entry.value;
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 400 + (index * 100)),
            builder: (context, value, child) => Transform.scale(scale: value, child: child),
            child: Card(
              color: Colors.orange,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizPage(
                        unitId: int.parse(unit['id']!),
                        unitTitle: unit['title']!,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.castle, size: 50, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      unit['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final int unitId;
  final String unitTitle;
  const QuizPage({super.key, required this.unitId, required this.unitTitle});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  double _shakeValue = 0.0;

  final List<Map<String, dynamic>> _allQuestions = const [
    {'question': '1 + 1 = ?', 'options': ['1', '2', '3', '4'], 'answer': '2', 'unitId': 2},
    {'question': '2 + 1 = ?', 'options': ['2', '3', '4', '5'], 'answer': '3', 'unitId': 2},
    {'question': '3 + 1 = ?', 'options': ['3', '4', '5', '6'], 'answer': '4', 'unitId': 2},
    {'question': '4 + 1 = ?', 'options': ['4', '5', '6', '7'], 'answer': '5', 'unitId': 2},
    {'question': '2 + 2 = ?', 'options': ['2', '3', '4', '5'], 'answer': '4', 'unitId': 2},
    {'question': '3 + 2 = ?', 'options': ['3', '4', '5', '6'], 'answer': '5', 'unitId': 2},
    {'question': '4 + 2 = ?', 'options': ['4', '5', '6', '7'], 'answer': '6', 'unitId': 2},
    {'question': '5 - 2 = ?', 'options': ['2', '3', '4', '5'], 'answer': '3', 'unitId': 2},
    {'question': '5 - 3 = ?', 'options': ['1', '2', '3', '4'], 'answer': '2', 'unitId': 2},
    {'question': '6 - 2 = ?', 'options': ['2', '3', '4', '5'], 'answer': '4', 'unitId': 2},
    {'question': '6 - 3 = ?', 'options': ['2', '3', '4', '5'], 'answer': '3', 'unitId': 2},
    {'question': '7 - 3 = ?', 'options': ['2', '3', '4', '5'], 'answer': '4', 'unitId': 2},
  ];

  List<Map<String, dynamic>> get _questions => _allQuestions.where((q) => q['unitId'] == widget.unitId).toList();

  void _shake() {
    setState(() {
      _shakeValue = 0.1;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _shakeValue = -0.1;
      });
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _shakeValue = 0.05;
      });
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _shakeValue = 0.0;
      });
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer == null) {
      _shake();
      return;
    }

    final isCorrect = _selectedAnswer == _questions[_currentIndex]['answer'];
    if (isCorrect) {
      setState(() => _score++);
    }

    if (_currentIndex + 1 < _questions.length) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RewardScreen(score: _score, total: _questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.unitTitle)),
        body: const Center(child: Text('لا توجد أسئلة في هذه الوحدة')),
      );
    }

    final currentQuestion = _questions[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.unitTitle} - سؤال ${_currentIndex + 1}/${_questions.length}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 400),
              builder: (context, value, child) => Transform.translate(
                offset: Offset(0, (1 - value) * 50),
                child: child,
              ),
              child: Card(
                color: Colors.deepPurple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    currentQuestion['question'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(4, (i) {
              final option = currentQuestion['options'][i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 500 + (i * 100)),
                  builder: (context, value, child) => Transform.translate(
                    offset: Offset((1 - value) * 100, 0),
                    child: child,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedAnswer == option ? Colors.deepPurple : Colors.grey.shade200,
                        foregroundColor: _selectedAnswer == option ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedAnswer = option;
                        });
                      },
                      child: Text(option, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            Transform.translate(
              offset: Offset(0, _shakeValue * 20),
              child: ElevatedButton(
                onPressed: _submitAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('تأكيد الإجابة', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class RewardScreen extends StatelessWidget {
  final int score;
  final int total;
  const RewardScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percentage = (score / total) * 100;
    final isExcellent = percentage >= 80;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isExcellent ? [Colors.green, Colors.lightGreen] : [Colors.orange, Colors.deepOrange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) => Transform.scale(scale: value, child: child),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isExcellent ? Icons.celebration : Icons.thumb_up,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  isExcellent ? '🎉 مبروك! 🎉' : '👍 عمل جيد!',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'النتيجة: $score من $total',
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          score,
                          (index) => const Icon(Icons.star, size: 40, color: Colors.yellow),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('العودة إلى الرئيسية', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}