Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD11CC38A02
	for <linux-security-module@archiver.kernel.org>; Sun, 30 Oct 2022 06:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ3GLQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 30 Oct 2022 02:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ3GLP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 30 Oct 2022 02:11:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CB8E
        for <linux-security-module@vger.kernel.org>; Sat, 29 Oct 2022 23:11:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n12so22133519eja.11
        for <linux-security-module@vger.kernel.org>; Sat, 29 Oct 2022 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMPeioCk2Uzr+ddpLtxu9paT20dadQsJOcXKRo4DcPw=;
        b=X6GSvPbdfreZVzs6R0GASPhY5nFyZBPVRlxKnX0NhNSfgz35uuzx74wFnKznkbrdaQ
         eydKp5aLFtEbcz75GtHfr8K7iOEooQGITFyPpeBYvMdYGpWxpnF12Pyl4fEWts89nD6J
         L0LTVFc2c7BYN6gvEesFWmTm+a5esU2iKbbiJaNvpFy8EJHg3DHc0wymKYmwV4w/fW4i
         DJq1OD4qvSO8ceoI6evEI38bgynnUNpe+YwG78pZ8YQtSZD40blQqQovmMQC+DAcy8Mr
         P/pysEmKa35mdwt2nIyB7nHzvVbgLpC5v+mqERpLFjpCWW5fBPuov5dxhxMojQWGzfNp
         pOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMPeioCk2Uzr+ddpLtxu9paT20dadQsJOcXKRo4DcPw=;
        b=cZU7fLJs5EJ9Vl1sg00zY1AF8/mK+Q4L0OiMizgwffcz6JViMeDAagEvakTmMBKuQ5
         Djo8bccInSive84+ygsdkq6UlzX/6kRe8Exvg48Iu/wtoUIw7ameE+qoODXz0yX6NETv
         o8YkCFr6ooXFaHJtjVgnQ7Q8HN4F9XdZW4/YliZaos+8+7g0yCkmF2xYLm/XtP2/xQm1
         DtY5sn4MSh0u8s3EWAiKUoY8H2mGJ+owd72u5/YKWo08cis/h5uRu/M6HIvKEBbnFwVs
         zmNrLEyRIlmRyZAHunfVbGBpEJsECQx0xNekWsIZomIp2cRzpUEViHAIyhenJOt1++XS
         JKQA==
X-Gm-Message-State: ACrzQf0OutILEw+jNGx/UQUqHAOfmmGnAUE7vPM5w4IBgkWNFOTGkGs0
        FraQgJhEh9gxJFzvOjHZgCFngjN05AI=
X-Google-Smtp-Source: AMsMyM6XQ85ymxBnqVh2Du1oYlMCtSmDKIw7YwC1nAoX26u2VLyagOvV4BP9N2cG0xZAq3m6gZgn8A==
X-Received: by 2002:a17:907:3f96:b0:7ab:34aa:9094 with SMTP id hr22-20020a1709073f9600b007ab34aa9094mr6881360ejc.85.1667110271761;
        Sat, 29 Oct 2022 23:11:11 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id v27-20020aa7cd5b000000b00458898fe90asm1708497edw.5.2022.10.29.23.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 23:11:11 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH] samples/landlock: Document best-effort approach for LANDLOCK_ACCESS_FS_REFER
Date:   Sun, 30 Oct 2022 07:11:07 +0100
Message-Id: <20221030061107.2351-1-gnoack3000@gmail.com>
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

