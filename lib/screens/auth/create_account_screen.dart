import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/screens/auth/sign_in_screen.dart';
import 'package:guess_duel/screens/auth/widgets/auth_brand_header.dart';
import 'package:guess_duel/screens/auth/widgets/auth_text_field.dart';
import 'package:guess_duel/screens/auth/widgets/auth_top_bar.dart';
import 'package:guess_duel/screens/auth/widgets/neon_button.dart';
import 'package:guess_duel/screens/auth/widgets/social_auth_buttons.dart';

/// The Sign Up / Registration Screen for Guess Duel.
/// Implemented as a [HookWidget] utilizing [flutter_hooks] for state management
/// and [flutter_animate] for smooth cinematic entry transitions.
class CreateAccountScreen extends HookWidget {
  final VoidCallback? onLoginTap;
  final Future<void> Function(String username, String email, String password)?
  onRegister;

  const CreateAccountScreen({super.key, this.onLoginTap, this.onRegister});

  @override
  Widget build(BuildContext context) {
    // Text editing controllers
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    // Focus nodes
    final usernameFocus = useFocusNode();
    final emailFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final confirmPasswordFocus = useFocusNode();

    // Field states
    final isPasswordObscured = useState<bool>(true);
    final isConfirmPasswordObscured = useState<bool>(true);
    final isLoading = useState<bool>(false);

    // Validation error states
    final usernameError = useState<String?>(null);
    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);
    final confirmPasswordError = useState<String?>(null);

    // Form validation logic
    bool validateForm() {
      bool isValid = true;
      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      // 1. Username
      if (username.isEmpty) {
        usernameError.value = 'Username is required';
        isValid = false;
      } else if (username.length < 3) {
        usernameError.value = 'Username must be at least 3 characters';
        isValid = false;
      } else {
        usernameError.value = null;
      }

      // 2. Email
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (email.isEmpty) {
        emailError.value = 'Email address is required';
        isValid = false;
      } else if (!emailRegex.hasMatch(email)) {
        emailError.value = 'Please enter a valid email address';
        isValid = false;
      } else {
        emailError.value = null;
      }

      // 3. Password
      if (password.isEmpty) {
        passwordError.value = 'Password is required';
        isValid = false;
      } else if (password.length < 6) {
        passwordError.value = 'Password must be at least 6 characters';
        isValid = false;
      } else {
        passwordError.value = null;
      }

      // 4. Confirm Password
      if (confirmPassword.isEmpty) {
        confirmPasswordError.value = 'Please confirm your password';
        isValid = false;
      } else if (confirmPassword != password) {
        confirmPasswordError.value = 'Passwords do not match';
        isValid = false;
      } else {
        confirmPasswordError.value = null;
      }

      return isValid;
    }

    // Submit handler
    Future<void> handleSignUp() async {
      FocusScope.of(context).unfocus();
      if (!validateForm()) return;

      isLoading.value = true;
      try {
        if (onRegister != null) {
          await onRegister!(
            usernameController.text.trim(),
            emailController.text.trim(),
            passwordController.text,
          );
        } else {
          // Default mock registration simulation
          await Future.delayed(const Duration(milliseconds: 1200));
          Get.snackbar(
            'Account Created!',
            'Welcome to Guess Duel, ${usernameController.text.trim()}!',
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
            duration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        Get.snackbar(
          'Registration Failed',
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

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. Top Bar (Players Online & Version)
                  const AuthTopBar(),

                  const SizedBox(height: 6),

                  // 2. Brand Header (Glowing Emblem, Title, Subtitle)
                  const AuthBrandHeader(),

                  const SizedBox(height: 16),

                  // 3. Registration Glass Card
                  Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF111624).withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: const Color(0xFF1D2538),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.45),
                              blurRadius: 28,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Username Field
                            AuthTextField(
                              label: 'Username',
                              controller: usernameController,
                              focusNode: usernameFocus,
                              hintText: 'alex_tactician',
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
                              ),
                              errorText: usernameError.value,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) => emailFocus.requestFocus(),
                              onChanged: (_) {
                                if (usernameError.value != null) {
                                  usernameError.value = null;
                                }
                              },
                            ),

                            const SizedBox(height: 12),

                            // Email Field
                            AuthTextField(
                              label: 'Email Address',
                              controller: emailController,
                              focusNode: emailFocus,
                              hintText: 'alex@guessduel.io',
                              prefixIcon: const Icon(
                                Icons.alternate_email_rounded,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              errorText: emailError.value,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) => passwordFocus.requestFocus(),
                              onChanged: (_) {
                                if (emailError.value != null) {
                                  emailError.value = null;
                                }
                              },
                            ),

                            const SizedBox(height: 12),

                            // Password Field
                            AuthTextField(
                              label: 'Password',
                              controller: passwordController,
                              focusNode: passwordFocus,
                              hintText: '••••••••••••',
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
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) =>
                                  confirmPasswordFocus.requestFocus(),
                              onChanged: (_) {
                                if (passwordError.value != null) {
                                  passwordError.value = null;
                                }
                              },
                            ),

                            const SizedBox(height: 12),

                            // Confirm Password Field
                            AuthTextField(
                              label: 'Confirm Password',
                              controller: confirmPasswordController,
                              focusNode: confirmPasswordFocus,
                              hintText: '••••••••••••',
                              prefixIcon: const Icon(Icons.shield_outlined),
                              isPassword: true,
                              obscureText: isConfirmPasswordObscured.value,
                              onToggleObscure: () {
                                isConfirmPasswordObscured.value =
                                    !isConfirmPasswordObscured.value;
                              },
                              errorText: confirmPasswordError.value,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => handleSignUp(),
                              onChanged: (_) {
                                if (confirmPasswordError.value != null) {
                                  confirmPasswordError.value = null;
                                }
                              },
                            ),

                            const SizedBox(height: 16),

                            // Primary CTA "Create Account"
                            NeonButton(
                              text: 'Create Account',
                              isLoading: isLoading.value,
                              onPressed: handleSignUp,
                              icon: const Icon(
                                Icons.arrow_forward_rounded,
                                size: 18,
                                color: Color(0xFF0A0E19),
                              ),
                            ),

                            // Social Auth Section
                            SocialAuthButtons(
                              dividerText: 'OR SIGN UP WITH',
                              onGoogleTap: () {
                                Get.snackbar(
                                  'Google Sign-Up',
                                  'Connecting with Google Account...',
                                  backgroundColor: const Color(0xFF111624),
                                  colorText: const Color(0xFFE2E8F0),
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.all(16),
                                );
                              },
                              onFacebookTap: () {
                                Get.snackbar(
                                  'Facebook Sign-Up',
                                  'Connecting with Facebook Account...',
                                  backgroundColor: const Color(0xFF111624),
                                  colorText: const Color(0xFFE2E8F0),
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.all(16),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 550.ms, delay: 200.ms)
                      .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),

                  const SizedBox(height: 16),

                  // 4. Footer Link to Log In
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            if (onLoginTap != null) {
                              onLoginTap!();
                            } else if (Navigator.canPop(context)) {
                              //replacment
                              Get.off(() => const SignInScreen());
                            } else {
                              Get.snackbar(
                                'Log In',
                                'Navigate to Log In screen.',
                                backgroundColor: const Color(0xFF111624),
                                colorText: const Color(0xFF00F0FF),
                                snackPosition: SnackPosition.BOTTOM,
                                margin: const EdgeInsets.all(16),
                              );
                            }
                          },
                          child: Text(
                            'Log In',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF00F0FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 450.ms, delay: 350.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
