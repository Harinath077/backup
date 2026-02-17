import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Placeholder fraud analytics screen.
/// Replace this with your full implementation when ready.
class FraudAnalyticsScreen extends StatelessWidget {
  const FraudAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Fraud Analytics',
            style: AppTheme.syneHeading(18, AppTheme.textDark)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.analytics_rounded,
                size: 64, color: AppTheme.primaryBlue.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            Text('Fraud Analytics Dashboard',
                style: AppTheme.syneHeading(20, AppTheme.textDark)),
            const SizedBox(height: 8),
            Text('47 threats blocked this week',
                style: AppTheme.dmBody(14, AppTheme.textGrey)),
          ],
        ),
      ),
    );
  }
}
