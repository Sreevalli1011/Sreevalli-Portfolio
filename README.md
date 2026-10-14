# S G Sreevalli — Flutter Portfolio

A responsive Flutter Web portfolio inspired by the section structure of the sample portfolio: Home, About, Skills, Projects, Education, Experience/Achievements and Contact. The design uses a warm cream background, rust accent, cards and a responsive layout.

## 1. Requirements
- Flutter SDK (stable channel)
- VS Code with Flutter and Dart extensions
- Chrome or another browser

Check installation:
```bash
flutter doctor
```

## 2. Open and run
Extract this ZIP, open the `sreevalli_flutter_portfolio` folder in VS Code, then run:
```bash
flutter pub get
flutter run -d chrome
```

If `flutter` is not recognized, install the Flutter SDK and add its `bin` directory to PATH, then restart VS Code.

## 3. Personalize
- Profile photo: `assets/images/sreevalli.jpg`
- Resume PDF: `assets/docs/sreevalli_resume.pdf`
- Main content, colors, navigation and project cards: `lib/main.dart`
- Browser title and description: `web/index.html`

Replace project descriptions or add repository/demo buttons only when you have the correct links. The Password Strength Analyzer and Urban Traffic project cards are starter entries; update them to accurately reflect your completed work.

## 4. Build for web
```bash
flutter build web --release
```
The built website is written to `build/web`.

## 5. Publish with GitHub Pages
1. Create a GitHub repository, for example `sreevalli-portfolio`.
2. Build the web app with Flutter.
3. Publish the contents of `build/web` to the repository's GitHub Pages source (commonly via a GitHub Actions workflow).
4. If the site is hosted under `https://USERNAME.github.io/REPOSITORY/`, configure the Flutter base href for that repository path when building:
   ```bash
   flutter build web --release --base-href /REPOSITORY/
   ```
5. In the repository settings, enable GitHub Pages and choose the deployment workflow/source you configured.

Note: Flutter Web produces a client-side web app, not a native HTML/CSS portfolio. Use a real HTTPS URL for deployment.

## Content source
Education, skills, projects, training, and problem-solving counts were adapted from the resume supplied for this portfolio. Verify all content and add the correct GitHub/demo links before publishing.
