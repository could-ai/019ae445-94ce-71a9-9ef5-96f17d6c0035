import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stayin_ubud/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(),
            _buildMarquee(),
            _buildVideoSection(),
            _buildVillaPreviewGrid(),
            const SizedBox(height: 100), // Footer spacing
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    // Glassmorphism effect calculation based on scroll
    final double opacity = (_scrollOffset / 200).clamp(0.0, 0.9);
    
    return AppBar(
      backgroundColor: AppColors.bgCream.withOpacity(opacity),
      elevation: 0,
      title: Text(
        'StayinUBUD',
        style: GoogleFonts.playfairDisplay(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Villas', style: TextStyle(color: AppColors.textPrimary)),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Blog', style: TextStyle(color: AppColors.textPrimary)),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textPrimary,
            foregroundColor: AppColors.bgCream,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('Book Now'),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Parallax Background
          Positioned(
            top: -_scrollOffset * 0.5, // Parallax effect
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.network(
              'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&q=80',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStaggeredText("Find Your Peace"),
                _buildStaggeredText("in Ubud", delay: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaggeredText(String text, {int delay = 0}) {
    return Text(
      text,
      style: GoogleFonts.playfairDisplay(
        fontSize: 56,
        color: AppColors.bgCream,
        fontWeight: FontWeight.bold,
      ),
    )
    .animate()
    .fadeIn(duration: 800.ms, delay: delay.ms)
    .slideY(begin: 0.3, end: 0, duration: 800.ms, curve: Curves.easeOutQuad);
  }

  Widget _buildMarquee() {
    return Container(
      height: 60,
      color: AppColors.accentLight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "LIMITED OFFER: 20% OFF FOR LONG STAYS • ",
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoSection() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: AppColors.accentMedium,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Placeholder for Video
          Image.network(
            'https://images.unsplash.com/photo-1544644181-1484b3fdfc62?auto=format&fit=crop&q=80',
            fit: BoxFit.cover,
          ),
          Container(
            color: AppColors.textPrimary.withOpacity(0.3),
          ),
          Center(
            child: Text(
              "The Ubud Experience",
              style: GoogleFonts.playfairDisplay(
                fontSize: 48,
                color: AppColors.bgCream,
              ),
            )
            .animate(target: _scrollOffset > MediaQuery.of(context).size.height * 0.8 ? 1 : 0)
            .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), duration: 1000.ms)
            .fadeIn(duration: 1000.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildVillaPreviewGrid() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Our Villas",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Responsive logic can be added here
              childAspectRatio: 1.2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildVillaCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVillaCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?auto=format&fit=crop&q=80',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Villa Serenity ${index + 1}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "IDR 3,500,000 / night",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: (index * 100).ms, duration: 600.ms)
    .slideY(begin: 0.1, end: 0, duration: 600.ms);
  }
}
