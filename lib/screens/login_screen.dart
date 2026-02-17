import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import 'signup_screen.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final List<TextEditingController> _mpinControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _mpinFocusNodes =
      List.generate(6, (_) => FocusNode());
  bool _obscureMpin = true;
  double _btnScale = 1.0;

  @override
  void dispose() {
    _phoneController.dispose();
    for (final c in _mpinControllers) {
      c.dispose();
    }
    for (final f in _mpinFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _login() {
    setState(() => _btnScale = 0.95);
    Future.delayed(const Duration(milliseconds: 120), _navigateToDashboard);
  }

  void _navigateToDashboard() {
    if (!mounted) return;
    setState(() => _btnScale = 1.0);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Blue header ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24, topPadding + 20, 24, 80),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0A2494), Color(0xFF3B5FE8)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Row(
                    children: [
                      const Icon(Icons.shield_rounded,
                          color: Colors.white, size: 24),
                      const SizedBox(width: 6),
                      Text('Sentra Pay',
                          style: AppTheme.syneHeading(16, Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        Text('Welcome Back',
                            style: AppTheme.syneHeading(28, Colors.white)),
                        const SizedBox(height: 6),
                        Text('Secure login to your account',
                            style: AppTheme.dmBody(14, Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Floating form card ──
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: Transform.translate(
                offset: const Offset(0, -40),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  decoration: AppTheme.cardDecoration(radius: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text('Sign In',
                          style: AppTheme.syneHeading(20, AppTheme.textDark)),
                      const SizedBox(height: 24),

                      // Mobile number
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 300),
                        child: _buildPhoneField(),
                      ),
                      const SizedBox(height: 20),

                      // MPIN
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 400),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('MPIN',
                                    style: AppTheme.dmBody(
                                        13, AppTheme.textGrey)),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => _obscureMpin = !_obscureMpin),
                                  child: Icon(
                                    _obscureMpin
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    size: 20,
                                    color: AppTheme.textGrey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _buildMpinRow(_mpinControllers, _mpinFocusNodes),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Forgot MPIN?',
                              style: AppTheme.dmBody(13, AppTheme.primaryBlue)
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Login button with scale animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 500),
                        child: GestureDetector(
                          onTap: _login,
                          child: AnimatedScale(
                            scale: _btnScale,
                            duration: const Duration(milliseconds: 120),
                            child: Container(
                              width: double.infinity,
                              height: 56,
                              decoration:
                                  AppTheme.blueGradientBox(radius: 14),
                              alignment: Alignment.center,
                              child: Text('Login',
                                  style: AppTheme.syneHeading(
                                      16, Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // OR divider
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('OR',
                                style:
                                    AppTheme.dmBody(12, AppTheme.textGrey)),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Biometric button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.fingerprint_rounded,
                              color: AppTheme.primaryBlue),
                          label: Text('Login with Biometrics',
                              style: AppTheme.dmBody(14, AppTheme.primaryBlue)
                                  .copyWith(fontWeight: FontWeight.w600)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: AppTheme.primaryBlue, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sign up link
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupScreen()),
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: AppTheme.dmBody(14, AppTheme.textGrey),
                              children: [
                                const TextSpan(text: 'New to Sentra Pay?  '),
                                TextSpan(
                                  text: 'Sign Up',
                                  style: AppTheme.dmBody(
                                          14, AppTheme.primaryBlue)
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Phone number field ──
  Widget _buildPhoneField() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      style: AppTheme.dmBody(15, AppTheme.textDark),
      decoration: InputDecoration(
        hintText: 'Enter mobile number',
        hintStyle: AppTheme.dmBody(14, const Color(0xFFB0B8C9)),
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 12, right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('+91',
              style: AppTheme.dmBody(14, AppTheme.primaryBlue)
                  .copyWith(fontWeight: FontWeight.w600)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),
      ),
    );
  }

  // ── MPIN row (6 dot boxes) ──
  Widget _buildMpinRow(
      List<TextEditingController> controllers, List<FocusNode> focusNodes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (i) {
        return SizedBox(
          width: 48,
          height: 48,
          child: TextField(
            controller: controllers[i],
            focusNode: focusNodes[i],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            obscureText: _obscureMpin,
            obscuringCharacter: '●',
            style: AppTheme.syneHeading(18, AppTheme.textDark),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
              ),
            ),
            onChanged: (val) {
              if (val.isNotEmpty && i < 5) {
                focusNodes[i + 1].requestFocus();
              } else if (val.isEmpty && i > 0) {
                focusNodes[i - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }
}
