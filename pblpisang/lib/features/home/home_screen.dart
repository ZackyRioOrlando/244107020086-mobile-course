import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../detection/detection_screen.dart';
import '../info/info_screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onNavigate});
  final ValueChanged<int> onNavigate;

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.darkGreen, AppColors.green]),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Expanded(child: Text('Halo, Sahabat Pisang! 👋', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800))),
                    IconButton(onPressed: () => _open(context, const GuideScreen()), icon: const Icon(Icons.notifications_none, color: Colors.white)),
                  ]),
                  const SizedBox(height: 3),
                  const Text('Ayo mulai deteksi kualitas pisangmu.', style: TextStyle(color: Color(0xFFE0EEE2))),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: const Color(0xFFFFF2B3), borderRadius: BorderRadius.circular(22)),
                    child: Row(children: [
                      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Grading Pisang\nLebih Mudah\nDengan AI', style: TextStyle(fontSize: 19, height: 1.25, fontWeight: FontWeight.w900, color: AppColors.darkGreen)),
                        SizedBox(height: 12),
                        Text('Mulai periksa kualitas visual buah.', style: TextStyle(fontSize: 12, color: AppColors.darkGreen)),
                      ])),
                      const Text('🍌', style: TextStyle(fontSize: 62)),
                    ]),
                  ),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              sliver: SliverList(delegate: SliverChildListDelegate([
                Row(children: [
                  Expanded(child: _ActionCard(icon: Icons.camera_alt_rounded, label: 'Ambil Foto', subtitle: 'Pakai kamera', onTap: () => _open(context, const DetectionScreen()))),
                  const SizedBox(width: 12),
                  Expanded(child: _ActionCard(icon: Icons.photo_library_rounded, label: 'Pilih Galeri', subtitle: 'Foto tersimpan', onTap: () => _open(context, const DetectionScreen(openGalleryOnStart: true)))),
                ]),
                const SizedBox(height: 26),
                const Text('Kategori Grade', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.text)),
                const SizedBox(height: 12),
                Row(children: const [
                  Expanded(child: _GradeCard(grade: 'A', label: 'Kualitas baik', color: Color(0xFF247A3E), emoji: '🍌')),
                  SizedBox(width: 10),
                  Expanded(child: _GradeCard(grade: 'B', label: 'Cukup baik', color: Color(0xFFE7A900), emoji: '🍌')),
                  SizedBox(width: 10),
                  Expanded(child: _GradeCard(grade: 'C', label: 'Kurang layak', color: Color(0xFFC94343), emoji: '🍌')),
                ]),
                const SizedBox(height: 26),
                const Text('Tips foto yang baik', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.text)),
                const SizedBox(height: 10),
                Card(child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Color(0xFFE8F4E8), child: Icon(Icons.lightbulb_outline, color: AppColors.green)),
                  title: const Text('Gunakan cahaya yang cukup', style: TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: const Text('Foto satu objek pisang dengan latar yang sederhana.'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _open(context, const GuideScreen()),
                )),
                const SizedBox(height: 12),
                OutlinedButton.icon(onPressed: () => onNavigate(1), icon: const Icon(Icons.history), label: const Text('Lihat Riwayat Deteksi')),
              ])),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.label, required this.subtitle, required this.onTap});
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            child: Column(children: [
              CircleAvatar(radius: 23, backgroundColor: AppColors.green, child: Icon(icon, color: Colors.white)),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
            ]),
          ),
        ),
      );
}

class _GradeCard extends StatelessWidget {
  const _GradeCard({required this.grade, required this.label, required this.color, required this.emoji});
  final String grade;
  final String label;
  final Color color;
  final String emoji;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
          child: Column(children: [
            Text(emoji, style: const TextStyle(fontSize: 27)),
            const SizedBox(height: 7),
            Text('Grade $grade', style: TextStyle(color: color, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, fontSize: 10)),
          ]),
        ),
      );
}
