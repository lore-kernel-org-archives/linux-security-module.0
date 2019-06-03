Return-Path: <SRS0=tuDa=UC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4555C28CC6
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Jun 2019 22:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC92261A9
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Jun 2019 22:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFCWEB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:04:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:52222 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCWEB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Jun 2019 18:04:01 -0400
Received: by mail-it1-f199.google.com with SMTP id g1so16304994itd.1
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2019 15:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=J4fvUgW1EwHf5GdkMvLmBkbktAv6wzecd5S4Jz43ikQ=;
        b=kPeP9jVEW3jIe5zh0c/WJsw0FM6VNBBwHHJbQ9PMnxUtcr+y7o5TmC1BidQOljIFII
         qQNI+tT01cNKtHbULfYbUvTMV9KP1H5kSZDkgUMHXMo1fF5T5Lb7F2e2WFi5eILcx9xK
         03uBBxkGdl1XyTxpnXRNKEdx19tGI+XP+oXSkfovzR7ZRXRi4IMbaUNgCS3odadeIMBv
         Q/cVQygJZgWBVGLiaVZgzazPCYJz3BHIrY2qosFz/TczSUsE6Yxbn1jehilQTsQa0FGJ
         FOdaIIlcBkvXq10zT9UL4NnX5a4RyCWfoq6V5vIjXFNQrHpUzil9GKT9qj74J6FP/NQN
         5uHg==
X-Gm-Message-State: APjAAAW02PeUPl0WGlpGxdawMU87ZXKUtmZRtig6Ai4KoOMjSY34dlxR
        o4rRFTOK2ZD2hF2JvZrQF1oLMVu5MGBb6BajpOxz9FSx+VrD
X-Google-Smtp-Source: APXvYqy092dyuRmUAcZWsDzruOze1nu2JQlB3MegZ3Kb0WH/yI/h42We3X9lAKWA1LcM4A9vfuDNs1zplvdSKP5p/7RrqdxuebqJ
MIME-Version: 1.0
X-Received: by 2002:a24:3ce:: with SMTP id e197mr19185899ite.143.1559599440698;
 Mon, 03 Jun 2019 15:04:00 -0700 (PDT)
Date:   Mon, 03 Jun 2019 15:04:00 -0700
In-Reply-To: <000000000000fa91e1058a358cd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7a51a058a728a6c@google.com>
Subject: Re: possible deadlock in __do_page_fault (2)
From:   syzbot <syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, hdanton@sina.com, jmorris@namei.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has bisected this bug to:

commit 69d61f577d147b396be0991b2ac6f65057f7d445
Author: Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed Apr 3 21:47:46 2019 +0000

     ima: verify mprotect change is consistent with mmap policy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16461c5aa00000
start commit:   3c09c195 Add linux-next specific files for 20190531
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15461c5aa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11461c5aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cfb24468280cd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=606e524a3ca9617cf8c0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10572ca6a00000

Reported-by: syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com
Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap  
policy")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
