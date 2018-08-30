From: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com (syzbot)
Date: Wed, 29 Aug 2018 20:43:03 -0700
Subject: WARNING in apparmor_secid_to_secctx
In-Reply-To: <000000000000c178e305749daba4@google.com>
Message-ID: <0000000000004a164f05749edfba@google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16662cb6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f20a96400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10efd7bc400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+21016130b0580a9de3b5 at syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
------------[ cut here ]------------
AppArmor WARN apparmor_secid_to_secctx: ((!secdata)):
WARNING: CPU: 0 PID: 4682 at security/apparmor/secid.c:82  
apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4682 Comm: syz-executor028 Not tainted 4.19.0-rc1+ #193
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
Code: c7 c7 40 66 58 87 e8 6a 6d 0f fe 0f 0b e9 6c fe ff ff e8 3e aa 44 fe  
48 c7 c6 80 67 58 87 48 c7 c7 a0 65 58 87 e8 4b 6d 0f fe <0f> 0b e9 3f fe  
ff ff 48 89 df e8 fc a7 83 fe e9 ed fe ff ff bb f4
RSP: 0018:ffff8801ba5a6d10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8801ba5a6ed0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8163ac01 RDI: 0000000000000001
RBP: ffff8801ba5a6d30 R08: ffff8801d9ba2580 R09: ffffed003b603eca
R10: ffffed003b603eca R11: ffff8801db01f657 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801ba5a6ed0
  security_secid_to_secctx+0x63/0xc0 security/security.c:1314
  ctnetlink_secctx_size net/netfilter/nf_conntrack_netlink.c:621 [inline]
  ctnetlink_nlmsg_size net/netfilter/nf_conntrack_netlink.c:659 [inline]
  ctnetlink_conntrack_event+0x303/0x1470  
net/netfilter/nf_conntrack_netlink.c:706
  nf_conntrack_eventmask_report+0x55f/0x930  
net/netfilter/nf_conntrack_ecache.c:151
  nf_conntrack_event_report include/net/netfilter/nf_conntrack_ecache.h:112  
[inline]
  nf_ct_delete+0x33c/0x5d0 net/netfilter/nf_conntrack_core.c:601
  nf_ct_iterate_cleanup+0x48c/0x5e0 net/netfilter/nf_conntrack_core.c:1892
  nf_ct_iterate_cleanup_net+0x23c/0x2d0  
net/netfilter/nf_conntrack_core.c:1974
  ctnetlink_flush_conntrack net/netfilter/nf_conntrack_netlink.c:1226  
[inline]
  ctnetlink_del_conntrack+0x66c/0x850  
net/netfilter/nf_conntrack_netlink.c:1258
  nfnetlink_rcv_msg+0xd88/0x1070 net/netfilter/nfnetlink.c:228
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  nfnetlink_rcv+0x1c0/0x4d0 net/netfilter/nfnetlink.c:560
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
  __sys_sendmsg+0x11d/0x290 net/socket.c:2152
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg net/socket.c:2159 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441189
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc388e2108 EFLAGS: 00000217 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441189
RDX: 0000000000000000 RSI: 0000000020d65000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004020d0
R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
