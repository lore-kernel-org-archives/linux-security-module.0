Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330D1D52D
	for <linux-security-module@vger.kernel.org>; Sat, 23 Dec 2023 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fe765d63eso7832685ab.0
        for <linux-security-module@vger.kernel.org>; Sat, 23 Dec 2023 15:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703375946; x=1703980746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnE90/gM+FOrwq3n/A3KUGVcXoe8EyUry4mDboMk71A=;
        b=d2/mSAK8ethAa0FgZtDyLIZJkl57V5sIf1f6MSYCVRqWgxB3K87G/O2mQhRG+YBQmK
         w9L0JnkDDyedtCJep8uOg/lRSJVRs11lbZx90E5CMXcz3XbhcpIgkaLt/kfbPj3MxiKf
         RW1FPmAoYON6e2DS40xn9RD1jLFSk2WlkZ6yjI+l1FuftLOBW/E+pE7FqWDMMdxv2YWp
         2ALrJOMq5aQL/Xnkxa9qLU89GiJDQDAi3InArLdTg/BmeKK6zFSvMwFwktg8xWo6gWyR
         n9Rt33FX1/tdJ+j80t/McQovqsuVtLYHbIemG6AS88Wt+rfIvcmeC3PJ0CDLr2oPiNfN
         gvIQ==
X-Gm-Message-State: AOJu0YyHJlLCbJfYAJ41gPlTB0WDqHYO4LCGKbiABdLlDY7k8gifXVcz
	XGBuCvUa46A3BPOdE4bInp4IiRkqh95J4vBGMKGhlBxSQg2X
X-Google-Smtp-Source: AGHT+IHdzy992p3eOYSCm1ExrqtgEjAANMZE46uTFzCGwczENlpyuH3RnOK6ks2u2GJyi5rfC3cm7A/jZHBGKzTo/cWixzyqFyxa
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be1:b0:35f:e864:f6f with SMTP id
 y1-20020a056e021be100b0035fe8640f6fmr275747ilv.0.1703375945865; Sat, 23 Dec
 2023 15:59:05 -0800 (PST)
Date: Sat, 23 Dec 2023 15:59:05 -0800
In-Reply-To: <2592301.1703374471@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c1f71060d361ece@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From: syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com

Tested on:

commit:         3f82f1c3 Merge tag 'x86-urgent-2023-12-23' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132be7e9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f7c7b3fa354ead9
dashboard link: https://syzkaller.appspot.com/bug?extid=94bbb75204a05da3d89f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ef6e26e80000

Note: testing is done by a robot and is best-effort only.
