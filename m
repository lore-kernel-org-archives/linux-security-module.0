Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB96C54EBD
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Jan 2023 05:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjAMFd1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 00:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjAMFcr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 00:32:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94A60CDF
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:32:34 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s8so14079385plk.5
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8axx3AV7ROrfEOwnPD/9/aBA9weQueHIvrzPLGkbXs=;
        b=C94Qrud1HV+68+M977Dy3QxSqt2g9o1/gZHpl7+mA6dayO3EMPR07sPDin9wjn7D4O
         fowOBGXIxafLbk3gMgRL4EZ7e8GjSjLKFK/5nGSJy1zthQkaIygksVc+lvwbYf7XpwDo
         8aJZSgvoTP3bNyOGGHYbHB8ghkfke1730mZ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8axx3AV7ROrfEOwnPD/9/aBA9weQueHIvrzPLGkbXs=;
        b=akCxa93D6VqxETylJhgoPWYSV9Y2VGQ7ol/xeoict6sWa7ASpxNMem/k5e521UcaJ9
         BHGtoX+IOFOmRtafybbLtjmUiz3GY9cbo+q9fq+qJd2DhRxd6VyPx4sfxWXKb+PhG4Ia
         8gxtFdSS2tYwdK2H8BM6SwnzrEWDfaLkh8DnR9piKruL2TLDzFm3YjcdhW3IqviIHalM
         40TCrUT8YLc7UROJ4gQz38eLrG21Eg96oMzkEeM9R84GtBRmHEsdBL5PM3CqJ4IK5Tus
         qZjNLvLoj9M5qFAm94438gxWMiAsIxau0sb0NUyM/BjDhGdTFa+6PWncNqumfYJUxyi0
         Bezg==
X-Gm-Message-State: AFqh2kqL8mVlc6TbYuyTxpCiHuh/tMO/yeOJ8c4cfWsjO38RKsBZNPU/
        RkCaNVjAmviS9SuzjFsu05xazQ==
X-Google-Smtp-Source: AMrXdXtbeUtKHMxxtG7KWRTANulPut9VXpliIrKIpmP4/RGVXGYJ+osXaCJ0RNzllyyYLPale+bCyg==
X-Received: by 2002:a17:902:6906:b0:194:6e70:8eea with SMTP id j6-20020a170902690600b001946e708eeamr1306441plk.7.1673587954352;
        Thu, 12 Jan 2023 21:32:34 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001945339354asm3450097plf.197.2023.01.12.21.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 21:32:33 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v8 0/1] selftests/landlock: fix fs_tests when overlayfs
Date:   Fri, 13 Jan 2023 05:32:28 +0000
Message-Id: <20230113053229.1281774-1-jeffxu@google.com>
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

Note: 
Below comments are raised during V7 discussion:

Currently SKIP() is applied to FIXTURE_SETUP, FIXTURE_TEARDOWN,
TEST_F_FORK, this is because SKIP() apply within the function 
scope, not the testcase.

We would like test infra to have a dedicated environment 
check hook (FIXTURE_ENV_CHECK) in test infra, called before 
FIXTURE_SETUP(). If the environment check fails, the remaining 
of the test will be skipped. The benefit of these are two:
1> if env check pass, in theory, the test should pass.
2> if env check fail, no need to call setup, so no need to cleanup
resource.

v8:
style change, no logic change.

v7:
https://lore.kernel.org/all/20221229211446.3154454-1-jeffxu@google.com/
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


Jeff Xu (1):
  selftests/landlock: skip overlayfs test when not support

 tools/testing/selftests/landlock/fs_test.c | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

