Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB0CC05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBQD0c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBQD0b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:31 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142994BEA8
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:30 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f10so4314262qtv.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdRxv1RtQfXxhQJougOqU4ZDN+0HvYJ25uWNDB/9CQk=;
        b=aGwRZ20UPWiUgtZc2FfC5kDFW4M8C/nZlLjrR5Q8hbP4Wy/s/Kh/sPmbEC0RkwUJOW
         kLaCMRILsmXA56r5+t69Olv0NtN1F/la54N0GSMe1Q5tyqeq8wXurFai9ffHlH04OGWM
         lqbLJ3ML26YYY3yq0pm5RyEaJZ3/2SthE8PNAEheYeL7U1VCQt1fOrmwzuM5wYMEXKCM
         C1CSdO2ZMtkzUYko3/DMvGl+c4XEbaiAP3WuWF5wSPx9hNoIVNV1RxvoKHleCrguMnBN
         jweGBdeCY4TuWZ5frYFI6rLZWx4g65YA0D0sjw9SRs60zVKzArej1S7es6fca3nQDylL
         iegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdRxv1RtQfXxhQJougOqU4ZDN+0HvYJ25uWNDB/9CQk=;
        b=cbHIGl4YP28rkKBGevRtObphG25omjvQYtR0aNIG+b0bRPSo0sEuaOg9EtDUlnHRRB
         oF2ZvdDQWPXCKHaUZIbKARQwKnzvifz7a5afjwSIpMf00FcbGrQCiAZL0tf0M9WgjS+L
         Ow0GpEhMPp/tbxD1hAylOLlR/BUcXFbL6yd5UkPCYfxJvumfej2+nq/Ilg+lUIxPTrsZ
         +vhcScDUf6yVqVGboc0xOsce3s3jQNj/G0KgyVv5NoiT9O/83KfF60SjvAG2ZrNmQpKm
         /+RRvNR0vi8dGWFclyobKzSkdNBIXHrBZGLHAIR2a+4PYJH1qfs5+zQOYBEbjJTy8ZmC
         +mIw==
X-Gm-Message-State: AO0yUKXUcyu8frOmNqJmvHF0B/rLtPRJHc3aHAc/O87y1Ceu2ff84YPo
        EpzM12B9XNnamKHWjWszhav3DHRLtv53vOo=
X-Google-Smtp-Source: AK7set8BvJoabARBDY3V0bOBZZjp7ESZ9tmwloG0tY5tAwwfcriwOrwOipO99Ku7dL6w75dHYSJxyw==
X-Received: by 2002:ac8:7d49:0:b0:3b8:6d92:bf62 with SMTP id h9-20020ac87d49000000b003b86d92bf62mr13473263qtb.46.1676604388763;
        Thu, 16 Feb 2023 19:26:28 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id j63-20020a37b942000000b0073b8512d2dbsm2450026qkf.72.2023.02.16.19.26.28
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:28 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 00/22] Move LSM hook comments into security/security.c
Date:   Thu, 16 Feb 2023 22:26:03 -0500
Message-Id: <20230217032625.678457-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello all,

The LSM hook comment blocks are a in a rather sad state; separated from
the hook definitions they are often out of mind, and as a result
most of them are in varying levels of bit-rot, some severely.  This
patchset moves all of the comment blocks out of lsm_hooks.c and onto
the top of the function definitions as one would normally expect.
In the process of moving the comment blocks, they have been massaged
into the standard kernel-doc format for the sake of consistency and
easier reading.  Unfortunately, correcting all of the errors in the
comments would have made an extremely long and painful task even worse,
so a number of errors remain, but the worst offenders were corrected in
the move.  Now that the comments are in the proper location, and in the
proper format, my hope is that future patch submissions correcting the
actual comment contents will be much easier and the comments as a whole
will be easier to maintain.

There are no code changes in this patchset, although since I was
already adding a lot of churn to security.c, the last patch in this
patchset (22/22) does take the liberty of fixing some rather ugly
style problems.

 include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
 security/security.c       | 2702 +---------------------------------------
 2 files changed, 1710 insertions(+), 2616 deletions(-)


