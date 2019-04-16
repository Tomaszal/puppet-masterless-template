class profile::helloworld (
  String $message = 'Default message',
) {
  notify { 'helloworld message':
    message => $message,
  }
}
