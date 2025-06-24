import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquid_glass_ui_design/liquid_glass_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define indigo color palette
class AppColors {
  static const indigo50 = Color(0xFFE8EAF6);
  static const indigo100 = Color(0xFFC5CAE9);
  static const indigo200 = Color(0xFF9FA8DA);
  static const indigo300 = Color(0xFF7986CB);
  static const indigo400 = Color(0xFF5C6BC0);
  static const indigo500 = Color(0xFF3F51B5);
  static const indigo600 = Color(0xFF3949AB);
  static const indigo700 = Color(0xFF303F9F);
  static const indigo800 = Color(0xFF283593);
  static const indigo900 = Color(0xFF1A237E);
}

// Theme provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Bookmarks provider
final bookmarksProvider = StateNotifierProvider<BookmarksNotifier, Set<String>>(
  (ref) => BookmarksNotifier(),
);

class BookmarksNotifier extends StateNotifier<Set<String>> {
  static const String _boxName = 'bookmarks';
  late final Box<String> _box;

  BookmarksNotifier() : super({}) {
    _initHive();
  }

  Future<void> _initHive() async {
    _box = await Hive.openBox<String>(_boxName);
    state = _box.values.toSet();
  }

  Future<void> toggleBookmark(String newsId) async {
    final newBookmarks = {...state};
    if (newBookmarks.contains(newsId)) {
      newBookmarks.remove(newsId);
      await _box.delete(newsId);
    } else {
      newBookmarks.add(newsId);
      await _box.put(newsId, newsId);
    }
    state = newBookmarks;
  }

  @override
  void dispose() {
    _box.close();
    super.dispose();
  }
}

// News data model
class NewsItem {
  final String id;
  final String title;
  final String content;
  final String category;
  final String imageUrl;

  NewsItem({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.imageUrl,
  });
}

