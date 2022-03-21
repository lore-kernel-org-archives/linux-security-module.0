Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD38C43219
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Mar 2022 11:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbiCULxO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346869AbiCULwk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Mar 2022 07:52:40 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6531567BD
        for <linux-security-module@vger.kernel.org>; Mon, 21 Mar 2022 04:51:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so10297113iow.5
        for <linux-security-module@vger.kernel.org>; Mon, 21 Mar 2022 04:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=83x05As+hpEzsvG90JcF+MmesN/BPt2Ioqkif/dNrHk=;
        b=OPp+fAA5xLhvS/shk05Wsl+qSahGtKAwGC2RE8fG7dzKm87oBHumZkRykvoGoDG4fi
         gm+3OkLzM6B6IX8UgbNCQLCxDMJyXC3UTmiaQBGFwI2MSi/LFI/t6ACrdO7d8dwKwXTV
         d3hhqV4MS9MB1osjctCuZ1RFnb20Oqv0FOdqCxcu+jP1v8jIh35IREcs6wjlld0STg/u
         lEcHiUYvCPiDFbd9OtRUkmCNkHx0ez1ZWPLmc+v+hCc9ApUMbrtAv/ZuuRVaQOgSkO/R
         lV5S7J5DsgUtLa30VjoO8WcO1j+aLq9nl+M+nKYAH9YiXnch7/iDDBXE5DF7Um6G2KpE
         8+qA==
X-Gm-Message-State: AOAM530juBFk/fSzftzgHOREO7PrimtIC/jN5S6RVQQcIwGFMIR4GYda
        YvEp8CvhUhsK6KtO7XZcQt/vn9eKXl6U6WuSMQxy/DtVuZFN
X-Google-Smtp-Source: ABdhPJx14oK7C0sSXYkXvGjnk1LhI7Nd7dI8dHsjz4cUx21fQNuejsWZo8ywfyvHHwBn1WhJ1G6ZfQQvui4PEZ82btWAzDlAb8dg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3816:b0:31a:60:22c9 with SMTP id
 i22-20020a056638381600b0031a006022c9mr9837348jav.146.1647863469476; Mon, 21
 Mar 2022 04:51:09 -0700 (PDT)
Date:   Mon, 21 Mar 2022 04:51:09 -0700
In-Reply-To: <1019067.1647862887@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc8eaf05dab91c63@google.com>
Subject: Re: [syzbot] memory leak in keyctl_watch_key
From:   syzbot <syzbot+6e2de48f06cdb2884bfc@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6e2de48f06cdb2884bfc@syzkaller.appspotmail.com

Tested on:

commit:         c82efd1d watch_queue: Actually free the watch
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7683c993c23430bc
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2de48f06cdb2884bfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
