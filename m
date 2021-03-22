Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08AC433C1
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C110061931
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 11:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCVLAm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVLAQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 07:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A28216196F;
        Mon, 22 Mar 2021 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616410815;
        bh=sJLoNty+wwm4+Go0Hzkw/T77KfmhnOqZSI9qPp8jce4=;
        h=From:To:Cc:Subject:Date:From;
        b=WrYx991CBrs8kdnI4PCFoh3ZISLWwW39e/9siKIMbKN+QbkWLZuuZuIwZf8UC9O4x
         z9Ou7IJe7OYV0bdrm2ySyK0v3JgG571s32TTBfixe06OwtaIl52CLLUy8YzmJo4upx
         B8rmUqVVnwyKRRF8dmFwJoCnojK+7WrEl0+7sNP8/CTuyuBSlPwONI7rWLOPrX8qqo
         gA8aqXXqJ257rKfgOwXizVRd4w2/pOFvrcYMSzfSaV5nomtPQPXuDvLEwQjig4d4c8
         0Kaz9f0zND7g2Xb4HOzMjHDwfKw4ACDSlcV1TCZ0BPFF6b5BDKpqjfzZHh5xamYymg
         WGpJ5cdohmYeg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: avoid -Wempty-body warning
Date:   Mon, 22 Mar 2021 12:00:08 +0100
Message-Id: <20210322110012.1570589-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows a warning for an empty macro:

security/apparmor/label.c: In function '__label_update':
security/apparmor/label.c:2096:59: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
 2096 |                 AA_BUG(labels_ns(label) != labels_ns(new));

Change the macro defintion to use no_printk(), which improves
format string checking and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/include/lib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index 7d27db740bc2..67fbb81a11f3 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -36,7 +36,7 @@
 #define AA_BUG_FMT(X, fmt, args...)					\
 	WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
 #else
-#define AA_BUG_FMT(X, fmt, args...)
+#define AA_BUG_FMT(X, fmt, args...) no_printk(fmt, ##args)
 #endif
 
 #define AA_ERROR(fmt, args...)						\
-- 
2.29.2

