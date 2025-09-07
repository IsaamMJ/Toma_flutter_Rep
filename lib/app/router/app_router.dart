import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}