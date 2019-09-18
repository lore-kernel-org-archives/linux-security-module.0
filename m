Return-Path: <SRS0=oQDc=XN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC3AC4CEC9
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Sep 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C9721848
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Sep 2019 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AyH57jpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfIRRlR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:41:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42692 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfIRRlR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Sep 2019 13:41:17 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so1119191iod.9
        for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2019 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=jm0GKZ+zs79GqNNWF0bZqXAiPqdnJ7mX725LngqNeLU=;
        b=AyH57jpKls0MoQw6pX8sOAAZtlVmhb3SwrHEHMt+yhenFGJbwuB3oo/i2VhokOepSL
         dshCfEkqojr3985fj9V639uHHEyl+N7jKzSr1MoOZ/S5/BxHiwxLh4Sexxgt/gp0yaU1
         URrtQmewbGhlOzKmUy1zhzP8+82zQ2ADJwkDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jm0GKZ+zs79GqNNWF0bZqXAiPqdnJ7mX725LngqNeLU=;
        b=UqO/9paO+J5eIw95RxApinBqBCGMFUohYlIY6/uzOrl3ZPc/GQJAFOlLIG5tg80He7
         nkr72hDTdf+a3KL7OqV+kPP5vGuWbfSO9Oqu91dS2sTXeUbuJJTkfR5CoW1xGj8p20SK
         9m8ekbSnXPfhcUOAZaADrZrQXN7fW1nW7uanePMftEfhvwP263FP8NtAdVPghNSy/suO
         Lah1jUlI8HQWtYVTiuF1Y2lk2bN3lJcclwlJWqAacXo8EAcJVer+mve5+gSUIr0wI9Kn
         zd5WfSQch1LJsMIHB49rYmPUS2w+0dMUdzQ+3uqobnIF2pEfkdZushvuaYtt91qHBgN7
         fVxw==
X-Gm-Message-State: APjAAAWSYY8yZy/IqOADcbShQG4bX1ojTrYiGVd6RZv4TnA74NS+eo+9
        hAfq4yF6J3z3pRDEEejMDvwmzGDFDnCFH5/Z3oGURA==
X-Google-Smtp-Source: APXvYqyqmyPlCjxTm+iq54gtMa6V2Hf3D4NA/wfYg+8rdQPOEkEMt80v6jNvqlmLrebuVHye2JqQOdf3XPODsa5VmQg=
X-Received: by 2002:a5d:9f17:: with SMTP id q23mr6584195iot.301.1568828476751;
 Wed, 18 Sep 2019 10:41:16 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 18 Sep 2019 10:41:06 -0700
Message-ID: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
Subject: [GIT PULL] SafeSetID LSM changes for 5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-bugfix-5.4

for you to fetch changes up to 21ab8580b383f27b7f59b84ac1699cb26d6c3d69:

  LSM: SafeSetID: Stop releasing uninitialized ruleset (2019-09-17
11:27:05 -0700)

----------------------------------------------------------------
Fix for SafeSetID bug that was introduced in 5.3

Jann Horn sent some patches to fix some bugs in SafeSetID for 5.3. After
he had done his testing there were a couple small code tweaks that went
in and caused this bug. From what I can see SafeSetID is broken in 5.3
and crashes the kernel every time during initialization if you try to
use it. I came across this bug when backporting Jann's changes for 5.3
to older kernels (4.14 and 4.19). I've tested on a Chrome OS device and
verified that this change fixes things. Unless I'm missing something it
doesn't seem super useful to have this change bake in linux-next, since it is
completely broken in 5.3 and nobody noticed.

Signed-off-by: Micah Morton <mortonm@chromium.org>

----------------------------------------------------------------
Micah Morton (1):
      LSM: SafeSetID: Stop releasing uninitialized ruleset

 security/safesetid/securityfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
