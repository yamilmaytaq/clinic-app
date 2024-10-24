import 'package:clinic_app/features/shared/shared.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;

  const CustomAppBar({super.key, this.scaffoldKey, this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;

    return AppBar(
      backgroundColor: primaryColor,
      toolbarHeight: 150,
      leadingWidth: 0,
      leading: Container(),
      iconTheme: const IconThemeData(color: Colors.white),
      title: Container(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => {
                        if (widget.scaffoldKey != null)
                          widget.scaffoldKey!.currentState?.openDrawer()
                      },
                    ),
                    SizedBox(
                      width: size.width * 0.5,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jhamil Eduardo Mayta Quisbert',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              overflow: TextOverflow.clip,
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ],
            ),
            if (widget.title != null) const SizedBox(height: 10),
            if (widget.title != null)
              CustomTitleForScreen(title: widget.title ?? ''),
          ],
        ),
      ),
    );
  }
}
