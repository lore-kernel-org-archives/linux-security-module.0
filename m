Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9911CAA92
	for <linux-security-module@vger.kernel.org>; Wed, 19 Mar 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399344; cv=none; b=a3ExS7NI5YxeCvdjDOhCX9KEF11zNK9Gs+bt+mCVFBCM2S5bnhcWWmXD/oObDYmwp8DqPMLblWc4E/E2BMOEak4QFa8lTI/bChhZy21xKtIA3RW+enFglrz4NceYOZva0SreMvh4XBMUATtHPQVXzDIGGgKzehERZyJAnqvB0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399344; c=relaxed/simple;
	bh=fcWnykL2D+X3lsK2+aZi+h5+Y/7JPhjSfSZX8mz6iQE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qhj6ly5rqDL/meeDZ5X6ldPdlBZQuX53ckDWSZCFmjAkmQQ2QEX82Tlw9nC5BrMm1yZBvU9Q8O2TB+q/dtDPA3r/odXOvJ6Zbblg7U/GlRxUz/ug7J3/hUBkUYGNldKat0/1v10s81lys+qjDhjelMs9vA36X+39E7VFz5DGqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b5e46a526so727360839f.1
        for <linux-security-module@vger.kernel.org>; Wed, 19 Mar 2025 08:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399342; x=1743004142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU5MsUCPLlub46H1EeBsFjmZwiNLwRWEGXg3sa+2OEw=;
        b=gN9CFM1Yn2WgUGx7FkBz/9CbILUn2XA6XBKBUtk2vBMwGTMcO4VOxoWGuy9GwZZhnC
         dynsCIh8+cUoHBwJTaHO7C/OFE56v6MKsYaoLBbT0RYh08mg5sN1cgfh3JvN/hr5l+ye
         ubUpke5q/4BhsBha0KTB8Qw4nXzyFR8wy6BCWgBvI8P1U8AyrSG8s2S0++rWLzFnoakT
         3gyzxIQag+mEelt0mm0PnxZc+ZDVpnVXxrOvvOefxW8DqEHNPUgOlS+bmmOx1I2TmhIy
         Zr/bm7lRt9v7PFesZn03id1hTtew52mIDslgvImB2LeI5+iN5UvUz0pnWi3cfwKZzz7o
         zgLg==
X-Forwarded-Encrypted: i=1; AJvYcCUAGAechq89j5/RGldumvPx/yN2+mc4thlaankuMCN327zm7TcMcNN5vFBYmYElwOB1iNLmkRG19uyy447TwKCIAVSdz6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNL7zNd5tfmRiTWIPnRBzI9u9IdVQ25eeLxjntkMTcnodefkfK
	NEtDyzY/MXvSUVOSPtETiw/h/q/naTZ8T9Cq2YOjPKsfVAmb9U+1M+kOyeO0V9aC+mC+FXLfzBp
	PK6wXm8clpz+kTBdJcPRTzu94mTylKXw7cl+xFxiJJxjbgSTOCUo2Woo=
X-Google-Smtp-Source: AGHT+IHigf+/jbu+BrDOZ0kUNEQZh8ja/sQ5P27qFvtFb3664GIL+McAifFSK3M9l9uXqP9Hc3TcZOIAlW7XNZTiIoNPl0IQs5eu
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:3cf:c9b9:3eb with SMTP id
 e9e14a558f8ab-3d58695fc90mr26735465ab.0.1742399342212; Wed, 19 Mar 2025
 08:49:02 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:49:02 -0700
In-Reply-To: <2831141.1742397619@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dae76e.050a0220.2ca2c6.0199.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
From: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, oleg@redhat.com, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com
Tested-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com

Tested on:

commit:         81e4f8d6 Merge tag 'pmdomain-v6.14-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1216744c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14213ea05709bce7
dashboard link: https://syzkaller.appspot.com/bug?extid=6105ffc1ded71d194d6d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bb93b0580000

Note: testing is done by a robot and is best-effort only.
