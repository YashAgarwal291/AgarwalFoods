import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ============================================================
// BREAKPOINTS & RESPONSIVE HELPER
// ============================================================
class ResponsiveBreakpoints {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const ResponsiveDrawer(),
      floatingActionButton: const WhatsAppFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top orange information bar
            const TopBar(),

            // Main navigation
            NavigationBarWidget(
              onMenuPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),

            // Category section
            const CategorySection(),

            // Hero banner
            const HeroSection(),

            // Premium chutneys
            const PremiumChutneySection(),

            // About Agarwal Foods
            const AboutSection(),

            // Get in Touch
            const GetInTouchSection(),

            // Footer
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MOBILE NAVIGATION DRAWER
// ============================================================

class ResponsiveDrawer extends StatelessWidget {
  const ResponsiveDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                color: Color(0xFFFCF8EF),
                border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5))),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFF4B00),
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agarwal Foods',
                          style: TextStyle(
                            color: Color(0xFF9F2F0C),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Authentic Indian Chutneys',
                          style: TextStyle(
                            color: Color(0xFF596579),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Nav items list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  _drawerItem(
                    context,
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () => Navigator.pop(context),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.storefront_outlined,
                    title: 'Shop',
                    onTap: () => Navigator.pop(context),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.info_outline,
                    title: 'About Us',
                    onTap: () => Navigator.pop(context),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.contact_support_outlined,
                    title: 'Contact',
                    onTap: () => Navigator.pop(context),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.star_border,
                    title: 'Reviews',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(height: 24, indent: 16, endIndent: 16),
                  _drawerItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'My Account',
                    onTap: () => Navigator.pop(context),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Cart',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Bottom Contact Info
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF8FAFC),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 16,
                        color: Color(0xFFFF4B00),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '+91 9403183903',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF344054),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 16,
                        color: Color(0xFFFF4B00),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'info@agarwalfoods.com',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF344054),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF344054), size: 22),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF344054),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}

// ============================================================
// TOP BAR
// ============================================================

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 820;

    return Container(
      width: double.infinity,
      color: const Color(0xFFFF4B00),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1540),
          child: isCompact
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Get Premium Chutney at your doorstep | +91 9403183903',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // LEFT SIDE
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '+91 9403183903',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(width: 24),
                        Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'info@agarwalfoods.com',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),

                    // RIGHT SIDE
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Get Premium Chutney at your doorstep',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ============================================================
// NAVIGATION BAR
// ============================================================

