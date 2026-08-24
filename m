Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576A19D07A
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551660; cv=none; b=IvqI8GIiFJMmavu3isGRUWl97dnOkKXzp+rX00wQrE8ac46+ulE+dtHhKrP6e89fv9qfgSwx6Bazueo3Uew1ZXc9TvoYMj3V0XB8AnQ+KRu9vHggeGRcg2L3bVtBqpD3CVVNli7I5OBrrUAQDZOuNCPOEvACnCgX1DKkCQ2MrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551660; c=relaxed/simple;
	bh=m5dZWCpjbhvYafQaBrrqQzzD/JtiPAU/M2+4ynxzODA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G01MS4Yt934BW10D/odGnWK9s+nbOrm8LRXr1y1vQ7zzrakBOAo0A1L9IrTn1c/N9KQVzcI5XOlkY0t1osBPYLRfjA3Fr7eoJ3/PeYpZnE2SNi7uuRideAkJJEdg+Q5WI2uhURL9ds5Lh9k+ZeFijkRsFRLG971lUR719W4KznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e8472960so2199786fac.1
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 23:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787551657; x=1788156457;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZSufcr8EjSGG9TES+EhviFpJfFbdzw3Sg/vtWeKWhc=;
        b=Gh7bqvIF7QABLzrw+OZVlYpQ0XlZSZkgcZwCJXYBDjgLrP0K8YMF2UpAYlbWT2XcuG
         QA56SKy2iaEFmMog/KnvarfEm5DSMuYaSI+73szUJ/gu9yskrnIsvDBy1ThpwYOuQUho
         GApWBZp3FFvvCGgunROYEdciOhEZMZQWYUktzQ/4cVXqF/q7VtWKBS47XdQrgSByhGO/
         9jAbixq/pyKt3pmVpGakNc210NxqKygyei1tgC3uQs3M5tu1sxT67MnMS+i/byV0109p
         ikCBKG2obnZw0jv1VW2CyLyvucjvnpwvC4wy8FdYwjXcPeYBmd0Mtm6ktu9Nl2yYqlH4
         df2Q==
X-Forwarded-Encrypted: i=1; AHgh+RoiAPWSgZcK697oh4esrkkV7y8TkMVNH4pKV3Z/XX6gAKcSKn9uVTYw/8g5udh4x+PIfu7MYz7R5dl8lZHgr7aaaqdZAjc=@vger.kernel.org
X-Gm-Message-State: AFuF++mOil/1SIz3Cw2yJad4tvrJHfDZIYXjnrb89Q6rlRLu98jAxxEx
	QcDniiZmR0eilyWkflzEzx83etd/J0kXlVUtCPrfWEwAZBVPsTX+0fPz/0o0WjArnXgrqmzXiN3
	62rFEEi8peGtwZSd8F8Zna8bvwgG5i6bnC7hanpAEX1e2FKqG/TUvGwyQH0o=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:24f:b0:6a3:1dc5:3570 with SMTP id
 006d021491bc7-6b15944b2cemr16703682eaf.31.1787551657632; Sun, 23 Aug 2026
 23:07:37 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:07:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8bdfa9.dbb3a75c.13dd47.0062.GAE@google.com>
Subject: [syzbot] [apparmor?] WARNING in aa_policy_destroy
From: syzbot <syzbot+faed97c4ed43bfe7fee5@syzkaller.appspotmail.com>
To: apparmor@lists.ubuntu.com, georgia.garcia@canonical.com, jmorris@namei.org, 
	john.johansen@canonical.com, john@apparmor.net, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d2ed026f031 Merge tag 'sysctl-7.03-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17516549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e414d6e0a79e71d
dashboard link: https://syzkaller.appspot.com/bug?extid=faed97c4ed43bfe7fee5
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16120415580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9d2ed026.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/89c0c0c0f535/vmlinux-9d2ed026.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80d7adeb0e7d/bzImage-9d2ed026.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+faed97c4ed43bfe7fee5@syzkaller.appspotmail.com

 </TASK>
------------[ cut here ]------------
AppArmor WARN aa_policy_destroy: (((!list_empty(&policy->profiles) && (&policy->profiles)->prev != ((void *) 0x122 + (0xdead000000000000UL))))): 
WARNING: security/apparmor/lib.c:509 at aa_policy_destroy+0x164/0x1b0 security/apparmor/lib.c:509, CPU#0: syz.0.17/5541
Modules linked in:
CPU: 0 UID: 0 PID: 5541 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:aa_policy_destroy+0x16b/0x1b0 security/apparmor/lib.c:509
Code: 85 ed 7e 4d e8 96 bc 37 fd 5b 41 5c 41 5e 41 5f 5d e9 19 27 4e 07 cc e8 83 bc 37 fd 48 8d 3d 0c f0 d3 0b 48 c7 c6 a4 eb 38 8e <67> 48 0f b9 3a e9 04 ff ff ff e8 66 bc 37 fd 48 8d 3d ff ef d3 0b
RSP: 0018:ffffc9000345eaa0 EFLAGS: 00010293
RAX: ffffffff848f530d RBX: ffff88803f734800 RCX: ffff88801af2a580
RDX: 0000000000000000 RSI: ffffffff8e38eba4 RDI: ffffffff90634320
RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff1d95913 R12: dead000000000122
R13: ffff88803f734800 R14: ffff88803f734828 R15: dffffc0000000000
FS:  00007f5f6a1836c0(0000) GS:ffff88808c519000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d02407b048 CR3: 0000000012aa9000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 aa_free_profile+0x9d/0x9f0 security/apparmor/policy.c:334
 aa_alloc_profile+0x1e4/0x3e0 security/apparmor/policy.c:416
 unpack_profile security/apparmor/policy_unpack.c:1153 [inline]
 aa_unpack+0x17db/0x7430 security/apparmor/policy_unpack.c:1748
 aa_replace_profiles+0x226/0x2a20 security/apparmor/policy.c:1183
 policy_update+0x234/0x4a0 security/apparmor/apparmorfs.c:505
 profile_load+0x1cb/0x320 security/apparmor/apparmorfs.c:522
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f6939e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5f6a183028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5f69625fa0 RCX: 00007f5f6939e0d9
RDX: 0000000000000041 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f5f6a183090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f5f69626038 R14: 00007f5f69625fa0 R15: 00007ffe23725c18
 </TASK>
----------------
Code disassembly (best guess):
   0:	85 ed                	test   %ebp,%ebp
   2:	7e 4d                	jle    0x51
   4:	e8 96 bc 37 fd       	call   0xfd37bc9f
   9:	5b                   	pop    %rbx
   a:	41 5c                	pop    %r12
   c:	41 5e                	pop    %r14
   e:	41 5f                	pop    %r15
  10:	5d                   	pop    %rbp
  11:	e9 19 27 4e 07       	jmp    0x74e272f
  16:	cc                   	int3
  17:	e8 83 bc 37 fd       	call   0xfd37bc9f
  1c:	48 8d 3d 0c f0 d3 0b 	lea    0xbd3f00c(%rip),%rdi        # 0xbd3f02f
  23:	48 c7 c6 a4 eb 38 8e 	mov    $0xffffffff8e38eba4,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 04 ff ff ff       	jmp    0xffffff38
  34:	e8 66 bc 37 fd       	call   0xfd37bc9f
  39:	48 8d 3d ff ef d3 0b 	lea    0xbd3efff(%rip),%rdi        # 0xbd3f03f


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
