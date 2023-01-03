Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9AFC3DA7D
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Jan 2023 19:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjACTDg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Jan 2023 14:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbjACTD0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Jan 2023 14:03:26 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770C13D02
        for <linux-security-module@vger.kernel.org>; Tue,  3 Jan 2023 11:03:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 79so20722607pgf.11
        for <linux-security-module@vger.kernel.org>; Tue, 03 Jan 2023 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYuXF/xhbatqqwlVeDNewy3h2s684bPrGs1lgBcTuXc=;
        b=a6by68GVn4/xiS1AfdFvM3+LXvD9np8i2pJpy1GpHaEd0E5CtdOMbFe5IBpywjnqqK
         lrB/QWax7bKGYH97mJxt9D+WCyBmEvpClgX9QSmzFJlZtK10P/uwt1axdzfJjt+UMn54
         jrdgtySXB4/cUt+fFHDQhqHOZPxqwvow208yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYuXF/xhbatqqwlVeDNewy3h2s684bPrGs1lgBcTuXc=;
        b=7m5d8wn8NCr7cpvkejeC5idF7plh5t/M+JBRA52UhW7q52LAVNRu9h00KF3Na3xL3u
         TdvhRNciSv78PFKxx04xE5meQOnA9WZB2jIW/kJ+OHuNWyjo9UI4+rYf1icDWA7QJKNQ
         nA7YbruJt0rD03GZJbi9A+lRnGXzMVl1WIbbyfgQXbgDLIwW9hN1GDhNsPF8AcK2C7oB
         QlxQTauVz2lKQfRLUMAKGHBze3M1A3qmhlHpKGQsDI7U26xrJt1sV8ss8NtioLsNyge2
         1sYFY/lqkDcJlNHum9aPQvRwQROPhAZ5f52o4uUJzNcsAcpFGhEtDVFXGgGC+b7k6DP6
         aFbw==
X-Gm-Message-State: AFqh2ko22gTzxpAO7y14xxmEGAfTW1CqSs5tr0gR2iUEZvEhxvgPPTYY
        P5It0PBGOrY3fQj09ow7Qlta7A==
X-Google-Smtp-Source: AMrXdXsgYGjNo4ABKr27qGsKuiMpq5bdgHnA/CBEuwS+Id1WLicdWc0jVAvh6PzTRoEIOM+O5UVeiA==
X-Received: by 2002:a62:1704:0:b0:581:e3db:3b56 with SMTP id 4-20020a621704000000b00581e3db3b56mr17730911pfx.32.1672772604799;
        Tue, 03 Jan 2023 11:03:24 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id v189-20020a6261c6000000b00582b4617735sm2147787pfb.194.2023.01.03.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 11:03:24 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v4 0/1] selftests/landlock: Fix selftest ptrace_test
Date:   Tue,  3 Jan 2023 19:03:13 +0000
Message-Id: <20230103190314.3882177-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Landlock ptrace failed because YAMA is enabled.
This patch check YAMA value and skip related tests.

V4: 
- apply can_trace_parent and can_trace_child to smaller scope.

V3:
https://lore.kernel.org/all/20221227140244.1041292-1-jeffxu@google.com
- add can_trace_parent and can_trace_child to handle yama value.

V2:
https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
- update from code review comments.

V1:
https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
- skip specific testcase according to YAMA value

V0: 
https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
- skip entire ptrace when YAMA is not 0.

Jeff Xu (1):
  selftests/landlock: skip ptrace_test according to YAMA

 .../testing/selftests/landlock/ptrace_test.c  | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

