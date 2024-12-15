Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE56194A6F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734281784; cv=none; b=XwLwdAtCYFL9hkkdYEpI8GhzyvYfFshee5lws1R6FySJC/6EiFhyb7mipOQJrpJUpvU5a7IZg77vuTcGSDQXYv83jQ90Hkou7lKp94CgPSGjdN9bccagKpp8IZB7/+sK0T1TkbjW8T9aEEIuAY3P3lkFzi9N8DGNB6Q5P2xHH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734281784; c=relaxed/simple;
	bh=xqOs6Z+UKyv3MXOR0f6n0k7ckhOjJJq2TXjAboGTMCU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uY/plm6953EM6PF0eh5fmmP0MVCrw/bsbm+5r520zW5XPpHUTqk0nDgduT7kC/VMUVFw8ELcX66JNjd9JUGE5vF526PbZa6/OlmZn3mPyjHykS0JIVEvgOzTlgjj7+bxNsOTdJi5srPT0YLc4jsu+Q/kE9ptQqCVfpNm0Mn6ukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844e9b9233eso183673439f.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 08:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734281782; x=1734886582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jd7/ODe3BJoj9ArJQMpN8NpBbFHmENCWNtUvI7ebTg0=;
        b=cphFmKJee0SiKGvr5xHIw/YuGoZYk2btX7dCJco3tOzJM3+o3T9ZUqrYAYvH1LRsSH
         prCO2otM6IElzIbii06r/NuVAZrQS3MNhVzUE47GEv/AshpmRLekLMqJKiBrMNVxZsDg
         71rv1OBcoRIkoJproWQCgU6RYGS5/osnGpL+J4y/qv3jxLX+tvYhStDbb4dbR0ImEf18
         S9w3VwisVnrU6j4qVLMhFmxxaHM/pXE82hcFRcizMN2HEVq9tqOM4rsEwYTFRweTtUDW
         eUVZT1v+rqkpuxUD0jM+RX79KyQ9QWAdbTkOBY56FXeOHXdmaSyHLE+KnlhQprgYhA3u
         ovJw==
X-Forwarded-Encrypted: i=1; AJvYcCWtuz7QTx51Wf88amKHvHpXE+86q7lRriByBbebkzzwPjI4qOqv0ijpaDKP1ynkXucdFuA8W+TCf4nE/5uNscAwu+Nay84=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgWtN02ge2xQJaIpPoQCVBkYw0wLhVDi83jjYz9AqlwgJM2/X
	n+uTT48ECUvK9RNCHMUEwI3W49oTz8z4IPHUGiEWYMmszBlo4YNMF+Ya3EeSTLWFEzqjIlhzxjn
	N3ZdpnPEcZ2o2+/A/H+xhy2seNyostgMnO3mHkm16zH0BxFHIaRZ9Vek=
X-Google-Smtp-Source: AGHT+IHtRdKWCe/qQaG467EGsSK+O1pVmRjK/naWohM0Ag3073bV9ZGFMuJgm6SUgOMstJU4TkSDZZPuRgr1XNK9JfOzgrUc4ETW
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3aff039a554mr109257625ab.13.1734281782211; Sun, 15 Dec 2024
 08:56:22 -0800 (PST)
Date: Sun, 15 Dec 2024 08:56:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f0a36.050a0220.37aaf.00fc.GAE@google.com>
Subject: [syzbot] [tomoyo?] general protection fault in tomoyo_gc_thread
From: syzbot <syzbot+bf6351831bc4f9148d98@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fa2cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=bf6351831bc4f9148d98
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fc78f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf6351831bc4f9148d98@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 6044 Comm: GC for TOMOYO Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:tomoyo_collect_acl security/tomoyo/gc.c:511 [inline]
RIP: 0010:tomoyo_collect_entry security/tomoyo/gc.c:537 [inline]
RIP: 0010:tomoyo_gc_thread security/tomoyo/gc.c:619 [inline]
RIP: 0010:tomoyo_gc_thread+0x1ab/0x1390 security/tomoyo/gc.c:612
Code: 3b 5c 47 fd c6 45 18 ff 4c 89 ee bf 09 00 00 00 e8 8a f1 ff ff e8 25 5c 47 fd 48 89 d8 48 89 de 49 89 dd 48 c1 e8 03 83 e6 07 <42> 0f b6 0c 20 48 8d 43 07 48 89 c2 48 c1 ea 03 42 0f b6 14 22 40
RSP: 0018:ffffc90003367e78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8451e1ab
RDX: ffff888074e85a00 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff888143b02f00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000b8f R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888025b49b00
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000028642000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_collect_acl security/tomoyo/gc.c:511 [inline]
RIP: 0010:tomoyo_collect_entry security/tomoyo/gc.c:537 [inline]
RIP: 0010:tomoyo_gc_thread security/tomoyo/gc.c:619 [inline]
RIP: 0010:tomoyo_gc_thread+0x1ab/0x1390 security/tomoyo/gc.c:612
Code: 3b 5c 47 fd c6 45 18 ff 4c 89 ee bf 09 00 00 00 e8 8a f1 ff ff e8 25 5c 47 fd 48 89 d8 48 89 de 49 89 dd 48 c1 e8 03 83 e6 07 <42> 0f b6 0c 20 48 8d 43 07 48 89 c2 48 c1 ea 03 42 0f b6 14 22 40
RSP: 0018:ffffc90003367e78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8451e1ab
RDX: ffff888074e85a00 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff888143b02f00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000b8f R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888025b49b00
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b9c4865950 CR3: 0000000029aee000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3b 5c 47 fd          	cmp    -0x3(%rdi,%rax,2),%ebx
   4:	c6 45 18 ff          	movb   $0xff,0x18(%rbp)
   8:	4c 89 ee             	mov    %r13,%rsi
   b:	bf 09 00 00 00       	mov    $0x9,%edi
  10:	e8 8a f1 ff ff       	call   0xfffff19f
  15:	e8 25 5c 47 fd       	call   0xfd475c3f
  1a:	48 89 d8             	mov    %rbx,%rax
  1d:	48 89 de             	mov    %rbx,%rsi
  20:	49 89 dd             	mov    %rbx,%r13
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e6 07             	and    $0x7,%esi
* 2a:	42 0f b6 0c 20       	movzbl (%rax,%r12,1),%ecx <-- trapping instruction
  2f:	48 8d 43 07          	lea    0x7(%rbx),%rax
  33:	48 89 c2             	mov    %rax,%rdx
  36:	48 c1 ea 03          	shr    $0x3,%rdx
  3a:	42 0f b6 14 22       	movzbl (%rdx,%r12,1),%edx
  3f:	40                   	rex


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
