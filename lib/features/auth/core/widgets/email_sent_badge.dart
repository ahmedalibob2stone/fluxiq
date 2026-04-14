import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailSentBadge extends StatelessWidget {
  final String email;

  const EmailSentBadge({required this.email});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final iconContainer = size.width * 0.24;
    final mainIcon = size.width * 0.112;
    final checkSize = size.width * 0.08;
    final checkIcon = size.width * 0.043;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: iconContainer,
              height: iconContainer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33667EEA),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.mark_email_read_rounded,
                color: Colors.white,
                size: mainIcon,
              ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                width: checkSize,
                height: checkSize,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x334CAF50),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: checkIcon,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.022),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.053,
            vertical: size.height * 0.012,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF667EEA).withOpacity(0.15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.email_outlined,
                size: size.width * 0.043,
                color: const Color(0xFF667EEA).withOpacity(0.7),
              ),
              SizedBox(width: size.width * 0.021),
              Flexible(
                child: Text(
                  email,
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF667EEA),
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.01),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: size.width * 0.037,
              color: Colors.green.shade600,
            ),
            SizedBox(width: size.width * 0.01),
            Text(
              'Reset link sent successfully',
              style: TextStyle(
                fontSize: size.width * 0.032,
                fontWeight: FontWeight.w500,
                color: Colors.green.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}