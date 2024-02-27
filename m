Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EF1420B3
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049904; cv=none; b=Oz/7ZkY7zYeJ4D2hMP/Mijwc9wF7xt1E69gjYNxbAe3QQBt3bvXVzbxZVgPWWKoEIZSaUoKHFfgotkKb9unWJOnKCZVKXg4pkFUMxjYO+Bv9bNvu+yovRWvdpquv7p4ovFbSg4f3uobAcbr1W/OXrwlYstsHimd2c2yd6k7DTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049904; c=relaxed/simple;
	bh=HBH/mlGn1GKuD1rLuQCa/9qkGT6/IzdMQvpWS/cMWy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g4rSzJjYPddV7vVfYH3YNeXx0/wpp1AAnV7OnCQ2A0ZeyyUxa2otLxQ1lklFNKoT9CL89d4uVbTwtSDPVT1FMtUe0PUSAhTo+co3cCnWskc9Jkf/QCZdUku0KzJM0fYDGZMwmAF51Ek5UVEMjYGL2Wc17w37qIlUdihI97A0bFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7a45b5ec6so326555139f.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 08:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049902; x=1709654702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yln7e3X50hPzjP07hatAlBcYIA7D/0apOIsor57CCn4=;
        b=sXQGqklzkDzeszQlTBQj5dJzMAFzyZuJnntGFR7i81GhekPquShCX3Y4Dap+8d9Jte
         ytFc2ms/XF5q+IstoRahNFq3JhH8hhLpx5nxEh3kRq2Srr9rbfcZQB7FFNU7bA89qf3T
         gnKeh3fQCON9NoHnoFLlIPTcOOS7kXv+4I8HqmA5yAZd1Thp/rYYhJ0KRTBVJGmivGq6
         LEGjOfq48EbyMgNLcajvhmTZnyN7QjzkMQzOiPPvzJDlW1ZIyhY999LWPXHV0XZV51pA
         2i0YNHVvfsOIWOkYU6SnGfWjDrVz7L3CDnwcqHnfSv4PvDKzBkic8A9XF2irQ+5ch8QG
         p65A==
X-Forwarded-Encrypted: i=1; AJvYcCXibbIB6l99FKQ+AZmaRnCnONZmq7qcn/JjwKgVVCQ3J7CUxliaS/n6p1mmy5HxX5rWKZYHmv7vFTjzq9DtekuYfNuwlbDZPLpXHK3vOnljwHTTEVZE
X-Gm-Message-State: AOJu0YyOa8jZmO3g+UdSILIP62yGnBwWuAUZSGZu7pI9GU8+HWLcFpG8
	39n26KiUE9aVn2Y2JnQovXKjmfx6Z98vBDueU0TQZEezWF9bYHE4seVmWnQu14CI31EKV8ycUCJ
	jo9vJ1Wfzg+ZCC6GAWBmDHiQDuGztlsymF16NmaJorAp7jjXbkLlEZ+I=
X-Google-Smtp-Source: AGHT+IGQrddUrzNg1cM0TuCyUnXm9cGXvL4qtuDHM1W3BsW0ptWD5HvYEy2BneyZBz5v/nqMCzBPdqx+SIOhr4bYRHxVwbUCFvDB
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:474:8b40:13fb with SMTP id
 m16-20020a056638271000b004748b4013fbmr316654jav.6.1709049902417; Tue, 27 Feb
 2024 08:05:02 -0800 (PST)
Date: Tue, 27 Feb 2024 08:05:02 -0800
In-Reply-To: <0000000000005a9fab05ff484cc4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000564c5006125f3087@google.com>
Subject: Re: [syzbot] [lsm?] [reiserfs?] general protection fault in fsnotify_perm
From: syzbot <syzbot+1d7062c505b34792ef90@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bpf@vger.kernel.org, brauner@kernel.org, 
	ivan.orlov0322@gmail.com, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	reiserfs-devel@vger.kernel.org, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17eb1102180000
start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=1d7062c505b34792ef90
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1066cc77280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116850bf280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
