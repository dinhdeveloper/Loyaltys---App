String formatVND(num amount) {
  return amount.toStringAsFixed(0).replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => ',',
  );
}

double getSoldRatio(int? soldCount, {int max = 2000}) {
  return ((soldCount ?? max).toDouble() / max).clamp(0.0, 1.0);
}