class NavigationBarWidget extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const NavigationBarWidget({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 960;
    final isMobile = MediaQuery.of(context).size.width < 650;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
        vertical: isMobile ? 12 : 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1540),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // LEFT: Hamburger menu (Mobile/Tablet) + Logo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isDesktop) ...[
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 28,
                        color: Color(0xFF344054),
                      ),
                      onPressed: onMenuPressed,
                      tooltip: 'Open Menu',
                    ),
                    const SizedBox(width: 6),
                  ],
                  // LOGO CIRCLE
                  Container(
                    width: isMobile ? 44 : 54,
                    height: isMobile ? 44 : 54,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFF4B00),
                    ),
                    child: Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // BRAND TEXT
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agarwal Foods',
                        style: TextStyle(
                          color: const Color(0xFF9F2F0C),
                          fontSize: isMobile ? 20 : 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isMobile)
                        const Text(
                          'Authentic Indian Chutneys',
                          style: TextStyle(
                            color: Color(0xFF596579),
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              // CENTER: DESKTOP MENU ITEMS
              if (isDesktop)
                Row(
                  children: [
                    _navItem('Home', isSelected: true),
                    _navItem('Shop'),
                    _navItem('About'),
                    _navItem('Contact'),
                    _navItem('Reviews'),
                  ],
                ),

              // RIGHT: ACTION BUTTONS (Cart / Account)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isDesktop) ...[
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: IconButton(
                        icon: const Icon(
                          Icons.person_outline,
                          size: 26,
                          color: Color(0xFF344054),
                        ),
                        onPressed: () {},
                        tooltip: 'Account',
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],

                  // CART BUTTON
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 14 : 20,
                          vertical: isMobile ? 8 : 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4B00),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33FF4B00),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: isMobile ? 18 : 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 14 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title, {bool isSelected = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFFFF4B00)
                : const Color(0xFF344054),
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY SECTION
// ============================================================

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Chutney', 'image': 'assets/images/chutney.jpg'},
      {'title': 'Masale', 'image': 'assets/images/masale.jpg'},
      {'title': 'Sauces', 'image': 'assets/images/sauces.jpg'},
      {'title': 'Spice Mixes', 'image': 'assets/images/spice_mixes.jpg'},
      {'title': 'Organic', 'image': 'assets/images/organic.jpg'},
    ];

    final isMobile = MediaQuery.of(context).size.width < 650;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 48,
        horizontal: 16,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              // HEADING
              Text(
                'Shop by Category',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF09284B),
                  fontSize: isMobile ? 26 : 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Explore our artisanal range of hand-crafted condiments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              SizedBox(height: isMobile ? 24 : 36),

              // SCROLLABLE CATEGORY CARDS
              SizedBox(
                height: isMobile ? 190 : 230,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: CategoryCard(
                          title: category['title']!,
                          image: category['image']!,
                          size: isMobile ? 190 : 230,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY CARD
// ============================================================

class CategoryCard extends StatefulWidget {
  final String title;
  final String image;
  final double size;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    this.size = 230,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? const Color(0x33000000)
                  : const Color(0x1A000000),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // IMAGE
              Image.asset(
                widget.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFFFEDDB),
                  child: const Center(
                    child: Icon(
                      Icons.fastfood,
                      color: Color(0xFFFF4B00),
                      size: 40,
                    ),
                  ),
                ),
              ),

              // DARK GRADIENT OVERLAY
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),

              // TITLE
              Positioned(
                left: 18,
                right: 18,
                bottom: 18,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HERO SECTION
// ============================================================

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 650;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 260 : 320),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/chutney.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: const Color(0xD9F0440A),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 40,
          vertical: isMobile ? 36 : 56,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Traditional Flavors, Modern Quality',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 14 : 20),
                Text(
                  'Discover our premium range of authentic Indian chutneys, crafted with love and the finest ingredients',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 24,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 28),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFFF4B00),
                      elevation: 2,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 36,
                        vertical: isMobile ? 14 : 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Explore Products',
                      style: TextStyle(
                        fontSize: isMobile ? 15 : 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PREMIUM CHUTNEY SECTION
// ============================================================

class PremiumChutneySection extends StatelessWidget {
  const PremiumChutneySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 650;

    final products = [
      {
        'name': 'Chenga Chutney',
        'image': 'assets/images/chenga.jpg',
        'description':
            'Tangy and flavorful traditional chutney made from fresh ingredients.',
        'price': '₹140',
      },
      {
        'name': 'Lasun Chutney',
        'image': 'assets/images/lasun.jpg',
        'description': 'Spicy garlic chutney perfect for parathas and snacks.',
        'price': '₹120',
      },
      {
        'name': 'Karal Chutney',
        'image': 'assets/images/kara.jpg',
        'description': 'Authentic bitter gourd chutney with a unique taste.',
        'price': '₹120',
      },
      {
        'name': 'Special Jain Chutney',
        'image': 'assets/images/jain.jpg',
        'description': 'Pure vegetarian chutney following Jain principles.',
        'price': '₹140',
      },
      {
        'name': 'Javas Chutney',
        'image': 'assets/images/javas.jpg',
        'description': 'Sweet and tangy chutney that complements every meal.',
        'price': '₹120',
      },
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFFFCF8EF),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 40 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              Text(
                'Our Premium Chutneys',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF0F2644),
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Handcrafted recipes prepared with 100% natural spices',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              SizedBox(height: isMobile ? 28 : 44),

              // PRODUCTS WRAP
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 28,
                children: products.map((product) {
                  return ProductCard(
                    name: product['name']!,
                    image: product['image']!,
                    description: product['description']!,
                    price: product['price']!,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PRODUCT CARD
// ============================================================

class ProductCard extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final String price;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Responsive card width (fits mobile screens gracefully)
    final cardWidth = screenWidth < 360 ? screenWidth - 32 : 310.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardWidth,
        transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? const Color(0x1F000000)
                  : const Color(0x0D000000),
              blurRadius: _isHovered ? 20 : 12,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PRODUCT IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: Image.asset(
                widget.image,
                width: double.infinity,
                height: 190,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 190,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey,
                      size: 44,
                    ),
                  );
                },
              ),
            ),

            // PRODUCT DETAILS
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF1B2836),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 44,
                    child: Text(
                      widget.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // PRICE + ADD TO CART
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.price,
                        style: const TextStyle(
                          color: Color(0xFFFF5200),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${widget.name} added to cart!'),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF5200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ABOUT SECTION (RESPONSIVE ROW TO COLUMN)
// ============================================================

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobileOrTablet = screenWidth < 960;
    final isMobile = screenWidth < 650;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobileOrTablet
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildAboutText(context, isCenter: true),
                    const SizedBox(height: 36),
                    _buildStatsGrid(context),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildAboutText(context, isCenter: false),
                    ),
                    const SizedBox(width: 50),
                    Expanded(flex: 4, child: _buildStatsGrid(context)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildAboutText(BuildContext context, {required bool isCenter}) {
    final isMobile = MediaQuery.of(context).size.width < 650;

    return Column(
      crossAxisAlignment: isCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'About Agarwal Foods',
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: const Color(0xFF09284B),
            fontSize: isMobile ? 26 : 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'For generations, Agarwal Foods has been bringing the authentic taste of traditional Indian chutneys to homes across the country. Our recipes have been passed down through generations, ensuring that every jar carries the essence of homemade goodness.',
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'We use only the finest ingredients, sourced locally and prepared with traditional methods to preserve the authentic flavors that make our chutneys special.',
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        StatCard(number: '100%', title: 'Natural Ingredients'),
        StatCard(number: '25+', title: 'Years Experience'),
        StatCard(number: '5', title: 'Premium Varieties'),
        StatCard(number: '10K+', title: 'Happy Customers'),
      ],
    );
  }
}

