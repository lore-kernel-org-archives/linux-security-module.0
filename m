Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE5BC3DA79
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 21:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiL2VOx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiL2VOw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 16:14:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2B12764
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:14:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b2so20041681pld.7
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCaO9/WtALgdTe0NS6YOvFELXlseKC/rnA/3CkUWgNw=;
        b=jx1C9oaM3RmXJMuPnsRF9xFDOggeDG++0sZzKboUWbis38z9TkHxJ2hF9a+axg/YUi
         Hs2A6N711LcuKVIWbuBSdWWvpu7n8PGk0pgEtJ71Ro/GY8ze4OKi3uukTV1sRHGEVIsF
         YovtH2OQtGgLU7/xN68mRflm/Zv5lbYHtbBDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCaO9/WtALgdTe0NS6YOvFELXlseKC/rnA/3CkUWgNw=;
        b=16L3/fl5KunVSirjqttJm07JC0zrJs3nfDVsbkRPiFHm2oE8z183IL/fLwdmO+tYlo
         1v6GsMd6oWXk3S9WWptzJHhjoM548UhAGAAC3zhwE99zCEUYOY/HWgZ2iByAENG2GWpP
         7WBCQRiqvoK6UbZ5BxfiKT2HeaRkrSefm14NEnHEWJDhm8cbbkiljZTeg3MVIKYDbT05
         dS5W8Py4K7BAvTasz6EWGlM4oYt6EiVoOJbc/VityxJEuqmul4D4mZyIuRAvPp/IBWQb
         fVHqPolo0v2kwj5pJ94r5MAQ6DexZqRjfZvMj8Bc4MCq8oAZtdwCIsdGf67dGqvUxumG
         8GXQ==
X-Gm-Message-State: AFqh2kq44FhtgJWxtq4YOklHJ6+oYxMJ5HeRd1/XIDR544wk86s1yMk1
        8ufz09hssOmINj4AIpi/1ie9+Q==
X-Google-Smtp-Source: AMrXdXuzQMjDcqDlKBE1pKj4MXQ42wkI0LwpCGJ/EApCuzF1JY+Ua0tCBrIhaMuFKJ90ORC5FHJxvQ==
X-Received: by 2002:a17:902:ead5:b0:191:1b:68e0 with SMTP id p21-20020a170902ead500b00191001b68e0mr39087873pld.36.1672348491659;
        Thu, 29 Dec 2022 13:14:51 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b001899c2a0ae0sm13413966plr.40.2022.12.29.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 13:14:51 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v7 0/1] selftests/landlock: fix test when overlayfs is
Date:   Thu, 29 Dec 2022 21:14:46 +0000
Message-Id: <20221229211446.3154454-1-jeffxu@google.com>
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

Jeff Xu (1):
  selftests/landlock: skip overlayfs test when kernel not support it

 tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

