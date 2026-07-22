import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';

class RiderOtpDialog extends StatefulWidget {
  final String title;
  final String correctOtp;
  final VoidCallback onSuccess;
  final bool isDark;

  const RiderOtpDialog({
    super.key,
    required this.title,
    required this.correctOtp,
    required this.onSuccess,
    required this.isDark,
  });

  @override
  State<RiderOtpDialog> createState() => _RiderOtpDialogState();
}

class _RiderOtpDialogState extends State<RiderOtpDialog> {
  final TextEditingController _otpController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: widget.isDark ? AppTheme.cardDarkElevated : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.shieldCheck, color: AppTheme.primary, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Ask customer/store for OTP: ${widget.correctOtp}",
              style: GoogleFonts.inter(fontSize: 12, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 12),
              decoration: InputDecoration(
                counterText: "",
                hintText: "••••",
                hintStyle: GoogleFonts.poppins(color: const Color(0xFF94A3B8)),
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                style: GoogleFonts.inter(fontSize: 12, color: AppTheme.danger, fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel", style: GoogleFonts.inter(color: const Color(0xFF64748B))),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_otpController.text.trim() == widget.correctOtp) {
                        Navigator.pop(context);
                        widget.onSuccess();
                      } else {
                        setState(() => errorMessage = "Invalid OTP! Hint: ${widget.correctOtp}");
                      }
                    },
                    child: Text("Verify", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
