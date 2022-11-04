Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285FC4332F
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Nov 2022 17:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiKDRAU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKDRAS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Nov 2022 13:00:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D53F31EFC
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 10:00:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 13so14916329ejn.3
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMPeioCk2Uzr+ddpLtxu9paT20dadQsJOcXKRo4DcPw=;
        b=Bps9I+bFEEe+HCYPvs/DutKxeUvXuEiPoosbxIFdrpdrts3hY1rDaCoxza00D4OH7v
         TnrW2UxHvElVhuW+6fDHoKWnCOZ0lp3ZjbJSAyuBJ9CcxhyhlHO0w9jyVuem/F+Tu4zs
         r82nlaHhzcni2EIHP7pCmj58nCSxt/k4XYV6n8dwbFlkRRf2obHxK+wsdb8PCuRqHKJn
         7vOJT8FAkakrFhlWaKtbOJ/hHGQ+GXKsLncgllPZ4KtVJYy7EVsmeSZYODNQ5Byi78Xh
         eiMjRY3954ujPdC1uO6trChsEPnYfjwzqp6VPmOKaeGuC10ELQplHc8xpiLOe+ZbIT2r
         +0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMPeioCk2Uzr+ddpLtxu9paT20dadQsJOcXKRo4DcPw=;
        b=jx+87Vcd7czcv/jDqIDV4BpaYZmS+CETeqRxbyb6K5pGwcgAthflZchqnOH2A/XzsA
         kiowwszflNJGPO9lUbclrFMXyl8t4mIHzsVsEu6QqHVegFWRywTosBEcIA4xSKi3RgFO
         24oz7jOZ9XwNwlSkB4Bz5GP92dNL+NV0dp7u6rFD/ZAeWizdMQJsGDW7M3+/3EUIPx0V
         d8GrVb2WuZ43mBZpEqUH8QBQLa3oUzI+t4m0U3VVhFbqkogeueoDXBNQXODcXZVhl8bg
         +aHNYZlYNiZspOKcNLG9WOi8V+VDe3WvRh04O3rmDybJ22BonNAkxcm2qEMEZ76sW9MN
         d2/A==
X-Gm-Message-State: ACrzQf03gUYRIvX20s6QkaRxe3u2xbyo24qZkUFm8V3q6uspg5lxmjYd
        h+oBrUhTvkL7a3iDeFt66aIFhs72OcQ=
X-Google-Smtp-Source: AMsMyM5OJ5+RyQNLLvLVsun17JPZcSZzRMpnFD76efwABv6H5NQSFGTKQxqdc+Fq9/sjmtnpuKmZPg==
X-Received: by 2002:a17:907:783:b0:76e:f290:8b5 with SMTP id xd3-20020a170907078300b0076ef29008b5mr35936270ejb.395.1667581213886;
        Fri, 04 Nov 2022 10:00:13 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b00770812e2394sm2014834ejz.160.2022.11.04.10.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:00:13 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2] samples/landlock: Document best-effort approach for LANDLOCK_ACCESS_FS_REFER
Date:   Fri,  4 Nov 2022 18:00:08 +0100
Message-Id: <20221104170008.3082-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a comment to clarify how to handle best-effort backwards
compatibility for LANDLOCK_ACCESS_FS_REFER.

The "refer" access is special because these operations are always
forbidden in ABI 1, unlike most other operations, which are permitted
when using Landlock ABI levels where they are not supported yet.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index fd4237c64fb2..901acb383124 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -234,7 +234,21 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	/* Best-effort security. */
 	switch (abi) {
 	case 1:
-		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
+		/*
+		 * Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2
+		 *
+		 * Note: The "refer" operations (file renaming and linking
+		 * across different directories) are always forbidden when using
+		 * Landlock with ABI 1.
+		 *
+		 * If only ABI 1 is available, the sample tool knowingly forbids
+		 * refer operations.
+		 *
+		 * If a program *needs* to do refer operations after enabling
+		 * Landlock, it can not use Landlock at ABI level 1.  To be
+		 * compatible across different kernels, such programs should
+		 * fall back to not using Landlock instead.
+		 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
 		__attribute__((fallthrough));
 	case 2:

base-commit: 4bc90a766ea5af69c12ca1ea00b7fc5fe1d68831
-- 
2.38.1

