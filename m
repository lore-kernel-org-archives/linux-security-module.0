Return-Path: <SRS0=EAti=ZO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A343C43215
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Nov 2019 07:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DCF20659
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Nov 2019 07:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKVHTC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:19:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:36430 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfKVHTB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Nov 2019 02:19:01 -0500
Received: by mail-io1-f70.google.com with SMTP id z12so4267534iop.3
        for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2019 23:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1cUcF3hJKE1N4P4WyddDQmYqcNZvFWfBMCxod9a8Ztg=;
        b=dRQBPr4+b+vnr1MzLXlgu7OA46iNjxB2gCcnCfBZkAsasB/wMJgHA9AJBQGUd18snV
         9rVLW4ts0B0PEfpavIloQG3NAKLVrSewPIuJKdvdJUEpQBxlHIqDOrZ4WJQ37X5r1YnV
         e6P72UBcIxAikFp9CGmhflPTZG2c85Ao1USV9hhOsLhOXXZnh6a5awSvqsHrNxq/VRpS
         sEXhM9faf/ggQyD3D+DYlc+adgBfrQGnwJjpIVsfSmSoGYbOL+v3WXmu67RA7tdXiI1v
         rBF+gBqLuajs1Ya8H1Mn+x0e78eKFhgk26tP6VyO2/Q6LASA7A2SrwEO7qPvpaySbk3m
         rK8w==
X-Gm-Message-State: APjAAAUoggFT0xuZ1B41y8paSc4741tzUAKqtlaxbKwMLMDIRS8ZKFwE
        wjL5bqClhmtKvAjYcN279IxEAT1wRFWlIhhDQdwsUfcvT29P
X-Google-Smtp-Source: APXvYqz7YQR3Ph2vR2o/JQ6Y+lyCMjwoGf4NoUXt8LcJXs8VhmLZT2rHE8UUekeFjpMnBlonHBj9FzFznQfgOmicwRtoMmh+YsCi
MIME-Version: 1.0
X-Received: by 2002:a92:3602:: with SMTP id d2mr14510424ila.7.1574407140976;
 Thu, 21 Nov 2019 23:19:00 -0800 (PST)
Date:   Thu, 21 Nov 2019 23:19:00 -0800
In-Reply-To: <000000000000e67a05057314ddf6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005eb1070597ea3a1f@google.com>
Subject: Re: general protection fault in __schedule (2)
From:   syzbot <syzbot+7e2ab84953e4084a638d@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, frederic@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, jmattson@google.com,
        jmorris@namei.org, karahmed@amazon.de,
        kstewart@linuxfoundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mingo@kernel.org,
        mingo@redhat.com, pasha.tatashin@oracle.com, pbonzini@redhat.com,
        pombredanne@nexb.com, rkrcmar@redhat.com, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has bisected this bug to:

commit 8fcc4b5923af5de58b80b53a069453b135693304
Author: Jim Mattson <jmattson@google.com>
Date:   Tue Jul 10 09:27:20 2018 +0000

     kvm: nVMX: Introduce KVM_CAP_NESTED_STATE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124cdbace00000
start commit:   234b69e3 ocfs2: fix ocfs2 read block panic
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=114cdbace00000
console output: https://syzkaller.appspot.com/x/log.txt?x=164cdbace00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=7e2ab84953e4084a638d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150f0a4e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f67111400000

Reported-by: syzbot+7e2ab84953e4084a638d@syzkaller.appspotmail.com
Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
