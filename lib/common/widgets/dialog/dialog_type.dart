enum DialogType {
  information('Information'),
  warning('Warning'),
  confirmation('Confirmation'),
  informationWithAction('Information');

  final String title;

  const DialogType(this.title);
}
