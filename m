Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AFBC3DA79
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 21:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiL2VCm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL2VCl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 16:02:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17513D75
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:02:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s7so20023809plk.5
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MF0iMBBIgQx8lTij9qzPXCtQ9FosnM/elD6oXBIT21o=;
        b=F467J3r2ns3d23cGoDKsvEepWv+veCL7aKJ9RmO5ko2M748+Kab0rJBUu4LpQeUc2+
         3dV+7pb8TrO4sRBM33O1+8m7EoX3CcTQ4HIHYjv16Ijf29k8Skq2LrheYGfVhcniJLUh
         bXcMpVNlU5EUi8zNBgWnNb5VPvZaPGB+1dZ3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MF0iMBBIgQx8lTij9qzPXCtQ9FosnM/elD6oXBIT21o=;
        b=uE/BJ1SrFrQUgsAop3vkhnjppaqhTTSwhlwyaDBbx0KpwI0dQRbFUSshF4OyupBYN9
         eQ8mHN2BPjG5tEf5yzfEXL7y+AksryQzBF0iH2TDZRiA9oE/+Ol+Pfz+T7Uwg0IGfYrI
         yIu+Q9OPM9xclwFGAQ/sI8zEFhdOJ3ZFs4aLd6+Y4XqhXC9RWLMKYTXNRXu3fBOexEeA
         ZKZJfJFgWP+0TybXjSpRGEaXBLC5LxtcA/AFfgXy+H5e8eTemGMHju9T1wnY1IQysf3V
         PUl9ZeuuIwF+ICeNJcBMWBvOeTPeXXxVc7Q8aRvg0g8AuG/ekhuN49ZwWF8JQpl9MovX
         GELQ==
X-Gm-Message-State: AFqh2kpbo7JBmOusXckv9wYnCzPeWZyo8kqynd7B6hlB3dvk/vF37VCw
        mh+T21IfI6D45C2Ld64FKRNB/Q==
X-Google-Smtp-Source: AMrXdXuS5INz7oilIkvUJb+ZOPaTPxmmtKKU43HitUw0XIMB4TeEuCjyERrQtDkd2SQBtuvKZK09uA==
X-Received: by 2002:a17:903:32ca:b0:192:7847:b047 with SMTP id i10-20020a17090332ca00b001927847b047mr16657155plr.54.1672347760442;
        Thu, 29 Dec 2022 13:02:40 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001897de9bae3sm13458444plk.204.2022.12.29.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 13:02:39 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v7 0/1] selftests/landlock: fix test when overlayfs is
Date:   Thu, 29 Dec 2022 21:02:35 +0000
Message-Id: <20221229210236.3151723-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Overlayfs can be disabled in kernel config, causing related tests to
fail. Adding a check for overlayfs’s supportability at runtime,
so we can call SKIP() when needed.

v7:
Fix bug in supports_overlayfs().
Manual test with kernel with and without overlayfs.

v6: https://lore.kernel.org/all/20221229201215.3006512-1-jeffxu@google.com/
In v4, the SKIP() was applied at FIXTURE_SETUP() after mount() fail,
however, FIXTURE_TEARDOWN() will fail. It might be complicated 
for test infra or testcase itself to have cleanup code handing the
success/failure of steps in SETUP().

This patch changes the approach, it calls supports_overlay() and SKIP()
at the beginning of FIXTURE_SETUP(), FIX_TEARDOWN(), TEST_F_FORK().
Because no modification of system is done by the test, cleanup is not 
needed.

v4:
https://lore.kernel.org/all/20220823010216.2653012-1-jeffxu@google.com/


*** BLURB HERE ***

Jeff Xu (1):
  selftests/landlock: skip overlayfs test when kernel not support it

 tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

