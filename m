Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5491C433ED
	for <linux-security-module@archiver.kernel.org>; Mon,  3 May 2021 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B557611AD
	for <linux-security-module@archiver.kernel.org>; Mon,  3 May 2021 21:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhECVnU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 May 2021 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVnU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 May 2021 17:43:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3027AC061573
        for <linux-security-module@vger.kernel.org>; Mon,  3 May 2021 14:42:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u13so5398495edd.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 May 2021 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=T+XjJ3dALnd0wG0aJMGSCh1rng0ubFs/IjGWlTrspJM=;
        b=Ybd9vvSWTOAC080D7jgCAv7+YqxcwtOyKIBQn8P36iYgh5OsJbjamKtIFBMxKP6A0n
         E+JYycOY4SIFpNC1Uq2HVYATPhDy8mEk9QD9cCTRyWnJIqzj8yJLsJqHKv96rz3Hrp1H
         JYlnFcu3VGzWBqNAN7T+Ban4hA1BFWlkGncr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=T+XjJ3dALnd0wG0aJMGSCh1rng0ubFs/IjGWlTrspJM=;
        b=B6KyV+2J97dUxftg5EaEPanmhQLWKKKx+aOcXsNa49mKm90QZVu8fHJGIONn+aH8t8
         frcN9bY1DR7a1J8hafx9TvQND/NQBfpb9o0ZnQ1G2/Juk5Pb7Cu42hweGjNP4lJMBAq+
         pMvVmbotuIPoHkEmbP4coySA7IB65UI+W6qy4+zCX8wWIxqskWSXkEIiNYcXbEJ+L1eC
         vawvbeR+FbdEUDr9RQM8sTcw2lgbnLy08OW//kUYWmNjkwEeY9zpejYjY7+tA5TFNRoO
         /K8s1ZcUn9mYjOdq6iKtmpyqwIwrNI7Yn6uP0eI5FCsWEBOrCTb0kBgUZ6eRzd1YpSBP
         wGQg==
X-Gm-Message-State: AOAM532qIOzwJgof3WwaZI26lgXaIeklDK11tqeBnybe5Yz1EumLurJ/
        fFIgae846+nhw8llVRbDKPsmlWKrd/xiBf8sEkXhNie/6mzcTw==
X-Google-Smtp-Source: ABdhPJyveRS3brIE3ehtHcriSX7MMFHgnM2+onNaMlB5JadrRCdNkKRzvACmNxg2rvC7wz9F4XEGv3gRsAYEnvlZq3s=
X-Received: by 2002:aa7:c150:: with SMTP id r16mr22009605edp.82.1620078144962;
 Mon, 03 May 2021 14:42:24 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 3 May 2021 11:42:13 -1000
Message-ID: <CAJ-EccOdLW1+8xx8=PRHzSjy4kVaVOUave0pAXF5b=cD4w3=pg@mail.gmail.com>
Subject: [GIT PULL] SafeSetID changes for v5.13
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-5.13

for you to fetch changes up to 1ca86ac1ec8d201478e9616565d4df5d51595cfc:

  LSM: SafeSetID: Fix code specification by scripts/checkpatch.pl
(2021-04-26 16:36:50 -0700)

----------------------------------------------------------------
Simple code cleanup

This pull request just has a single 3-line code cleanup commit to eliminate
some unreachable 'break' statements that come after 'return's. No
other work was done on SafeSetID for the 5.13 merge window.

The commit has been in linux-next since 4-26-2021. I forgot to add the commit
to linux-next until after the 5.13 merge window started, which is why the commit
is on top of the 5.12 release. I'm not really sure which
release/commit the patch author based the commit on, but doesn't seem
to matter in this case since the commit is obviously correct from
looking at the code and the commit applied cleanly on top of 5.12 --
so I don't see applying this on top of 5.12 as a case of losing any of
the testing/development history of the commit.

----------------------------------------------------------------
Yanwei Gao (1):
      LSM: SafeSetID: Fix code specification by scripts/checkpatch.pl

 security/safesetid/lsm.c | 3 ---
 1 file changed, 3 deletions(-)
