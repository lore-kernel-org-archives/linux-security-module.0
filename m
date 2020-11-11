Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B6C4742C
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 10:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050EF2063A
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 10:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWXi/eR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKKKpV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKKpN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 05:45:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2EC0613D1;
        Wed, 11 Nov 2020 02:45:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so2039144wrb.9;
        Wed, 11 Nov 2020 02:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQfCxdd9lfHZL2HxpazZyNkHVyN3/e1lyGU4J0L7Nm8=;
        b=kWXi/eR9bpXEcqR6HMdlwx3uxK8rFreZAPYa0jp5MxBLMJnf9nUfQkDdDge9I4U4zh
         LQYzpqKj6H03fwpTZBpLOn1yEMIsu0FEtSe+8z6LgyZTaEB2xa2UeD8dsjBErcNmT3p4
         n8J+0n1qOtVYk1H4FMO+MVyDjPkhpVVCGoUXai1Q0Ew7njRqliR4H7Ak406ZaGIRVhU5
         o5nlk0xj1jtb+e+NAI0GB1hdeeh/MTICWuTqqhMxsfqe3aiqB2AHpEs8hn/AqLrPVHvD
         sjcNM0LjPbnKcsYVlG6i6unyDHvHM3Jddb4+INGxpHqPIuQWgxlcK7o2pkvkpBcG7zDd
         K88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQfCxdd9lfHZL2HxpazZyNkHVyN3/e1lyGU4J0L7Nm8=;
        b=OhsfYIX1m4z1kvp1i8ljMKPjj4FICTH0tukrSPD2zdomWHj7+QqvSpovvduAFFrtVH
         liRbLKGCYWwenFRH2KbrZUNUIIY3WgowvBqvtynrB8LkxSPlrBi87U1LjUPCDGvf5TZv
         fmI9pp6JyzWJh+bF6q2+AfMJoGAYGhG2NxNkBEWfSVfm3TFtRa10vzOz+VaesJWJAApn
         5h+8dbakG8mfnoewMer1khSwVS4Um36yyuA+q7VgUs2/t7dI1cKFYsDLh6vTnAb9ot+3
         DuWwrv/VlL7R3EM8ONayR8h3KaEvRzrEAqg+EAvyRlWsrjtFYjLB0K6HrjATVeasdOf0
         mO1g==
X-Gm-Message-State: AOAM531AIDY2RzSs9Wx+KIg8nvT76l1Ygnzx4rg6J/mrunnYbfrXnHMm
        UjPf8JCf8iJw5UOWf2da7xUK4pw9+az41A==
X-Google-Smtp-Source: ABdhPJx2xco370midub/gDlZx0qtge/7pjUmIJ2cKuUZAchpfZusrIHz0xm2gpp/yasatifvcDIaiQ==
X-Received: by 2002:adf:804b:: with SMTP id 69mr28946750wrk.274.1605091512294;
        Wed, 11 Nov 2020 02:45:12 -0800 (PST)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id u195sm2111549wmu.18.2020.11.11.02.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:45:11 -0800 (PST)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com, casey@schaufler-ca.com,
        penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mortonm@chromium.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [PATCH v4 2/2] docs: add fail_lsm_hooks info to fault-injection.rst
Date:   Wed, 11 Nov 2020 10:44:09 +0000
Message-Id: <20201111104409.1530957-3-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201111104409.1530957-1-a.nogikh@gmail.com>
References: <20201111104409.1530957-1-a.nogikh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Aleksandr Nogikh <nogikh@google.com>

Describe fail_lsm_hooks fault injection capability.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
--
v2:
- Added this commit.
---
 Documentation/fault-injection/fault-injection.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 31ecfe44e5b4..48705adfbc18 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -48,6 +48,12 @@ Available fault injection capabilities
   status code is NVME_SC_INVALID_OPCODE with no retry. The status code and
   retry flag can be set via the debugfs.
 
+- fail_lsm_hooks
+
+  injects failures into LSM hooks. When a fault is injected, actual hooks
+  are not executed and a code from /sys/kernel/debug/fail_lsm_hooks/retval
+  is returned (the default value is -EACCES).
+
 
 Configure fault-injection capabilities behavior
 -----------------------------------------------
-- 
2.29.2.222.g5d2a92d10f8-goog

