import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/pageview.dart';
import 'package:guess_duel/screens/auth/create_account_screen.dart';
import 'package:guess_duel/screens/auth/widgets/auth_ambient_background.dart';
import 'package:guess_duel/screens/auth/widgets/auth_brand_header.dart';
import 'package:guess_duel/screens/auth/widgets/auth_text_field.dart';
import 'package:guess_duel/screens/auth/widgets/auth_top_bar.dart';
import 'package:guess_duel/screens/auth/widgets/neon_button.dart';
import 'package:guess_duel/screens/auth/widgets/social_auth_buttons.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';

/// The Sign In / Login Screen for Guess Duel.
/// Implemented as a [HookWidget] utilizing [flutter_hooks] for state management
/// and [flutter_animate] for smooth cinematic glowing and entry transitions.
class SignInScreen extends HookWidget {
  final VoidCallback? onSignUpTap;
  final Future<void> Function(String emailOrUsername, String password)? onLogin;
  final VoidCallback? onForgotPasswordTap;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onFacebookSignIn;
  final VoidCallback? onGuestPlay;

  const SignInScreen({
    super.key,
    this.onSignUpTap,
    this.onLogin,
    this.onForgotPasswordTap,
    this.onGoogleSignIn,
    this.onFacebookSignIn,
    this.onGuestPlay,
  });

