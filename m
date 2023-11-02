Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBAFC4167D
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 00:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjKBAzh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Nov 2023 20:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjKBAzf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Nov 2023 20:55:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B885119
        for <linux-security-module@vger.kernel.org>; Wed,  1 Nov 2023 17:55:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A21C433CB;
        Thu,  2 Nov 2023 00:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698886531;
        bh=JOZadfTBs66sdCP63lK4KyiGq8JzdX8fj3ltYO7ERP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8CJRvcd4M0FhWXr6Exs2MUYqFB4HK0sPKwnKkZ4rXarG4fiVlfQ6zc0IOFQiFlrm
         0ohFxar/fxSqTPbcSbtAzSvTOn4O206rPsZm6DwR7Ybw6q0/nNH0K8PLoAv0UNOLS4
         hOiZ5DSN2CHG3T0swcSiZ4mCmclVfKKU7zWOrMAbFituQAwYkilqnQyFCMQy1BXp6y
         p/QahTlteKEAFle3o3SVdkJXbKYm19X97/wT6wW9uSEWwMEwFrx2Q13yk/hSEKFn5c
         nDpacizOEaRa/F1hLho+8ZM01w9EfLcMag4XRC5lFJQr8OIEEQnGKjUcrtqgT9H7u/
         WDaqGY9pf+t7Q==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, renauld@google.com, pabeni@redhat.com
Subject: [PATCH v7 1/5] kernel: Add helper macros for loop unrolling
Date:   Thu,  2 Nov 2023 01:55:17 +0100
Message-ID: <20231102005521.346983-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231102005521.346983-1-kpsingh@kernel.org>
References: <20231102005521.346983-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This helps in easily initializing blocks of code (e.g. static calls and
keys).

UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
argument as the index of the iteration. This allows string pasting to
create unique tokens for variable names, function calls etc.

As an example:

	#include <linux/unroll.h>

	#define MACRO(N, a, b)            \
		int add_##N(int a, int b) \
		{                         \
			return a + b + N; \
		}

	UNROLL(2, MACRO, x, y)

expands to:

	int add_0(int x, int y)
	{
		return x + y + 0;
	}

	int add_1(int x, int y)
	{
		return x + y + 1;
	}

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/unroll.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/linux/unroll.h

diff --git a/include/linux/unroll.h b/include/linux/unroll.h
new file mode 100644
index 000000000000..d42fd6366373
--- /dev/null
+++ b/include/linux/unroll.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2023 Google LLC.
+ */
+
+#ifndef __UNROLL_H
+#define __UNROLL_H
+
+#include <linux/args.h>
+
+#define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL_, N)(MACRO, args)
+
+#define __UNROLL_0(MACRO, args...)
+#define __UNROLL_1(MACRO, args...)  __UNROLL_0(MACRO, args)  MACRO(0, args)
+#define __UNROLL_2(MACRO, args...)  __UNROLL_1(MACRO, args)  MACRO(1, args)
+#define __UNROLL_3(MACRO, args...)  __UNROLL_2(MACRO, args)  MACRO(2, args)
+#define __UNROLL_4(MACRO, args...)  __UNROLL_3(MACRO, args)  MACRO(3, args)
+#define __UNROLL_5(MACRO, args...)  __UNROLL_4(MACRO, args)  MACRO(4, args)
+#define __UNROLL_6(MACRO, args...)  __UNROLL_5(MACRO, args)  MACRO(5, args)
+#define __UNROLL_7(MACRO, args...)  __UNROLL_6(MACRO, args)  MACRO(6, args)
+#define __UNROLL_8(MACRO, args...)  __UNROLL_7(MACRO, args)  MACRO(7, args)
+#define __UNROLL_9(MACRO, args...)  __UNROLL_8(MACRO, args)  MACRO(8, args)
+#define __UNROLL_10(MACRO, args...) __UNROLL_9(MACRO, args)  MACRO(9, args)
+#define __UNROLL_11(MACRO, args...) __UNROLL_10(MACRO, args) MACRO(10, args)
+#define __UNROLL_12(MACRO, args...) __UNROLL_11(MACRO, args) MACRO(11, args)
+#define __UNROLL_13(MACRO, args...) __UNROLL_12(MACRO, args) MACRO(12, args)
+#define __UNROLL_14(MACRO, args...) __UNROLL_13(MACRO, args) MACRO(13, args)
+#define __UNROLL_15(MACRO, args...) __UNROLL_14(MACRO, args) MACRO(14, args)
+#define __UNROLL_16(MACRO, args...) __UNROLL_15(MACRO, args) MACRO(15, args)
+#define __UNROLL_17(MACRO, args...) __UNROLL_16(MACRO, args) MACRO(16, args)
+#define __UNROLL_18(MACRO, args...) __UNROLL_17(MACRO, args) MACRO(17, args)
+#define __UNROLL_19(MACRO, args...) __UNROLL_18(MACRO, args) MACRO(18, args)
+#define __UNROLL_20(MACRO, args...) __UNROLL_19(MACRO, args) MACRO(19, args)
+
+#endif /* __UNROLL_H */
-- 
2.42.0.820.g83a721a137-goog

