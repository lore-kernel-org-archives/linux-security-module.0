Return-Path: <SRS0=mxSC=UY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52383C48BD5
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jun 2019 08:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27067214DA
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jun 2019 08:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfFYIzB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:55:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47995 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfFYIzB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jun 2019 04:55:01 -0400
Received: by mail-io1-f69.google.com with SMTP id r27so25527482iob.14
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jun 2019 01:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Zjzrp6Z1yIYEzVPtYsq/bEDymAlSPVUgkpHVJlksCG8=;
        b=IgsAJbpJNJOGrxwLJ2Wz97qK1kFoKvz8DgWSpfnzmShL1UHMrHsRmYC8ga5LX8yPdP
         ft41qwrR/Qe+NkABaI/a60GUxjzupanb2KGl5A5CG756LQtnPgNjxqdhOZMKMU98H4s+
         fhHDQIo2sDDsKCm0K65r01btTyG2LSlSLLH7Jf8vJHLEpiXoPm/eoYAeUO1uxrH3UBYw
         eAiJbmoZJUGeedIRm34/b8N/xQ4YFyD4Z7xZtUwVgn8Eqs4ckwMeqAZUin+voDn0QLY5
         9STDrmaDYDjldNiH6mC0Vsl+CUx/UdBJGNiQDOGRqpVhRF9exEA3pNaTEEDJ19phNFhE
         f3iw==
X-Gm-Message-State: APjAAAVgfCjVnoGoMDww3Xya8VGAKFaGnQB0C9hlgeFC8LBn5Txxe220
        RCDSYjH2fwRtzFqRh8rY0yVzTJVCpzkHLZ3Bxf7mdjEgv0gB
X-Google-Smtp-Source: APXvYqymIq7V92AiFr4YVas8U2D1869nxSpTalL7qPQms4TCQUQwzhr0aPenrnKgB5vpNPbSMZ1tFsnqEqu7rwuIWkHfkUg8yVy8
MIME-Version: 1.0
X-Received: by 2002:a6b:c80a:: with SMTP id y10mr7502351iof.170.1561452900713;
 Tue, 25 Jun 2019 01:55:00 -0700 (PDT)
Date:   Tue, 25 Jun 2019 01:55:00 -0700
In-Reply-To: <0000000000009ad686058bc12956@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b0e26058c2215d3@google.com>
Subject: Re: possible deadlock in console_trylock_spinning
From:   syzbot <syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jamorris@linux.microsoft.com,
        jmorris@namei.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has bisected this bug to:

commit e80b18599a39a625bc8b2e39ba3004a62f78805a
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Apr 12 11:04:54 2019 +0000

     tomoyo: Add a kernel config option for fuzzing testing.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156e43cea00000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=176e43cea00000
console output: https://syzkaller.appspot.com/x/log.txt?x=136e43cea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=fc1da0f1a577d15b64fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1357add6a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1611ac89a00000

Reported-by: syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com
Fixes: e80b18599a39 ("tomoyo: Add a kernel config option for fuzzing  
testing.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
