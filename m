Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89E0C433F5
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Feb 2022 22:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355825AbiBCWa4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355822AbiBCWa4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Feb 2022 17:30:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13440C06173D
        for <linux-security-module@vger.kernel.org>; Thu,  3 Feb 2022 14:30:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ee12so8365954edb.8
        for <linux-security-module@vger.kernel.org>; Thu, 03 Feb 2022 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=U3YvCn/HrD/HLrQa4da2DKOuBsVCbCmCsg7ulvfRUQs=;
        b=H+zIBOm0GBrFikps9VmjNbRgeZfS2yMDVxS8UeY8ew2OXA2DyyvV9emXLMoP3p8lJb
         BWvqF/rEQCfVsmE1qKnIts7E6/ERYKcnYnqrHzdewOf36mcLwT/l1ttXBnBBlIzjMVnh
         32un7hmF2TpE6jmuJnnjgzs0B9eUsNjxYCeyUEVg2MSWOXZ7xSsQk7UyFRIKSkKevdPP
         HVrY6HKjIW9N0RzQlG90HJK0d1gDIMImksoSQUuM8bRkLEQ534NQaM1W6+Hw/GQmJzZr
         1LPjWEf2ua+LdFT/CgLkqIUd9Wiin6mudKprQOtBXatlPm5tXRetlV4E0be0fSsHnNWK
         /5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=U3YvCn/HrD/HLrQa4da2DKOuBsVCbCmCsg7ulvfRUQs=;
        b=ALdM7Obwu6bOkN1qP0yFQgMXu9Gn32KExXi6JNIQMpBL/yhudxcOKwSvz51wWluI9k
         A11dKfgG06mdJNz1WAcLu1Ww9UXrlZFGsexJ2UPdxE3rfr1ZefADfz8bABC1o6VA+k6f
         4911R3xtRh6blheTA70LK11rn/zAndaJoRmCEMHP0Eqe9kfg+br0jLORtd9+vgBXxYXH
         qGkTEtUgHKyTRxs2gkxbtgLQhevzPplq3ZJqsbL7QnfhjHdTLfT68BMnjwl6dqAzyow/
         TAP7vhW7yqqs92vyuZ+q3lY6X4w7X8Tk8xgsNpO+6J4u3i48ZS27vz35bnQJA4W681PQ
         EClw==
X-Gm-Message-State: AOAM5319CswCORnjpfZcwMq+3y4r28uQjtERJR6HC59rtz7ARqKXg3GT
        lQu/bPKRCobi4IzmpuvZWqP6EOK37b539vgwdcLoZ8D+milx
X-Google-Smtp-Source: ABdhPJx+OpOd8KdK7VhlWOaLYW3heLDcuXuVW0BTpITGujHHsQT/fbLIs07GJryAxfkW3PcNVDgV5myxMMt+/2hdOhk=
X-Received: by 2002:a50:ec0d:: with SMTP id g13mr300369edr.427.1643927454425;
 Thu, 03 Feb 2022 14:30:54 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Feb 2022 17:30:43 -0500
Message-ID: <CAHC9VhQcLpAAXgs1oqB2WvturqvkMguYM40d=AK+LDSTnzAARg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.17 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus,

One small SELinux patch to ensure that a policy structure field is
properly reset after freeing so that we don't inadvertently do a
double-free on certain error conditions.  Please merge for the next
-rcX release.

As a quick FYI, I didn't catch the missing 'Cc: stable...' marking on
this patch until I was putting together this pull request, so if you
see a force-pull on this branch/tag that's why.  The tag used in this
pull request is signed and the patch itself is pretty trivial but I
just wanted to mention it.

-Paul

--
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

 Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220203

for you to fetch changes up to 186edf7e368c40d06cf727a1ad14698ea67b74ad:

 selinux: fix double free of cond_list on error paths
   (2022-02-02 11:02:10 -0500)

----------------------------------------------------------------
selinux/stable-5.17 PR 20220203

----------------------------------------------------------------
Vratislav Bendel (1):
     selinux: fix double free of cond_list on error paths

security/selinux/ss/conditional.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

-- 
paul-moore.com
