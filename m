Return-Path: <SRS0=AbGf=V5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD11C19759
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 23:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAF520657
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 23:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="S8j3gBwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbfHAXCF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:02:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46601 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfHAXCF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Aug 2019 19:02:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so47228332lfh.13
        for <linux-security-module@vger.kernel.org>; Thu, 01 Aug 2019 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UnHL4pQNtVIpmyGSDaBU0opI82QJrnu+hxREmY3sJnY=;
        b=S8j3gBwqjNIVIXHuusoTq/wIkZLgWjhuFIz0S6xa6GB0QdlV77aKPSFhstTdfhH6yg
         3KChmnFoNg3q6R4hxSVNOK4/oCSOW46G2lWHtGapX0XHgXXYthy+yNrmCsR1nkDPwMaI
         2YOHsM7LGgZXNVzk/VWVAxL+vZNH2bw5TNT/avFE/3LdooClmqSo1G26wU6leBviuuRg
         GnCoGVATQEfQcyS2NfKvb2hxgZbr47+y64b6IEGp0FvfLNMOmQj0bkmVLZzdirewKxC3
         q3QEeYX+DnwZHnsWX6eS3GXCIH+bsVQeIb/Lz3ZWDzHPCrw3M4WhHItlxg0yfl2Cuxtt
         KEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UnHL4pQNtVIpmyGSDaBU0opI82QJrnu+hxREmY3sJnY=;
        b=lk8MQnQPJL/+LsTy4tw2k8m7BBBDuxtHXrvUj6PMqMRY7xBY82qY2FVbtlQN9+nUr1
         paJ+QLQx3TGrT+oKOQvBclsVlvPxeBg64vzecW9GH6GcFZJ8LpJZV/GOOeQo5Z4zGk9A
         3BZ9FGvwLZqkM9yXwd1jerPvWE+T0hHxQUoNghTGnjOnqhaW6ke5wdQN+9nMNaaiXF7k
         9ZgbT3QnnW8Jo9bhLtQpofiEavuyG/fNrwpov5BI/75FjKOCH/I9fsNqZelBbWy1/8Wu
         4EKHiTey5oRUj7Qxdg8KnkF6dn8QppWep0suPoRzVC6lCpApXX7W2hrUC4rs6EjlZ0/o
         PBDw==
X-Gm-Message-State: APjAAAUs70c/LFxAmMfRn1IDLMy2ZI0uYAmuyIuSRX1joiOy13uV4kU2
        kUgpefLLL3gOp1y/ojVRg3igAv5sXhNQOcDe6L1APU4=
X-Google-Smtp-Source: APXvYqxyaCNAjbqpHWFZK+AUXX7LyIVRGbMS7v+RE8gYdSAnmhvcQoXTfUd7I7k/boWiCeenW0zF1/0piDjuzQvzZ7A=
X-Received: by 2002:a19:4349:: with SMTP id m9mr61806805lfj.64.1564700523663;
 Thu, 01 Aug 2019 16:02:03 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Aug 2019 19:01:52 -0400
Message-ID: <CAHC9VhQ6X==anxZ435QAdbjiWtGiVA3LQbBbp0vhbzOhW6NvCQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.3 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

One more small patch for Linux v5.3-rcX to fix a potential memory leak
in an error path.  Please merge.

Thanks,
-Paul
--
The following changes since commit acbc372e6109c803cbee4733769d02008381740f:

 selinux: check sidtab limit before adding a new entry
   (2019-07-24 11:13:34 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190801

for you to fetch changes up to 45385237f65aeee73641f1ef737d7273905a233f:

 selinux: fix memory leak in policydb_init() (2019-07-31 16:51:23 -0400)

----------------------------------------------------------------
selinux/stable-5.3 PR 20190801

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix memory leak in policydb_init()

security/selinux/ss/policydb.c | 6 +++++-
1 file changed, 5 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
