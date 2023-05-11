Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2602EC77B7C
	for <linux-security-module@archiver.kernel.org>; Thu, 11 May 2023 21:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbjEKVew (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 May 2023 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbjEKVev (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 May 2023 17:34:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8259E8
        for <linux-security-module@vger.kernel.org>; Thu, 11 May 2023 14:34:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643846c006fso9741353b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 May 2023 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683840889; x=1686432889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+0/GVZgLBH6PMkReAmP7J8wDURjmtx81m3HSPypGMA=;
        b=jaNXHgOsOc00cBPbE6wx9gckIw2Q/Um/cKSBDT2gyxXE5t2692YhDFoGrbxBzaKGpz
         fX1qUuRiG7BqMGEb6gWUkI9GBpnS6wPZpOhfYu7mu30SwaBpiNMxc+Ig0Rqc5DufL4RS
         AqDHQzqAg+72MtBDEp+tAC3aLLMtJavmkawLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683840889; x=1686432889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+0/GVZgLBH6PMkReAmP7J8wDURjmtx81m3HSPypGMA=;
        b=hMyQAgiGmlDIb7X14yInUNaaLkY08gLvlijjePjVn0i9yzmSDdZqqtA+aF2ENPGCLd
         ciwECVvryUszgvJlDNV/IbWPBvZ3g6+f5BIV/eJKMlJFAaFFUj8fIloO+YyX18bjICeW
         bkNvZPhhotXd3THheh7DmeigD8WqtI5rzl8WAeHk4JfDv3k9wHQh6AS231lJ+WeqLXSe
         uKTuFp9T7oXzgNguyl7CQSxmqK4h5oiA6l9b4XVDfRJzQFVx64coPw3GV+1ByiXUNxnU
         C5vCPDRMfFTyCPRtu4rTgbj9R3mEM5bXVtmxGZzk5w12lafyxIeYEE+Ydue5zJL0VJXL
         0Nxg==
X-Gm-Message-State: AC+VfDzx+r34jcpJLSqCw/0yD8PV0uz4v+JZF9Pou8Fn7khcXIUAuVsj
        MvzQnH3zu+p0gv+6cKy0hqpgcw==
X-Google-Smtp-Source: ACHHUZ6aIVQi2PoT8nJNkXF7lJUrXqlz/U4E4/5bAfucHx/weKzuj5vTz8HeUezW4TkZKZWK6UC36A==
X-Received: by 2002:a05:6a00:88f:b0:648:24c1:fe5a with SMTP id q15-20020a056a00088f00b0064824c1fe5amr11096650pfj.16.1683840889532;
        Thu, 11 May 2023 14:34:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7864d000000b0063b85893633sm5723353pfo.197.2023.05.11.14.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:34:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible array
Date:   Thu, 11 May 2023 14:34:45 -0700
Message-Id: <20230511213441.never.401-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; h=from:subject:message-id; bh=RrVUNVC3gegju2xKIW8jFRuLI/RiqJcR7VGQB4D/Evs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkXV90iD6pl1iKdfr2Ps0RyjFlScFvSso0BrIaopyd ZQOueMqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZF1fdAAKCRCJcvTf3G3AJkTuD/ 4guSJdw3bNVmQ7eEYndRa0y3hZ2G3lDOgGzJbSemtYsubbOwoTLZe+nua0LcHDXyY5X27tNGTi+1SL M2w1+4cS74i5Wv7ig0XOjBlSTXJv99aZdTWoek/gPqxzNo/1Z1rvK+EO4jGYYR3eDZJhwpq0iP3REc OeS7z8lj2kaaaSmDPEwUlWqep+kgbb3uZoKAkxnOKRW8s3wLomio5a2iVMLTyohD92ibYs3j0eL7R3 CBOdQ2ZCrCz7kg0RkqC1mytmxEICPDNZokdROVAkKxlnHn03DVS+hQ4L/ytYUIF/LMXwRbP4y3wJWm UPc533JZYrKt1BpU7ubrsfXcuXcgrHRPvy91+GpRdUYNqIJbSwyn4gDo5UTSZs0S8B2m065X0BHcG/ 96PPWKo/woEwMCfFCTS12eG/zQrfrtQuwoCwGnzpwHfVw0r4GGRyv65ck8IRczuKsADvUdhiW5nKjT wE3i70lGdoI8OuMv1xbQVQLbm/Wapp+Xr/ff8uJWd4te9iULOl3bctVgAlTLGcn1bHZiwC7shh+vBE hEYELPR++NZekxFdRZr3ylL6b3TYMspR3f3aGPt1Je0uKcUIhYDuQFck85l2c3/lOikRFyW9ftK6/o GxUiMHjtwTAOBBNZlX0e1ylDvTaN+Gw1flVjeJt5AkPKxUwAp8O/Fqg7mnkw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In the ongoing effort to convert all fake flexible arrays to proper
flexible arrays, replace aa_buffer's 1-element "buffer" member with a
flexible array.

Cc: John Johansen <john.johansen@canonical.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
One thing I notice here is that it may be rare for "buffer" to ever change
for a given kernel. Could this just be made PATH_MAX * 2 directly and
remove the module parameter, etc, etc?
---
 security/apparmor/lsm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d6cc4812ca53..35eb41bb9e3a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -46,7 +46,7 @@ int apparmor_initialized;
 
 union aa_buffer {
 	struct list_head list;
-	char buffer[1];
+	DECLARE_FLEX_ARRAY(char, buffer);
 };
 
 #define RESERVE_COUNT 2
@@ -1647,7 +1647,7 @@ char *aa_get_buffer(bool in_atomic)
 		list_del(&aa_buf->list);
 		buffer_count--;
 		spin_unlock(&aa_buffers_lock);
-		return &aa_buf->buffer[0];
+		return aa_buf->buffer;
 	}
 	if (in_atomic) {
 		/*
@@ -1670,7 +1670,7 @@ char *aa_get_buffer(bool in_atomic)
 		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
 		return NULL;
 	}
-	return &aa_buf->buffer[0];
+	return aa_buf->buffer;
 }
 
 void aa_put_buffer(char *buf)
@@ -1747,7 +1747,7 @@ static int __init alloc_buffers(void)
 			destroy_buffers();
 			return -ENOMEM;
 		}
-		aa_put_buffer(&aa_buf->buffer[0]);
+		aa_put_buffer(aa_buf->buffer);
 	}
 	return 0;
 }
-- 
2.34.1

