Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E76C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE538205C9
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 17:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfCYReB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:34:01 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58850 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729503AbfCYReB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 13:34:01 -0400
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2PHXxQs012133
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 13:33:59 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2PHXsF4002607
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 13:33:59 -0400
Received: by mail-qt1-f198.google.com with SMTP id l26so10847337qtk.18
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 10:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=WMLZConRHnx6ldf/cno9zlt7rwhXHmyz2T/baU6kol8=;
        b=Z1yk7fFrnhZXdadQFlLq1Qbp12+79zlZbUYcVNyQkcCaXTTC+4i5av95LiPUkiT8Ih
         0NK3k1diwZdLboPjCWVq/5cdp5ySr9lAcIojD0tYhMKfPDKcbs9SwZdWKbQq6GVgXr/e
         ZvZMYFTIz0hPWMkl9DDEcS97QGgrt7lFGaxxkeaI/Y3i4PXkQ1G6K+TyTeon+++ETnJ1
         g3DnGBUXOT1BENVaTHHmItTo4RRriro+73wdXyfZIkTRHdbvlN3+Oa2M85IeOTXEPQp6
         l6nfsTrrkjg/7X29DzFTQidpHdJEsy7fUOz1Prr2Ume2lGNvl6OY3PRneJv4ENEqGV+k
         VBJg==
X-Gm-Message-State: APjAAAVEa80W06FEXSa/aFXbAsBj7cwNQbm8Qxr2SVrwCqFtaSwaqSbM
        7mPYUUpo6qfgRHfHW1J0zEUHj3f6qbhu4JiKlX1s+IkQ2HfQQoiD4//xPpR7YvEsBAVi4dr61j+
        ZF5A7vj3fgSHzSRcfiVH6CgUU9YwcJbohmCoVD+Gkt0kjUwM=
X-Received: by 2002:aed:2a22:: with SMTP id c31mr22310438qtd.49.1553535234088;
        Mon, 25 Mar 2019 10:33:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwn0COyDnvv5zKe7+VXUhCEKLOqyqSI7+2tndw3byZosddZgAMrIJSDoJbJ0G9u+a7SZLq1/A==
X-Received: by 2002:aed:2a22:: with SMTP id c31mr22310414qtd.49.1553535233757;
        Mon, 25 Mar 2019 10:33:53 -0700 (PDT)
Received: from tongs-mbp.workgroup (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id c18sm10911516qta.2.2019.03.25.10.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 10:33:52 -0700 (PDT)
From:   TongZhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Repost: Missing security_mmap_file() in remap_file_pages syscall 
Message-Id: <A6FCC3DA-C72C-4B59-A27E-E91F85949608@vt.edu>
Date:   Mon, 25 Mar 2019 13:33:51 -0400
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, rientjes@google.com, aarcange@redhat.com,
        dave@stgolabs.net, kirill.shutemov@linux.intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Shen Wenbo <shenwenbosmile@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Dear Kernel Developers,

We’d like to bring this up for a discussion again.

Several months ago we posted an email discussing a case where remap_file_pages() has no security_mmap_file() check.
At that time we were told that do_mmap_pgoff() will base the new VMA permission on the old one.
But somehow we still think the check is needed, for the reason that the advisory could first do a 
mmap() which can pass SELinux check then remap using a completely different file or region of file,
which could possibly pose a risk.

Thanks,
- Tong

The original post is pasted below:

8<—————————————————————————————
[1.] One line summary of the problem:

Possible missing security_mmap_file() in remap_file_pages

[2.] Full description of the problem/report:

We noticed remap_file_pages syscall uses do_mmap_pgoff without LSM check: security_mmap_file().

This system call passed user controllable parameters to do_mmap_pgoff().

We think that this LSM check should be added in order to be consistent with other cases,
for example:
in system call mmap_pgoff(), shmat(), they all have security_mmap_file() check before calling
do_mmap_pgoff().

[3.] Keywords: LSM check
[4.] Kernel information
[4.1] Kernel Version: 4.14.61

8<—————————————————————————————





