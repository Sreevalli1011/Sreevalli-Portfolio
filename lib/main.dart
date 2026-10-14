import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const SreevalliPortfolioApp());

const ink = Color(0xFF18202B);
const muted = Color(0xFF667085);
const accent = Color(0xFFB85D3D);
const cream = Color(0xFFFAF7F2);
const card = Colors.white;

class SreevalliPortfolioApp extends StatelessWidget {
  const SreevalliPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S G Sreevalli | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(seedColor: accent, surface: cream),
        fontFamily: 'Arial',
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final scrollController = ScrollController();
  final sections = <String, GlobalKey>{
    'Home': GlobalKey(),
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Projects': GlobalKey(),
    'Education': GlobalKey(),
    'Experience': GlobalKey(),
    'Contact': GlobalKey(),
  };

  void goTo(String name) {
    final context = sections[name]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
        alignment: 0.04,
      );
    }
  }

  Future<void> openLink(String value) async {
    final uri = Uri.parse(value);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LayoutBuilder(
        builder: (context, constraints) => Drawer(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text('SGS.', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: accent)),
                const SizedBox(height: 16),
                ...sections.keys.map((name) => ListTile(
                  title: Text(name),
                  onTap: () { Navigator.pop(context); goTo(name); },
                )),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cream.withOpacity(.96),
            surfaceTintColor: cream,
            title: const Text('SGS.', style: TextStyle(color: ink, fontWeight: FontWeight.w900, letterSpacing: -1)),
            actions: [
              if (MediaQuery.sizeOf(context).width > 780)
                ...sections.keys.map((name) => TextButton(
                  onPressed: () => goTo(name),
                  child: Text(name, style: const TextStyle(color: ink, fontWeight: FontWeight.w600)),
                )),
              const SizedBox(width: 16),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _hero(),
                _about(),
                _skills(),
                _projects(),
                _education(),
                _experience(),
                _contact(),
                _footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      key: sections['Home'],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 76),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(builder: (context, box) {
            final narrow = box.maxWidth < 720;
            final intro = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('HELLO, I’M', style: TextStyle(color: accent, letterSpacing: 3, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                const Text('S G Sreevalli', style: TextStyle(fontSize: 48, height: 1.05, color: ink, fontWeight: FontWeight.w900, letterSpacing: -1.5)),
                const SizedBox(height: 18),
                const Text('Aspiring Software Engineer', style: TextStyle(fontSize: 23, color: muted, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                const Text(
                  'I enjoy solving problems and building useful applications with Java, Python, SQL and web technologies.',
                  style: TextStyle(fontSize: 16, height: 1.8, color: muted),
                ),
                const SizedBox(height: 28),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  FilledButton.icon(
                    onPressed: () => openLink('mailto:sg.sreevalli@gmail.com'),
                    icon: const Icon(Icons.mail_outline),
                    label: const Text('Contact me'),
                    style: FilledButton.styleFrom(backgroundColor: accent, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => openLink('assets/docs/sreevalli_resume.pdf'),
                    icon: const Icon(Icons.description_outlined),
                    label: const Text('View resume'),
                    style: OutlinedButton.styleFrom(foregroundColor: ink, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                  ),
                ]),
                const SizedBox(height: 24),
                Wrap(spacing: 18, children: [
                  _social('GitHub', 'https://github.com/Sreevalli1011', Icons.code),
                  _social('LinkedIn', 'https://www.linkedin.com/in/s-g-sreevalli-996496395', Icons.work_outline),
                  _social('Email', 'mailto:sg.sreevalli@gmail.com', Icons.email_outlined),
                ]),
              ],
            );
            final portrait = Container(
              width: narrow ? 210 : 300,
              height: narrow ? 250 : 350,
              decoration: BoxDecoration(
                color: const Color(0xFFF0DFD5),
                borderRadius: BorderRadius.circular(150),
                border: Border.all(color: Colors.white, width: 8),
                boxShadow: [BoxShadow(color: accent.withOpacity(.13), blurRadius: 32, offset: const Offset(0, 14))],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/sreevalli.jpg', fit: BoxFit.cover, alignment: const Alignment(0, -.2)),
            );
            return narrow
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Center(child: portrait), const SizedBox(height: 38), intro])
                : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(child: intro),
                    const SizedBox(width: 60),
                    portrait,
                  ]);
          }),
        ),
      ),
    );
  }

  Widget _social(String label, String url, IconData icon) => InkWell(
    onTap: () => openLink(url),
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 18, color: accent),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: ink, fontWeight: FontWeight.w600)),
      ]),
    ),
  );

  Widget _section({required GlobalKey? key, required String eyebrow, required String title, required Widget child, Color background = cream}) {
    return Container(
      key: key,
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 66),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(eyebrow.toUpperCase(), style: const TextStyle(color: accent, fontWeight: FontWeight.bold, letterSpacing: 2.4, fontSize: 12)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 34, color: ink, fontWeight: FontWeight.w800, letterSpacing: -.7)),
            const SizedBox(height: 28),
            child,
          ]),
        ),
      ),
    );
  }

  Widget _about() => _section(
    key: sections['About'], eyebrow: 'A little about me', title: 'Curious mind. Practical builder.',
    background: Colors.white,
    child: const Text(
      'I’m a Computer Science and Engineering student at BVRIT Hyderabad College of Engineering for Women. I’m building my skills in software development, programming and problem-solving through academic projects and hands-on learning. I like turning ideas into clear, usable applications and learning something new with every project.',
      style: TextStyle(fontSize: 17, height: 1.9, color: muted),
    ),
  );

  Widget _skills() => _section(
    key: sections['Skills'], eyebrow: 'What I work with', title: 'Technical skills',
    child: Wrap(spacing: 12, runSpacing: 12, children: [
      for (final skill in ['Java', 'Python', 'C', 'SQL', 'HTML5', 'CSS3', 'JavaScript', 'MySQL', 'OpenCV', 'Git', 'GitHub', 'VS Code', 'Eclipse', 'Problem Solving', 'Teamwork'])
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE9E1DA)), borderRadius: BorderRadius.circular(12)),
          child: Text(skill, style: const TextStyle(color: ink, fontWeight: FontWeight.w600)),
        ),
    ]),
  );

  Widget _projects() => _section(
    key: sections['Projects'], eyebrow: 'Selected work', title: 'Projects',
    background: Colors.white,
    child: LayoutBuilder(builder: (context, box) {
      final count = box.maxWidth > 750 ? 2 : 1;
      final width = (box.maxWidth - (count - 1) * 18) / count;
      final projects = [
        ('EduCatch', 'Educational Egg Catching Adventure', 'An interactive educational game designed to make learning engaging for children, with responsive UI, game logic and a scoring mechanism.', ['HTML5', 'CSS3', 'JavaScript', 'Python'], Icons.sports_esports_outlined),
        ('Hand Gesture Recognition System', 'Computer Vision · Real-time', 'A real-time system that detects and recognizes hand gestures from live webcam input using computer vision techniques.', ['Python', 'OpenCV'], Icons.back_hand_outlined),
        ('Password Strength Analyzer', 'Java · Security fundamentals', 'A Java project to assess password strength. Add your repository link and screenshots here when ready.', ['Java'], Icons.lock_outline),
        ('Urban Traffic Flow & Incident Intelligence', 'Hackathon concept / prototype', 'A traffic intelligence concept exploring congestion detection, short-term traffic prediction and smart diversion recommendations. Update this card with the features you have implemented.', ['YOLOv8', 'OpenCV', 'FastAPI', 'Leaflet'], Icons.traffic_outlined),
      ];
      return Wrap(spacing: 18, runSpacing: 18, children: projects.map((p) => SizedBox(
        width: width,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE9E1DA))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: accent.withOpacity(.12), borderRadius: BorderRadius.circular(14)), child: Icon(p.$5, color: accent)),
            const SizedBox(height: 18),
            Text(p.$1, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: ink)),
            const SizedBox(height: 5),
            Text(p.$2, style: const TextStyle(color: accent, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Text(p.$3, style: const TextStyle(color: muted, height: 1.7)),
            const SizedBox(height: 16),
            Wrap(spacing: 7, runSpacing: 7, children: p.$4.map((s) => Chip(label: Text(s), visualDensity: VisualDensity.compact, side: BorderSide.none, backgroundColor: Colors.white)).toList()),
          ]),
        ),
      )).toList());
    }),
  );

  Widget _education() => _section(
    key: sections['Education'], eyebrow: 'Learning journey', title: 'Education',
    child: Column(children: [
      _timeline('B.Tech — Computer Science and Engineering', 'BVRIT Hyderabad College of Engineering for Women', 'Aug 2025 – Jun 2028', 'CGPA: 8.05 / 10'),
      const SizedBox(height: 16),
      _timeline('Diploma — Computer Science and Engineering', 'Smt. Durgabai Deshmukh Government Women’s Technical Training Institute, Hyderabad', 'Jul 2022 – Apr 2025', 'CGPA: 9.66 / 10'),
      const SizedBox(height: 16),
      _timeline('Secondary School Certificate (SSC)', 'Unique High School, Hyderabad', 'Jun 2021 – Apr 2022', 'CGPA: 9.8 / 10'),
    ]),
  );

  Widget _timeline(String title, String place, String date, String detail) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE9E1DA))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 19, color: ink, fontWeight: FontWeight.w800)),
      const SizedBox(height: 5),
      Text(place, style: const TextStyle(color: muted, height: 1.5)),
      const SizedBox(height: 9),
      Wrap(spacing: 12, runSpacing: 5, children: [
        Text(date, style: const TextStyle(color: accent, fontWeight: FontWeight.w700)),
        Text(detail, style: const TextStyle(color: muted, fontWeight: FontWeight.w600)),
      ]),
    ]),
  );

  Widget _experience() => _section(
    key: sections['Experience'], eyebrow: 'Hands-on learning', title: 'Training & achievements',
    background: Colors.white,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _bullet('Industech Solutions — Python Industrial Training (2024)'),
      _bullet('Built a Hand Gesture Recognition System using Python and OpenCV.'),
      _bullet('Solved 100+ problems on LeetCode and 600+ problems on CodeChef.'),
      _bullet('Practiced programming, computer vision and image processing concepts.'),
    ]),
  );

  Widget _bullet(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(top: 8), child: Icon(Icons.circle, size: 8, color: accent)),
      const SizedBox(width: 13),
      Expanded(child: Text(text, style: const TextStyle(color: muted, fontSize: 16, height: 1.7))),
    ]),
  );

  Widget _contact() => _section(
    key: sections['Contact'], eyebrow: 'Let’s connect', title: 'Get in touch',
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(20)),
      child: LayoutBuilder(builder: (context, box) {
        final content = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Have an opportunity or a project in mind?', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          const Text('I’m happy to connect and learn from new opportunities.', style: TextStyle(color: Color(0xFFD0D5DD), height: 1.6)),
          const SizedBox(height: 22),
          Wrap(spacing: 18, runSpacing: 12, children: [
            _contactLink(Icons.email_outlined, 'sg.sreevalli@gmail.com', 'mailto:sg.sreevalli@gmail.com'),
            _contactLink(Icons.phone_outlined, '+91 74163 27324', 'tel:+917416327324'),
          ]),
          const SizedBox(height: 12),
          _contactLink(Icons.location_on_outlined, 'Hyderabad, Telangana, India', null),
        ]);
        return content;
      }),
    ),
  );

  Widget _contactLink(IconData icon, String label, String? url) => InkWell(
    onTap: url == null ? null : () => openLink(url),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: const Color(0xFFF0A184), size: 19),
      const SizedBox(width: 9),
      Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _footer() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(26),
    child: const Center(child: Text('© 2026 S G Sreevalli · Built with Flutter', style: TextStyle(color: muted))),
  );
}
