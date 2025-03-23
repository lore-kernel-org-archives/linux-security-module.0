Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218461FFC40
	for <linux-security-module@vger.kernel.org>; Sun, 23 Mar 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742712785; cv=none; b=Q578y0rDgz85pjT9CAz+z/QyattscOIhwynlNiKRTw4qlQ5TlgYAJdi7hCRs9vb7JBD4D8KUAzuM9nO0lxmgddY336DeShOHxCvo3ZfBlIfOxyQwVYRSqlyHQBYQDCtvldeotUdxZ+49YG+oYVrpUGCmY/w7cb7WS+IIzHYJ4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742712785; c=relaxed/simple;
	bh=Bf7yka2w1VVpUuX6J7h+vWCKWalB2ArNcjPpVEqVGZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eKiW2cSTnmxxjZ+Q+E/HmFl0MyEYx4NhdB96XA44Y25mHNXFXbTKevoG4r+39fHdA7eiPA6IpEMMdyWJ7u9orEKf6UyyFqaWu30ekh5Y4qrxp7qmDwxdU76U4R5epbbX9AVJOw3PQOfYpgcee7jbL6cQon2qzOTP2Ky5PwnzW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b34bd03c4so429234739f.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Mar 2025 23:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742712783; x=1743317583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuTtDdQllfqVQdTnY1GFjo08/XepPL02PHTKNSl5Nyk=;
        b=Vcz9oRWWr0HbG2R1tB8a/T4VFddf4ZTfyPu+BWhi18oGp2120qkneJCgMixpwX9dO9
         0pb409VhyjHuAfmEi/sCW6SRx0t3tly2WjzL2hbsazjLj2Fjiqkljj4AbM9pwDMq3uQ5
         jBFxAz5KyoWHjkRpbNXb5S537k2Cf4SxHA9wLbPXEnqfII+8npz3MmPniPPQ5oM4Ejix
         RAaAllMfIaA2hBwOVzNRBLOWl7sJ6FBezh5WEYDyUQ0xjc0yPlVwCsxkIUYTYWNCOUyQ
         hDiQZnr99FY+LDN1YjzRuJrEleg/9gMrgGHluisjM+sBh1EAPjsBEO/lspoenhb0FdXC
         ClxA==
X-Forwarded-Encrypted: i=1; AJvYcCVWES56DVOfxlf8vz2bm4OGBdaZucjwVKPzHtIZpzTzjNxNCtciRmo7JWyrCuDU5hbqS9WqOm5PYNMsbcLnd4104pe/2yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHHhLGnTmVkMsX2hDpdmuI1DyQnaShP27pcb7qTwh3vgoojtq
	quYe4ckr2K9nlEMyGcUTdqnTJTbr1g7Fv7flabcK0MrrQkqtenynFgjR3Y8uMWO9KfVasbuvYpL
	iJU+pC3uMwuyMHNsWivS0u9ZrOhs2YdmCMI6w3a/V2fAYUBzP332Zrp0=
X-Google-Smtp-Source: AGHT+IFomXej1RrN6WELV4Qii9/yxfjxlWnmlmMb+ysYA1j31F3Z04e+3d3vMyCUXzjVvvz9y1wv7XB/R6rxL+wT2R6HvXmksUMF
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378c:b0:3d3:cdb0:a227 with SMTP id
 e9e14a558f8ab-3d5960f4d68mr77368565ab.9.1742712783188; Sat, 22 Mar 2025
 23:53:03 -0700 (PDT)
Date: Sat, 22 Mar 2025 23:53:03 -0700
In-Reply-To: <6707499c.050a0220.1139e6.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dfafcf.050a0220.31a16b.0058.GAE@google.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_getdents64
From: syzbot <syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com>
To: apparmor-owner@lists.ubuntu.com, apparmor@lists.ubuntu.com, 
	edumazet@google.com, jmorris@namei.org, john.johansen@canonical.com, 
	john@apparmor.net, kuba@kernel.org, kuniyu@amazon.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, penguin-kernel@i-love.sakura.ne.jp, razor@blackwall.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e759e1e4a4bd2926d082afe56046a90224433a31
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Jan 29 14:27:26 2025 +0000

    net: revert RTNL changes in unregister_netdevice_many_notify()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1084f004580000
start commit:   fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba92623fdea824c9
dashboard link: https://syzkaller.appspot.com/bug?extid=17bc8c5157022e18da8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135f7d27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483b380580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: revert RTNL changes in unregister_netdevice_many_notify()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
