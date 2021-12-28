Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C53DC433FE
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhL1VcH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhL1VcH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F56C06173E
        for <linux-security-module@vger.kernel.org>; Tue, 28 Dec 2021 13:32:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y22so78742335edq.2
        for <linux-security-module@vger.kernel.org>; Tue, 28 Dec 2021 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cHTU5eSbVn+Nq+7+XwSfl6tfJrjIWfjd65MmcAa33Tw=;
        b=e32C6fkJy9hBkegXx689ALBUQNblaYKuVEwDLVzJJ9wPRgTmwXIDmSNJ5taBcWaziO
         qXm0VQucFDSpa82knvAD0/iYHg7LCZQuQST/39ybNhF8uqdPV7LhpOHfHhtR3gFGt1Q9
         rrmtWaD/JM8DSe04Xz4o3PbkoJfxZ0/Z/tt0PUXEfXB6zPTH+WWssfyeaHTm0M3vgS97
         tyuy1xXLvIePI8jN2TtbQYFvyA/3nBU2lOMjP0OO2VGyN3j+Qup8EkTpC1kU2BCKLUb/
         UZY48OewoTL9kkOMarn1uyGF8enMMdQ7AG33l++xpfIiBUCSLO0pBxrRfobpZByjQERm
         Ag9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cHTU5eSbVn+Nq+7+XwSfl6tfJrjIWfjd65MmcAa33Tw=;
        b=UOgvu4yH7wBApCNWLzxgAZlodFGo6q/57pZncNtnsj1Elt0Rpd5ljdgyHlxrlCE1HU
         VNkBBzqjlcxg0bYXScLbJ/4LcvyO0nBp9doM3VKf2u4IpU6SqyKFeWQsX1CUeMxrw3ZE
         2TkpoqaG90CqCDOSnLjJR/u9Ceps8YHtvD3+J02gY5c8gmZx/p9WsCmnzBnkrUai/07n
         viQuTFy2TijBXzQgBZk+gj11JpG9l9qHNtKH8X0iUtOBPI83NrFeJKzKUb3QJKvVF5Re
         WF5pqGP7VaPr+Rmy41k5NTWr6D0vweT/LuFDJgKOwFdMIXw7n2WHYBxlolR1rML61qJx
         PA8A==
X-Gm-Message-State: AOAM531BzwUErf6G3SlOGLiGJCCQuAfUtDr4xNS578NbaMeWFzcoxF/9
        y2w7IDjHk5tp97zFxMOynFOS/jdFgOgMjAfksSRs
X-Google-Smtp-Source: ABdhPJzQ0p02hmA9Dta7IcVRKcye7gXhGSFiKcQLB60AX9N1OiN+KPZZOiQV2nM76TPAUe8O3ecK9jo6izsxo4LT8p8=
X-Received: by 2002:a05:6402:1388:: with SMTP id b8mr22841120edv.171.1640727125234;
 Tue, 28 Dec 2021 13:32:05 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Dec 2021 16:31:54 -0500
Message-ID: <CAHC9VhRrwLKn1mbMPjsaVwye8YVhP2Y6qxTz6pMyQoqcSFfXRg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.16 (#4)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus,

One more small SELinux patch to address an uninitialized stack
variable, please merge for the next -rcX release.

Thanks,
-Paul

--
The following changes since commit cc274ae7763d9700a56659f3228641d7069e7a3f:

 selinux: fix sleeping function called from invalid context
   (2021-12-16 17:47:39 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211228

for you to fetch changes up to 732bc2ff080c447f8524f40c970c481f5da6eed3:

 selinux: initialize proto variable in selinux_ip_postroute_compat()
   (2021-12-27 10:41:20 -0500)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211228

----------------------------------------------------------------
Tom Rix (1):
     selinux: initialize proto variable in selinux_ip_postroute_compat()

security/selinux/hooks.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
