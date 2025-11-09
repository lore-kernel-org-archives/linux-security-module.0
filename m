Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA71E1E0B
	for <linux-security-module@vger.kernel.org>; Sun,  9 Nov 2025 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762676644; cv=none; b=jQpikMMSLZ83214OvIwXybxteI+X11C9YntSQBBMNca5LcUOhhkRXW+vWK1JxpzN6OYDsWCqprN69lNcLQlK2aDgDrAUKwhU9SfJ2SkZLaYRHdDoR6pBO83YX3FmverHUizezXCxQbn08za0nn6zvczjDKQXCGdoEHTdb6KQBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762676644; c=relaxed/simple;
	bh=/wa1QJzC1lG4pLKjSXBlRzkDHnFybIm8qOXkdf+F1xo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jOg2mL186jvkTGC4Exzxhv4Ce3SffzcvFiFekzdN44uHO5o6l2cSf8rVUrHMWqUBiHAkPtDxhX/g3j6emvEMFZvwTCH26FddAHQrkzMxCVCAS6q181hUItbd8ZIUmdxmN6+1bFSL4cqD/aRWpDLBhoVVvWI+lNHlofA3YEQ0+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4337b5c3388so10568255ab.2
        for <linux-security-module@vger.kernel.org>; Sun, 09 Nov 2025 00:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762676642; x=1763281442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL3FxTXejtzhr5abhLD58XcrwrPM61KGMnvXhlFjr4E=;
        b=GcpHOQrZFsl9pN1VP9A509d1XZKqIv2fNRhf7SGKUdbytlro3yTNS52o5TBK37Xkhz
         04jxAVdTXm4Y3OP/s41u5oQMj7TzAjs6XAnqxdWHyCzwc4gItfymLtAxNDzzFUelh4ZB
         FjiGLPCLxV70V7XdZBRS15nn8yBR3Z1hNZxNd1SGLeTmNuuYLkLV3Tgoxh2jCixTLVmJ
         8yEcQnV8b4HzzqBugZYwBZsYkkR1C1Qx/ZN3QsRlQ1q/btFfJi6Aluh435o0pxI3kHUM
         wriFEp/TDgkq3MdX91MCyl7lZ9ENee8oJ7L8BOfDfyHc8eLU1OrEIlgLFLbP25SSyHK0
         PUGg==
X-Forwarded-Encrypted: i=1; AJvYcCUr9nZFfuNAr8Q5ZVVM+V0Kl8wiOGsBI9FMCvm+O620v4KMfuankf49fFBzCR/1umi+Ch+7PfC+uX7saC7knvIY1axkOPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8YjFvFWBC1EphmCBtAI3mv11n33ow4Htdrhm3B5NxIedgBcT
	V25UoCsZSnUQhXZzVdYkTKsZQ0Q8xWjHJ1ZTmCEB+w9qvyDftTXajWR8YoNYdOB7b6gPkNOm+vk
	npy6Vnz/pAWuZnITeAZ+G0wyKbwAqFk2QQ9zlnWW2rFpeM6eNAmOYh0H/wzM=
X-Google-Smtp-Source: AGHT+IHOqUl2FIWzqMdoU47l5Gxi7c0kUdVzP4da94Ci7TzBLeLq0JKA4Ol0t1W4WTRGmKRyGXfPx3vt9pTfOQ1/fi74ObEhuKjW
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2388:b0:433:7728:b17e with SMTP id
 e9e14a558f8ab-4337728b3damr42151785ab.17.1762676642611; Sun, 09 Nov 2025
 00:24:02 -0800 (PST)
Date: Sun, 09 Nov 2025 00:24:02 -0800
In-Reply-To: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69104fa2.a70a0220.22f260.00a5.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: Liam.Howlett@Oracle.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, mjguzik@gmail.com, oleg@redhat.com, paul@paul-moore.com, 
	peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3a18f809184bc5a1cfad7cde5b8b026e2ff61587
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Oct 29 12:20:24 2025 +0000

    ns: add active reference count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a350b4580000
start commit:   9c0826a5d9aa Add linux-next specific files for 20251107
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13a350b4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15a350b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2ebeee52bf052b8
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1639d084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1625aa92580000

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Fixes: 3a18f809184b ("ns: add active reference count")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
