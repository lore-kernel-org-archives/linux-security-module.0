Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA267C32792
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 21:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiHVVVI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiHVVVF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 17:21:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC86D520A0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 14:21:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id h27so8916295qkk.9
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc;
        bh=5RQRl53BMMbcV3UBpkUvMw0kVRmuERrDcog8F29EXKk=;
        b=XxTaY88L6YyDi4q4wmCk8eVhxMP+iLwiTQfB+DWrM8PTcGLBvO8N71ubEFVUt83vYA
         wdnD/fZmhMHsA9CfRa30LDpuYjZBFBee5jEo0dzDLzzEvvtbBR8P9Btu6S9Njwn6lz9q
         D5p7andXJ/eFjisCdzDEogdJKwtPCaGa425/HNYL6WAYn8VN/00nGGzBslxj6FN2XFUe
         RL/93480d1VSeSt+2h/uOGO55rmFRfWs6Cah4Wzys7DoYbZ+2N0WLpHIs+LMiA/yddYU
         40Hu9gdGDOMjJyTZm4sLwRZdlJ+jh/vXDMuYpQ26A1fELppD8lNBdIUPP8kKDUzyzMn2
         D5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc;
        bh=5RQRl53BMMbcV3UBpkUvMw0kVRmuERrDcog8F29EXKk=;
        b=tEtADMGtsc7GOkX3zLwAJwoNK6BEw/+fvRd5yr1Xdc9D1NRrnfUGxuGUdee+0UOLcw
         lPZILpylkEjNpLpG/kHdFW9WfAGuFlUnk+OdAe1hnXGl+0yD8uoqOc+Lawi9e9/0GhpZ
         TMEWgpJYFV5qqoyxXjK3XPEq2sa6869pvHxh6t2P3nujvD9THwo5KoMxbk97X1ryV9jq
         jBYY4VluEOsDvQdyo0n8hssxt4YZBixwJtXCmHAl1ehlkgwp7zCook9saGzcXYsVzT2M
         6fY3JWswrc7XKM8AoITi9PmfCuQ1/54F8ALmfTi9bHnV7cOSv2Q+fgRWLDxoO/lQswkU
         SH0A==
X-Gm-Message-State: ACgBeo0DJPrz2zzgxuLzmsOcwwDzQdgRyVeH30p9RNQfFlWiZKzDe9Uz
        6/qAceApIaoO/th3288Bbs5tBFuEilFn
X-Google-Smtp-Source: AA6agR5HRvyFM8nlzlvFRus8PX8jMZnrW3P+rNROq/qiCc53eyykqUoFMwCw7xUqAQrocMjVabC3Ng==
X-Received: by 2002:a37:cc5:0:b0:6bb:93e9:54f with SMTP id 188-20020a370cc5000000b006bb93e9054fmr13958588qkm.114.1661203262755;
        Mon, 22 Aug 2022 14:21:02 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id m1-20020a05620a290100b006b95f832aebsm11627625qkp.96.2022.08.22.14.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:21:02 -0700 (PDT)
Subject: [PATCH 0/3] LSM hooks for IORING_OP_URING_CMD
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Date:   Mon, 22 Aug 2022 17:21:01 -0400
Message-ID: <166120321387.369593.7400426327771894334.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patchset includes three patches: one to add a new LSM hook for
the IORING_OP_URING_CMD operation, one to add the SELinux
implementation for the new hook, and one to enable
IORING_OP_URING_CMD for /dev/null.  The last patch, the /dev/null
support, is obviously not critical but it makes testing so much
easier and I believe is in keeping with the general motivation behind
/dev/null.

Luis' patch has already been vetted by Jens and the io_uring folks,
so the only new bits are the SELinux implementation and the trivial
/dev/null implementation of IORING_OP_URING_CMD.  Assuming no one
has any objections over the next few days, I'll plan on sending this
up to Linus during the v6.0-rcX cycle.

I believe Casey is also currently working on Smack support for the
IORING_OP_URING_CMD hook, and as soon as he is ready I can add it
to this patchset (or Casey can send it up himself).

-Paul

---

Luis Chamberlain (1):
      lsm,io_uring: add LSM hooks for the new uring_cmd file op

Paul Moore (2):
      selinux: implement the security_uring_cmd() LSM hook
      /dev/null: add IORING_OP_URING_CMD support


 drivers/char/mem.c                  |  6 ++++++
 include/linux/lsm_hook_defs.h       |  1 +
 include/linux/lsm_hooks.h           |  3 +++
 include/linux/security.h            |  5 +++++
 io_uring/uring_cmd.c                |  5 +++++
 security/security.c                 |  4 ++++
 security/selinux/hooks.c            | 24 ++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +-
 8 files changed, 49 insertions(+), 1 deletion(-)

