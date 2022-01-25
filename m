Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685EDC433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jan 2022 03:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382431AbiAYDmW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jan 2022 22:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415619AbiAYBtW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jan 2022 20:49:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC9C06179A;
        Mon, 24 Jan 2022 17:49:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F06161227;
        Tue, 25 Jan 2022 01:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF29C340E4;
        Tue, 25 Jan 2022 01:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643075361;
        bh=n9p4chGrfYBwW/8m0BAudbbep+5r1Wm8/mnKLL8vO50=;
        h=Date:From:To:Cc:Subject:From;
        b=Ar5k98RnWiRSPN29uouVjK20XA+S3kp5Bmh/FpFPdRkWyG5bqLbXGtB/+ViplKv1Z
         LVKO9qdgIZpRP8Ov980O62sx1tliLoM+OXG36W7eaSLaIcKXxF7swqBkUrytIqpFjR
         FqOJcNGLbVhReIiMZtLVZrlN4MbJ3ohqo+RGDhordrHNc2lCsPABNXcpJWRh9P2gnH
         MIot5EieNl7H2rhuY+/61advXPqbMNeZQUi95UYK/GLDpp/4BAO0UjIN9qF/Hg6Rop
         CoTGd7RpLHQYNpAbpsJo9rLsOHpqCJfPmd36mR3Tj8LhImUoplYuMSKnn9ArSpxIS/
         4ugEgQeFM0THw==
Date:   Mon, 24 Jan 2022 19:56:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] apparmor: Use struct_size() helper in kmalloc()
Message-ID: <20220125015606.GA28243@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
security/apparmor/lib.c:139:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 security/apparmor/lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index fa49b81eb54c..5eda003c0d45 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -136,7 +136,7 @@ __counted char *aa_str_alloc(int size, gfp_t gfp)
 {
 	struct counted_str *str;
 
-	str = kmalloc(sizeof(struct counted_str) + size, gfp);
+	str = kmalloc(struct_size(str, name, size), gfp);
 	if (!str)
 		return NULL;
 
-- 
2.27.0

