Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90828DCC
	for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774625; cv=none; b=tQHkyASIxxgwc5i2jS61n8T1wftGQVqpbkURUvF/GFftdMtjSwvm1HQqP7Yth6DhkCh7BwWL1f1DqpO1gPodWxa4NLIfZ3feAab5+EiEfY3Lm0SN4aE7rbZx3x4Xh2bq4CqGscR6t6SoUDiuP1ak44juGyPJOFGLJ2aBaMb35N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774625; c=relaxed/simple;
	bh=h7cJFJvH2bii7WYkqUdFJoFaaZT4B06F01W+siRkutA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J1TK7mb1dFTvxgst9C2s2oZcpk3JGTnGH/XVCZ1iPIBEVZc1is13UyGws3FiSiu5jxw08paJAOVNt5DYSQxoNHhkwZglOG82PZFv4/qtoUa0fKteHwmzMSKn6qAIrB5BNONhp/boNqyQU+RvQj8oe2/Qqugmhs5k4ZDP3lTBvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cdb749571so139262739f.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 12:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726774623; x=1727379423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CRNWnXG6C62pd73O5+0DURKFiurkyy58Iv9yEaQuwU=;
        b=Lt3FXMn41HRsfGRqrkR5TP+HxwbliVlFvit89pdpz//WVfgf2jM621yJghic+d6lV3
         iDRsIcs4skcLez2HvrYOEM8/JCo2t5j6E8V471jvHsxNsxTxaDwxVFsEkTI8N7/71T3Y
         ir59SB7Nf14pNFqwOlN0LzFxME6+/g1XFG/PeHNC8XMxGVw3Py/+B//LYeW1czkoC0+f
         9O/mWysWJGzO/YCoqnsPbxIQUHq9dzqlymgy3ImU7iFUxmMcMFfbysn0Btyp2Yi0eln5
         fNK+/ar/0W0TfN6bD4WU/KGdu1lXvDwCyF7MPyG7HX7rVUqDUbroafZITa1lkDDp6xco
         Paaw==
X-Forwarded-Encrypted: i=1; AJvYcCWmUUzx39270KaKaKW8Q6p0udpcrtDbuU+x2PE+NClOq1627xVaD1CG5YtVGZYDalDBAeKSydbJKkeszNBP35thX9m3iUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5JcarrPOMj3uTg5MQQ21sOMs5NO7eJTR38ZY28mtM+3gl5uK4
	TXYfmU3pMgYnSVliBBMmSxvZ9qLMr9dQ+c53MgGoiFdwUuXMAdvVR4JgomM3iuNNWVP9FnF9x4N
	Y7zEkTWC+Vb32+jK1uar6hAX+evr0ylFomMvFcI99IfVy9m+3JevebN8=
X-Google-Smtp-Source: AGHT+IEWigGKNkyjia5d2sn1U9cVlDImOMi4LZBpan1NY7y3ryjmidJ6A3/FBWMdIrvH645kOzaYezjv0UDb5xZ8rJdIberjuPNM
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a5:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a0c8c808admr7797375ab.7.1726774623498; Thu, 19 Sep 2024
 12:37:03 -0700 (PDT)
Date: Thu, 19 Sep 2024 12:37:03 -0700
In-Reply-To: <CAHC9VhRpDPTopxgOEbDt1d_XyDVNzaA7++6UojWXidbpBHjeVA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec7d5f.050a0220.29194.0043.GAE@google.com>
Subject: Re: [syzbot] [audit?] general protection fault in smack_log_callback
From: syzbot <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, casey@schaufler-ca.com, eparis@redhat.com, 
	jmorris@namei.org, john.johansen@canonical.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
Tested-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com

Tested on:

commit:         2004cef1 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1784c427980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38d475ce6711b8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=044fdf24e96093584232
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162b369f980000

Note: testing is done by a robot and is best-effort only.
