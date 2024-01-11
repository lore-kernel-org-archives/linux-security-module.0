Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA53EADC
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jan 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bef67c486aso141551939f.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jan 2024 22:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704955444; x=1705560244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go7MHHguEsXDJaMiDiMFUZrkJPCJjs8e6jnOcbKt05k=;
        b=kJ3JpstrbvuHWuafHABe3+IYEDVyk+IjRRDlO5rpa25h/dHzX8cVY4sZa0DuPbt0/f
         gi8mS1Re7EzM+0uOY/1lejLVyQwhLkkqYN65GTT3mm69cKby+cA+Vuf8MlQaK3DAluD6
         /zLumldpW6+hijIM0TY15dk1VpEXNvwLuWJy7i1Db/EiMSSN5J3RIG6IhLIT2+xPCwoW
         LlIKZJUmzU3E9eyp+1kE9X1Ty8ej/0JH/cAv3PcDkZmnIUTTj7BvCaulGV5EXG/Mf3yB
         eHYNyFZfXSB5mg6pZiwK7L/jziWRE2Fo0SMd8R78Gtzhw5BdJjFwVc9sJTKioM+10CfI
         hvew==
X-Gm-Message-State: AOJu0YxU3v2k7I2kBUYLDGZHAIeM4OdwUIIaNHx0N7Z3Ww4ovzY/QGrG
	kInzYJr7zMMbOU4m4rch8vunR5d+AUr8KLiLHY6nHUTm9O9Y
X-Google-Smtp-Source: AGHT+IHkD2jmO/TL/yOssuiaFNilDxssd908YaoSm12wBNANAvPSwd623sCODi3g2j4cDI1dKtqu1f3WEK5dMfbA4SkkLKacv/vM
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210:b0:46e:50ab:6a4e with SMTP id
 e16-20020a056638021000b0046e50ab6a4emr31005jaq.3.1704955444335; Wed, 10 Jan
 2024 22:44:04 -0800 (PST)
Date: Wed, 10 Jan 2024 22:44:04 -0800
In-Reply-To: <000000000000fcfb4a05ffe48213@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e1b00060ea5df51@google.com>
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
From: syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, penguin-kernel@i-love.sakura.ne.jp, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en-owner@lists.osdn.me, tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15135c0be80000
start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=28aaddd5a3221d7fd709
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b5bb80a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10193ee7280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
