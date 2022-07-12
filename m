Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F9C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jul 2022 21:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiGLVOp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiGLVOo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jul 2022 17:14:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16BAF76B
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k30so11712977edk.8
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n//A1HtDJqlKzSBKBtFQcL7iCsYun1y7eN8AGtOdjEw=;
        b=HftJ0cQHyX3SO0wZXVG3ISQV2zgV4WBDxY0/tmKlJtNVmefxdY2TrkftkFQKe+gesj
         lHrZJc+WC3ENenzGwY7Si4GfxaTzTLFozbrQC1xWdBFjqdrcUuSzGfnAAhmEqUfYi8a8
         MnLT0eRB5EQminyyvVVmPdtbJWaFIS9LGU7RuCUfhfMBlVnxiZYrBSY35ongG3qRP1sG
         3iIew4WccjVwncfKf8GcNFn8W1ELqweF48SU3vPeqP8YiBc1nKkIjFuckXaboInuvAv9
         bJ6G0ze0SgKPcEoRxIPfVvKru60j58poVgZcSivgI2O1nhXJPVLiCPmFvUuDJg4mrTaK
         sw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n//A1HtDJqlKzSBKBtFQcL7iCsYun1y7eN8AGtOdjEw=;
        b=BkyU2Svlkqnrq2CcjNNjrjfc7ebh1bdZOnz6Xn3mQrYqgbLP/j/2yyAAzkBV6Kl77+
         c8UGbq01FacAJT0gyiAbJg20JfiKUYzje3QlPyj9pYrvzxFUtl+qpaEZdv3dpX/JJ7lR
         Po7ocuHTCA7c4yWq1w01VrUFVMnIG66owg97w8iJZpLQ1H7rYM8RC9eCp8qHU1LxkJtM
         VjbGxveEpObfvcwHK1BMoIGIU4UDl18UuFyhCxVVTCJGAiT6v6rZUojKpU0XJ8Lojuxo
         jzcHkdjc5Avq14pUcu7Q9CMfiZMjoRI72AkMurTSNv+sizdNysuOJHwc9IRarBUC/S9K
         BCfw==
X-Gm-Message-State: AJIora/xTONzwxv5soZ9eZvnC4nigD9LWkM+u9b2/7Hanl3AFFaV6yi4
        1+/fHRv9Izm25n6mrFtfpQ/gimXyuVA=
X-Google-Smtp-Source: AGRyM1sYPiZqhlStENEfhl1ls5jQPxqYXvq2XQyRpZVyqgNXTMBzqWGIJFlG/kUrrhndZ+TxnZT1BA==
X-Received: by 2002:a05:6402:5c9:b0:420:aac6:257b with SMTP id n9-20020a05640205c900b00420aac6257bmr126780edx.128.1657660483020;
        Tue, 12 Jul 2022 14:14:43 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e41-20020a056402332900b0042de3d661d2sm6679296eda.1.2022.07.12.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:14:42 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 4/4] landlock: Document Landlock's file truncation support
Date:   Tue, 12 Jul 2022 23:14:05 +0200
Message-Id: <20220712211405.14705-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712211405.14705-1-gnoack3000@gmail.com>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.

Adapt the backwards compatibility example and discussion to remove the
truncation flag if needed.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
---
 Documentation/userspace-api/landlock.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b86fd94ae797..41fa464cc8b8 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_FIFO |
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
-            LANDLOCK_ACCESS_FS_REFER,
+            LANDLOCK_ACCESS_FS_REFER |
+            LANDLOCK_ACCESS_FS_TRUNCATE,
     };
 
 Because we may not know on which kernel version an application will be
@@ -69,14 +70,22 @@ should try to protect users as much as possible whatever the kernel they are
 using.  To avoid binary enforcement (i.e. either all security features or
 none), we can leverage a dedicated Landlock command to get the current version
 of the Landlock ABI and adapt the handled accesses.  Let's check if we should
-remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
-starting with the second version of the ABI.
+remove the `LANDLOCK_ACCESS_FS_REFER` and `LANDLOCK_ACCESS_FS_TRUNCATE` access
+rights, which are only supported starting with the second and third version of
+the ABI.
 
 .. code-block:: c
 
     int abi;
 
     abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+    if (abi == -1) {
+        perror("Landlock is unsupported on this kernel");
+        return 1;
+    }
+    if (abi < 3) {
+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
+    }
     if (abi < 2) {
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
     }
@@ -127,8 +136,8 @@ descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because
-`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
+ABI version.  In this example, this is not required because all of the requested
+``allowed_access`` rights are already available in ABI 1.
 
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
-- 
2.37.0

