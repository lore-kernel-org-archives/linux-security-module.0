Return-Path: <SRS0=jFhn=R2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDD9C43381
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Mar 2019 06:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5692083D
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Mar 2019 06:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCWG6B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:58:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51030 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfCWG6B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Mar 2019 02:58:01 -0400
Received: by mail-io1-f72.google.com with SMTP id s24so3568420ioe.17
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2019 23:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+jHD7zt1qXUVETzDrb4TXsejELYIvphHth1sfbXCJ4A=;
        b=ni9jgUW5ZWoKCBxKLQvjJlSHeUaJO4kMTAczvmJJ7yb1vWz4e2Cp6+0Wub47L/iIVE
         /oisZnCQSFCoTQOLkq7B4ojI0s47JSoKjX+wOUHTpC8C1qeeZt3+VfDCpHm2UpM3jP/o
         7sjGkCk9udbtX6oerF5tG/0br2rS2Ol1oSaQR21qxErggXD4hbu9yoxskJYY/dS7nWwo
         Dox5sNkDhyL5uLik27lqBDymsc5cmeoV9nslfO5FCzJhHQSjSlEBrKirtItH6qVu4+K6
         //4SWdyoLBpQlX17KGFfVdck5tmTKoAqUSPKmJTfoAuv+adYkydr0BoTNc11f6uZX8/9
         zdTQ==
X-Gm-Message-State: APjAAAUMae+D6uJ5+/z6hX6FUiZ5De7fKA9EYnLz9Eb1mVf/yXbwUu+p
        MNg/YEUMHtlMrlYEkhZTWcq3WPhTZdYtKJnXMiYZlmnQhkr7
X-Google-Smtp-Source: APXvYqywqECM9/Qy92UXMEsDYx1iP1dfg9HZOliwz/kdC2P/qr0XuINM0xz3ri0JvJsG92CT7IWy2/Am1ma+Blh3R0ZglJZjHXnS
MIME-Version: 1.0
X-Received: by 2002:a5d:8597:: with SMTP id f23mr9525256ioj.148.1553324280668;
 Fri, 22 Mar 2019 23:58:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 23:58:00 -0700
In-Reply-To: <00000000000033ebee0577262a98@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8654a0584bd7d5d@google.com>
Subject: Re: INFO: task hung in process_measurement
From:   syzbot <syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com>
To:     airlied@linux.ie, dmitry.kasatkin@gmail.com,
        dri-devel@lists.freedesktop.org, james.l.morris@oracle.com,
        jmorris@namei.org, jsarha@ti.com,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tomi.valkeinen@ti.com,
        zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has bisected this bug to:

commit 8fe5616b20e5742bb5fee0e77dffe2fc76ac92a0
Author: Jyri Sarha <jsarha@ti.com>
Date:   Tue Jun 14 08:43:30 2016 +0000

     drm/tilcdc: Restore old dpms state in pm_resume()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10daff1b200000
start commit:   291d0e5d Merge tag 'for-linus-20180929' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12daff1b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14daff1b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8212f992609a887
dashboard link: https://syzkaller.appspot.com/bug?extid=cdc562bc26a2b2b0a94f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e285e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1237fe81400000

Reported-by: syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com
Fixes: 8fe5616b20e5 ("drm/tilcdc: Restore old dpms state in pm_resume()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
