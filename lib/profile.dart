import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/images/mohammed.abu.shuqair.jpg'),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Mohammed Abu Shuqair",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Flutter Developer",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 24,
              ),
              Item(
                title: '0592509703',
                icon: Icons.phone,
              ),
              const SizedBox(
                height: 14,
              ),
              Item(
                title: 'eng.mohamed.shuqair@gmail.com',
                icon: Icons.mail,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
