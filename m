Return-Path: <SRS0=+AtZ=WZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA8EC3A59F
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Aug 2019 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4BC21874
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Aug 2019 18:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="isJCPHV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfH2Sab (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:30:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33493 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbfH2Saa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Aug 2019 14:30:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so2654535pfq.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Aug 2019 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7rGaqUzAk36ILWcKr/jrH6Y9v6WlXTDUlDGIYS/FWg=;
        b=isJCPHV3UCx5mYklMoclrNYYLuiDQl8rOsozhV+AOuvC+A2RL6Of1dXi59VVYyJ8Yh
         nbEhIdofSeqRVf4HCfoE6ntd1M93ZOHul+nGhedXl4X/3a2yARQ0GOzfEQ15nzNgQYPB
         1qKP8GgA9JnCgMRJQUtSXxcy4vfrkx21r3RNVe3qyvObBnL8kD7niQLjxUF4okFXNipE
         xH4SbLpar4QTNbuR639sRK9Rl7AjtvDaXh7RxA2QQ5TQMMwH7Jvn/lt+jb0pKjCbx2kA
         nIW6xVEvasZpHC5rUvv6GxUt4FvYgKMyRkjbLb/Yai1SwPEGGgtc9v1G/s23AMVOJplX
         pIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7rGaqUzAk36ILWcKr/jrH6Y9v6WlXTDUlDGIYS/FWg=;
        b=IBgBbqcRlz1JXvK+F8MasSnZH9VoUrzlSXWb74idfSysyq/KRArG9vv8q2vfhz+z6X
         vap/aebyrD/h1gnGmMyn4jVacF6arFyIYDahBTE3FMG+5xej1a5l+Rqr/EDPdfEjDYRj
         tjPO7rlrrSr4Du7I/zgLMtgXV4xh6oZSTU9/71trSo33Zp2aUOjrdZ8efnqi0jc9ZuQA
         32/Y2for1XFq1qqTZBj+9Ajba/u1Z6QguZYskW4B+ikpZqOUHeb6lg5Wx8WwH7fZL1Uv
         rQqfYNN2PQ3pN0SgqN9vFlW+BxUDbVBwHc4em8pzi6nnelmEMoAIpC7MpPihcxk8a3h5
         DapQ==
X-Gm-Message-State: APjAAAUJkosABRqSxHgskR2pb75XWazWX/WgWH3pmO7+MVX2OWl+i752
        nYVZuJehFpEBCf3BtOh8R820gw==
X-Google-Smtp-Source: APXvYqw/vXkr0PEX/jzpgnhtbh7cvLECq0WihqgmP+dtE4STT7/cXn7PqLsTujfn/flbDd+wdX6iYg==
X-Received: by 2002:a63:c84d:: with SMTP id l13mr9620053pgi.154.1567103429436;
        Thu, 29 Aug 2019 11:30:29 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id y16sm4090168pfc.36.2019.08.29.11.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 11:30:28 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        linux-kernel@vger.kernel.orga,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH] overlayfs: filter of trusted xattr results in audit.
Date:   Thu, 29 Aug 2019 11:30:14 -0700
Message-Id: <20190829183021.87586-1-salyzyn@android.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When filtering xattr list for reading, presence of trusted xattr
results in a security audit log.  However, if there is other content
no errno will be set, and if there isn't, the errno will be -ENODATA
and not -EPERM as is usually associated with a lack of capability.
The check does not block the request to list the xattrs present.

Switch to ns_capable_noaudit to reflect a more appropriate check.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.orga
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org # 4.4, 4.9, 4.14 & 4.19
---
 fs/overlayfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7663aeb85fa3..bc14781886bf 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -383,7 +383,8 @@ static bool ovl_can_list(const char *s)
 		return true;
 
 	/* Never list trusted.overlay, list other trusted for superuser only */
-	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+	return !ovl_is_private_xattr(s) &&
+	       ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 }
 
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
-- 
2.23.0.187.g17f5b7556c-goog

