import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _currentStep = 0; // 0, 1, 2

  // Step 1 controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  // Step 2 controllers
  final List<TextEditingController> _mpinControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _mpinFocusNodes =
      List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _confirmMpinControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _confirmMpinFocusNodes =
      List.generate(6, (_) => FocusNode());

  double _mpinStrength = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    for (final c in _mpinControllers) {
      c.dispose();
    }
    for (final c in _confirmMpinControllers) {
      c.dispose();
    }
    for (final f in _mpinFocusNodes) {
      f.dispose();
    }
    for (final f in _confirmMpinFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    }
    if (_currentStep == 2) {
      // Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OtpScreen(phone: _phoneController.text.isNotEmpty
                  ? _phoneController.text
                  : '98XXX XX789'),
        ),
      );
    }
  }

  void _updateMpinStrength() {
    final entered =
        _mpinControllers.where((c) => c.text.isNotEmpty).length;
    setState(() => _mpinStrength = entered / 6);
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
                  GestureDetector(
                    onTap: () {
                      if (_currentStep > 0) {
                        setState(() => _currentStep--);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Text('Create Account',
                            style: AppTheme.syneHeading(28, Colors.white)),
                        const SizedBox(height: 6),
                        Text('Join Sentra Pay today',
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
                      // Step indicator
                      _buildStepIndicator(),
                      const SizedBox(height: 28),
                      // Current step content
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _currentStep == 0
                            ? _buildStep1()
                            : _buildStep2(),
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

  // ── Step indicator: 3 circles connected by lines ──
  Widget _buildStepIndicator() {
    return Row(
      children: [
        for (int i = 0; i < 3; i++) ...[
          _stepCircle(i),
          if (i < 2)
            Expanded(
              child: Container(
                height: 2,
                color: i < _currentStep
                    ? AppTheme.primaryBlue
                    : const Color(0xFFE2E8F0),
              ),
            ),
        ],
      ],
    );
  }

  Widget _stepCircle(int step) {
    final isCompleted = step < _currentStep;
    final isActive = step == _currentStep;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted || isActive
            ? AppTheme.primaryBlue
            : Colors.transparent,
        border: Border.all(
          color: isCompleted || isActive
              ? AppTheme.primaryBlue
              : const Color(0xFFE2E8F0),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: isCompleted
          ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
          : Text(
              '${step + 1}',
              style: AppTheme.dmBody(
                13,
                isActive ? Colors.white : AppTheme.textGrey,
              ).copyWith(fontWeight: FontWeight.w700),
            ),
    );
  }

  // ── Step 1: Personal Info ──
  Widget _buildStep1() {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Info',
            style: AppTheme.syneHeading(18, AppTheme.textDark)),
        const SizedBox(height: 20),
        _inputField(
          controller: _nameController,
          hint: 'Full Name',
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 16),
        _inputField(
          controller: _phoneController,
          hint: 'Mobile Number',
          icon: Icons.phone_android_rounded,
          keyboardType: TextInputType.phone,
          prefix: '+91',
          formatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        const SizedBox(height: 16),
        _inputField(
          controller: _emailController,
          hint: 'Email (optional)',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 28),
        _gradientButton('Continue', _nextStep),
      ],
    );
  }

  // ── Step 2: Create MPIN ──
  Widget _buildStep2() {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Set your 6-digit MPIN',
            style: AppTheme.syneHeading(18, AppTheme.textDark)),
        const SizedBox(height: 20),
        Text('Enter MPIN',
            style: AppTheme.dmBody(13, AppTheme.textGrey)),
        const SizedBox(height: 10),
        _buildPinRow(_mpinControllers, _mpinFocusNodes, onChanged: true),
        const SizedBox(height: 8),
        // Strength indicator
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: _mpinStrength,
            minHeight: 4,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(
              _mpinStrength < 0.4
                  ? AppTheme.dangerRed
                  : _mpinStrength < 0.8
                      ? AppTheme.warningAmber
                      : AppTheme.safeGreen,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('Confirm MPIN',
            style: AppTheme.dmBody(13, AppTheme.textGrey)),
        const SizedBox(height: 10),
        _buildPinRow(_confirmMpinControllers, _confirmMpinFocusNodes),
        const SizedBox(height: 28),
        _gradientButton('Continue', _nextStep),
      ],
    );
  }

  // ── Shared widgets ──

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? prefix,
    List<TextInputFormatter>? formatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      style: AppTheme.dmBody(15, AppTheme.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTheme.dmBody(14, const Color(0xFFB0B8C9)),
        prefixIcon: prefix != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 12),
                  Icon(icon, size: 20, color: AppTheme.textGrey),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(prefix,
                        style: AppTheme.dmBody(13, AppTheme.primaryBlue)
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 8),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(icon, size: 20, color: AppTheme.textGrey),
              ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 0, minHeight: 0),
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

  Widget _buildPinRow(
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes, {
    bool onChanged = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (i) {
        return SizedBox(
          width: 46,
          height: 48,
          child: TextField(
            controller: controllers[i],
            focusNode: focusNodes[i],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            obscureText: true,
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
                borderSide: const BorderSide(
                    color: AppTheme.primaryBlue, width: 1.5),
              ),
            ),
            onChanged: (val) {
              if (val.isNotEmpty && i < 5) {
                focusNodes[i + 1].requestFocus();
              } else if (val.isEmpty && i > 0) {
                focusNodes[i - 1].requestFocus();
              }
              if (onChanged) _updateMpinStrength();
            },
          ),
        );
      }),
    );
  }

  Widget _gradientButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: AppTheme.blueGradientBox(radius: 14),
        alignment: Alignment.center,
        child: Text(text, style: AppTheme.syneHeading(16, Colors.white)),
      ),
    );
  }
}
