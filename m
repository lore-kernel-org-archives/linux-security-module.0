From: lists@kaiser.cx (Martin Kaiser)
Date: Sat, 8 Sep 2018 15:13:12 +0200
Subject: next-20180906 crashes during ubifs_mount (legacy fs_context)
Message-ID: <20180908131312.eob2glzykvq5w7dd@viti.kaiser.cx>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Dear all,

I'd like to report an issue that seems to be related to fs_context or security.
Starting from next-20180906, ubifs_mounts are crashing the kernel.
next-20180905 is ok,

[root at host ]# mount /mnt/test/
[   15.793240] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   15.805283] pgd = c62320c4
[   15.808141] [00000000] *pgd=92963831, *pte=00000000, *ppte=00000000
[   15.814510] Internal error: Oops: 17 [#1] ARM
[   15.818903] Modules linked in:
[   15.822025] CPU: 0 PID: 163 Comm: mount Tainted: G        W         4.19.0-rc2-next-20180907+ #2015
[   15.831099] Hardware name: Freescale i.MX25 (Device Tree Support)
[   15.837261] PC is at ubifs_mount+0x58/0x654
[   15.841489] LR is at ubifs_mount+0x50/0x654
[   15.845707] pc : [<c017f204>]    lr : [<c017f1fc>]    psr: 20000013
[   15.852006] sp : d29b3e78  ip : d29b3e78  fp : d29b3eb4
[   15.857258] r10: c18232e8  r9 : 00000000  r8 : c17f7028
[   15.862514] r7 : 00008000  r6 : c18232e8  r5 : d3be5f80  r4 : 00000000
[   15.869071] r3 : 00000000  r2 : 13fd740b  r1 : 00000001  r0 : ffffffea
[   15.875630] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   15.882797] Control: 0005317f  Table: 92974000  DAC: 00000051
[   15.888587] Process mount (pid: 163, stack limit = 0x2780be82)
[   15.894457] Stack: (0xd29b3e78 to 0xd29b4000)
[   15.898853] 3e60:                                                       13fd740b a0000013
[   15.907085] 3e80: d29251e0 13fd740b d3be5f80 d3be5f80 d3be5f80 00000000 d29251c0 00000000
[   15.915316] 3ea0: 00000000 c18232e8 d29b3edc d29b3eb8 c01108a0 c017f1bc 00000000 d29b3ec8
[   15.923546] 3ec0: c0110ed0 00000020 d3be5f80 00000000 d29b3f04 d29b3ee0 c00e2208 c0110870
[   15.931775] 3ee0: 00000020 d3be5f80 d29b3f04 00000020 d3be5f80 00000000 d29b3f5c d29b3f08
[   15.940004] 3f00: c00ffb10 c00e217c 00000000 00000000 0000000c c17f7028 00001000 d38c1ab0
[   15.948234] 3f20: d3700cc0 d29b3f30 c00bcb38 13fd740b 001ac67e 00008000 d29253c0 d29251c0
[   15.956465] 3f40: 00000000 001ac68a d29b2000 00000000 d29b3f8c d29b3f60 c00ffe84 c00ff478
[   15.964690] 3f60: 00000000 00000000 d29b3f8c 00000000 00000000 001ac694 00000015 c00091e4
[   15.972923] 3f80: d29b3fa4 d29b3f90 c00ffed0 c00ffe10 00000000 bec2ac68 00000000 d29b3fa8
[   15.981152] 3fa0: c0009000 c00ffebc 00000000 00000000 001ac67e 001ac68a 001ac694 00008000
[   15.989378] 3fc0: 00000000 00000000 001ac694 00000015 001ac67e 00008000 001ac478 00000000
[   15.997607] 3fe0: 0137e4e0 bec2ab28 0004cec4 00009d60 60000010 001ac67e 00000000 00000000
[   16.005803] Backtrace:
[   16.008355] [<c017f1ac>] (ubifs_mount) from [<c01108a0>] (legacy_get_tree+0x40/0xf8)
[   16.016159]  r10:c18232e8 r9:00000000 r8:00000000 r7:d29251c0 r6:00000000 r5:d3be5f80
[   16.024016]  r4:d3be5f80
[   16.026632] [<c0110860>] (legacy_get_tree) from [<c00e2208>] (vfs_get_tree+0x9c/0x1b8)
[   16.034590]  r6:00000000 r5:d3be5f80 r4:00000020
[   16.039282] [<c00e216c>] (vfs_get_tree) from [<c00ffb10>] (do_mount+0x6a8/0x7c8)
[   16.046717]  r6:00000000 r5:d3be5f80 r4:00000020
[   16.051392] [<c00ff468>] (do_mount) from [<c00ffe84>] (ksys_mount+0x84/0xac)
[   16.058493]  r10:00000000 r9:d29b2000 r8:001ac68a r7:00000000 r6:d29251c0 r5:d29253c0
[   16.066347]  r4:00008000
[   16.068934] [<c00ffe00>] (ksys_mount) from [<c00ffed0>] (sys_mount+0x24/0x2c)
[   16.076118]  r8:c00091e4 r7:00000015 r6:001ac694 r5:00000000 r4:00000000
[   16.082873] [<c00ffeac>] (sys_mount) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
[   16.090475] Exception stack(0xd29b3fa8 to 0xd29b3ff0)
[   16.095574] 3fa0:                   00000000 00000000 001ac67e 001ac68a 001ac694 00008000
[   16.103801] 3fc0: 00000000 00000000 001ac694 00000015 001ac67e 00008000 001ac478 00000000
[   16.112013] 3fe0: 0137e4e0 bec2ab28 0004cec4 00009d60
[   16.117117] Code: e3a01001 eb0567ec e3700a01 9a00003f (e5d43000)
[   16.123729] ---[ end trace 74eabff63854bbfa ]---

This is how far I got when trying to track down the issue:

ubifs_mount() is called with name==NULL

legacy_get_tree() sets the name parameter to fc->source when it calls the mount function.

Before this, vfs_parse_fs_param() is called with param->key=="source"
  ret = security_fs_context_parse_param(fc, param);                            
  -> this returns 0

  and we exit here
  if (ret != -ENOPARAM)                                                        
      /* Param belongs to the LSM or is disallowed by the LSM; so               
       * don't pass to the FS.                                                  
       */                                                                       
      return ret;                                                               

  before the legacy fs context's parse_param method is called
  if (fc->ops->parse_param) {                                                  
      ret = fc->ops->parse_param(fc, param);                                    
  ...

I have CONFIG_SECURITY disabled. Enabling it does not change the behaviour.

Commenting out the -ENOPARAM check makes the mount work again.

I'm not sure how to fix this.
Is it ok for security_fs_context_parse_param() to return 0 when CONFIG_SECURITY
is turned off? Shouldn't this be -ENOPARAM, meaning "not a parameter I
care about"?

Best regards,
Martin
