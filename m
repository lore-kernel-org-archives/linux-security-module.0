Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4D6C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Sep 2021 10:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC986101A
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Sep 2021 10:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhI0KLA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Sep 2021 06:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233722AbhI0KLA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Sep 2021 06:11:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 966F760FD7;
        Mon, 27 Sep 2021 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632737362;
        bh=gfQEGx5g0xl76EupJ/cDQRNtdcMb0gv24w6dGuQwiu0=;
        h=From:To:Cc:Subject:Date:From;
        b=KZmuvh+1CQjYlPm5SKI67HUtfM5tcwCpayz1QlUkbXTMDRpV4wfvBOMKk+Op1to2f
         0OaIzuxa9hdTmHuD4JmbUnTfaCaM662rqU+AnR1rTWB0gbTFTK/Y9hwkNqYHnQk2qS
         H88/Eh+GjDLSVCVsmtr3SVQH2gBmExS3PQYYHwNA9KWiJZs0tVRkGE/KvTebC7YtPX
         unvbmTZneIOAqqUgEVHHpNZkpvazl5vskiqRzBL6e5Wz2na29xZ66cfkGE2QIFMhwo
         A9at6ygWp+e51v71Ms+NAOuS6zQZtGYj1VTeYOe9yQG3RQOOVXMe6nnWfjinJ7cguM
         4yiWpeqPQrd6A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] apparmor: avoid -Wempty-body warning
Date:   Mon, 27 Sep 2021 12:09:12 +0200
Message-Id: <20210927100919.1500526-1-arnd@kernel.org>
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

Acked-by: John Johansen <john.johansen@canonical.com>
Link: https://lore.kernel.org/all/4e3e409e-c72e-edd5-379a-60883f166405@canonical.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sentn this back in April, and John replied that it's in the apparmor
tree, but the fix is still missing as of v5.15-rc2.

Please double-check and re-apply if necessary.
---
 security/apparmor/include/lib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index 7d27db740bc2..394130a0f3a4 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -36,7 +36,7 @@
 #define AA_BUG_FMT(X, fmt, args...)					\
 	WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
 #else
-#define AA_BUG_FMT(X, fmt, args...)
+#define AA_BUG_FMT(X, fmt, args...) no_printk("Apparmor WARN" fmt, ##args)
 #endif
 
 #define AA_ERROR(fmt, args...)						\
-- 
2.29.2