// ============================================================
// STAT CARD
// ============================================================

class StatCard extends StatelessWidget {
  final String number;
  final String title;

  const StatCard({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDDB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFFFF4B00),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// GET IN TOUCH SECTION
// ============================================================

class GetInTouchSection extends StatelessWidget {
  const GetInTouchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 650;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 64,
        horizontal: 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Get in Touch',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF09284B),
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We would love to hear from you. Reach out anytime!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 15),
              ),
              SizedBox(height: isMobile ? 28 : 44),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 24 : 60,
                runSpacing: 28,
                children: const [
                  ContactItem(
                    icon: Icons.phone_outlined,
                    title: 'Call Us',
                    value: '+91 9403183903',
                  ),
                  ContactItem(
                    icon: Icons.email_outlined,
                    title: 'Email Us',
                    value: 'info@agarwalfoods.com',
                  ),
                  ContactItem(
                    icon: Icons.location_on_outlined,
                    title: 'Visit Us',
                    value: 'Solapur, Maharashtra',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CONTACT ITEM
// ============================================================

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ContactItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5200),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF09284B),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FOOTER
// ============================================================

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF182538),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '© 2026 Agarwal Foods. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Bringing authentic Indian flavors to your table',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF8E9BAE), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// WHATSAPP FLOATING BUTTON
// ============================================================

class WhatsAppFloatingButton extends StatefulWidget {
  final String phoneNumber;
  final String defaultMessage;

  const WhatsAppFloatingButton({
    super.key,
    this.phoneNumber = '919403183903',
    this.defaultMessage =
        'Hello Agarwal Foods! I would like to inquire about your products.',
  });

  @override
  State<WhatsAppFloatingButton> createState() => _WhatsAppFloatingButtonState();
}

class _WhatsAppFloatingButtonState extends State<WhatsAppFloatingButton> {
  bool _isHovered = false;

