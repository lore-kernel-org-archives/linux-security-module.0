Return-Path: <SRS0=DAbT=7W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A2AC433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jun 2020 18:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E762067B
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jun 2020 18:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gMJRP2Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgFIS0w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgFIS0w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Jun 2020 14:26:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9AC03E97C
        for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2020 11:26:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g1so17157337edv.6
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2020 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ygqvsD0x+BbV1wuNC2xCZ5dHDCQ7gpdLfW+BMG8uWyI=;
        b=gMJRP2ExsJ50SFbC9ybxykye/BOmpO0Mmk5xjtQXAFd+RDLthcueyJef3K6tveVy7c
         aetriQfEKsh+SXOFQEa3VE7ejZ9PlNXv6K3VZn4Z5u2qzJ4UKn0OTV+TFlzfvWnrHXCI
         vg4WbFh0pcCBwayx445MqT7dVJiY3hklyjXOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ygqvsD0x+BbV1wuNC2xCZ5dHDCQ7gpdLfW+BMG8uWyI=;
        b=dt9eQ2f+5Deu9r0eqtkPHc4n1CB0ymV7MWJgLt9G6Y2q0KXS/K+0Nxwy4qfBbSXW86
         SQWaTu+FLRiNJdegy4BWYXcUK5iZvE1/qTvt/4qfqdJTt1W8TjwZ9uA9VasQCu41w+fU
         rhxGFYa6Snn+NHhWUFWNjAwkiy6XCcHSLml+7k+8oqtMQD6dfJrQvGr+OsDWbv0m4Wl/
         wWg1mz/IaWuEx0bDuK5SdOb21kFOdXIbSt0QJezknBfH7Snamnt2hyEZJkPm9CabiMHB
         ZO2yHuhQsuITJVnYCrc3UTcxfL/KbhOl9w8nHiynDbIdLNykPxyZ3Qfv8uJARM6erVQE
         WIDw==
X-Gm-Message-State: AOAM531epIY4dGvdS0MD4ltQAvVswMOrxUqe3CK8vRpbXurptQ7V+PtC
        d7zFTGev4NY2zpu9kKKlsoqr7aG2/GXyNgvDkWmKcw==
X-Google-Smtp-Source: ABdhPJwNvYT9kZwhYb2THprAReSfSna7/wbiV65MZjhc8iQ1NpqjhjP5P+5xWG4F0cGxS+pnggLKOr9rp3axT3iKbb4=
X-Received: by 2002:aa7:cb53:: with SMTP id w19mr26953081edt.328.1591727210443;
 Tue, 09 Jun 2020 11:26:50 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 9 Jun 2020 11:26:39 -0700
Message-ID: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
Subject: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/LSM-add-setgid-hook-5.8

for you to fetch changes up to 04d244bcf92f525011e3df34b21fc39b0591ba93:

  security: Add LSM hooks to set*gid syscalls (2020-06-09 10:22:13 -0700)

----------------------------------------------------------------
Add additional LSM hooks for SafeSetID

SafeSetID is capable of making allow/deny decisions for set*uid calls
on a system, and we want to add similar functionality for set*gid
calls. The work to do that is not yet complete, so probably won't make
it in for v5.8, but we are looking to get this simple patch in for
v5.8 since we have it ready. We are planning on the rest of the work
for extending the SafeSetID LSM being merged during the v5.9 merge
window.

This patch was sent to the security mailing list and there were no objections.

Signed-off-by: Micah Morton <mortonm@chromium.org>

----------------------------------------------------------------
Micah Morton (1):
      security: Add LSM hooks to set*gid syscalls

 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      |  9 +++++++++
 kernel/sys.c                  | 15 ++++++++++++++-
 security/security.c           |  6 ++++++
 5 files changed, 40 insertions(+), 1 deletion(-)
