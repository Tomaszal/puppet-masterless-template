$role = lookup('role')

if ($role != undef) {
  include "role::${role}"
}
