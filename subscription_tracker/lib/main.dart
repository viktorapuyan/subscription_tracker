import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
	runApp(const SubscriptionTrackerApp());
}

class SubscriptionTrackerApp extends StatelessWidget {
	const SubscriptionTrackerApp({super.key});

	@override
	Widget build(BuildContext context) {
		const primaryBlue = Color(0xFF1B2AA5);
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Subscription Tracker',
			theme: ThemeData(
				useMaterial3: true,
				scaffoldBackgroundColor: const Color(0xFFF5F7FB),
				colorScheme: ColorScheme.fromSeed(
					seedColor: primaryBlue,
					surface: const Color(0xFFF5F7FB),
				),
				textTheme: GoogleFonts.manropeTextTheme(),
			),
			home: const DashboardScreen(),
		);
	}
}

class DashboardScreen extends StatelessWidget {
	const DashboardScreen({super.key});

	static const _upcomingCharges = <_ChargeItem>[
		_ChargeItem(name: 'Netflix', amount: 549, date: 'Mar 25', icon: Icons.live_tv),
		_ChargeItem(name: 'Spotify', amount: 129, date: 'Mar 27', icon: Icons.music_note),
		_ChargeItem(name: 'Canva Pro', amount: 299, date: 'Mar 30', icon: Icons.brush),
		_ChargeItem(name: 'Google One', amount: 149, date: 'Apr 1', icon: Icons.cloud_outlined),
	];

	static const _potentialSavings = <_SavingItem>[
		_SavingItem(name: 'Spotify', note: 'Not used in 14 days', amount: 129),
		_SavingItem(name: 'Canva Pro', note: 'Not used in 21 days', amount: 299),
	];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: const BoxDecoration(
					gradient: LinearGradient(
						begin: Alignment.topCenter,
						end: Alignment.bottomCenter,
						colors: [Color(0xFFF7FAFF), Color(0xFFF2F5FB)],
					),
				),
				child: SafeArea(
					child: Center(
						child: ConstrainedBox(
							constraints: const BoxConstraints(maxWidth: 430),
							child: Padding(
								padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
								child: Column(
									children: [
										const _HeaderSection(),
										const SizedBox(height: 14),
										const _TotalSubscriptionCard(),
										const SizedBox(height: 12),
										const _InsightBanner(),
										const SizedBox(height: 12),
										const _SectionTitle('Upcoming Charges'),
										const SizedBox(height: 8),
										SizedBox(
											height: 118,
											child: ListView.separated(
												scrollDirection: Axis.horizontal,
												itemCount: _upcomingCharges.length,
												separatorBuilder: (_, _) => const SizedBox(width: 10),
												itemBuilder: (context, index) {
													return _UpcomingChargeCard(item: _upcomingCharges[index]);
												},
											),
										),
										const SizedBox(height: 12),
										const _SectionTitle('Potential Savings'),
										const SizedBox(height: 8),
										Expanded(
											child: ListView.separated(
												padding: EdgeInsets.zero,
												itemCount: _potentialSavings.length,
												separatorBuilder: (_, _) => const SizedBox(height: 10),
												itemBuilder: (context, index) {
													return _SavingsCard(item: _potentialSavings[index]);
												},
											),
										),
										const SizedBox(height: 8),
										const _QuickActionsBar(),
										const SizedBox(height: 8),
									],
								),
							),
						),
					),
				),
			),
			bottomNavigationBar: const _BottomNavBar(),
		);
	}
}

class _HeaderSection extends StatelessWidget {
	const _HeaderSection();

	@override
	Widget build(BuildContext context) {
		return Row(
			children: [
				Expanded(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								'Good evening, Angelo',
								style: Theme.of(context).textTheme.titleLarge?.copyWith(
									fontWeight: FontWeight.w800,
									color: const Color(0xFF13203A),
								),
							),
							const SizedBox(height: 2),
							Text(
								"Here's your subscription overview",
								style: Theme.of(context).textTheme.bodyMedium?.copyWith(
									color: const Color(0xFF667085),
								),
							),
						],
					),
				),
				Container(
					height: 42,
					width: 42,
					decoration: BoxDecoration(
						color: Colors.white,
						borderRadius: BorderRadius.circular(14),
						boxShadow: const [
							BoxShadow(
								color: Color(0x14000000),
								blurRadius: 14,
								offset: Offset(0, 6),
							),
						],
					),
					child: const Icon(Icons.person_outline_rounded, color: Color(0xFF21324F)),
				),
			],
		);
	}
}

