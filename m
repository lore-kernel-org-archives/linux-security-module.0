Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C11AEFE7
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jul 2024 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102700; cv=none; b=AaEyeN8SLZtWpELtXGY3IScd5qxbn1Yc45LCAeX+XPB3UhpqB1iSCRLtXAm7JiwBIsbhP9UcPASGi08JjYB0Zwgo1QcmTP+nDfXEwsGQDkI6k22T1Jszh3YoqTBhdXtMVChuxLSV3bNhN9WzpKl5fLfrhzWnsKvXJX8gNOS5SS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102700; c=relaxed/simple;
	bh=1smwYFCQdFQQ+pWuZhmovy2EI8RvSR9Ox32GS+V1Eqs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QB8C7RMPmzQG/HkiiKwDFsQCXMZmyS1xPNfVCGTSz3RP353RPDa17VMZL9KnfodQ8Q3scCScadVeX4YzFTc8XizZc+jWMBv3lcLG2zCaemAyAc3IqTQE6Pp6y+Sfp+4h5RwRl35aLafRGAiWh5VSkFOJ2wa/LdjUYISc9ZZefRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f66b2c7e9aso85874439f.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jul 2024 07:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102698; x=1720707498;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdkZATJ7OGmsuHw198PHVJ2z9yJtklx34ktzk5b34qM=;
        b=HAqC83Pi+ikuOHSHvJG+Hayce1mH5ppkJ0JsmR5HObTUfnE961gBz3vk/HixPzNK9p
         jfu1ygXoug+P6qwq5PEOUkQnDg1tOvWc3Q5RP3COySOF5ARnVUisZ6KGo8sJldVBDFCS
         i99TC5KyTpKv+UU2yKRC6ubKhteSg2EI3vRs+2VTgyn+ye65nK9JpoicFtLOZRvG+oVA
         +xsyHPz2w4v3O555he3PiTs+b17UZfSj+8no+VRW4MrU+2Tr5ZQxy9crmDNj+Gof+TgV
         swo7dRIQqEl5h5vDRz9uuGh4vMcTxg8D4WrjvST8RMhq5sd5uROQUaUgleY9MmfgcFhL
         JPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQbGisnyagu39PIrXb6gM1cWKfnTbpBVpeCW1UUJvQICeQlxRcrtkHzGvrqthpYkNj4V3rCJluj3fDAbEK0fu8GcB/zOfcyFeoeyn6/9Wq+agXh3Lv
X-Gm-Message-State: AOJu0YyrkK9iW0OvXIPDdm/C/t5/irNF4yUUUBQSihOrAIVBrZkd9tCc
	WE78XOz3d8PQj8eYLAb0aNiNbH4cALPINpfGBbXATQ1ESDmbLSK5LrSMj7CJuvARYI4ZqvQBBeY
	7k7SDS3XPk0kFZPF51YrfX3jB5XKkHgkXyGjelQ0fRpXNfbStkiYCETk=
X-Google-Smtp-Source: AGHT+IHt7B2//ng4CP9pxz/XHbuJQsdbZaMaQQF0GUJZb5OndszSfzXEAxtT8oIGTFDMeWPyXe7aFdP1l7ua6pzOFF3QX5ZxVkEc
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c7:b0:4b9:6c10:36c1 with SMTP id
 8926c6da1cb9f-4bf60de4273mr218703173.2.1720102698181; Thu, 04 Jul 2024
 07:18:18 -0700 (PDT)
Date: Thu, 04 Jul 2024 07:18:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d74cd061c6c9e68@google.com>
Subject: [syzbot] [lsm?] [keyrings?] KCSAN: data-race in __se_sys_keyctl /
 key_task_permission (3)
From: syzbot <syzbot+8c446f45cf5815e9110a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a9c6c40432e Merge tag 'io_uring-6.10-20240703' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113817ae980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
dashboard link: https://syzkaller.appspot.com/bug?extid=8c446f45cf5815e9110a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f01153f3ec8e/disk-8a9c6c40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04b88663a824/vmlinux-8a9c6c40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/63c518cc63c5/bzImage-8a9c6c40.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c446f45cf5815e9110a@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __se_sys_keyctl / key_task_permission

write to 0xffff88812277dd70 of 4 bytes by task 19442 on cpu 0:
 keyctl_setperm_key security/keys/keyctl.c:1098 [inline]
 __do_sys_keyctl security/keys/keyctl.c:1926 [inline]
 __se_sys_keyctl+0xab5/0xbb0 security/keys/keyctl.c:1874
 __x64_sys_keyctl+0x67/0x80 security/keys/keyctl.c:1874
 x64_sys_call+0x2bf5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:251
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88812277dd70 of 4 bytes by task 19441 on cpu 1:
 key_task_permission+0x14a/0x2c0 security/keys/permission.c:55
 lookup_user_key+0x9ea/0xdf0 security/keys/process_keys.c:803
 keyctl_setperm_key security/keys/keyctl.c:1083 [inline]
 __do_sys_keyctl security/keys/keyctl.c:1926 [inline]
 __se_sys_keyctl+0x829/0xbb0 security/keys/keyctl.c:1874
 __x64_sys_keyctl+0x67/0x80 security/keys/keyctl.c:1874
 x64_sys_call+0x2bf5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:251
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x3d010000 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 19441 Comm: syz.1.4799 Tainted: G        W          6.10.0-rc6-syzkaller-00067-g8a9c6c40432e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
==================================================================


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
