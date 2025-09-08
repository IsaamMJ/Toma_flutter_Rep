# Toma - AI Platform for Automotive

A modern, responsive Flutter web application for Toma, an AI platform that builds personalized AI agents for automotive dealerships to automate customer communications and operational tasks.

## Features

- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Modern UI/UX**: Clean, professional design with smooth animations
- **Hero Section**: Eye-catching landing area with compelling messaging
- **Automation CTA**: Dedicated section highlighting AI automation capabilities
- **Meet Employee**: Showcase of AI employee functionality
- **Responsive Footer**: Complete footer with newsletter signup and social links
- **Interactive Elements**: Hover effects, animations, and smooth transitions

## Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **UI Libraries**:
    - `flutter_animate` - For smooth animations
    - `google_fonts` - Typography (Crimson Text, Libre Baskerville, Inter)
- **Architecture**: Clean architecture with separation of concerns
- **Responsive Design**: Custom responsive helper utilities

## Project Structure

```
lib/
├── app/
│   └── theme/
│       ├── app_colors.dart
│       ├── app_constants.dart
│       └── text_styles.dart
├── core/
│   ├── components/
│   │   └── nav_bar_item_button.dart
│   └── utils/
│       └── responsive_helper.dart
├── features/
│   ├── demo/
│   │   └── presentation/
│   │       └── book_a_demo_modal.dart
│   ├── home/
│   │   ├── data/
│   │   │   └── datasources/
│   │   │       ├── automation_cta_data.dart
│   │   │       ├── meet_employee_data.dart
│   │   │       └── footer_data.dart
│   │   └── presentation/
│   │       ├── widgets/
│   │       │   ├── hero_section.dart
│   │       │   ├── automation_cta_section.dart
│   │       │   ├── meet_employee_section.dart
│   │       │   └── toma_footer.dart
│   │       └── pages/
│   │           └── home_page.dart
│   └── shared/
└── main.dart
```

## Design System

### Colors
- **Primary**: Custom brand colors for buttons and accents
- **Text**: Hierarchical text colors (primary, secondary, muted)
- **Background**: Subtle grays and whites for clean aesthetics
- **Shadows**: Consistent shadow system for depth

### Typography
- **Headings**: Crimson Text (serif) for elegance
- **Body**: Inter (sans-serif) for readability
- **Accent**: Libre Baskerville for special content

### Responsive Breakpoints
- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: > 1024px

## Key Components

### HeroSection
- Full-height hero with background image
- Responsive text sizing and positioning
- Animated call-to-action buttons
- Y Combinator backing badge

### AutomationCTASection
- Content and image layout that stacks on mobile
- "Talk to Toma" interactive button with microphone icon
- Smooth fade and slide animations

### MeetEmployeeSection
- Feature benefits list with checkmark icons
- Custom audio wave animation for "Talk to Toma" button
- Error handling for missing images

### TomaFooter
- Newsletter signup with email validation
- Social media icons with hover effects
- Responsive navigation links
- Mobile-optimized layout with stacked email form

## Responsive Features

### Mobile Optimizations
- Centered content alignment
- Stacked layouts instead of side-by-side
- Full-width buttons
- Reduced spacing and font sizes
- Touch-friendly interactive elements
- Optimized image positioning

### Animation System
- Consistent timing using `AppConstants.animationSlow/Fast`
- Staggered animations with delays
- Fade in, slide, and scale effects
- Hover animations for interactive elements

## Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK
- A code editor (VS Code, Android Studio, etc.)


### Building for Production

**Web Build**
```bash
flutter build web --release
```

**Mobile Build (Android)**
```bash
flutter build apk --release
```

**Mobile Build (iOS)**
```bash
flutter build ios --release
```



Add to `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
```

## Configuration

### App Constants
Located in `app/theme/app_constants.dart`:
- Font sizes
- Spacing values
- Animation durations
- Border radius values
- Content width constraints

### Color Scheme
Located in `app/theme/app_colors.dart`:
- Brand colors
- Text colors
- Background colors
- Button colors

### Code Style Guidelines

- Follow Dart/Flutter conventions
- Use meaningful variable and function names
- Comment complex logic
- Maintain responsive design patterns
- Test on multiple screen sizes

## Browser Support

- Chrome (recommended)
- Firefox
- Safari
- Edge

## Future Enhancements

- [ ] Add form validation for email signup
- [ ] Implement actual social media link functionality
- [ ] Add loading states for demo booking
- [ ] Include analytics tracking
- [ ] Add SEO metadata for web
- [ ] Implement dark mode support
- [ ] Add accessibility improvements (WCAG compliance)



**Built with ❤️ using Flutter**