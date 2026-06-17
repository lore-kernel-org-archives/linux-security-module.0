Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADD39C012
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685697; cv=none; b=odPzdv7SpiJKTZnEa+7OymUgXVt/Qk/ejL6frubkLMUYNcm+9f4YNdyFWPdp22//gKdJ53kM+MQT/LvMjQ469gFFRkyeZIXz85fiLlZoMtCsA4LD7Cy14X8U33+k1NuWpa5C1iIdJrItrwoBWlcl++SHx1mk8jfZXSaxZ2p8+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685697; c=relaxed/simple;
	bh=VXS6XudEQAPjMBd/7aKbTLEixeQJWMYmcVf/vQFJn58=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X546GX7tqFi5y2ac4cQIsSIT3MlTEF0l6nQznc+98BU9CEZX4BOjkAVnhqolWKBjj/JoIZSMXwoWZQmkkMDfOdhhZ50q8XTV/BwiFvvS7Z33ygstguxIRT9nu+Rgfq1uzEdGoLqrFvhruil1zg8YlJXkaXHY+oaGALWi3VRR0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-48679a595e2so8187067b6e.3
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 01:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685693; x=1782290493;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6PXUHS/IFR4w+OORuxpA79Vor0EvBF7s+4hHeE2tas=;
        b=HobOkixi3DKGcNiXs0jpIfF44iEB080Hvdq2gLlQFJij58Ez0UYpe2nqEzCB3yPNKD
         /KpvLjK0z6MQkpnvmeJNBRa4wriIkIePk3DE3tJNMSHFg695ixFZAvEMs+4BeNxL0xqX
         B9E0axI5TKMVdt6/WcK4+3pvO/TEvAARqTJC5kRm+539lC2nT8YZW6LONzvbO9IhntP2
         yn1DAwiEotyhC7JEhVTYfx2gnttJ++yBRjPGBxCm8ZCM6qqmZIBIBoPn0OpBXZw2JvQD
         UMc3z3RITGQ8Eyrb8pvaLcV9NHya3PcH5MGLN7r+BJPpRJm9AIlkk7tW2oB2wD7JMNJY
         GWhw==
X-Forwarded-Encrypted: i=1; AFNElJ+oUE0WcDPwpuCEgOwrncxZKoZUCiVIbU/jw1tENfz8XDx2fU6RnTrG8MvBuTepSxdft9lg3g5MRrAhyYWKEOWhiwUmLeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAzT2BlEX8VGnU61meIVnmTbe0o/cIcKX9bOIoUYrh4p0d9oV
	E4xXufVAMYbjKEmB65WTy3LJ7mQp5cUubPbEoVA4chXAyj9TdjXdh1zYm0SZDKrGJIcWW0lLWDP
	QY8cdxNYTT5INq/3hi0mZPsflv7ckYnaDCGj7oPSyvohuX1sJpQUVcXILv78=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1692:b0:486:39db:ebfd with SMTP id
 5614622812f47-48942aafea7mr2550142b6e.33.1781685693573; Wed, 17 Jun 2026
 01:41:33 -0700 (PDT)
Date: Wed, 17 Jun 2026 01:41:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a325dbd.dc986f81.2c135.0008.GAE@google.com>
Subject: [syzbot] [tomoyo?] KMSAN: uninit-value in tomoyo_path_chown (3)
From: syzbot <syzbot+eaae8fa60ce81f1e4eeb@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-users_en@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b414a95b8f7 Merge tag 's390-7.1-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cff156580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0ca3b8cb3875012
dashboard link: https://syzkaller.appspot.com/bug?extid=eaae8fa60ce81f1e4eeb
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d7dcdf890eed/disk-2b414a95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/214784598f3b/vmlinux-2b414a95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/403c25c5a3db/bzImage-2b414a95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eaae8fa60ce81f1e4eeb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in tomoyo_path_chown+0x128/0x270 security/tomoyo/tomoyo.c:380
 tomoyo_path_chown+0x128/0x270 security/tomoyo/tomoyo.c:380
 security_path_chown+0x1c0/0x710 security/security.c:1598
 chown_common+0x69f/0xcb0 fs/open.c:771
 do_fchownat+0x20f/0x490 fs/open.c:804
 __do_sys_chown fs/open.c:824 [inline]
 __se_sys_chown fs/open.c:822 [inline]
 __x64_sys_chown+0x9d/0x110 fs/open.c:822
 x64_sys_call+0x30cc/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:93
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable newattrs created at:
 chown_common+0xbc/0xcb0 fs/open.c:746
 do_fchownat+0x20f/0x490 fs/open.c:804

CPU: 1 UID: 0 PID: 4943 Comm: udevd Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
=====================================================


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
