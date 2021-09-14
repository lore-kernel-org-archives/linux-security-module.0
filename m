Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FEC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 10:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF04361108
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 10:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhINKaH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhINKaG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 06:30:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FCD660F21;
        Tue, 14 Sep 2021 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631615329;
        bh=IothWu7mCcEpfkccHVCp122mEcJcmkyW3Tzq9Brg0d4=;
        h=From:To:Cc:Subject:Date:From;
        b=TI7IjmyK6rB156grO+FnLIpz+kC8luvhmMaVvZCScsz/BZ21THgUKHYZtg7IJothM
         ubTq3/jqoIzMWOXx0k9tZWs74+4pqqtCvR8cw22fgL+8g6DiXBLeBBCWYHWyIcYASf
         Nx85o8CSRuu/hpoyhl98dppRgyOmmZ4NrWdKDlQepBkPkjZ+6LTrJTv7pKuY9cQ3ck
         SLaaLdsOUxrd+KO4JZRIqqe+y6g2d6cZlqpYtaAVIBEGNXa4mMSTXwpDBe7xgwED+Q
         XuyM6DXhtB7huGV1Kstqv0ft6ZT9CaK560MI9gTuyYN2vDhoJ51KM1AknRs/RWiRJh
         +KSQIePrkRZrA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
Date:   Tue, 14 Sep 2021 11:28:37 +0100
Message-Id: <20210914102837.6172-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

CC_HAS_AUTO_VAR_INIT_ZERO requires a supported set of compiler options
distinct from those needed by CC_HAS_AUTO_VAR_INIT_PATTERN, Fix up
the Kconfig dependency for INIT_STACK_ALL_ZERO to test for the former
instead of the latter, as these are the options passed by the top-level
Makefile.

Cc: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: dcb7c0b9461c ("hardening: Clarify Kconfig text for auto-var-init")
Signed-off-by: Will Deacon <will@kernel.org>
---

I just noticed this while reading the code and I suspect it doesn't really
matter in practice.

 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 90cbaff86e13..341e2fdcba94 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -29,7 +29,7 @@ choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
 	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
-	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
+	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at
-- 
2.33.0.309.g3052b89438-goog

