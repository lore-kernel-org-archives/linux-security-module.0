Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D71FBEB0
	for <linux-security-module@vger.kernel.org>; Wed, 11 Dec 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886845; cv=none; b=elZHTgmK0wuhaL86gVlgF6ycNpJVFYFpEdayoecpCBu9K4tupqIPw0Kovn5P7p6IxdOFpZ6YTBaYWUokg0i2ZVMG2Zv7roADkX+Qd2JqrBm2RRxFfXCwlOl0p/XnWOzk1oRFW6RlzeEYK7NI9QvhM11qo6i7t+IBSUHupRUrUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886845; c=relaxed/simple;
	bh=uNdsxOh6w/4q4YhOO6WgmJHWeXojlmXswW8c1T2NVtE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=crQHDdwXQ12WeIK17Wa1kr/B5uH6C5IyA1wgt5GsoN3c055x4Xy6rQZSBniPTFCejFln6kcjnru8ICnPDm7gY1RpniPwqQWlFhhKKh7Zl5rmxi1NpToTS8tnB0iCbSpAmEBLER4X1KXp+0ygLkjTbxR+JCmUipiLamDNd2ThqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so63249425ab.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Dec 2024 19:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733886842; x=1734491642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0W94+kQ3tRQ+O3QZLf8SyKmRW6RQEhoTIJ7U4RDgHI=;
        b=FvKwtkgunxCbQN6sqNO4zuGgXc+q/jxPoJm5qu0TBI7WSkW+cg7gdSuhCBh92KYb1A
         KDZFrwTbvLlKq0Wz86NNBrR481+uB8kyS/li1p2qZF04DpDafMVV9lVTWhwN3DT0P28H
         f21+vgcSHwNS1Egmk/Re7bto8h3fGOSrNHrJ9pA4ceSqvkBMdBGE6FAxn1RHG4g3psBH
         jjPldcW7wN09tQVEMQMgnM3ZYK0ELAYW/jutanV5+TVTOkGuqmmDdw/onPbaGHfuhoPd
         9t/RxPQlS35kVtOXG/mKHVLrRJ1886UTJ+8d2df0k75ifD3Jmkwq4EgC+zkx51kAgkWQ
         UNag==
X-Forwarded-Encrypted: i=1; AJvYcCWbOphnpLZrcBQSNbamsWk9uawzxumij1rB7eCJKdfDX7id9dwgrIip4sKkHLhiC/C/eyh/tR6ao7eYVrdqCS5ewP06ygI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytw/ZN+hVaoueEd3dY9rYZp89wEQyZYlKLFnKM6IzH8MOdrgKl
	htofCz5A9gTgQwZTZbBu9U3s+osBeoztADrkqQPnD7hNAf7BeJh2el4cduMccoilSaALH4OHA28
	Cci3M1zL3DpyLfQEPMOFet1UKDcwyfrzrF2vOGB2ToCgwgM+zbwjGt/c=
X-Google-Smtp-Source: AGHT+IGIjOZIyxdMur+PVZfSAqXCP92gYPE7/Et8+cFS4YQe79jNleZ88XKKmsCw4p4nuoFGSWy5higCF1W0Wiq3ByYVRpfaL8pK
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e08:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3aa08f66f18mr11666915ab.17.1733886842313; Tue, 10 Dec 2024
 19:14:02 -0800 (PST)
Date: Tue, 10 Dec 2024 19:14:02 -0800
In-Reply-To: <PUZPR04MB6316E053BBAA0B434A32A147813E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759037a.050a0220.17f54a.0003.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com

Tested on:

commit:         f92f4749 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12034cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179da544580000

Note: testing is done by a robot and is best-effort only.
