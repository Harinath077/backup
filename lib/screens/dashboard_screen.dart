import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import 'fraud_analytics_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;
  bool _balanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ═══ SECTION A: HEADER ═══
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: _buildHeader(topPadding),
            ),

            // ═══ SECTION B: FRAUD SHIELD STATUS ═══
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              child: _buildFraudShield(),
            ),

            // ═══ SECTION C: SEARCH BAR ═══
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: _buildSearchBar(),
            ),

            // ═══ SECTION D: QUICK SEND ═══
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: _buildQuickSend(),
            ),

            // ═══ SECTION E: RECENT TRANSACTIONS ═══
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: _buildRecentTransactions(),
            ),

            // ═══ SECTION F: FRAUD ANALYTICS PREVIEW ═══
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 500),
              child: _buildAnalyticsPreview(),
            ),

            const SizedBox(height: 100), // space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ──────────────────────────────────────────
  // SECTION A – Header
  // ──────────────────────────────────────────
  Widget _buildHeader(double topPadding) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, topPadding + 20, 20, 36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A2494), Color(0xFF1A3FCC)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: avatar, name, bell
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.lightBlue, width: 2),
                  color: AppTheme.accentBlue,
                ),
                alignment: Alignment.center,
                child: Text('RK',
                    style: AppTheme.syneHeading(16, Colors.white)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good morning! 🌤',
                        style: AppTheme.dmBody(13, Colors.white70)),
                    Text('Raj Kumar',
                        style: AppTheme.syneHeading(22, Colors.white)),
                  ],
                ),
              ),
              // Bell with badge
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded,
                        color: Colors.white, size: 26),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppTheme.dangerRed,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text('3',
                          style: AppTheme.dmBody(10, Colors.white)
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Balance
          Text('Total Balance',
              style: AppTheme.dmBody(12, Colors.white60)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                _balanceVisible ? '₹4,84,250.00' : '₹ ••••••',
                style: AppTheme.syneHeading(32, Colors.white),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    setState(() => _balanceVisible = !_balanceVisible),
                child: Icon(
                  _balanceVisible
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Colors.white60,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Quick action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _quickAction(Icons.arrow_upward_rounded, 'Send'),
              _quickAction(Icons.arrow_downward_rounded, 'Request'),
              _quickAction(Icons.receipt_long_rounded, 'Pay Bills'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTheme.dmBody(12, Colors.white)),
      ],
    );
  }

  // ──────────────────────────────────────────
  // SECTION B – Fraud Shield Status
  // ──────────────────────────────────────────
  Widget _buildFraudShield() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      transform: Matrix4.translationValues(0, -20, 0),
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(radius: 20),
      child: Row(
        children: [
          const Icon(Icons.shield_rounded,
              color: AppTheme.safeGreen, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fraud Shield',
                    style: AppTheme.syneHeading(15, AppTheme.textDark)
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('All systems active · Last scan 2s ago',
                    style: AppTheme.dmBody(12, AppTheme.textGrey)),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.safeGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('PROTECTED',
                style: AppTheme.dmBody(11, AppTheme.safeGreen)
                    .copyWith(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // SECTION C – Search Bar
  // ──────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.cardDecoration(radius: 14),
      child: Row(
        children: [
          const Icon(Icons.search_rounded,
              color: AppTheme.textGrey, size: 22),
          const SizedBox(width: 12),
          Text('Pay by Contact or UPI ID',
              style: AppTheme.dmBody(14, const Color(0xFFB0B8C9))),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // SECTION D – Quick Send
  // ──────────────────────────────────────────
  Widget _buildQuickSend() {
    final contacts = [
      _Contact('Jenny', Colors.pink.shade300),
      _Contact('Esther', Colors.teal.shade400),
      _Contact('Robert', Colors.orange.shade400),
      _Contact('Arlene', Colors.purple.shade300),
      _Contact('Ralph', Colors.indigo.shade300),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Quick Send',
                  style: AppTheme.syneHeading(16, AppTheme.textDark)
                      .copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text('View All',
                  style: AppTheme.dmBody(13, AppTheme.primaryBlue)
                      .copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Add new
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppTheme.primaryBlue, width: 1.5),
                        ),
                        child: const Icon(Icons.add_rounded,
                            color: AppTheme.primaryBlue, size: 24),
                      ),
                      const SizedBox(height: 6),
                      Text('Add',
                          style: AppTheme.dmBody(12, AppTheme.textDark)),
                    ],
                  ),
                ),
                // Contacts
                ...contacts.map((c) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: c.color,
                            child: Text(
                              c.name.substring(0, 1),
                              style: AppTheme.syneHeading(18, Colors.white),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(c.name,
                              style: AppTheme.dmBody(12, AppTheme.textDark)),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // SECTION E – Recent Transactions
  // ──────────────────────────────────────────
  Widget _buildRecentTransactions() {
    final txns = [
      _Txn('Netflix Premium', 'Monthly subscription · 08 Oct, 09:50 AM',
          '-₹149.00', true, Icons.play_arrow_rounded, Colors.red.shade600,
          isSafe: true),
      _Txn('Marvin McKinney', 'Received Money · 07 Oct, 10:30 AM',
          '+₹24.00', false, Icons.person_rounded, Colors.blue.shade400,
          isSafe: true),
      _Txn('Robert Fox', 'Received Money · 07 Oct, 09:30 AM',
          '+₹100.00', false, Icons.person_rounded, Colors.orange.shade400,
          isSafe: true),
      _Txn('Unknown@upi', 'New Receiver · 06 Oct, 11:15 PM',
          '-₹5,000.00', true, Icons.warning_amber_rounded,
          Colors.red.shade400,
          isSafe: false),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Recent Transfer',
                  style: AppTheme.syneHeading(16, AppTheme.textDark)
                      .copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text('View All',
                  style: AppTheme.dmBody(13, AppTheme.primaryBlue)
                      .copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: AppTheme.cardDecoration(radius: 16),
            child: Column(
              children: [
                for (int i = 0; i < txns.length; i++) ...[
                  _txnTile(txns[i]),
                  if (i < txns.length - 1)
                    const Divider(height: 1, indent: 68),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _txnTile(_Txn txn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: txn.avatarColor.withValues(alpha: 0.12),
            child: Icon(txn.icon, color: txn.avatarColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txn.title,
                    style: AppTheme.dmBody(14, AppTheme.textDark)
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(txn.subtitle,
                    style: AppTheme.dmBody(11, AppTheme.textGrey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                txn.amount,
                style: AppTheme.syneHeading(
                  14,
                  txn.isDebit ? AppTheme.dangerRed : AppTheme.safeGreen,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: txn.isSafe
                      ? AppTheme.safeGreen.withValues(alpha: 0.1)
                      : AppTheme.dangerRed.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  txn.isSafe ? 'Safe' : 'Flagged',
                  style: AppTheme.dmBody(
                    10,
                    txn.isSafe ? AppTheme.safeGreen : AppTheme.dangerRed,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // SECTION F – Fraud Analytics Preview
  // ──────────────────────────────────────────
  Widget _buildAnalyticsPreview() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.blueGradientBox(radius: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fraud Analytics',
                    style: AppTheme.syneHeading(16, Colors.white)),
                const SizedBox(height: 4),
                Text('47 threats blocked this week',
                    style: AppTheme.dmBody(13, Colors.white70)),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FraudAnalyticsScreen()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryBlue,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('View Details →',
                      style: AppTheme.dmBody(13, AppTheme.primaryBlue)
                          .copyWith(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Overlapping shields with 47 count
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: Icon(Icons.shield_rounded,
                      size: 48, color: Colors.white.withValues(alpha: 0.1)),
                ),
                Positioned(
                  left: 16,
                  child: Icon(Icons.shield_rounded,
                      size: 48, color: Colors.white.withValues(alpha: 0.2)),
                ),
                Positioned(
                  left: 32,
                  child: Icon(Icons.shield_rounded,
                      size: 48, color: Colors.white.withValues(alpha: 1.0)),
                ),
                Positioned(
                  left: 32,
                  child: Text('47',
                      style: AppTheme.syneHeading(14, AppTheme.primaryBlue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // Bottom Navigation Bar
  // ──────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', 0),
              _navItem(Icons.credit_card_rounded, 'Card', 1),
              // Center FAB-style send button
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppTheme.deepBlue, AppTheme.accentBlue],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x401A3FCC),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_upward_rounded,
                      color: Colors.white, size: 26),
                ),
              ),
              _navItem(Icons.receipt_long_rounded, 'Activity', 2),
              _navItem(Icons.person_outline_rounded, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = _navIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _navIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 24,
                color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.dmBody(
                11,
                isActive ? AppTheme.primaryBlue : AppTheme.textGrey,
              ).copyWith(
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            if (isActive)
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryBlue,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

// ── Data classes ──

class _Contact {
  final String name;
  final Color color;
  _Contact(this.name, this.color);
}

class _Txn {
  final String title, subtitle, amount;
  final bool isDebit, isSafe;
  final IconData icon;
  final Color avatarColor;
  _Txn(this.title, this.subtitle, this.amount, this.isDebit, this.icon,
      this.avatarColor,
      {required this.isSafe});
}