  @override
  Widget build(BuildContext context) {
    // Text editing controllers
    final identifierController = useTextEditingController(
      text: 'alex@guessduel.io',
    );
    final passwordController = useTextEditingController(
      text: 'secretduel123',
    );

    // Focus nodes
    final identifierFocus = useFocusNode();
    final passwordFocus = useFocusNode();

    // Field states
    final isPasswordObscured = useState<bool>(true);
    final isLoading = useState<bool>(false);

    // Validation error states
    final identifierError = useState<String?>(null);
    final passwordError = useState<String?>(null);

    // Form validation
    bool validateForm() {
      bool isValid = true;
      final identifier = identifierController.text.trim();
      final password = passwordController.text;

      // 1. Email or Username
      if (identifier.isEmpty) {
        identifierError.value = 'Email or Username is required';
        isValid = false;
      } else if (identifier.length < 3) {
        identifierError.value = 'Must be at least 3 characters';
        isValid = false;
      } else {
        identifierError.value = null;
      }

      // 2. Password
      if (password.isEmpty) {
        passwordError.value = 'Password is required';
        isValid = false;
      } else if (password.length < 6) {
        passwordError.value = 'Password must be at least 6 characters';
        isValid = false;
      } else {
        passwordError.value = null;
      }

      return isValid;
    }

    // Submit handler
    Future<void> handleLogin() async {
      FocusScope.of(context).unfocus();
      if (!validateForm()) return;

      isLoading.value = true;
      try {
        if (onLogin != null) {
          await onLogin!(
            identifierController.text.trim(),
            passwordController.text,
          );
        } else {
          // Simulated login flow
          await Future.delayed(const Duration(milliseconds: 1000));
          Get.snackbar(
            'Welcome Back!',
            'Logging in to Guess Duel arena...',
            backgroundColor: const Color(0xFF111624).withValues(alpha: 0.95),
            colorText: const Color(0xFF00F0FF),
            borderColor: const Color(0xFF00F0FF).withValues(alpha: 0.5),
            borderWidth: 1,
            icon: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF00F0FF),
            ),
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(16),
            borderRadius: 16,
            duration: const Duration(seconds: 2),
          );
          await Future.delayed(const Duration(milliseconds: 500));
          Get.offAll(() => const Pages());
        }
      } catch (e) {
        Get.snackbar(
          'Login Failed',
          e.toString(),
          backgroundColor: const Color(0xFF1F1116),
          colorText: const Color(0xFFFF6B6B),
          borderColor: const Color(0xFFFF4D4D).withValues(alpha: 0.5),
          borderWidth: 1,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
        );
      } finally {
        isLoading.value = false;
      }
    }

    // Default Guest login handler
    Future<void> handleGuestPlayDefault() async {
      isLoading.value = true;
      try {
        try {
          await FirebaseService.signInAnonymously();
        } catch (_) {
          // Continue into pages even in offline/demo environment
        }
        Get.offAll(() => const Pages());
      } catch (e) {
        Get.snackbar(
          'Guest Play',
          'Entering as guest...',
          backgroundColor: const Color(0xFF111624),
          colorText: const Color(0xFF00F0FF),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
        );
        Get.offAll(() => const Pages());
      } finally {
        isLoading.value = false;
      }
    }

    // Social login feedback
    void handleSocialSignIn(String provider) {
      Get.snackbar(
        '$provider Sign-In',
        'Connecting to $provider...',
        backgroundColor: const Color(0xFF111624),
        colorText: const Color(0xFFE2E8F0),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
      );
    }

    // Forgot Password Bottom Sheet
    void showForgotPasswordSheet() {
      final resetEmailController = TextEditingController(
        text: identifierController.text.contains('@')
            ? identifierController.text.trim()
            : '',
      );

      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFF111624),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) => Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Reset Password',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the email address associated with your Guess Duel account and we will send you a reset link.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF94A3B8),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Email Address',
                controller: resetEmailController,
                hintText: 'alex@guessduel.io',
                prefixIcon: const Icon(Icons.alternate_email_rounded),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              NeonButton(
                text: 'Send Reset Link',
                height: 48,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Get.snackbar(
                    'Reset Link Sent',
                    'Check your inbox for instructions to reset your password.',
                    backgroundColor: const Color(0xFF111624),
                    colorText: const Color(0xFF00F0FF),
                    snackPosition: SnackPosition.TOP,
                    margin: const EdgeInsets.all(16),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0C101A),
      body: AuthAmbientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. Status Header (Players Online & Version)
                    const AuthTopBar(
                      statusText: '1,420 Players Online',
                      versionText: 'v2.4',
                    )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(
                          begin: -0.15,
                          end: 0,
                          curve: Curves.easeOutCubic,
                        ),

                    const SizedBox(height: 6),

                    // 2. Brand Identity Header (Emblem, Guess Duel Title, Tagline)
                    const AuthBrandHeader(
                      subtitle: 'Enter the arena of intuition & quick wits',
                    )
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 100.ms)
                        .slideY(
                          begin: 0.1,
                          end: 0,
                          curve: Curves.easeOutCubic,
                        ),

                    const SizedBox(height: 18),

                    // 3. Credentials Glass Card
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(23, 27, 39, 0.85),
                            Color.fromRGBO(15, 19, 30, 0.95),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.45),
                            blurRadius: 30,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email or Username Field
                          AuthTextField(
                            label: 'Email or Username',
                            controller: identifierController,
                            focusNode: identifierFocus,
                            hintText: 'e.g. alex@game.io or Player_One',
                            prefixIcon: const Icon(
                              Icons.alternate_email_rounded,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            errorText: identifierError.value,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => passwordFocus.requestFocus(),
                            onChanged: (_) {
                              if (identifierError.value != null) {
                                identifierError.value = null;
                              }
                            },
                          ),

                          const SizedBox(height: 14),

                          // Password Field
                          AuthTextField(
                            label: 'Password',
                            controller: passwordController,
                            focusNode: passwordFocus,
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                            ),
                            isPassword: true,
                            obscureText: isPasswordObscured.value,
                            onToggleObscure: () {
                              isPasswordObscured.value =
                                  !isPasswordObscured.value;
                            },
                            errorText: passwordError.value,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => handleLogin(),
                            onChanged: (_) {
                              if (passwordError.value != null) {
                                passwordError.value = null;
                              }
                            },
                          ),

                          const SizedBox(height: 8),

                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: onForgotPasswordTap ??
                                  showForgotPasswordSheet,
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF00F0FF),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Primary CTA "Log In" Button with Neon Glow
                          NeonButton(
                            text: 'Log In',
                            isLoading: isLoading.value,
                            onPressed: handleLogin,
                            icon: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: Color(0xFF020617),
                            ),
                          ),

                          // OAuth Providers & Play Instant as Guest
                          SocialAuthButtons(
                            dividerText: 'OR CONTINUE WITH',
                            onGoogleTap: onGoogleSignIn ??
                                () => handleSocialSignIn('Google'),
                            onFacebookTap: onFacebookSignIn ??
                                () => handleSocialSignIn('Facebook'),
                            onGuestTap: onGuestPlay ?? handleGuestPlayDefault,
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 550.ms, delay: 200.ms)
                        .slideY(
                          begin: 0.08,
                          end: 0,
                          curve: Curves.easeOutCubic,
                        ),

                    const SizedBox(height: 18),

                    // 4. Footer Link to Sign Up
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF94A3B8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: onSignUpTap ??
                                () {
                                  Get.to(
                                    () => CreateAccountScreen(
                                      onLoginTap: () => Navigator.pop(context),
                                    ),
                                  );
                                },
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF00F0FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 450.ms, delay: 350.ms),
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
