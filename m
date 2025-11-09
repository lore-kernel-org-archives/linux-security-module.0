Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A12FB60E
	for <linux-security-module@vger.kernel.org>; Sun,  9 Nov 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697464; cv=none; b=NA/1meGJxbH+6mStgfgX+uD6F9bBFT1ectll8hi5rJapEas/1pyT0hCtZb7383gQ2Vik3YP6dCOJ/BjzpgqSThMA6tHVOSEvvXUwBI0WeKW4zi2GSAp7EYcH/RAdxei/XDw3E/0Mo7oq8rzrXbIYRfs8ozSfN7S0JdQRXiLG/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697464; c=relaxed/simple;
	bh=y6Dy/w1K3XpX2uFUEe+rBJFRb32lSDcExJhalbXQ5aU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rKW72P7BUeF5iSvHfbFumOOALrmlY97VyhoM7XHQAy8vYq2VhXBQPv/tHRwdfW3wnHu+PKWd636pb5r7F93CpFy4cRRBSNADXcT/ywOGf6V33iURbM0rnsV2BdvjYHDl2dQAQZfaIrpVlZVb4P0NnvCTX5OBMdZzTuxojKGBfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-945c705df24so191190139f.0
        for <linux-security-module@vger.kernel.org>; Sun, 09 Nov 2025 06:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697462; x=1763302262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m02kWE5lhyrzZgApWthbB6kQBtAUB+gmZPn3Dt1ZsD4=;
        b=BWFEQHhjVQIciPdQ9+sAE1prWTlQc8bhZNnqGyqfdAFETPqbU+BlxNJ/eX7dRglu1n
         HCVvbgYjdWLO6FfKEjBQ10ZJM3xczXZDXPSl/BpCA0dR6seHiTBM3yU5CFeyZtXwsN60
         fMRbiJZN+79gdaYGg0Khbm2eH/wRviMwqUMK9Jz9pUfEIzqb7x4+Hq8wNj3KdWLtuMrk
         RhAQl6kttE0cnALj4t34f9GPoGBgEIIO2B5bpO8ISmXFSZnD3nC2HmqzBqV04wIgOlNe
         VEH7RCOCBhnSI4o5RzqYUtqqEDLkQbYbG/SgpGIMo/cdRm2K6RM+4PveTTXANSpoR1On
         yOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOOi9gl36TpOp9UjLpjZDycxt2ORBZt7QXwht6qB/7D5JKaexummLCDRPY+oEJo8JOMiNW/IbpLSaUvYnRkXWvMhWqy28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpz6Bd+sX/ASLBWF1kg5kOWk1aohRLWkNyH3icu3+/hBpCPFY
	FI1OmWcIZ0muDtlKzk1W4EYx1P10bMZuNqOTgzu9vcPp+CHXHzojEzFPlvwQenDK3EkRDXOHk2M
	ZBOiUOFlRB4xam71kpc4n6tUopKEwFZ8PnirzLzfjCIbqosDhgL4qY3FIEpY=
X-Google-Smtp-Source: AGHT+IEw+SyBMcsmvsru2ydmWiAer57ckBKlQAwl2f1WWyRnepHiN7uVkkXdan4vghsxm/ZOPYzm213l8SerzWDt7Il3Poc2ozLJ
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4417:20b0:433:7d0b:b377 with SMTP id
 e9e14a558f8ab-4337d0bb530mr14752975ab.15.1762697462239; Sun, 09 Nov 2025
 06:11:02 -0800 (PST)
Date: Sun, 09 Nov 2025 06:11:02 -0800
In-Reply-To: <20251109-lesung-erkaufen-476f6fb00b1b@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910a0f6.a70a0220.22f260.00b8.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, bpf@vger.kernel.org, 
	brauner@kernel.org, bsegall@google.com, cgroups@vger.kernel.org, 
	david@redhat.com, dietmar.eggemann@arm.com, frederic@kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	mkoutny@suse.com, oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Tested-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com

Tested on:

commit:         241462cd ns: fixes for namespace iteration and active ..
git tree:       https://github.com/brauner/linux.git namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11e1517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b1a45727d1f117
dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
