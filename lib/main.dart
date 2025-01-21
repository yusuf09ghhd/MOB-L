import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Trivia Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _money = 0;
  String _answerStatus = '';
  int _currentQuestionIndex = 0;
  int _incorrectAnswers = 0;
  int _timeRemaining = 20;
  bool _gameOver = false;
  String _category = '';
  late Timer _timer;

  // Sorular
  final Map<String, List<Map<String, dynamic>>> _questions = {
    'Bilişim ve Yazılım': [
      {
        'question': 'Flutter hangi dili kullanır?',
        'answers': ['Dart', 'Java', 'C#', 'Python'],
        'correctAnswer': 'Dart',
        'hint': 'Flutter yalnızca tek bir dili destekler.',
      },
      {
        'question': 'Flutter 2023\'te hangi sürüme geldi?',
        'answers': ['2.0', '3.0', '2.8', '4.0'],
        'correctAnswer': '3.0',
        'hint': 'Flutter 3.0, büyük bir güncellemeydi.',
      },
      {
        'question': 'Hangisi bir JavaScript framework\'üdür?',
        'answers': ['Angular', 'Flutter', 'React Native', 'Dart'],
        'correctAnswer': 'Angular',
        'hint': 'Bu framework JavaScript ile çalışır.',
      },
      {
        'question': 'C# dili hangi şirket tarafından geliştirilmiştir?',
        'answers': ['Microsoft', 'Google', 'Apple', 'Facebook'],
        'correctAnswer': 'Microsoft',
        'hint': 'Bu şirket yazılım geliştirme dünyasında çok büyüktür.',
      },
      {
        'question': 'HTML ne için kullanılır?',
        'answers': ['Web Sayfası Yapmak', 'Veritabanı İşlemleri', 'Masaüstü Uygulama', 'Mobil Uygulama'],
        'correctAnswer': 'Web Sayfası Yapmak',
        'hint': 'Web sayfalarının yapısal iskeletini oluşturur.',
      },
      {
        'question': 'Google\'ın en popüler tarayıcısı nedir?',
        'answers': ['Chrome', 'Edge', 'Firefox', 'Safari'],
        'correctAnswer': 'Chrome',
        'hint': 'Dünyada en çok kullanılan tarayıcıdır.',
      },
      {
        'question': 'C++ dili hangi paradigma üzerine inşa edilmiştir?',
        'answers': ['Nesne Yönelimli', 'Fonksiyonel', 'Veri Yönelimli', 'Prosedürel'],
        'correctAnswer': 'Nesne Yönelimli',
        'hint': 'Bu dil nesneleri kullanarak programlama yapar.',
      },
      {
        'question': 'Python hangi sektörde yaygın olarak kullanılır?',
        'answers': ['Veri Bilimi', 'Web Tasarım', 'Mobil Uygulama', 'Oyun Geliştirme'],
        'correctAnswer': 'Veri Bilimi',
        'hint': 'Veri analizi ve yapay zeka uygulamaları için yaygın kullanılır.',
      },
      {
        'question': 'GitHub nedir?',
        'answers': ['Kod Deposu', 'Veritabanı Yönetim Sistemi', 'İnternet Tarayıcısı', 'E-ticaret Sitesi'],
        'correctAnswer': 'Kod Deposu',
        'hint': 'Yazılım projelerini barındıran bir platformdur.',
      },
      {
        'question': 'SQL dili ne için kullanılır?',
        'answers': ['Veritabanı Yönetimi', 'Web Tasarımı', 'Oyun Geliştirme', 'Mobil Uygulama Geliştirme'],
        'correctAnswer': 'Veritabanı Yönetimi',
        'hint': 'Veri tabanlarında veri sorgulama ve yönetme işlemleri yapar.',
      },
    ],
    'Tarih': [
      {
        'question': 'Türkiye Cumhuriyeti ne zaman kuruldu?',
        'answers': ['1923', '1930', '1919', '1945'],
        'correctAnswer': '1923',
        'hint': 'Mustafa Kemal Atatürk tarafından kuruldu.',
      },
      {
        'question': 'I. Dünya Savaşı hangi tarihte sona erdi?',
        'answers': ['1918', '1914', '1923', '1945'],
        'correctAnswer': '1918',
        'hint': 'Savaşın sona erdiği yıl.',
      },
      {
        'question': 'Osmanlı İmparatorluğu hangi savaşta kesin olarak yenilmiştir?',
        'answers': ['I. Dünya Savaşı', 'II. Dünya Savaşı', 'Çanakkale Savaşı', 'Kudüs Kuşatması'],
        'correctAnswer': 'I. Dünya Savaşı',
        'hint': 'Osmanlı İmparatorluğu bu savaş sonunda savaş dışı kaldı.',
      },
      {
        'question': 'Kurtuluş Savaşı hangi yıllar arasında olmuştur?',
        'answers': ['1919-1922', '1914-1918', '1923-1925', '1912-1914'],
        'correctAnswer': '1919-1922',
        'hint': 'Mustafa Kemal Atatürk önderliğinde yapılmıştır.',
      },
      {
        'question': 'Tarihteki ilk yazılı belgeler nerede bulunmuştur?',
        'answers': ['Mezopotamya', 'Mısır', 'Yunanistan', 'Roma'],
        'correctAnswer': 'Mezopotamya',
        'hint': 'İlk yazılı belgeler Sümerler tarafından yazılmıştır.',
      },
      {
        'question': 'Roma İmparatorluğu hangi çağda çöküş yaşamıştır?',
        'answers': ['Orta Çağ', 'Antik Çağ', 'Yeni Çağ', 'Rönesans'],
        'correctAnswer': 'Orta Çağ',
        'hint': 'Roma İmparatorluğu Batı Roma ve Doğu Roma olarak ikiye ayrılmıştır.',
      },
      {
        'question': 'Napolyon Bonapart hangi savaşı kaybetmiştir?',
        'answers': ['Waterloo Savaşı', 'I. Dünya Savaşı', 'Çanakkale Savaşı', 'Küba Krizi'],
        'correctAnswer': 'Waterloo Savaşı',
        'hint': 'Napolyon’un son savaşıdır.',
      },
      {
        'question': 'Dünyanın ilk demokratik anayasası hangi ülkede kabul edilmiştir?',
        'answers': ['Amerika', 'Fransa', 'İngiltere', 'Almanya'],
        'correctAnswer': 'Amerika',
        'hint': '1787’de kabul edilmiştir.',
      },
      {
        'question': 'Mısır Piramitleri hangi eski uygarlığa aittir?',
        'answers': ['Mısırlılar', 'Roma', 'Yunanlar', 'Persler'],
        'correctAnswer': 'Mısırlılar',
        'hint': 'Dünyanın yedi harikasından biri.',
      },
      {
        'question': 'Fransa Devrimi hangi yılda başlamıştır?',
        'answers': ['1789', '1815', '1914', '1920'],
        'correctAnswer': '1789',
        'hint': 'Toplumda büyük değişimlere yol açmıştır.',
      },
    ],
    'Futbol': [
      {
        'question': 'FIFA Dünya Kupası hangi yılda başladı?',
        'answers': ['1930', '1950', '1966', '1970'],
        'correctAnswer': '1930',
        'hint': 'İlk turnuva Uruguay’da düzenlenmiştir.',
      },
      {
        'question': 'Messi hangi takımdan transfer oldu?',
        'answers': ['Paris Saint-Germain', 'Barcelona', 'Real Madrid', 'Bayern Munich'],
        'correctAnswer': 'Barcelona',
        'hint': 'Messi uzun yıllar bu kulüpte oynadı.',
      },
      {
        'question': 'Cristiano Ronaldo hangi kulüpte futbol oynamaktadır?',
        'answers': ['Manchester United', 'Real Madrid', 'Juventus', 'Paris Saint-Germain'],
        'correctAnswer': 'Manchester United',
        'hint': 'Portekizli yıldız bu kulüpte oynuyor.',
      },
      {
        'question': 'Hangi ülke 2014 Dünya Kupası şampiyonudur?',
        'answers': ['Almanya', 'Brezilya', 'Fransa', 'İspanya'],
        'correctAnswer': 'Almanya',
        'hint': 'Finalde Arjantin’i yendiler.',
      },
      {
        'question': 'Futbolun en büyük turnuvası nedir?',
        'answers': ['FIFA Dünya Kupası', 'UEFA Şampiyonlar Ligi', 'Afrika Kupası', 'Copa América'],
        'correctAnswer': 'FIFA Dünya Kupası',
        'hint': 'Dünyanın en prestijli futbol organizasyonudur.',
      },
      {
        'question': 'Euro 2008’i hangi ülke kazandı?',
        'answers': ['İspanya', 'Almanya', 'Fransa', 'İtalya'],
        'correctAnswer': 'İspanya',
        'hint': 'Finalde Almanya’yı yenmişlerdir.',
      },
      {
        'question': 'Bir futbol maçı kaç dakikadır?',
        'answers': ['90', '120', '60', '100'],
        'correctAnswer': '90',
        'hint': 'İki yarıdan oluşur.',
      },
      {
        'question': 'En çok gol atan futbolcu kimdir?',
        'answers': ['Cristiano Ronaldo', 'Lionel Messi', 'Pele', 'Diego Maradona'],
        'correctAnswer': 'Cristiano Ronaldo',
        'hint': 'Portekizli yıldız, gol sayısında zirvededir.',
      },
      {
        'question': 'Hangi takım Şampiyonlar Ligi tarihinin en çok kazananıdır?',
        'answers': ['Real Madrid', 'Barcelona', 'AC Milan', 'Liverpool'],
        'correctAnswer': 'Real Madrid',
        'hint': 'Bu kulüp en fazla zaferi elde etmiştir.',
      },
      {
        'question': '2020 UEFA Avrupa Şampiyonası hangi ülkede yapıldı?',
        'answers': ['İngiltere', 'Fransa', 'İtalya', 'Yapılmadı'],
        'correctAnswer': 'Yapılmadı',
        'hint': 'Pandemi nedeniyle ertelendi.',
      },
    ],
  };

  // Zamanlayıcı başlatma
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0 && !_gameOver) {
          _timeRemaining--;
        }
      });
    });
  }

  // Kategori seçme
  void _selectCategory(String category) {
    setState(() {
      _category = category;
      _currentQuestionIndex = 0;
      _incorrectAnswers = 0;
      _money = 0;
      _counter = 0;
      _gameOver = false;
      _timeRemaining = 20;
      _answerStatus = '';
    });
    _startTimer();
  }

  // Cevap kontrolü
  void _checkAnswer(String answer) {
    if (!_gameOver) {
      if (answer == _questions[_category]![_currentQuestionIndex]['correctAnswer']) {
        setState(() {
          _counter++;
          _money += 10; // Doğru cevapla para kazanılır
          _answerStatus = 'Doğru Cevap!';
        });
      } else {
        setState(() {
          _incorrectAnswers++;
          _answerStatus = 'Yanlış Cevap! Doğru cevap: ${_questions[_category]![_currentQuestionIndex]['correctAnswer']}';
        });
      }

      // Sonraki soruya geçiş
      setState(() {
        _currentQuestionIndex++;
        if (_currentQuestionIndex >= 10) {
          _gameOver = true; // Tüm sorular bitince oyun biter
        } else {
          _timeRemaining = 20; // Yeni soru geldiğinde süreyi sıfırla
        }
      });
    }
  }

  // Yeniden başlatma
  void _resetGame() {
    setState(() {
      _counter = 0;
      _incorrectAnswers = 0;
      _money = 0;  // Para sıfırlanacak
      _timeRemaining = 20;
      _currentQuestionIndex = 0;
      _answerStatus = '';
      _gameOver = false;  // Oyun sıfırlanacak
    });
    _startTimer();
  }

  // Ek süre ekleme
  void _addTime() {
    if (_money >= 5) {
      setState(() {
        _money -= 5;
        _timeRemaining += 5; // 5 birim ile 5 saniye eklenir
      });
    } else {
      _showNotEnoughMoneyDialog();
    }
  }

  // İpucu gösterme
  void _showHint() {
    if (_money >= 5) {
      setState(() {
        _money -= 5;
        _answerStatus = 'İpucu: ${_questions[_category]![_currentQuestionIndex]['hint']}';
      });
    } else {
      _showNotEnoughMoneyDialog();
    }
  }

  // Yeterli para olmadığında uyarı
  void _showNotEnoughMoneyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeterli Para Yok!'),
          content: const Text('Ek süre veya ipucu kullanmak için yeterli paranız yok.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  // Yüzde 50-50 joker kullanımı
  void _useFiftyFifty() {
    if (_money >= 10) {
      setState(() {
        _money -= 10;
        List<String> wrongAnswers = List.from(_questions[_category]![_currentQuestionIndex]['answers']);
        wrongAnswers.remove(_questions[_category]![_currentQuestionIndex]['correctAnswer']);
        wrongAnswers.shuffle();
        _questions[_category]![_currentQuestionIndex]['answers'] = [
          _questions[_category]![_currentQuestionIndex]['correctAnswer'],
          wrongAnswers[0]
        ];
        _answerStatus = '50-50 Joker Kullanıldı';
      });
    } else {
      _showNotEnoughMoneyDialog();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Para: $_money',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Center(
        child: _category == ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Kategori Seçin',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectCategory('Bilişim ve Yazılım'),
                    child: const Text('Bilişim ve Yazılım'),
                    
                  ),
                  ElevatedButton(
                    onPressed: () => _selectCategory('Tarih'),
                    child: const Text('Tarih'),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectCategory('Futbol'),
                    child: const Text('Futbol'),
                  ),
                ],
              )
            : _gameOver
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Oyun Bitti! Skor: $_counter',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Yanlış Cevaplar: $_incorrectAnswers',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Kazandığınız Para: $_money birim',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: _resetGame,
                        child: const Text('Yeniden Başla'),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _questions[_category]![_currentQuestionIndex]['question'],
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      ..._questions[_category]![_currentQuestionIndex]['answers']
                          .map<Widget>((answer) {
                        return ElevatedButton(
                          onPressed: () => _checkAnswer(answer),
                          child: Text(answer),
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      Text(
                        'Zaman Kalan: $_timeRemaining saniye',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _answerStatus,
                        style: TextStyle(fontSize: 18, color: _answerStatus.contains('Doğru') ? Colors.green : Colors.red),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.access_time),
                            onPressed: _addTime,
                          ),
                          IconButton(
                            icon: const Icon(Icons.help),
                            onPressed: _showHint,
                          ),
                          IconButton(
                            icon: const Icon(Icons.star),
                            onPressed: _useFiftyFifty,
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
}
