Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A7201026
	for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342804; cv=none; b=o4ymW27MCOpL0fVQ4yGPPBMYa8/XesPwzqEEIlYw08qhUKGRygNo3q+su73QNJ+3wJWkey+JvssW5DsvGbeZdulIuE51LlDVGTGa+ZWUHHpLVWr85IgRJFHDXZ/XS8uw4TcgP/otSfOc4fUj5+/1r+gnm7DikCs3dY1Q2Ugb2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342804; c=relaxed/simple;
	bh=/MLg2COHMjsZCod1ruY47lBuhT2RIi1o93WT9dXfDFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QrXmnMdYngMUFRKT77cN1MRollrlu45pqBgeVY/h7WgpuAvZg987Rc72WZjf4SeNBGSKZ4f8Uz+3ruPrwcnWqUAsGkIQ93GepLyUJgF02Y8Cw+dYDqtheP3CLQ27Jn4Vuac5+AIkjk0Zq4s6RFgxdn3pdwCYDZ6YuNGXJvapRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844e9b92401so506954939f.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 01:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342802; x=1734947602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjvZ2fR7d5U5v00o1JgKQWfzqz7EVTL2oI8L3s5YqcE=;
        b=m4H5mFN0aKUc0inqdhQfoE2CHW4tkpYM+X9i591c6YGS/Jv5ZIqnSUb7RaMOrddizh
         BZC1ltraVWwbu9PNhfju0W23h0mnzlCesL13JZ3iKfsuuv5tVTW3ZyTGQr/p9nIsOAaM
         OBBIZcMwuqU7H2aKH7SLAK1gmZ2qrNLwpDeDC9J1cKNvh3yRf63ZQFiT4rzYN7Kd7gKu
         ktV4Pl/oUH/jt1p7uyBvCXeG46ZQRsnwdcjggLGgR0ZY35AV59YF2xYigKRBcC8d0Cd4
         iCQkOiErSOKoed9aHLTpYWuadoFWYLHqK2AJ3T2wPvQLMdc+n2k55s4bXdC3zZF8uknR
         8ntQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBauU1AnXRcHUcCiN7EVAQqLJeXaSzNbxPSpE7/VCiZbqNP+BHBxhmvVzOAajEZgd6rQd5sIlcI24k+ve4a3piJ2cR6/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKYJ0I7eDGg/aPd4MSEWCvaEYJdrEVXY1aJwNsmIxMSumkeMx
	ff/qaWEXPW0P5lhjIuiHCr/9KGRdsLgbyc/56bdF3zwoR2c7qcEQAyPFIaG/F7Hbgc17f2WWuNA
	rk05Gwmybs2D5pEtNcZNr3iCEcp01jETGDgN0L9bjUqqPV3VAn5EUOo4=
X-Google-Smtp-Source: AGHT+IG/G6LOhXmDucogI9EtALgmvb5IlZcGI8ijU6zAcBdIy38k5V86u92tZSW75gS8pNoMOQGits6pkg0/WL8Rcz3CXWUwN0OH
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a7:8cc2:9a84 with SMTP id
 e9e14a558f8ab-3aff4619ab5mr123996095ab.5.1734342802382; Mon, 16 Dec 2024
 01:53:22 -0800 (PST)
Date: Mon, 16 Dec 2024 01:53:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff892.050a0220.37aaf.012a.GAE@google.com>
Subject: [syzbot] [tomoyo?] BUG: corrupted list in tomoyo_try_to_gc
From: syzbot <syzbot+e92661ab419d1a81b816@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=132a7b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=e92661ab419d1a81b816
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e92661ab419d1a81b816@syzkaller.appspotmail.com

list_del corruption, ffff8880258fb100->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:52!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 9271 Comm: GC for TOMOYO Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__list_del_entry_valid_or_report+0xea/0x1c0 lib/list_debug.c:52
Code: 0f 85 ae 00 00 00 48 8b 42 08 48 39 c6 75 5f b8 01 00 00 00 48 83 c4 18 c3 cc cc cc cc 48 c7 c7 c0 59 b1 8b e8 67 f9 da fc 90 <0f> 0b 48 c7 c7 20 5a b1 8b e8 58 f9 da fc 90 0f 0b 48 c7 c7 80 5a
RSP: 0018:ffffc900041c7e00 EFLAGS: 00010282
RAX: 0000000000000033 RBX: ffff8880258fb100 RCX: ffffffff8178d119
RDX: 0000000000000000 RSI: ffffffff817978a6 RDI: 0000000000000005
RBP: ffff8880258fb100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff8880258fb110
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555584206808 CR3: 000000007cd4a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 tomoyo_try_to_gc+0x21/0xcd0 security/tomoyo/gc.c:395
 tomoyo_collect_entry security/tomoyo/gc.c:599 [inline]
 tomoyo_gc_thread security/tomoyo/gc.c:619 [inline]
 tomoyo_gc_thread+0xd3b/0x1390 security/tomoyo/gc.c:612
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xea/0x1c0 lib/list_debug.c:52
Code: 0f 85 ae 00 00 00 48 8b 42 08 48 39 c6 75 5f b8 01 00 00 00 48 83 c4 18 c3 cc cc cc cc 48 c7 c7 c0 59 b1 8b e8 67 f9 da fc 90 <0f> 0b 48 c7 c7 20 5a b1 8b e8 58 f9 da fc 90 0f 0b 48 c7 c7 80 5a
RSP: 0018:ffffc900041c7e00 EFLAGS: 00010282
RAX: 0000000000000033 RBX: ffff8880258fb100 RCX: ffffffff8178d119
RDX: 0000000000000000 RSI: ffffffff817978a6 RDI: 0000000000000005
RBP: ffff8880258fb100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff8880258fb110
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555584206808 CR3: 000000007cd4a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
