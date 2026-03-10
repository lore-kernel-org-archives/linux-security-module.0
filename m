Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD238B14A
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147103; cv=none; b=or1pPFNr8aZn42xCPyI71jOL0vdPZsRJJF+c2j6Mf/s/u3JLxWaPlf/v+yOAphgdaXnF0RFU6FH41V/qBcict6u2Xn2B7APx6llZLCFurI2k41ITCxA+3dX+/0v/wl4iR9mndQrxKAtfjD0JGr/3HfATd1nZWrHsDMgYDH00d+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147103; c=relaxed/simple;
	bh=wafJtbWuM02dpFWlk1FY1GQH4V6ZSUBF6EHEWYxC6hU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=L8yQkob1OYRreHqEisr7E63ri/hnIyPFEE4EPqBJj+mDLWcrbJ9tV9a8caGlre2vCaPExBxkNjRbmfdEaAj+YhT0rqZZ+qYb+z/G6f2WnHJ4qu65zCKG14KFKuuh2vUl8iNeqhPZN5I+LZvgTebPY1ZM4GGN4Ybt9tLXDvZVhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67bbfa324fbso9258280eaf.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 05:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147100; x=1773751900;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OshdSFBHq9GherBohmmJStIsm55YycRNXXb8a35WIC0=;
        b=d77HCs5VEdj+7wcH4HiASz6KBGiLQkwbJW7CmedDa8nBrJT786teOd3ITQuNUWopZi
         g3YDNsAwF2ogOHWaV+SOjpBBllISD4e0IcH9k2pm0y7XY7ntzSgA9oe2CeNO5CKk4AB5
         jIZ0m02wea4q0hs8pfX7WX3GSpPuGbReK20Wu8GHaVph+BwI6B6JUd0omKnUkQMb+hdX
         70ovFPF4APABUM5V+RfAtSZhCwxEK3yh5SrtCRX9VVPoJupuyUlbj1rW72p5RNURVom2
         T+lYpFTPPaDFN1BLGfht+TIcS0x8ylZ9FG5ThImSrOpJL4m/bsZQRFO2IcExIHD/urqB
         afFw==
X-Forwarded-Encrypted: i=1; AJvYcCUeb1m6UgXduxC/I9WMqMa7TjI0QWpk1vtgCEzn0nKQthnM50gIZ4J//0HdrDSgbfj8BT9LEelHho2zv1YFStHfBCgsBGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMCIzQ1w0RQv9A5OFcDEKpGirVs2oNbSqv9e2PXvFYYVIcOR3
	c0M4TfLUHNhPQRa6ABagrH/3DxwszjMpr1ctH7NgRBd3fnPTnDQSVzjRkJiHxxGQft7HlapjrU8
	GhDchHQsRqZcRxlS1OVrsKYkN5ygYNaxwEYS0D6wMSwpa2KNs2L0vs7b8IIA=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:480c:b0:67b:a8f8:f69e with SMTP id
 006d021491bc7-67ba8f905d0mr5643788eaf.29.1773147100604; Tue, 10 Mar 2026
 05:51:40 -0700 (PDT)
Date: Tue, 10 Mar 2026 05:51:40 -0700
In-Reply-To: <abAT0q5bMfFYGT6V@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b013dc.a70a0220.be77.0113.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in task_work_cancel
From: syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
To: gnoack@google.com
Cc: gnoack@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mic@digikod.net, miklos@szeredi.hu, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Sat, Mar 07, 2026 at 07:46:25PM -0800, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    4ae12d8bd9a8 Merge tag 'kbuild-fixes-7.0-2' of git://git.k..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17dc475a580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
>> dashboard link: https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10
>> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130b075a580000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/010ac4052aed/disk-4ae12d8b.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2aad8bef9031/vmlinux-4ae12d8b.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/fd350ec4896a/bzImage-4ae12d8b.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com
>
> #syz dup: general protection fault in task_work_cancel_match
> #syz set subsystems: lsm

Command #1:
Can't dup bug to a bug in different reporting (upstream->moderation2).Please dup syzbot bugs only onto syzbot bugs for the same kernel/reporting.

