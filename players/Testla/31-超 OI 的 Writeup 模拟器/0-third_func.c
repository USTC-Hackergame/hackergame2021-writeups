ulong FUN_00101160(ulong param_1,ulong param_2,ulong param_3,ulong param_4)

{
  ulong uVar1;
  ulong local_48;
  ulong local_40;
  ulong local_38;
  
  local_40 = param_1 ^ param_2;
  local_48 = param_3;
  local_38 = param_4;
LAB_00101230:
  while ((long)local_40 < <Redacted>) {
    if ((long)local_40 < -<Redacted>) {
      if (local_40 == <Redacted>) {
        local_40 = <Redacted>;
      }
      else {
        if (local_40 != <Redacted>) goto LAB_001011e2;
        local_40 = <Redacted>;
        local_48 = (local_48 ^ local_38) * local_38;
      }
    }
    else {
      if (local_40 != <Redacted>) {
        if (local_40 == <Redacted>) {
          return local_48;
        }
        goto LAB_001011e2;
      }
      local_40 = <Redacted>;
      local_48 = (local_48 ^ local_38) & local_38;
    }
  }
  if ((long)local_40 < <Redacted>) {
    if (local_40 == <Redacted>) {
      local_40 = <Redacted>;
      local_48 = local_48 ^ local_38;
      goto LAB_00101230;
    }
    if (local_40 == <Redacted>) {
      local_40 = <Redacted>;
      local_48 = local_48 + local_38;
      goto LAB_00101230;
    }
  }
  else {
    if (local_40 == <Redacted>) {
      local_40 = <Redacted>;
      local_48 = local_48 ^ local_38 | local_38;
      goto LAB_00101230;
    }
    if (local_40 == <Redacted>) {
      local_40 = <Redacted>;
      local_48 = (ulong)((local_38 * -<Redacted> ^ <Redacted> |
                          (local_38 | <Redacted>) ^ <Redacted> |
                         local_48 * <Redacted> ^ <Redacted> |
                         (local_48 | <Redacted>) ^ <Redacted>) != 0);
      goto LAB_00101230;
    }
  }
LAB_001011e2:
  uVar1 = (local_38 ^ <Redacted> | <Redacted>) * local_48;
  local_48 = local_38;
  local_40 = local_40 + <Redacted>;
  local_38 = uVar1;
  goto LAB_00101230;
}
