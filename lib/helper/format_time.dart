String formatDuration(int? duration) {
  if (duration == null || duration <= 0) {
    return '';
  }

  final hours = duration ~/ 60;
  final remainingMinutes = duration % 60;

  return '${hours > 0 ? '$hours hour${hours > 1 ? 's' : ''}' : ''}'
      '${hours > 0 && remainingMinutes > 0 ? ' ' : ''}'
      '${remainingMinutes > 0 ? '$remainingMinutes minute${remainingMinutes > 1 ? 's' : ''}' : ''}';
}
