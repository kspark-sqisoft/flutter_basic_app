import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../pages/auth/reset_password/reset_password_page.dart';
import '../../pages/auth/signin/signin_page.dart';
import '../../pages/auth/signup/signup_page.dart';
import '../../pages/auth/verify_email/verify_email_page.dart';
import '../../pages/content/change_password/change_password_page.dart';
import '../../pages/content/home/home_page.dart';
import '../../pages/page_not_found.dart';
import '../../pages/splash/firebase_error_page.dart';
import '../../pages/splash/splash_page.dart';
import '../../repositories/auth_repository_provider.dart';

import '../constants/firebase_constants.dart';
import 'route_names.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  ref.listen(authStateStreamProvider, (previous, next) {
    log('authStateStreamProvider state:${next.valueOrNull}');
  });
  final authState = ref.watch(authStateStreamProvider);
  //authState(인증 상태)가 변할때 마다 routerProvider가 리빌드되고 redirect콜백이 실행된다.
  return GoRouter(
      initialLocation: '/splash',
      redirect: (context, state) {
        if (authState is AsyncLoading<User?>) {
          return '/splash';
        }

        if (authState is AsyncError<User?>) {
          return '/firebaseError';
        }
        //인증 여부
        final authenticated = authState.valueOrNull != null;

        //인증이 안된 상태에서 인증 관련 작업하는 중(인증이 되 있다면 액세스 할 필요 없다.)
        final authenticating = (state.matchedLocation == '/signin') ||
            (state.matchedLocation == '/signup') ||
            (state.matchedLocation == '/resetPassword');

        //인증이 안되 있으면
        if (authenticated == false) {
          return authenticating ? null : '/signin';
        }
        //signUp을 하면 authenticated=true 이메일을 확인 안했으면
        if (!fbAuth.currentUser!.emailVerified) {
          return '/verifyEmail';
        }

        final verifyingEmail = state.matchedLocation == '/verifyEmail';
        final splashing = state.matchedLocation == '/splash';

        return (authenticating || verifyingEmail || splashing) ? '/home' : null;
        //null 원래 사용자가 접근하고자 했던데로 이동 시킨다.
      },
      routes: [
        GoRoute(
          path: '/splash',
          name: RouteNames.splash,
          builder: (context, state) {
            print('##### Splash #####');
            return const SplashPage();
          },
        ),
        GoRoute(
          path: '/firebaseError',
          name: RouteNames.firebaseError,
          builder: (context, state) {
            print('##### FirebaseError #####');
            return const FirebaseErrorPage();
          },
        ),
        GoRoute(
          path: '/signin',
          name: RouteNames.signin,
          builder: (context, state) {
            print('##### Signin #####');
            return const SigninPage();
          },
        ),
        GoRoute(
          path: '/signup',
          name: RouteNames.signup,
          builder: (context, state) {
            print('##### Signup #####');
            return const SignupPage();
          },
        ),
        GoRoute(
          path: '/resetPassword',
          name: RouteNames.resetPassword,
          builder: (context, state) {
            print('##### ResetPassword #####');
            return const ResetPasswordPage();
          },
        ),
        GoRoute(
          path: '/verifyEmail',
          name: RouteNames.verifyEmail,
          builder: (context, state) {
            print('##### VerifyEmail #####');
            return const VerifyEmailPage();
          },
        ),
        GoRoute(
          path: '/home',
          name: RouteNames.home,
          builder: (context, state) {
            print('##### Home #####');
            return const HomePage();
          },
          routes: [
            GoRoute(
              path: 'changePassword',
              name: RouteNames.changePassword,
              builder: (context, state) {
                print('##### ChangePassword #####');
                return const ChangePasswordPage();
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) {
        print('##### PageNotFound #####');
        return PageNotFound(
          errorMessage: state.error.toString(),
        );
      });
}