  Future<void> _openWhatsApp() async {
    final encodedMessage = Uri.encodeComponent(widget.defaultMessage);
    final urlString =
        'https://wa.me/${widget.phoneNumber}?text=$encodedMessage';
    final uri = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Could not launch WhatsApp URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, right: 8.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: 'Chat with us on WhatsApp',
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: AnimatedScale(
            scale: _isHovered ? 1.08 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              elevation: _isHovered ? 8 : 4,
              shadowColor: const Color(0x6625D366),
              child: InkWell(
                onTap: _openWhatsApp,
                customBorder: const CircleBorder(),
                splashColor: Colors.white.withValues(alpha: 0.3),
                highlightColor: Colors.white.withValues(alpha: 0.15),
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF25D366), Color(0xFF1EBE5D)],
                    ),
                  ),
                  child: Center(
                    child: CustomPaint(
                      size: const Size(32, 32),
                      painter: const WhatsAppIconPainter(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WhatsAppIconPainter extends CustomPainter {
  final Color color;

  const WhatsAppIconPainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.scale(scale, scale);

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    // Speech bubble outline
    final bubblePath = Path();
    bubblePath.moveTo(12.007, 2.0);
    bubblePath.cubicTo(6.486, 2.0, 2.0, 6.486, 2.0, 12.007);
    bubblePath.cubicTo(2.0, 13.771, 2.46, 15.429, 3.264, 16.877);
    bubblePath.lineTo(2.0, 22.0);
    bubblePath.lineTo(7.241, 20.627);
    bubblePath.cubicTo(8.643, 21.499, 10.274, 22.014, 12.007, 22.014);
    bubblePath.cubicTo(17.528, 22.014, 22.014, 17.528, 22.014, 12.007);
    bubblePath.cubicTo(22.014, 6.486, 17.528, 2.0, 12.007, 2.0);
    bubblePath.close();

    // Phone handset path inside bubble
    final phonePath = Path();
    phonePath.moveTo(17.472, 14.382);
    phonePath.cubicTo(17.171, 14.232, 15.692, 13.503, 15.416, 13.403);
    phonePath.cubicTo(15.14, 13.303, 14.939, 13.253, 14.738, 13.553);
    phonePath.cubicTo(14.538, 13.853, 13.96, 14.533, 13.784, 14.733);
    phonePath.cubicTo(13.609, 14.933, 13.433, 14.958, 13.132, 14.808);
    phonePath.cubicTo(12.831, 14.658, 11.859, 14.339, 10.708, 13.312);
    phonePath.cubicTo(9.812, 12.513, 9.207, 11.525, 9.031, 11.224);
    phonePath.cubicTo(8.856, 10.923, 9.012, 10.76, 9.163, 10.61);
    phonePath.cubicTo(9.299, 10.475, 9.464, 10.259, 9.615, 10.083);
    phonePath.cubicTo(9.765, 9.908, 9.815, 9.782, 9.915, 9.582);
    phonePath.cubicTo(10.015, 9.382, 9.965, 9.206, 9.89, 9.056);
    phonePath.cubicTo(9.815, 8.906, 9.212, 7.421, 8.961, 6.815);
    phonePath.cubicTo(8.717, 6.225, 8.468, 6.305, 8.283, 6.295);
    phonePath.lineTo(7.705, 6.285);
    phonePath.cubicTo(7.505, 6.285, 7.179, 6.36, 6.903, 6.661);
    phonePath.cubicTo(6.627, 6.962, 5.85, 7.69, 5.85, 9.17);
    phonePath.cubicTo(5.85, 10.65, 6.929, 12.08, 7.08, 12.281);
    phonePath.cubicTo(7.23, 12.481, 9.204, 15.524, 12.225, 16.827);
    phonePath.cubicTo(12.944, 17.137, 13.505, 17.322, 13.943, 17.461);
    phonePath.cubicTo(14.665, 17.691, 15.322, 17.658, 15.843, 17.581);
    phonePath.cubicTo(16.423, 17.494, 17.623, 16.854, 17.874, 16.151);
    phonePath.cubicTo(18.124, 15.449, 18.124, 14.848, 18.049, 14.721);
    phonePath.cubicTo(17.974, 14.595, 17.773, 14.52, 17.472, 14.382);
    phonePath.close();

    canvas.drawPath(bubblePath, strokePaint);
    canvas.drawPath(phonePath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
