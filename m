Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0DC4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Nov 2022 18:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiKGSS0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiKGSSA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Nov 2022 13:18:00 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F8B2187
        for <linux-security-module@vger.kernel.org>; Mon,  7 Nov 2022 10:16:55 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 13so32476353ejn.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Nov 2022 10:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1xgbTIlIfmdkigFlB/REbWW4NQp/nzxo9SU7qAm7Mw=;
        b=Rr/x/3B+ra3KI3CQhIYOJ1jAShEDt/OM3EfTQdLm39I3w5TC1dh9wqRmhgp6H4S+Wl
         Xu+qIFxDoaHhBvg8D4FGyYzO3GpG/Wl3+tyoU6QfkgiNvswV75t9WCZFQfsCqz1LfT7X
         d7EyzteE7GHAttgeHczy2xFT97ZSFMXBq+TjaGCRRgm4KsieSFX+pfE7OtFRXgdT69XW
         Uvs9BGAAo+wskQHhI9DTttEdITUeWk50ES9rIrbyFb+Cax9NP5cEZE6eHMgE7MayLcv6
         6yyqSvVBnxeI6msVYnQ6/eod5v7dDSlI2n6cve3gylypurYNQrJspuYJE8Dhn7Q9EP8+
         nxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1xgbTIlIfmdkigFlB/REbWW4NQp/nzxo9SU7qAm7Mw=;
        b=wmveMxS2RNNSXLb3IiLMocRdUvxqpXD1yGTtshfJsMQKytv8nD3Phnfwk1OeHQqNVl
         9VtN8fmKUXWq/erQ8wyjZU+sJIwZtKCzIXsHxcXAtR0HiJmXZwr2MkQHMzkHcWn40PUY
         FHA+celrwM5YX3LwK5WSOn26DXBH+I9NhTNwK+Mgpuct7D1CyG3UXQSCw/uBWNIwwwrL
         qGMtE04w0lQK7HFGyDbI8uTrjFuI3lpipaXEA8wyWqIwjC6mNnP+zQxHN4g3WblLZHtG
         wIr6P9i4mmrAsZe5Td5GOMFUo1rGFoGpQAhkDv0vg8aakWKDdsfCiH/P4ldvQvGkX+rz
         BmYA==
X-Gm-Message-State: ACrzQf26GYzAzrUXiyeQxg4xpCzFrtcUT8Ptry+fFlhKMaSkEUXYDRqL
        TaLDSZa4FKHKJPVD/3g47so3cFlNTN0=
X-Google-Smtp-Source: AMsMyM6qIXm9N4z8l8+gKP1aVcpEsklmtkZdDITQ0zMXB0cWK0wkaCQAmYI2f50qZZY+96682GBeUQ==
X-Received: by 2002:a17:907:1c8a:b0:782:1a0d:3373 with SMTP id nb10-20020a1709071c8a00b007821a0d3373mr47196489ejc.135.1667845014261;
        Mon, 07 Nov 2022 10:16:54 -0800 (PST)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b007ae32daf4b9sm3692638ejb.106.2022.11.07.10.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:16:53 -0800 (PST)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3] samples/landlock: Document best-effort approach for LANDLOCK_ACCESS_FS_REFER
Date:   Mon,  7 Nov 2022 19:16:51 +0100
Message-Id: <20221107181651.4555-1-gnoack3000@gmail.com>
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
 samples/landlock/sandboxer.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index fd4237c64fb2..e2056c8b902c 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -234,7 +234,22 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
+		 * If only ABI 1 is available, this sandboxer knowingly forbids
+		 * refer operations.
+		 *
+		 * If a program *needs* to do refer operations after enabling
+		 * Landlock, it can not use Landlock at ABI level 1.  To be
+		 * compatible with different kernel versions, such programs
+		 * should then fall back to not restrict themselves at all if
+		 * the running kernel only supports ABI 1.
+		 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
 		__attribute__((fallthrough));
 	case 2:

base-commit: 4bc90a766ea5af69c12ca1ea00b7fc5fe1d68831
-- 
2.38.1

