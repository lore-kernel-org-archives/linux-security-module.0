Return-Path: <SRS0=DyZ0=VX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC119C7618F
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jul 2019 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E23422BF5
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jul 2019 22:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="17VtZ02i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfGZWOG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:14:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33466 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfGZWOG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Jul 2019 18:14:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so52888014ljg.0
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jul 2019 15:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tM6iRcvs2oyT/Wt34pW7ORo4I6mVuCJbX7XV+vt6GyM=;
        b=17VtZ02iyN18SKHkZeksu8ybrTXnDBYaB6pUGE0u2GqW19a3eN9TIX5k0/f4h9t5HO
         yaXE/S9pGdF+wFpa26PyPxUg6dlIeTtdcCQAGJTbWX2g+iDoVuWNdO2UuuuhL4v34lr+
         +vcixfn5Tgx3dXaOZpO476FinvXLRXCOJpOvvOu8uyAi7CroNjfwUVvEAQ7Ot5S4Yxxu
         NauuHeM7fEZKHAUNgLZRDGBQY3XrpcPU9ylD9xgzI7PxYIcF5CTnx0xazjGrOlg/ubPW
         sMaT3qyInNKzLouIUJ5BVIol2ligsh0hP3/xTi1c3dJ11XqDDkGutSrGnIuHt4chxJCY
         P6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tM6iRcvs2oyT/Wt34pW7ORo4I6mVuCJbX7XV+vt6GyM=;
        b=Uc5x9qP5hA0fYqghhY1J8dLeYCs9H/B9NF4hWKOVLUp25p4xhvgBjcq+Ghj1LGp5LF
         7YDiDJOC/1X4Tnw2ZOJZF0JwD8f5uZVXAXAHxEGbYKW2kpfMcMz3dNIexhyaxdza3UBr
         94TWj4/c6OvX5jE7cTj7WA6yr8C4T8eNlYik5tanhAYdIATlvQj0cpoyNvPIWom6Ijf/
         KB1vlUwECyqZpk7pIC320ZIbo4OiSFTwMJIt1povUwLaKoMSqZ8lno1zsGvY2DySS8qL
         5eVpiHxFU5GQWMp2pshpUzOR8lhOSCMQAjVeZyYu1ZeWY5OmQ2SKq2/SAui2v0B9umDz
         7R1g==
X-Gm-Message-State: APjAAAVmjhpyakV3W38RHOPg+jhd7FxLGgrkRdIkwRWvB8B7anS2exGS
        tWCpozRicb39eR1I4A+OJ6th1PgW3Ag5AUw5qQ==
X-Google-Smtp-Source: APXvYqzcW7BFPRKH5zQXIM0uI4BFE2T9Ag129+7Kta5szZyKk08AVmLt88TF2Pb++oK4r+lUCHS4epYfiPg/jw+yusQ=
X-Received: by 2002:a2e:9858:: with SMTP id e24mr27285211ljj.91.1564179244320;
 Fri, 26 Jul 2019 15:14:04 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Jul 2019 18:13:53 -0400
Message-ID: <CAHC9VhQJ8oDqX09AdrvLJAgweaBcxETCw547CSiRyApRguXznQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.3 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

One small SELinux patch to add some proper bounds/overflow checking
when adding a new sid/secid.  Please merge for v5.3.

Thanks,
-Paul
--
The following changes since commit ea74a685ad819aeed316a9bae3d2a5bf762da82d:

 selinux: format all invalid context as untrusted
   (2019-07-01 16:29:05 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190726

for you to fetch changes up to acbc372e6109c803cbee4733769d02008381740f:

 selinux: check sidtab limit before adding a new entry
   (2019-07-24 11:13:34 -0400)

----------------------------------------------------------------
selinux/stable-5.3 PR 20190726

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: check sidtab limit before adding a new entry

security/selinux/ss/sidtab.c | 5 +++++
1 file changed, 5 insertions(+)

-- 
paul moore
www.paul-moore.com
