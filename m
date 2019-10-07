Return-Path: <SRS0=9mRN=YA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E34EECE58C
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Oct 2019 22:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1904C20867
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Oct 2019 22:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="V7oSDnKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJGWwK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:52:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43468 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfJGWwK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Oct 2019 18:52:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so15407668ljj.10
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2019 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FVwCMABg99tdlNx6emr/YdtOOEDE07gvzo7XLhdzGn4=;
        b=V7oSDnKyrOIIH1lEp/sZO38TFu/EZpj9S6PVOsbW+YUVG6TXoA6nnSvv+1IowrVkrO
         oEpxaTepVnV/Au8RTXdfGWonG11LjAsM9pra//9xN26bn3nOJy5iESRsCc2/Tq7v0TVl
         bq1F9kB1oeio/YZeioER9QWM/T3OgqgX47vKR8MQNZssgj2rCstFoGzlT0j1/IZ3KECj
         x3K2tH7ZwXNzlqc/CZnKEf4/D+nOnuzF+3y6Ke8lYq0+b5W2UWzdVpIBJyGuhpKIpRPZ
         I6bds1F3YH+e/LdURJlBDDnqNMn3pH+RyREcWw5qG880D57NHkqtOVqMwu6Du66jQjth
         BQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FVwCMABg99tdlNx6emr/YdtOOEDE07gvzo7XLhdzGn4=;
        b=hm497GXTp1x/o4pcVKMXx0IWP+r05imHvjoQmo6PxkwOs7rCBkDQ2bByGh+nfMMu/o
         FY+bkQwzPTf3dEXKF5i9iL+mNYpwCa/er6uKGs+qj/gJy4bILXbPxZV4ePAEI9A+9u0m
         UVKCwgMQKFOAU4oL702CQ1QRS+RxOxHrr99u85uF3uTSIlDEcZceiBnWuqrc/VPawb1H
         xZN80jk4mo7mZsExdTXpRx2f1nDzbI6EqIrx+DGqBH2LSMKhEDpnHLBob5TqFsbllAk1
         6PgVmtXCD0icZ3L/f4K8wVMn27XAaImQcOPUKOWJ2m1JO1rRgA9SARngt/xDg3EDuN+p
         IrTw==
X-Gm-Message-State: APjAAAUq723/zNgKntzB4oBPf/LokXAsz0cf3o1P63Jc7xZ2e5avyNfm
        sS+Wht2+MQsDeFXr1IIBE76C81/Yi81oXIjcaCTZ
X-Google-Smtp-Source: APXvYqxg+H1tip5gK9A7b7kI8GMbzy7+jVDELfMGMJgxAbv8kx7evCyysHRIFhzMqjo61LplPKBpIS/ZMq1ij+j30Yk=
X-Received: by 2002:a2e:5418:: with SMTP id i24mr18422510ljb.126.1570488726917;
 Mon, 07 Oct 2019 15:52:06 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Oct 2019 18:51:56 -0400
Message-ID: <CAHC9VhR6KFR+1F1eWyYEHnRfJyYhUP7RYf6=FsZOX=_m24btbg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.4 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

One patch for SELinux to ensure we don't copy bad memory up into
userspace, please merge for the next v5.4-rc.

Thanks,
-Paul
--
The following changes since commit 15322a0d90b6fd62ae8f22e5b87f735c3fdfeff7:

 lsm: remove current_security() (2019-09-04 18:53:39 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20191007

for you to fetch changes up to 2a5243937c700ffe6a28e6557a4562a9ab0a17a4:

 selinux: fix context string corruption in convert_context()
   (2019-10-03 14:13:36 -0400)

----------------------------------------------------------------
selinux/stable-5.4 PR 20191007

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix context string corruption in convert_context()

security/selinux/ss/services.c | 9 ++++++++-
1 file changed, 8 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
