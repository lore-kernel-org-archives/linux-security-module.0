Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65068C4320A
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Aug 2021 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445EF60EBA
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Aug 2021 02:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhH1CMI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Aug 2021 22:12:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40721 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhH1CMI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Aug 2021 22:12:08 -0400
Received: by mail-io1-f70.google.com with SMTP id i26-20020a5e851a000000b005bb55343e9bso5177646ioj.7
        for <linux-security-module@vger.kernel.org>; Fri, 27 Aug 2021 19:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=76HdtwbOVuUSM0zGrd3e0OmR58hv5g+WaLxPr1hL0E4=;
        b=S4pFas/b5l4SdrVA445Jy0ITgGFeJlA9UrtrFmBJDgoiRHM3xswT6hZuPezOqncLEZ
         Vh1E5TaVcuzQ6VvnTQkiCPOqXlcF575Z1+gt7ce16sa84oDuvfkWND4auP3LWuFmw5XI
         65CpblZlviyUHeUUVlLXQ9ZIBOhoXGpFVr5n5FaqP8Dr1TkTs2pJGJfeP8ZUJngO/8us
         36KL1VU3nfQmzh8DD5FjuJIH4kvAV4Xppq2El9axuhKe6hMwaBKAjNbX4PJxuqo/sOv+
         1KBZiqsQFBA6wxww8KdI15cTeYfI6oFqmVeSntp4T8hCZS8/YqJQyeNTh6PXixZOuyO4
         HJzA==
X-Gm-Message-State: AOAM533/3/YpacY+yuAYIRhfFNoXubdMvktd+UXgNokRULJ8eJEupz8o
        GFOFG8cJUkahskldTGvFT9isVhwa2HxHhnsSD4DFhsnxc2XQ
X-Google-Smtp-Source: ABdhPJwxHKu7FuMPwsV3/K93KbzrQVZacplDFFF1AqhALknBpGVJrTL9S9TggZdWzsPWSAJamrYeqbYL7FXnvQQ5smEHI6uIWlTf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9e:: with SMTP id h30mr8559944ila.195.1630116678280;
 Fri, 27 Aug 2021 19:11:18 -0700 (PDT)
Date:   Fri, 27 Aug 2021 19:11:18 -0700
In-Reply-To: <0000000000004e5ec705c6318557@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d2a0005ca951d94@google.com>
Subject: Re: [syzbot] general protection fault in legacy_parse_param
From:   syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        casey@schaufler-ca.com, christian.brauner@ubuntu.com,
        daniel@iogearbox.net, dhowells@redhat.com, dvyukov@google.com,
        jmorris@namei.org, kafai@fb.com, kpsingh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        paul@paul-moore.com, selinux@vger.kernel.org,
        songliubraving@fb.com, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        viro@zeniv.linux.org.uk, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has bisected this issue to:

commit 54261af473be4c5481f6196064445d2945f2bdab
Author: KP Singh <kpsingh@google.com>
Date:   Thu Apr 30 15:52:40 2020 +0000

    security: Fix the default value of fs_context_parse_param hook

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160c5d75300000
start commit:   77dd11439b86 Merge tag 'drm-fixes-2021-08-27' of git://ano..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=150c5d75300000
console output: https://syzkaller.appspot.com/x/log.txt?x=110c5d75300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126d084d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16216eb1300000

Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
Fixes: 54261af473be ("security: Fix the default value of fs_context_parse_param hook")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
