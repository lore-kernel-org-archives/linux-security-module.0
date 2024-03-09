Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD05381AF
	for <linux-security-module@vger.kernel.org>; Sat,  9 Mar 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709978345; cv=none; b=eVceciKGxGv/OKz+mdISwDevwODoQE0qVPfWMvjX1rWVLcm/FX56mT1ULdBi+3oPN62AGrv1mvG3NkcnKqN9+JRiydS+wZgCyJrS+k0i1pyGx6ozWuj1t9HU4BcQdWHdDjb8J9dPsjK5fkkZYH7D0woFf+sukJ7sqmZDdK8fmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709978345; c=relaxed/simple;
	bh=asn96ezzDe7z4cS9Xr9t03l6ZD3ftiEfDmD7qxHPWR4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MIAV9+MfGDgYjXWsQh4Rt3rLslDZU3rdcNSRKZs8+u2CNyCJaL3ZX8EU7RxVAsjrChd4Aa84ucTtsagRXrvHE2jzwRo24UGZqLiy3m/ggg6wwia/jBMbRLOw7lVNCxdY08/NgLbapepplBLaJUfDvfctm2FZuDaOXmCL4GkLNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3657bb7b8e9so25422905ab.0
        for <linux-security-module@vger.kernel.org>; Sat, 09 Mar 2024 01:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709978343; x=1710583143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVYUoCeuZ1fyxODvD3L6XZXHBvcIymgYiHpvfaB7YME=;
        b=OTGGJaAE8FnUGC7vc4lfBBHAQXipi3INNn5MjmQyFu+7O4ohgrAWNm7PnMV441voED
         K94GoMfOzipEaeVmITd2Tphy8X37jvwbcakIM1Kkm3DwI9aL5mlZ5WG9S/bd3CPb1byL
         HqJbEovHtLAYj7dEiqV27YsyNPrETuFCEpSHaWSdMcd2k9nm9ipheB053FlndYWSZRd0
         EKEJSRjJRmG9KA7mMI/p6AGWPNoOTUpBdxIK3KCUa/MkDE9D+ll2juU0EMooQ8R2YKda
         +EZjqdJch1ed6J7opWzl6ZGTm7wHnPn5QD7wcLunZ4U0xYCUnZOd3HfSj0HJ/Ixnfy+T
         MFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4wesH5BxwZR24A2KEmKdSfVVB6AML5pq2L3dkisYBF8hbkX1Xs4DeYp3Jf7UlayeE7YvvaPWMMb31rM/Y8Oxw6NOQWI9iyRxkGwQ8jW8axgHnL0QQ
X-Gm-Message-State: AOJu0YyEaDgun6WE5ulAs1a7eKO+4GaGbJR+J1ylOX5nrwO4aq12SKCV
	Wn0XDiaRO1+Q46SMGXOHp4SxAYVsAjB4y3bXtc3t44ITsipg2oDZLYckd5UYTtdJwjcWNid/yqW
	1N/ge7HYLf6g3XWA9lo2VA1QmZAbF+rWyOhGXL1bVAlY9+BOtzBTloA4=
X-Google-Smtp-Source: AGHT+IE1qe21EYraqy1mF2HjTY4C7GyobmyXlxUrrhxJTThu1W+Kf+RgPU89aqiaYRwYdp0pyncoVYWN7fk62Y1+CPuhsAXE2nyz
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:365:147b:fb44 with SMTP id
 d12-20020a056e02214c00b00365147bfb44mr62585ilv.0.1709978343080; Sat, 09 Mar
 2024 01:59:03 -0800 (PST)
Date: Sat, 09 Mar 2024 01:59:03 -0800
In-Reply-To: <000000000000cfe6f305ee84ff1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6989a0613375b88@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From: syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jeffm@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11750da6180000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=c319bb5b1014113a92cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113f3717680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154985ef680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
