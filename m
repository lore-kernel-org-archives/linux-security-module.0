Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A5C433E6
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Jan 2021 23:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3021B208C3
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Jan 2021 23:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbhABXIw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 2 Jan 2021 18:08:52 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:47821 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbhABXIs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 2 Jan 2021 18:08:48 -0500
Received: by mail-io1-f71.google.com with SMTP id q21so9686393ios.14
        for <linux-security-module@vger.kernel.org>; Sat, 02 Jan 2021 15:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xiEz0zPMyUpnKzLhYUnlv16mJTBk47GYHjbMemvYGag=;
        b=pDhY9Csw1+x3tsIbYlAmHalRUh/S3erBlv6RBwJLLshbKg4dVwZMHJ+WvqdyPsj+Ff
         B+vr8oNEEIh7dETGffi4T/yHgqIPPCEnyogV7laVpoxd7EmePtZO/kKbB0CojfQigWKS
         YFbg9SeBPhYGbU8RrSldox3pnZasNTQgaFpGq2QLVwdXcI3R6tndbxTI0dftzt4NE3zE
         YXnKtuNNbCR0WTzqSghGaTTTYVTPjyOSPTO/Y62FezCpzIV+RiDKEWXBhPVYbnZ7ehwg
         YVpzxOacRdXxYMv+TWbmyweWOrO0+yKDks3m24JMQ0Jv6UFQMUlTbXomARXPxAl9m7rS
         pP4Q==
X-Gm-Message-State: AOAM533n+HL3ghviR2Nx4W7k2LtsCE+g7Zan3378+7n2yJPiiC/j+7MA
        0WTSD8sJ6MNgPYQxCYMUgea16+IgPABfeNclBlvDKepxoUwe
X-Google-Smtp-Source: ABdhPJw5aPB63tv+UKyWH6P3GLw1/joSnocDf9Va4zkVn9W6ovN0OmH9m4h5GDMUABDOGXo/PpQv9dQg0Tviuv4SPWoyM7fs5DD8
MIME-Version: 1.0
X-Received: by 2002:a92:1508:: with SMTP id v8mr37962807ilk.162.1609628887224;
 Sat, 02 Jan 2021 15:08:07 -0800 (PST)
Date:   Sat, 02 Jan 2021 15:08:07 -0800
In-Reply-To: <000000000000880dcc0598bcfac9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b157705b7f2eefd@google.com>
Subject: Re: possible deadlock in process_measurement (2)
From:   syzbot <syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bhe@redhat.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mike.kravetz@oracle.com,
        richard.weiyang@linux.alibaba.com, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot suspects this issue was fixed by commit:

commit 15a8d68e9dc23dc9def4bd7e9563db60f4f86580
Author: Wei Yang <richard.weiyang@linux.alibaba.com>
Date:   Tue Oct 13 23:56:33 2020 +0000

    mm/hugetlb: a page from buddy is not on any list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13612350d00000
start commit:   1590a2e1 Merge tag 'acpi-5.8-rc3' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=18a1619cceea30ed45af
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c79dbb100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169bba3d100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/hugetlb: a page from buddy is not on any list

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
