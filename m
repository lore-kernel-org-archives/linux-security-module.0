Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE6C77B7E
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 01:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjFBBNq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Jun 2023 21:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFBBNq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Jun 2023 21:13:46 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B213E
        for <linux-security-module@vger.kernel.org>; Thu,  1 Jun 2023 18:13:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5664b14966bso16415907b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jun 2023 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685668424; x=1688260424;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4nydeH8fGmYfEq//3RT6MGqc1Z4XWdWvcyC0fJTwhtM=;
        b=JFBun+Pik8MgDtLxGed2bleSGjQCew45jQglAUHqtG3l9V53YpgjD3ZokHdpg2u95+
         nR3woVnNJRgAcLxwgbda8dkLv7dMAMIbAlzoqLQJUEsKtUYBApsyTpqbc7P042Sygxxd
         h7m4VmiGKxlLVAj7GLE9wuDHP+uMeFHB8rslF/yhflnSNcewswQICHjPdlKOn/CzSLi0
         avgCmxnCuYQslsl6cyl+JmCfP2xp9u5BWKAuUdpiMomu6oGeT0n594nYyRhKfCj0ifuw
         1UyLccigYVvCOx7oT453wNtRcR5Rgw1d1JSSharO0tegFGxPuP4VBIk6ifiO5wKy7r1+
         T8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668424; x=1688260424;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nydeH8fGmYfEq//3RT6MGqc1Z4XWdWvcyC0fJTwhtM=;
        b=SSlbpf/maUlGKub4mpadlcLxGlc5cYGmSvpuMWcxlL2JGyGfriDxDKb5zWa1DQJZUi
         5dYNbWRGtMtCwVmAESLeasDhVaQCwlaZ9rGyLVbJaKEV/vatcexwzINRcru2IIW8IbE2
         HFUKTSBT8pCn+oCUDU4T4VMaLljnw79rh6ko4c2h/aM059qs8iU1IPAPlJoe5hoT7QOz
         MqIkG6KapYFA92E34t7cdIYJVMqJAtxqyAe+ikkZDxGAHyXYpu7rbTG4sk3TH9BRQIPe
         dkwutAHs5lwuohIkyn27MCb98lF/ACP4vpG4z4NlAV3k+UUWOkfQZaaK6NcofQqi0P3h
         tu7A==
X-Gm-Message-State: AC+VfDyf14AlSriE7dU/ik7iMyxqKrG5vJXrjCWz4nu393XafdVgA6vH
        ZXTreCpZwesYq86lHGAMqvmbcdlWrblwxLb1xGTX+FprxwA3fGQZZQ==
X-Google-Smtp-Source: ACHHUZ7orX0SaNZQ72ZLc51WkA3Dy6WwNhQoWx2L0nYgKXT4snf9ah6BwBrapuvf/G9Xsr9zVyKYPNl1JmUAZdSPl3g=
X-Received: by 2002:a0d:e801:0:b0:561:e8d7:ac6b with SMTP id
 r1-20020a0de801000000b00561e8d7ac6bmr10789383ywe.49.1685668424300; Thu, 01
 Jun 2023 18:13:44 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 21:13:33 -0400
Message-ID: <CAHC9VhQPMmWZwS-S9FQpU5rETcizcDPK0Nm1mwXeWpykUdDLFw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.4 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

A small SELinux Makefile fix to resolve a problem seen when building
the kernel with older versions of make.  The fix is pretty trivial and
effectively reverts a patch that was merged during the last merge
window.  As usual, the commit description has more information.

Thanks,
-Paul
--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

 Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230601

for you to fetch changes up to 42c4e97e06a839b07d834f640a10911ad84ec8b3:

 selinux: don't use make's grouped targets feature yet
   (2023-06-01 13:56:13 -0400)

----------------------------------------------------------------
selinux/stable-6.4 PR 20230601

----------------------------------------------------------------
Paul Moore (1):
     selinux: don't use make's grouped targets feature yet

security/selinux/Makefile | 6 +++++-
1 file changed, 5 insertions(+), 1 deletion(-)

-- 
paul-moore.com
