let
  m1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMgXB7v8UmgXtvespZsO7zmDfL+7iBiMgKVjAtLswNYd lucas.summers.dev@gmail.com";
  m5 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJmnvWIaW7vq5vxHzgRjN0p6DY50COjl+06q8+QP3NEH lucas.summers.dev@gmail.com";
in {
  "gpg_priv.asc.age".publicKeys = [ m1 m5 ];
  "gpg_pub.asc.age".publicKeys  = [ m1 m5 ];
}
