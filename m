Return-Path: <SRS0=3ULx=DW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069DFC433E7
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8833720878
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQcnZxYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbgJOSPb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgJOSPa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Oct 2020 14:15:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3F8C0613D2
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2020 11:15:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dt13so4923536ejb.12
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2020 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hV2kzljzkPtlmabMiMR4tfaBM+VlAVmvUSlWLpICaPs=;
        b=VQcnZxYNoqwWWKhsVR9IcKy7FA5LslWVlI7LkqdXV7QDISXJtrEr7hdM0qXaD18BvI
         u1v5WkAly0t9EDxfyBHEDAqjyC9WOAsEb+d2sdss9TF/1NTLtysgYR/SYJsB4gbHDr03
         MBlwWDi7RwFVCPkhqB3xjwh1dcr9zDvi9XVuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hV2kzljzkPtlmabMiMR4tfaBM+VlAVmvUSlWLpICaPs=;
        b=a9R/Mo1OLmjrZi9h51e/Ocu9fyZM5B5BB0Q9VBS9Q41d6F9VPQ1sLq124bXwlIvfJu
         iP7HiNC1M1SQuvwyPkBhxW/BfkzxgNS3SJ1P2MEgh69/KpHnDbO7kxAea5G8fjYCIVI2
         WNmeRC77cSkXZVLL7fAU/NEAghIGkFfZ3KgGk3vy263WTwnBb5v5wM6/OQ3obRCF1y70
         lTlcqPghS/VDHvID2c0GVBMZ9uEleWws4RO5S0vk1CxdEbILScfB8dUyHeQPRZWi6QhT
         TVgPQq+DQmCNCFhgMa96hN3XiaVLXNMuHUr2jusZ1XPnpxglIO7jJpXuVujtWKa2K/qB
         DPCg==
X-Gm-Message-State: AOAM531JOLGmxTae1GrbVFpi/M63GkPW5WMM0sjuAdZgF9hgrzIrwfsP
        MpE59ZgexCyWfcK9yJ9n2ZSEqPFa2YJ6jtJgrFf6mtyNvAp0kw==
X-Google-Smtp-Source: ABdhPJy0H4kXoNR3cKvxKxNi/cMqUcFkeks5ROSvOXlaFHJgTp0Fq4kw3L79EnQiNzORlO6xBDY8GEyzvA/5x5lhPA4=
X-Received: by 2002:a17:906:6d0c:: with SMTP id m12mr5820394ejr.498.1602785728757;
 Thu, 15 Oct 2020 11:15:28 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 15 Oct 2020 11:15:18 -0700
Message-ID: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
Subject: [GIT PULL] SafeSetID changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-5.10

for you to fetch changes up to 03ca0ec138927b16fab0dad7b869f42eb2849c94:

  LSM: SafeSetID: Fix warnings reported by test bot (2020-10-13 09:17:36 -0700)

----------------------------------------------------------------
SafeSetID changes for v5.10

The changes in this pull request are mostly contained to within the
SafeSetID LSM, with the exception of a few 1-line changes to change
some ns_capable() calls to ns_capable_setid() -- causing a flag
(CAP_OPT_INSETID) to be set that is examined by SafeSetID code and
nothing else in the kernel. These changes have been baking in -next and
actually were in -next for the entire v5.9 merge window but I didn't
have a chance to send them.

The changes to SafeSetID internally allow for setting up GID transition
security policies, as already existed for UIDs.

NOTE: I'm re-using my safesetid-next branch here as the branch for
creating the pull request. I think that's fine, not sure if this is the
normal workflow or not. Also, I use 'git rebase vX.X' to put my commits
on top of the latest stable release. Again, I verified with gitk that I
don't have any weird history in my branch that will mess things up so
AFAICT that should be fine too.

----------------------------------------------------------------

Thomas Cedeno (3):
      LSM: Signal to SafeSetID when setting group IDs
      LSM: SafeSetID: Add GID security policy handling
      LSM: SafeSetID: Fix warnings reported by test bot

 Documentation/admin-guide/LSM/SafeSetID.rst |  29 +++--
 kernel/capability.c                         |   2 +-
 kernel/groups.c                             |   2 +-
 kernel/sys.c                                |  10 +-
 security/safesetid/lsm.c                    | 190 +++++++++++++++++++++-------
 security/safesetid/lsm.h                    |  38 ++++--
 security/safesetid/securityfs.c             | 190 ++++++++++++++++++++--------
 7 files changed, 336 insertions(+), 125 deletions(-)
