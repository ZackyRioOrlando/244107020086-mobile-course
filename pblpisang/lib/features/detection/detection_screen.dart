import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../core/theme/app_theme.dart';
import 'result_screen.dart';

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key, this.openGalleryOnStart = false});
  final bool openGalleryOnStart;

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  bool _copyingImage = false;

  @override
  void initState() {
    super.initState();
    if (widget.openGalleryOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _pickImage(ImageSource.gallery));
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 90);
      if (picked == null || !mounted) return;
      setState(() => _copyingImage = true);
      final directory = await getApplicationDocumentsDirectory();
      final extension = p.extension(picked.path).isEmpty ? '.jpg' : p.extension(picked.path);
      final savedPath = p.join(directory.path, 'banana_${DateTime.now().millisecondsSinceEpoch}$extension');
      await File(picked.path).copy(savedPath);
      if (!mounted) return;
      setState(() {
        _imagePath = savedPath;
        _copyingImage = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _copyingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal membuka gambar: $error')));
    }
  }

  Future<void> _analyze() async {
    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ambil foto atau pilih gambar terlebih dahulu.')));
      return;
    }
    final saved = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => ResultScreen(imagePath: _imagePath!)));
    if (saved == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hasil simulasi disimpan ke riwayat.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deteksi Grading')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Container(
          height: 300,
          decoration: BoxDecoration(color: const Color(0xFFE9EEE7), borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border)),
          clipBehavior: Clip.antiAlias,
          child: _copyingImage
              ? const Center(child: CircularProgressIndicator())
              : _imagePath == null
                  ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.add_a_photo_outlined, size: 60, color: AppColors.green),
                      SizedBox(height: 12),
                      Text('Pilih foto buah pisang', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      SizedBox(height: 5),
                      Text('Pastikan buah terlihat jelas dan tidak buram.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted)),
                    ])
                  : Image.file(File(_imagePath!), fit: BoxFit.cover, width: double.infinity),
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: _copyingImage ? null : () => _pickImage(ImageSource.camera), icon: const Icon(Icons.camera_alt_outlined), label: const Text('Kamera'), style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48), foregroundColor: AppColors.green))),
          const SizedBox(width: 12),
          Expanded(child: OutlinedButton.icon(onPressed: _copyingImage ? null : () => _pickImage(ImageSource.gallery), icon: const Icon(Icons.photo_library_outlined), label: const Text('Galeri'), style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48), foregroundColor: AppColors.green))),
        ]),
        const SizedBox(height: 20),
        ElevatedButton.icon(onPressed: _copyingImage ? null : _analyze, icon: const Icon(Icons.auto_awesome), label: const Text('Analisis Grading')),
        const SizedBox(height: 15),
        const Text('Catatan: hasil yang ditampilkan masih berupa simulasi UI. Model CNN/TFLite belum terhubung.', style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.muted)),
      ]),
    );
  }
}
