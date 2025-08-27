import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../helpers/consts.dart';
import '../../helpers/functions_helper.dart';
import '../../providers/dark_theme_provider.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    super.key,
    required this.text,
    this.isActive = true,
    required this.onPressed,
    this.widthFromScreen = 0.9,
    this.inProgress = false,
    this.withBorder = false,
    this.btnColor = primaryColor,
    this.txtColor = Colors.white,
    this.radius = 12,
    this.heightFromScreen = 0.05,
    this.horizontalPadding = 25,
    this.icon,
    this.assetIcon,
    this.asset,
    this.borderColor,
    this.assetSizeFromWidth = 0.08,
    this.txtSize = 14,
    this.assetColor,
    this.secondaryAsset,
    this.secondaryIcon,
    this.contentAlignment = MainAxisAlignment.center,
    this.iconSize = 18,
  });

  final String text;
  final bool isActive;
  final double widthFromScreen;
  final bool inProgress;
  final bool withBorder;
  final Color btnColor;
  final Color txtColor;
  final Color? borderColor;
  final Function onPressed;
  final double radius;
  final double heightFromScreen;
  final double horizontalPadding;
  final IconData? icon;
  final String? asset;
  final String? assetIcon;
  final String? secondaryAsset;
  final IconData? secondaryIcon;

  final Color? assetColor;
  final double? assetSizeFromWidth;
  final double txtSize;
  final double iconSize;

  final MainAxisAlignment contentAlignment;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    Size size = MediaQuery.of(context).size;
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeConsumer, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
        child: TapDebouncer(
            cooldown: const Duration(milliseconds: 600),
            onTap: () async {
              if (widget.isActive && !widget.inProgress)
                await widget.onPressed();
            },
            builder: (BuildContext context, TapDebouncerFunc? onTap) {
              return GestureDetector(
                onTap: () {
                  if (widget.isActive || !widget.inProgress && onTap != null) {
                    onTap!();
                  }
                },
                child: Container(
                  width: size.width * widget.widthFromScreen,
                  height: size.height * widget.heightFromScreen,
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? widget.btnColor
                        : withOpacity(widget.btnColor, 0.2),
                    borderRadius: BorderRadius.circular(widget.radius),
                    border: widget.withBorder
                        ? Border.all(
                            color: widget.borderColor != null
                                ? widget.borderColor!
                                : themeListener.isDark
                                    ? lightWihteColor
                                    : widget.txtColor,
                            width: 1)
                        : null,
                  ),
                  child: Center(
                    child: widget.inProgress
                        ? CircularProgressIndicator(
                            color: Colors.white60,
                            backgroundColor: primaryColor,
                          )
                        : Row(
                            mainAxisAlignment: widget.contentAlignment,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              widget.secondaryAsset != null
                                  ? Image.asset(
                                      widget.secondaryAsset!,
                                      color: widget.assetColor ?? null,
                                      width: 20,
                                      height: 20,
                                    )
                                  : Container(),
                              widget.secondaryIcon != null
                                  ? Icon(
                                      widget.secondaryIcon,
                                      color: widget.txtColor,
                                      size: widget.iconSize,
                                    )
                                  : Container(),
                              if (widget.secondaryAsset != null ||
                                  widget.secondaryIcon != null ||
                                  widget.contentAlignment ==
                                      MainAxisAlignment.center)
                                const Spacer(),
                              AutoSizeText(
                                widget.text,
                                maxFontSize: widget.txtSize,
                                style: TextStyle(
                                    color: widget.txtColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              if (widget.icon != null ||
                                  widget.assetIcon != null ||
                                  widget.contentAlignment ==
                                      MainAxisAlignment.center)
                                const Spacer(),
                              widget.assetIcon != null
                                  ? Image.asset(
                                      widget.assetIcon!,
                                      color:
                                          widget.assetColor ?? widget.txtColor,
                                      width: 20,
                                      height: 20,
                                    )
                                  : Container(),
                              widget.icon != null
                                  ? Icon(
                                      widget.icon,
                                      color: widget.txtColor,
                                      size: widget.iconSize,
                                    )
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