final List<NewsItem> dummyNews = [
  NewsItem(
    id: '1',
    title: 'Global Markets Surge in Q3 2025',
    content:
        'In a surprising turn of events, global stock markets rallied throughout Q3 of 2025. Tech stocks led the charge with strong earnings from AI and automation sectors. The Dow Jones gained 8%, while the NASDAQ hit a new record high. Analysts attribute the surge to improved inflation control, steady interest rates, and growing investor confidence in digital transformation trends sweeping through banking and manufacturing sectors worldwide.',
    category: 'Business',
    imageUrl:
        'https://images.unsplash.com/photo-1565372918674-1b8b5db3f3a2?auto=format&fit=crop&w=1280&q=80',
  ),
  NewsItem(
    id: '2',
    title: 'Epic Football Finals Thrill Fans Worldwide',
    content:
        'The 2025 UEFA Champions League final went down in history as one of the most electrifying matches ever played. With a tie that led to a penalty shootout, fans were treated to 120 minutes of world-class football. Unexpected heroics, last-minute goals, and intense rivalries made this final a true testament to the beautiful game. Fans flooded the streets in celebration as the underdog clinched victory under immense pressure.',
    category: 'Sports',
    imageUrl:
        'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1280&q=80',
  ),
  NewsItem(
    id: '3',
    title: 'AI Model Sets New Global Performance Benchmarks',
    content:
        'Researchers have unveiled a revolutionary AI model that outperforms previous systems in natural language processing, image recognition, and real-time analytics. Trained on over 10 trillion parameters, this AI is being dubbed the "GPT-X Era" by tech leaders. It promises major advancements in healthcare diagnostics, autonomous vehicles, and cybersecurity. Tech giants are already racing to integrate this AI into their ecosystems, signaling a new dawn in intelligent automation.',
    category: 'Tech',
    imageUrl:
        'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1280&q=80',
  ),
  NewsItem(
    id: '4',
    title: 'Fintech Disruption: Banks Push for Decentralized Solutions',
    content:
        'In response to growing competition from fintech startups, traditional banks are now investing heavily in decentralized finance (DeFi) platforms. Many are exploring blockchain-based services and tokenized assets to stay competitive. With regulatory support growing in regions like Europe and Southeast Asia, the financial industry is at the cusp of its most significant transformation in decades.',
    category: 'Business',
    imageUrl:
        'https://images.unsplash.com/photo-1556741533-f6acd647d2fb?auto=format&fit=crop&w=1280&q=80',
  ),
  NewsItem(
    id: '5',
    title: '2025 Olympics: Record-Breaking Performances Shine',
    content:
        'The Summer Olympics in 2025 saw world records shattered across multiple disciplines. From track and field to swimming and gymnastics, athletes delivered performances that redefined the limits of human capability. Advances in training technology and sports science are credited for the surge in record-breaking feats. The host city witnessed a 40% surge in tourism and hospitality revenues.',
    category: 'Sports',
    imageUrl:
        'https://images.unsplash.com/photo-1571019613914-85f342c1d4d2?auto=format&fit=crop&w=1280&q=80',
  ),
  NewsItem(
    id: '6',
    title: 'Quantum Computing Reaches Public Cloud Platforms',
    content:
        'For the first time, quantum computing has been integrated into mainstream cloud services, allowing developers and researchers to run quantum experiments from anywhere. This marks a major step toward democratizing quantum development. Leading cloud providers offer quantum simulators and hardware access through APIs. Experts say this is a pivotal moment that could accelerate breakthroughs in drug discovery, logistics, and encryption.',
    category: 'Tech',
    imageUrl:
        'https://images.unsplash.com/photo-1634979146204-7a3aa84e15c4?auto=format&fit=crop&w=1280&q=80',
  ),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return LiquidThemeProvider(
      theme: LiquidTheme(
        primaryColor: AppColors.indigo50.withAlpha(
          (255 * 0.9).round().clamp(0, 255),
        ),
        accentColor: AppColors.indigo600,
        blurStrength: 10.0,
        borderRadius: 12.0,
        textStyle: const TextStyle(
          fontFamily: 'SFPro',
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        defaultPadding: const EdgeInsets.all(12.0),
        defaultMargin: const EdgeInsets.all(8.0),
      ),
      child: MaterialApp(
        title: 'Liquid Glass News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: AppColors.indigo500,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.indigo50.withAlpha(
              (255 * 0.8).round().clamp(0, 255),
            ),
            foregroundColor: AppColors.indigo900,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: AppColors.indigo700,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.indigo900.withAlpha(
              (255 * 0.8).round().clamp(0, 255),
            ),
            foregroundColor: AppColors.indigo50,
          ),
        ),
        themeMode: themeMode,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight;
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          semanticsLabel: 'App Title',
        ),
        actions: [
          LiquidSwitch(
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).state =
                  value ? ThemeMode.dark : ThemeMode.light;
            },
            semanticsLabel: 'Theme Toggle',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1504711434969-e33886168f5c?auto=format&fit=crop&w=1280&q=80',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    SizedBox(child: _buildNewsTab('All')),
                    SizedBox(child: _buildNewsTab('Sports')),
                    SizedBox(child: _buildNewsTab('Tech')),
                    SizedBox(child: _buildBookmarksTab()),
                  ],
                ),
              ),
              LiquidBottomNav(
                icons: const [
                  Icons.list,
                  Icons.sports,
                  Icons.computer,
                  Icons.bookmark,
                ],
                onItemSelected: _onItemSelected,
                semanticsLabel: 'News Navigation',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsTab(String category) {
    final newsItems =
        category == 'All'
            ? dummyNews
            : dummyNews.where((item) => item.category == category).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidText(
            text: category,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            semanticsLabel: '$category Title',
          ),
          const SizedBox(height: 16),
          for (var news in newsItems)
            LiquidCard(
              semanticsLabel: 'News Card ${news.title}',
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LiquidText(
                      text: news.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      semanticsLabel: 'News Title ${news.title}',
                    ),
                    Center(
                      child: Image.network(
                        news.imageUrl,
                        width: 180,
                        height: 150,
                      ),
                    ),
                    LiquidText(
                      text: news.content,
                      semanticsLabel: 'News Content ${news.content}',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Consumer(
                          builder: (context, ref, child) {
                            final bookmarks = ref.watch(bookmarksProvider);
                            return IconButton(
                              icon: Icon(
                                bookmarks.contains(news.id)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: AppColors.indigo600,
                              ),
                              onPressed: () {
                                ref
                                    .read(bookmarksProvider.notifier)
                                    .toggleBookmark(news.id);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBookmarksTab() {
    return Consumer(
      builder: (context, ref, child) {
        final bookmarks = ref.watch(bookmarksProvider);
        final bookmarkedNews =
            dummyNews.where((news) => bookmarks.contains(news.id)).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LiquidText(
                text: 'Bookmarked News',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                semanticsLabel: 'Bookmarked News Title',
              ),
              const SizedBox(height: 16),
              if (bookmarkedNews.isEmpty)
                const LiquidText(
                  text: 'No bookmarked news yet.',
                  semanticsLabel: 'No Bookmarks Message',
                ),
              for (var news in bookmarkedNews)
                LiquidCard(
                  semanticsLabel: 'News Card ${news.title}',
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LiquidText(
                          text: news.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          semanticsLabel: 'News Title ${news.title}',
                        ),
                        const SizedBox(height: 8),
                        LiquidText(
                          text: news.content,
                          semanticsLabel: 'News Content ${news.content}',
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LiquidButton(
                              onTap: () => print('Read ${news.title}'),
                              semanticsLabel: 'Read More ${news.title}',
                              child: const Text(
                                'Read More',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.bookmark,
                                color: AppColors.indigo600,
                              ),
                              onPressed: () {
                                ref
                                    .read(bookmarksProvider.notifier)
                                    .toggleBookmark(news.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
