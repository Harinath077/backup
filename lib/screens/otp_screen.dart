import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, this.phone = '98XXX XX789'});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _secondsLeft = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Focus the first box
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _startTimer() {
    _secondsLeft = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _verify() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (route) => false,
    );
  }

  void _autoSubmit() {
    final allFilled = _controllers.every((c) => c.text.isNotEmpty);
    if (allFilled) _verify();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            Text('Verify OTP', style: AppTheme.syneHeading(18, AppTheme.textDark)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(flex: 1),
            // Phone illustration
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.phone_android_rounded,
                        size: 44, color: AppTheme.primaryBlue),
                    // Signal ripples
                    Positioned(
                      top: 16,
                      right: 14,
                      child: Icon(Icons.wifi_rounded,
                          size: 22,
                          color: AppTheme.primaryBlue.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              child: Text(
                'OTP sent to +91 ${widget.phone}',
                style: AppTheme.dmBody(15, AppTheme.textGrey),
              ),
            ),
            const SizedBox(height: 32),

            // OTP boxes
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  return SizedBox(
                    width: 48,
                    height: 52,
                    child: TextField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: AppTheme.syneHeading(20, AppTheme.textDark),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppTheme.primaryBlue, width: 2),
                        ),
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && i < 5) {
                          _focusNodes[i + 1].requestFocus();
                        } else if (val.isEmpty && i > 0) {
                          _focusNodes[i - 1].requestFocus();
                        }
                        _autoSubmit();
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),

            // Timer / resend
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: _secondsLeft > 0
                  ? Text(
                      'Resend OTP in 0:${_secondsLeft.toString().padLeft(2, '0')}',
                      style: AppTheme.dmBody(14, AppTheme.textGrey),
                    )
                  : GestureDetector(
                      onTap: _startTimer,
                      child: Text(
                        'Resend OTP',
                        style: AppTheme.dmBody(14, AppTheme.primaryBlue)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
            ),

            const Spacer(flex: 1),

            // Verify button
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: GestureDetector(
                onTap: _verify,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: AppTheme.blueGradientBox(radius: 14),
                  alignment: Alignment.center,
                  child: Text(
                    'Verify',
                    style: AppTheme.syneHeading(16, Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
