Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E62749C5
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043365; cv=none; b=YOHFlDio0glCVDbS1ONY5o3o9OLhE2lUtcNuHimN/3r9IRUssy/oGO+RgGhZRD0cHUGdZZLao75NXQG1UsND8IX4QDtEB4lI6qqIwHqKwI+6h33w5VN/Lkunz+Hzcy3fQ+InyB5Rsn6yCmw+ZeOBPkT2TOe9o1JzzqrLiUChKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043365; c=relaxed/simple;
	bh=GfmPq3HACCp8o8RV9X5r7hr9CR4rpOel1xO+LMrzOZk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i7YAykXcbe5gPrp4xt14tQ7sXWWS6gN0GLaz6uVX0Y5qjEIkL5Rbvg89D+xcuWYX/BmkA91HIRZuHGqofnpb74gCLnG96dKfk5gx4Op1fk0EAMOkAlJEk4JDresUrKqhikrjf8ktrD2y7oDd0G39KzFUvSc6EGukRUG02Kr7t7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bbd28b4f3so284232439f.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 13:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760043363; x=1760648163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hksci9x2jx44nWzRfyFuUH4NBDU7N2pjE2NiMbKpeC0=;
        b=a3yJz7clw+mYWx229/X89oYtXHiUppWSbTYzEG7u1xIE2XFOHTRsnIGDQzjhxE1FlK
         d4wvdNvdSH+sUcSsluGYA6c50J0gPzChkPY1oEK45YZZoSJldLFSOzFXEJodI9K+V5kj
         z6zvzz1erOYnHTCOPiFeLAroqlA9uQdyuqUcI0Mq9qJk4bQEc6ayhshvrp4BucdG0Pkx
         P+JFc76TJbYguBDcZXVQXy0Dyi+KihK3MTdwT2o0nkQCouVCpOU2VCvJciIB0Y84ibsF
         h8EyKqFF5TwHbwzgmeZIhShUrQQ59fdbVfRr05JEpe2x29KsStenXEBOia3iU6saQ5DK
         38DA==
X-Forwarded-Encrypted: i=1; AJvYcCXWjHaS0w9DhdyfGbLRHjU+Oa3Q4rgZfFCMePkaGqpv7JIN6L9ydchdA8JOB2L28Xdl5x6jo6dBCOFCh+i4eg4xemMCVMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdQMaY0qjW51Js7RdvZ5fU6rsQmxevvUUqx/iP456MT1I8vwe
	klaQT1Y4FdmXDNcPF9x7jTq+XW2wUt6SOInWbL0B1JhWmfsijGm/qTGtf6kMeknsM1L0XmHejUM
	LNXayPKmEefApKgJeXfg2vZ2y7HKF3fIYHi2/gS6lNlOim8u8D8T/yeuRxq4=
X-Google-Smtp-Source: AGHT+IFYtivfCGpqnWFo4z8EgycX5Hd412zY/vm1trt1fBFKxZT7ktTkYJX85FlbrPlwX8RsxqMKMjwyJRG58lCrZszYaKW0qsQH
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1652:b0:921:2f68:fa0 with SMTP id
 ca18e2360f4ac-93bd1851614mr1049241739f.2.1760043363452; Thu, 09 Oct 2025
 13:56:03 -0700 (PDT)
Date: Thu, 09 Oct 2025 13:56:03 -0700
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e82163.050a0220.3897dc.00a3.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, gnoack@google.com, hdanton@sina.com, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, max.kellermann@ionos.com, 
	mic@digikod.net, syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2ef435a872abc347dc0a92f1c213bb0af3cbf195
Author: Max Kellermann <max.kellermann@ionos.com>
Date:   Wed Sep 17 15:36:31 2025 +0000

    fs: add might_sleep() annotation to iput() and more

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1092ba7c580000
start commit:   7c3ba4249a36 Add linux-next specific files for 20251008
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1292ba7c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1492ba7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa7a95b14b1eaa
dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12280dcd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111d852f980000

Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Fixes: 2ef435a872ab ("fs: add might_sleep() annotation to iput() and more")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