class _TotalSubscriptionCard extends StatelessWidget {
	const _TotalSubscriptionCard();

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.all(18),
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(20),
				gradient: const LinearGradient(
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
					colors: [Color(0xFF2A38B6), Color(0xFF1C287F)],
				),
				boxShadow: const [
					BoxShadow(
						color: Color(0x332A38B6),
						blurRadius: 18,
						offset: Offset(0, 10),
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(
						'Total Subscriptions',
						style: Theme.of(context).textTheme.bodyMedium?.copyWith(
							color: const Color(0xD9FFFFFF),
							fontWeight: FontWeight.w600,
						),
					),
					const SizedBox(height: 8),
					Text(
						'₱2,450/month',
						style: Theme.of(context).textTheme.headlineMedium?.copyWith(
							color: Colors.white,
							fontWeight: FontWeight.w800,
							letterSpacing: -0.4,
						),
					),
					const SizedBox(height: 6),
					Row(
						children: [
							Container(
								padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
								decoration: BoxDecoration(
									color: const Color(0x26FF9B9B),
									borderRadius: BorderRadius.circular(999),
								),
								child: Text(
									'+₱200 from last month',
									style: Theme.of(context).textTheme.bodySmall?.copyWith(
										color: const Color(0xFFFFD5D5),
										fontWeight: FontWeight.w700,
									),
								),
							),
						],
					),
				],
			),
		);
	}
}

class _InsightBanner extends StatelessWidget {
	const _InsightBanner();

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
			decoration: BoxDecoration(
				color: const Color(0xFFEFFFF1),
				borderRadius: BorderRadius.circular(16),
				border: Border.all(color: const Color(0xFFCCF0D3)),
			),
			child: Row(
				children: [
					Container(
						height: 32,
						width: 32,
						decoration: BoxDecoration(
							color: const Color(0xFF2DB460),
							borderRadius: BorderRadius.circular(10),
						),
						child: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
					),
					const SizedBox(width: 10),
					Expanded(
						child: Text(
							'You can still save ₱800 this month',
							style: Theme.of(context).textTheme.bodyMedium?.copyWith(
								color: const Color(0xFF175730),
								fontWeight: FontWeight.w700,
							),
						),
					),
				],
			),
		);
	}
}

class _SectionTitle extends StatelessWidget {
	const _SectionTitle(this.title);

	final String title;

	@override
	Widget build(BuildContext context) {
		return Align(
			alignment: Alignment.centerLeft,
			child: Text(
				title,
				style: Theme.of(context).textTheme.titleMedium?.copyWith(
					color: const Color(0xFF1A2A46),
					fontWeight: FontWeight.w800,
				),
			),
		);
	}
}

class _UpcomingChargeCard extends StatelessWidget {
	const _UpcomingChargeCard({required this.item});

	final _ChargeItem item;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: 142,
			padding: const EdgeInsets.all(12),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: const [
					BoxShadow(
						color: Color(0x12000000),
						blurRadius: 12,
						offset: Offset(0, 6),
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						height: 30,
						width: 30,
						decoration: BoxDecoration(
							color: const Color(0xFFEDF1FF),
							borderRadius: BorderRadius.circular(9),
						),
						child: Icon(item.icon, size: 17, color: const Color(0xFF2E3DA8)),
					),
					const SizedBox(height: 8),
					Text(
						item.name,
						style: Theme.of(context).textTheme.bodyMedium?.copyWith(
							fontWeight: FontWeight.w700,
							color: const Color(0xFF1A2A46),
						),
					),
					const SizedBox(height: 4),
					Text(
						'₱${item.amount}',
						style: Theme.of(context).textTheme.titleSmall?.copyWith(
							fontWeight: FontWeight.w800,
							color: const Color(0xFF0D1B3B),
						),
					),
					const Spacer(),
					Text(
						item.date,
						style: Theme.of(context).textTheme.bodySmall?.copyWith(
							color: const Color(0xFF73809A),
							fontWeight: FontWeight.w600,
						),
					),
				],
			),
		);
	}
}

