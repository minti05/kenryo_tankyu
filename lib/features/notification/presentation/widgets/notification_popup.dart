import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:kenryo_tankyu/core/utils/text_with_url.dart';

class NotificationPopup extends StatelessWidget {
  final NotificationContent notification;
  const NotificationPopup({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxHeight: 600),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              notification.isRead
                                  ? const SizedBox.shrink()
                                  : Text(
                                      'NEW',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(Icons.close,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://scontent-nrt1-1.cdninstagram.com/v/t51.29350-15/431784372_937890994216575_8423817026337271904_n.jpg?stp=dst-jpg_e15_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMDgweDcyMC5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UifQ&_nc_ht=scontent-nrt1-1.cdninstagram.com&_nc_cat=103&_nc_ohc=_z7PSDDCSJoQ7kNvgHhDe8f&_nc_gid=19bf89d2afb4486fbc19302979cdc887&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzMxODE3NjUwMTkzMjYyMTAyMw%3D%3D.3-ccb7-5&oh=00_AYBN423lSvhTX_kSQ2figd5SsUKYMO16-DUslCFKLZcvpQ&oe=6773CE4C&_nc_sid=7a9f4b',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                notification.type.icon,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                notification.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${notification.sendAt.month}/${notification.sendAt.day} ${notification.sendAt.hour}:${notification.sendAt.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextWithUrl(
                              text: notification.contents), // text:取得した文字列
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
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
