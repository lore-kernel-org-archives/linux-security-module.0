Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76162F25FB
	for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854365; cv=none; b=ET0tP+T5oAUucewb6zlk5J49PTM8Ud4K03BSVERYYbrPBNRflLM5Ebzo3OzNUeaxeKRN9cpQ5rmgeI19XzJaR9+LRLWbxX6z09PqHzu/ITtiTsw6Rwj/rNEpWR+ykfPIQJ8tSUQ2fRyUgKynjKm+JHXrSInzyxPZROaihfKMZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854365; c=relaxed/simple;
	bh=MGqkyJPAh4zW65+tZYFbDdGQAx3QF87Y101n3ZZIGWc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AmoAl4MaHqjEkmkvE0XYl2fnNTwzojtzZ62pJtBNIcqcj49sjekPkmKA0HJPpBUJUD2U0DIromHASj1qooZ1Ahuol27/mD+UGMmzo3qsGJ+anqce+vp7Hjw3pyeHm/O8snWObUMmqbASrQYNqXZEd9E+lDI9oKYf8H+xELerzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4337853ffbbso29209565ab.0
        for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 01:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854363; x=1763459163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxx43rg5vTwPZ2wNbygdxPupwm5jqNPgGIjEmJm74aE=;
        b=QzHlLhFens6t++M/wBnncY424Gwba3U137HT1MhnLVXcCZVR/2Cap+gmx25IIySp9l
         yHbSKZ0OgGLAi1xNcPcqgGsJu/UpDZ/r17EUkOGzDIQB5JJfUPGOBd7BgZoCeZgLJ37K
         DftnnuB5wRC2kbnMCD+GJ3omUJQn9lm/UEta5scPiTwUndk6qe8P6nTde7WPHXQbKBYP
         J3Aj76mGTMx4DS0r4Y4+ohFEvNy/W2ixQLtK0ysYd7oR7A4qKAg9N+4h3fl2UbpHyYUD
         TYZ5I09Rp2Er5mvmS4gQLKeadBsBIsWpOQpFpg+WyUQrL3zeXNKWUQuysDSnP31i7ilA
         l3iw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Y03EoSmX7rZxOuB3w10PgEHxPaN+MC91EAJr4HCEEyK0TjTZhaFj1sPVzB+zLi7GTI3V8FgKrA9hEXbny1US/TCv6vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCX5bpVVkq7EECExQZ41RBishI+5yhQLcg8mzPBGDw9vJgKOg1
	0fc09MAKxtpCdt6QNBNrQLIY5K87nbq6lT9jYGFL9B5Qj7kZ1zzw1NhmYMW22Do7UysZDfo2a46
	FoJmColgEUeoOU5uQ5BIVzZSwMNBLdAe7u3pW7rxkW8hBngbjB2SfGNY6org=
X-Google-Smtp-Source: AGHT+IFqLPDPKBiPRu3uu7IeP812DZQb4h/dmZnbCd8SnvgWxvVU1yv/z8fN5lQPvlaeArHHV0ZoY+wPaoICTLGVJWFDgk3ltdWI
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349d:b0:433:4ac7:13bb with SMTP id
 e9e14a558f8ab-43367dd8a03mr188557675ab.11.1762854363073; Tue, 11 Nov 2025
 01:46:03 -0800 (PST)
Date: Tue, 11 Nov 2025 01:46:03 -0800
In-Reply-To: <20251111-lausbub-wieweit-76ec521875b2@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691305db.a70a0220.22f260.0130.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __ns_ref_active_put

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6489 at kernel/nscommon.c:171 __ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Modules linked in:
CPU: 0 UID: 0 PID: 6489 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Code: 4d 8b 3e e9 1b fd ff ff e8 b6 61 32 00 90 0f 0b 90 e9 29 fd ff ff e8 a8 61 32 00 90 0f 0b 90 e9 59 fd ff ff e8 9a 61 32 00 90 <0f> 0b 90 e9 72 ff ff ff e8 8c 61 32 00 90 0f 0b 90 e9 64 ff ff ff
RSP: 0018:ffffc90003457d50 EFLAGS: 00010293
RAX: ffffffff818e5b86 RBX: 00000000ffffffff RCX: ffff88802cc69e40
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc90003457e00 R08: ffff8880320be42b R09: 1ffff11006417c85
R10: dffffc0000000000 R11: ffffed1006417c86 R12: dffffc0000000000
R13: 1ffff11006417c84 R14: ffff8880320be420 R15: ffff8880320be428
FS:  00007fe11c3746c0(0000) GS:ffff888125cf3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d863fff CR3: 000000007798c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nsproxy_ns_active_put+0x4a/0x200 fs/nsfs.c:701
 free_nsproxy+0x21/0x140 kernel/nsproxy.c:190
 put_nsset kernel/nsproxy.c:341 [inline]
 __do_sys_setns kernel/nsproxy.c:594 [inline]
 __se_sys_setns+0x1459/0x1c60 kernel/nsproxy.c:559
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe11b590ef7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 34 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe11c373fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000134
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe11b590ef7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c9
RBP: 00007fe11b611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe11b7e6038 R14: 00007fe11b7e5fa0 R15: 00007ffcd9b83d18
 </TASK>


Tested on:

commit:         18b5c400 Merge patch series "ns: header cleanups and i..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=12c08658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
