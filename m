From: dvyukov@google.com (Dmitry Vyukov)
Date: Fri, 28 Sep 2018 10:39:40 +0200
Subject: KASAN: global-out-of-bounds Read in __aa_lookupn_ns
In-Reply-To: <CACT4Y+YAbon-m=N-UcEVfGj8DxgRAySQz7qLYQWFxQZqv+3JhA@mail.gmail.com>
References: <000000000000a7487d0576c18693@google.com>
	<CACT4Y+YAbon-m=N-UcEVfGj8DxgRAySQz7qLYQWFxQZqv+3JhA@mail.gmail.com>
Message-ID: <CACT4Y+ZP3bFBZ7Omjn7e78ibfCNAFriMpmPut5P38Ex_aGcJHQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 26, 2018 at 12:06 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 26, 2018 at 9:54 AM, syzbot
> <syzbot+71b6643475f707f93fdc@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    02214bfc89c7 Merge tag 'media/v4.19-2' of git://git.kernel..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1456f8a1400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=71b6643475f707f93fdc
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>
> Again misattributed to net. This misattribution should now be fixed by:
> https://github.com/google/syzkaller/commit/db716d6653d073b0abfb51186cd4ac2d5418c9c6
> Adding security/apparmor/policy_ns.c maintainers explicitly.

This is the same as "KASAN: stack-out-of-bounds Read in __aa_lookupn_ns":
https://syzkaller.appspot.com/bug?id=f0d603856d8b3cc9b8e09228f2f548c18ef907ac
right?

>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+71b6643475f707f93fdc at syzkaller.appspotmail.com
>>
>>  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3038
>>  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
>>  __do_sys_setsockopt net/socket.c:1913 [inline]
>>  __se_sys_setsockopt net/socket.c:1910 [inline]
>>  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>> ==================================================================
>> BUG: KASAN: global-out-of-bounds in memcmp+0xe3/0x160 lib/string.c:861
>> Read of size 1 at addr ffffffff88000008 by task syz-executor0/10914
>>
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x457579
>> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f4c14533c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
>> RAX: ffffffffffffffda RBX: 00007f4c14533c90 RCX: 0000000000457579
>> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
>> RBP: 000000000072bf00 R08: 0000000000000004 R09: 0000000000000000
>> R10: 0000000020000080 R11: 0000000000000246 R12: 00007f4c145346d4
>> R13: 00000000004c3ed9 R14: 00000000004d6260 R15: 0000000000000004
>> CPU: 0 PID: 10914 Comm: syz-executor0 Not tainted 4.19.0-rc5+ #252
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>  print_address_description.cold.8+0x58/0x1ff mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>>  memcmp+0xe3/0x160 lib/string.c:861
>>  strnstr+0x4b/0x70 lib/string.c:934
>>  __aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
>>  aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
>>  aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
>>  fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
>>  aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
>>  aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
>>  aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
>>  apparmor_setprocattr+0xa8b/0x1150 security/apparmor/lsm.c:656
>>  security_setprocattr+0x66/0xc0 security/security.c:1298
>>  proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
>>  __vfs_write+0x119/0x9f0 fs/read_write.c:485
>>  vfs_write+0x1fc/0x560 fs/read_write.c:549
>>  ksys_write+0x101/0x260 fs/read_write.c:598
>>  __do_sys_write fs/read_write.c:610 [inline]
>>  __se_sys_write fs/read_write.c:607 [inline]
>>  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x457579
>> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f5a92ec2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
>> RDX: 000000000000002c RSI: 00000000200000c0 RDI: 0000000000000004
>> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5a92ec36d4
>> R13: 00000000004c5454 R14: 00000000004d8c78 R15: 00000000ffffffff
>>
>> CPU: 1 PID: 10921 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #252
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> The buggy address belongs to the variable:
>>  __start_rodata+0x8/0x1000
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>
>> Memory state around the buggy address:
>>  ffffffff87ffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  ffffffff87ffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  fail_dump lib/fault-inject.c:51 [inline]
>>  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
>>>
>>> ffffffff88000000: 00 fa fa fa fa fa fa fa 00 01 fa fa fa fa fa fa
>>
>>                       ^
>>  ffffffff88000080: 00 00 00 07 fa fa fa fa 00 04 fa fa fa fa fa fa
>>  ffffffff88000100: 05 fa fa fa fa fa fa fa 00 00 00 00 05 fa fa fa
>> ==================================================================
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller at googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
