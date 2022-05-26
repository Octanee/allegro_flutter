enum AllegroApiEnvironment {
  allegro('allegro.pl'),
  sandbox('allegro.pl.allegrosandbox.pl');

  const AllegroApiEnvironment(this.path);
  final String path; 
}

