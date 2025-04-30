import 'package:flutter/material.dart';

@immutable
class UpApiExtraColors extends ThemeExtension<UpApiExtraColors> {

  const UpApiExtraColors({
    required this.success,
    required this.onSuccess,
    required this.attention,
    required this.attentionBackground,
  });
  final Color success;
  final Color onSuccess;
  final Color attention;
  final Color attentionBackground;

  @override
  UpApiExtraColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? attention,
    Color? attentionBackground,
  }) {
    return UpApiExtraColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      attention: attention ?? this.attention,
      attentionBackground: attentionBackground ?? this.attentionBackground,
    );
  }

  @override
  UpApiExtraColors lerp(ThemeExtension<UpApiExtraColors>? other, double t) {
    if (other is! UpApiExtraColors) return this;
    return UpApiExtraColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      attention: Color.lerp(attention, other.attention, t)!,
      attentionBackground: Color.lerp(attentionBackground, other.attentionBackground, t)!,
    );
  }
}