class _SavingsCard extends StatelessWidget {
	const _SavingsCard({required this.item});

	final _SavingItem item;

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.all(13),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: const [
					BoxShadow(
						color: Color(0x12000000),
						blurRadius: 10,
						offset: Offset(0, 4),
					),
				],
			),
			child: Row(
				children: [
					Container(
						height: 36,
						width: 36,
						decoration: BoxDecoration(
							color: const Color(0xFFFFF6EC),
							borderRadius: BorderRadius.circular(11),
						),
						child: const Icon(Icons.savings_outlined, color: Color(0xFFC26712), size: 20),
					),
					const SizedBox(width: 10),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									'${item.name} • ${item.note}',
									maxLines: 1,
									overflow: TextOverflow.ellipsis,
									style: Theme.of(context).textTheme.bodyMedium?.copyWith(
										color: const Color(0xFF1A2A46),
										fontWeight: FontWeight.w700,
									),
								),
								const SizedBox(height: 2),
								Text(
									'You can save ₱${item.amount}/month',
									style: Theme.of(context).textTheme.bodySmall?.copyWith(
										color: const Color(0xFF2B8A4A),
										fontWeight: FontWeight.w700,
									),
								),
							],
						),
					),
					const SizedBox(width: 10),
					FilledButton.tonal(
						onPressed: () {},
						style: FilledButton.styleFrom(
							visualDensity: VisualDensity.compact,
							backgroundColor: const Color(0xFFEAF0FF),
							foregroundColor: const Color(0xFF21359D),
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
						),
						child: const Text('Review'),
					),
				],
			),
		);
	}
}

class _QuickActionsBar extends StatelessWidget {
	const _QuickActionsBar();

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.all(8),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(18),
				boxShadow: const [
					BoxShadow(
						color: Color(0x19000000),
						blurRadius: 14,
						offset: Offset(0, 6),
					),
				],
			),
			child: OutlinedButton.icon(
				onPressed: () {},
				icon: const Icon(Icons.mail_outline_rounded),
				label: const Text('Scan Email'),
				style: OutlinedButton.styleFrom(
					side: const BorderSide(color: Color(0xFFD3DAEC)),
					foregroundColor: const Color(0xFF253250),
					minimumSize: const Size.fromHeight(44),
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
				),
			),
		);
	}
}

class _BottomNavBar extends StatelessWidget {
	const _BottomNavBar();

	@override
	Widget build(BuildContext context) {
		return NavigationBar(
			selectedIndex: 0,
			backgroundColor: Colors.white,
			indicatorColor: const Color(0xFFE6ECFF),
			height: 80,
			destinations: const [
				NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
				NavigationDestination(icon: Icon(Icons.view_list_outlined), selectedIcon: Icon(Icons.view_list), label: 'Subscriptions'),
				NavigationDestination(icon: _AddNavIcon(), selectedIcon: _AddNavIcon(selected: true), label: ''),
				NavigationDestination(
					icon: Icon(Icons.bar_chart_outlined),
					selectedIcon: Icon(Icons.bar_chart),
					label: 'Insights',
				),
				NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
			],
		);
	}
}

class _AddNavIcon extends StatelessWidget {
	const _AddNavIcon({this.selected = false});

	final bool selected;

	@override
	Widget build(BuildContext context) {
		final baseColor = selected ? const Color(0xFF1A2CA8) : const Color(0xFF2335AA);
		return Container(
			height: 50,
			width: 50,
			decoration: BoxDecoration(
				shape: BoxShape.circle,
				color: baseColor,
				border: Border.all(color: Colors.white, width: 3),
				boxShadow: [
					BoxShadow(
						color: baseColor.withValues(alpha: 0.42),
						blurRadius: 18,
						offset: const Offset(0, 10),
					),
				],
			),
			child: Icon(
				Icons.add_rounded,
				size: 28,
				color: selected ? const Color(0xFFF4F6FF) : Colors.white,
			),
		);
	}
}

class _ChargeItem {
	const _ChargeItem({
		required this.name,
		required this.amount,
		required this.date,
		required this.icon,
	});

	final String name;
	final int amount;
	final String date;
	final IconData icon;
}

class _SavingItem {
	const _SavingItem({
		required this.name,
		required this.note,
		required this.amount,
	});

	final String name;
	final String note;
	final int amount;
}
