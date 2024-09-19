Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BA19DF4C
	for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752205; cv=none; b=CL0tcAgMlUt7TQP0kyxIjNCYFQyOqI4fyS9VGAzAxjwlGm/jyGhuJDCXODVGHMEb+AS4YU0jSGqsZ16fqNWhcDIH3Br5ddfN5rim+A7tdXtU3EYgT7vcpd6Xc/B1UyTQUMwsc/ujKjtsUtQw3lzYqRYLmAmfGSzifHxplAsyO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752205; c=relaxed/simple;
	bh=3FGaCfX4LwTPenS9duS/r2Obpl7fl3uhKds5iAuINr4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NrVPR5H4tR9tKvRtJ+4IW9WRzgvq7OeNxmQUtCbgovw55ksMsrtKYWmwtfcBdwGH3ykYHsjyortd4h4S9QZE7EPB5/eaRnuN8np99HtCvGZaG9gknvXi7ZigW8S54bbNomHj8S9XNXxBKajZ32ENrr7f3LJeRv+0DApv4bfoF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cedb7a183so114771239f.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 06:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726752203; x=1727357003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCv3f/sfQGVFfOP6CGznLTW/Qm9t9FwoZJNLbppMWAA=;
        b=KYhLWemX6c5HxZ+qbkNyA8pkatpts0jjgUPb1kIMl6KUAB0NVoz0QL0sb7cRDKXzws
         4bNUe1ABFgFruleg/JgMi/Ip/yi/o68oqu1jazLyCXg3Iczu8ysRNsJaL0I9bQLU6JFt
         uEDdyXCUfoXzxuVjPQGiWfYrsa4Hp9AMA8BHJKUvP++IJKeopaIEtqIqi2fi0wshRTrI
         RlyjmlybYvZgBVnwrAf5df0k1mKiL66Sp/bBklXBO/04pR32P2kI9/Ceh1Q7ON6wXKrx
         Q/EKdrZf4n7Vr2N9eSb/vklhFaoZRblfioHfVwHvL2pOn17WCvpedIBkUxeh7PkFt9cH
         lVrA==
X-Forwarded-Encrypted: i=1; AJvYcCXFa4MH74iYBxs8JF+LVhFkSWWh1aRTkBzu5NUhHupRVzstJpMxAJhAXN3QgPkvAuaOnhJ9ZAWC3Zmlu5KWLjrkONG1YtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ46bCzjvY4Jfws7daxZ4CKIJ/cjLQhNwnteqi6u8M0c3D7jzz
	knBngO1wjYnh/ey0HMZPYG/tHfrTFnSujt0m0Z2zgcmFVuFpu09pRR3+6LygTze1yLqojToMx6z
	KjD9XxHe4lSffGadXtnEItP6M7Hj083aCWF1tkuDICx+CzmKPiFSjrVY=
X-Google-Smtp-Source: AGHT+IEu8uV9pGjcnDk9OZPztGF+3QV5lWRhA6+41vXfBEK90s1XVMUdRVi8Si6uTNFJrzzFUsYoftA0aa4Qs88pYupJnE7huPhR
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b12:b0:82c:d966:6bf7 with SMTP id
 ca18e2360f4ac-82d1f8d1356mr3373782039f.6.1726752203254; Thu, 19 Sep 2024
 06:23:23 -0700 (PDT)
Date: Thu, 19 Sep 2024 06:23:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec25cb.050a0220.92ef1.001e.GAE@google.com>
Subject: [syzbot] [audit?] general protection fault in smack_log_callback
From: syzbot <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, casey@schaufler-ca.com, eparis@redhat.com, 
	jmorris@namei.org, john.johansen@canonical.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bdf56c7580d2 Merge tag 'slab-for-6.12' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12584b00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4540f5bcdd31e3de
dashboard link: https://syzkaller.appspot.com/bug?extid=044fdf24e96093584232
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155cffc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ad24a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cec9f3c675f1/disk-bdf56c75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21e06ae5b159/vmlinux-bdf56c75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e936c954b8b/bzImage-bdf56c75.xz

The issue was bisected to:

commit 5f8d28f6d7d568dbbc8c5bce94894474c07afd4f
Author: Casey Schaufler <casey@schaufler-ca.com>
Date:   Wed Jul 10 21:32:26 2024 +0000

    lsm: infrastructure management of the key security blob

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1124d69f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1324d69f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1524d69f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security blob")

Oops: general protection fault, probably for non-canonical address 0xe006eb2e8e85e5c5: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x00377974742f2e28-0x00377974742f2e2f]
CPU: 0 UID: 3327 PID: 5215 Comm: syz-executor393 Not tainted 6.11.0-syzkaller-04744-gbdf56c7580d2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
RSP: 0018:ffffc9000399f838 EFLAGS: 00010207
RAX: 0006ef2e8e85e5c5 RBX: 00377974742f2e2e RCX: ffff888027135a00
RDX: 0000000000000000 RSI: 00377974742f2e2e RDI: 00377974742f2e2e
RBP: 00000000fffffff3 R08: ffffffff897a37ca R09: 3d7463656a626f20
R10: dffffc0000000000 R11: ffffed10050c4e0d R12: ffffffffffffffff
R13: ffff888027135a00 R14: 00377974742f2e2e R15: dffffc0000000000
FS:  0000555591989380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020caaffb CR3: 0000000024a90000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 audit_log_untrustedstring+0x25/0x1b0 kernel/audit.c:2135
 smack_log_callback+0x105/0x1b0 security/smack/smack_access.c:321
 common_lsm_audit+0xfd/0x1b30 security/lsm_audit.c:456
 smack_log+0x421/0x540 security/smack/smack_access.c:383
 smk_access+0x4a4/0x4e0 security/smack/smack_access.c:199
 smack_watch_key+0x2f4/0x3a0 security/smack/smack_lsm.c:4656
 security_watch_key+0x86/0x250 security/security.c:4448
 keyctl_watch_key+0x2b7/0x480 security/keys/keyctl.c:1813
 __do_sys_keyctl security/keys/keyctl.c:2021 [inline]
 __se_sys_keyctl+0x106/0xa50 security/keys/keyctl.c:1874
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f384e02daf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd63c63ed8 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f384e02daf9
RDX: 0000000000000004 RSI: 000000000adcda0f RDI: 0000000000000020
RBP: 00007f384e0a05f0 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
RSP: 0018:ffffc9000399f838 EFLAGS: 00010207
RAX: 0006ef2e8e85e5c5 RBX: 00377974742f2e2e RCX: ffff888027135a00
RDX: 0000000000000000 RSI: 00377974742f2e2e RDI: 00377974742f2e2e
RBP: 00000000fffffff3 R08: ffffffff897a37ca R09: 3d7463656a626f20
R10: dffffc0000000000 R11: ffffed10050c4e0d R12: ffffffffffffffff
R13: ffff888027135a00 R14: 00377974742f2e2e R15: dffffc0000000000
FS:  0000555591989380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020caaffb CR3: 0000000024a90000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	fa                   	cli
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 54                	push   %r12
   7:	53                   	push   %rbx
   8:	49 89 fe             	mov    %rdi,%r14
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  19:	fc ff df
  1c:	48 89 fb             	mov    %rdi,%rbx
  1f:	49 89 c4             	mov    %rax,%r12
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 12                	jne    0x44
  32:	48 ff c3             	inc    %rbx
  35:	49 8d 44 24 01       	lea    0x1(%r12),%rax
  3a:	43                   	rex.XB
  3b:	80                   	.byte 0x80
  3c:	7c 26                	jl     0x64
  3e:	01                   	.byte 0x1


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
