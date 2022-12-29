Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C8C3DA7A
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 20:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiL2UM0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiL2UMY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 15:12:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48613D74
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:12:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ge16so16624208pjb.5
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmsLucPbd8/eQ46655SBo6Wp+rkES8C03g+N69McUKA=;
        b=GwKSVGq0dRGCUgdO/pTUtvKoCrzCDlR5Eb8naEPgs9oPZsZBcneDNPKlYGBQGjUkr2
         H2b6N0bK2/5Nb2mf7kqX+3H5uCD9rYGVR5P3uenUycm0EWfOru7MJp51AD5nvLZwXpC0
         pFXaE4H6OqKCQa5Z4YU/8Rf+bQxoELRnIUEyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmsLucPbd8/eQ46655SBo6Wp+rkES8C03g+N69McUKA=;
        b=70YigTd/NEz24JjOnbo6s+79LoTY7pRWnKBSNnwtEAm99AhZCT8opG1SpRwR9Lp3I7
         as7bZ6UTJglb/KILuNmb4qAl9M4Dy1lMWOivWOYT8oNvjp/C6qTRDyWmiFhclsXsJB69
         KGv46qBZZYheqsW2WS2OA57m8SjpVruIg0fE7cbuWneqnZbmUwJ1dC71At8yleDCoMye
         kc2G4aSHQ+B19sNehkCNci+v/Rbxy0F/Sfm5yw6uAw0puB7Vk0lQFp1sBQZ6uRkWIJVv
         FcH+GhVDTl6axZCkjiGm/WJMcY69+uvJn6emtt+rc04kFh+IlPSlv+fWGjegp+s4hM18
         sbgA==
X-Gm-Message-State: AFqh2kqxX5avQ7kPa62vRIyXlZmtM6ON9vBYV57xT+pD151Qgl19LUvJ
        DoewHns1FZ+TXF7uRkDe/dWzqw==
X-Google-Smtp-Source: AMrXdXsuPMp2DSDA3ExwSSKslJSz3z+7tXL086u4uEosfF1lvRv8blJWWU6FjbU3DgKJLgfZ1JIP8A==
X-Received: by 2002:a17:903:234b:b0:192:9f2d:d6b9 with SMTP id c11-20020a170903234b00b001929f2dd6b9mr6059009plh.9.1672344743768;
        Thu, 29 Dec 2022 12:12:23 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b00177fb862a87sm13395570plb.20.2022.12.29.12.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:12:23 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v6 0/1] selftests/landlock: fix test when overlayfs is
Date:   Thu, 29 Dec 2022 20:12:14 +0000
Message-Id: <20221229201215.3006512-1-jeffxu@google.com>
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

v6: In v4, the SKIP() was applied at FIXTURE_SETUP() after mount() fail,
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
  selftests/landlock: skip overlayfs test when kernel not support it

 tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

