Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507AC433B4
	for <linux-security-module@archiver.kernel.org>; Fri,  7 May 2021 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4732B61464
	for <linux-security-module@archiver.kernel.org>; Fri,  7 May 2021 12:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhEGMyj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 May 2021 08:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236604AbhEGMyM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 May 2021 08:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620391993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ekkd3oyzogIptalBe2cpy9zc9ReWtKldN7D44gkdUnI=;
        b=O0M8J44Q1Bhqporh5Yy39ackZSMO3Iu+AW1uRiY8XlsuSLPOi8LyBv9JEF3JA7uPXhIXvp
        9G86CLwXrQWqN39JREhiB8FmbXobQTNbxhT8DtMoQZSt4o2fPk+YTXUBGZ/RMYoIBvORpA
        N8ch3rrzMjSh+uURNxHR45RbJ3JoEcw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-ta-iZ9YZO46nmhUaa8VrNw-1; Fri, 07 May 2021 08:53:10 -0400
X-MC-Unique: ta-iZ9YZO46nmhUaa8VrNw-1
Received: by mail-ej1-f71.google.com with SMTP id x21-20020a1709064bd5b029037c44cb861cso2956557ejv.4
        for <linux-security-module@vger.kernel.org>; Fri, 07 May 2021 05:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ekkd3oyzogIptalBe2cpy9zc9ReWtKldN7D44gkdUnI=;
        b=UK5uSyXkuT69uXzHYgLfAhV0snjhsUDtVAg9XW74EhPgbRMbXvvcVGyfK+P54rzzfh
         y9fXbHQg4Qt0hMa2GjXgKkCE3sCu+VI7jNQx6MhwADd6BYJOQ34YlmxnDK3qaRKm8Q0C
         LqENG2UhHCcrJZzi7nYPCwcB/XEa3XBkRHBekqcgJdnvO3FYTqTJ7VLwNCAk2SEf6jUK
         19sv+bUZ+YVYDiNnthYYiyQAwJ7gF0kk+1E+B2GL2yJLkcQftQHWIl5HvZaI614x0BoN
         Mj4boqStY80beWNgto/FBBVjA5+FZsYP1HpLuSaMpMx7oX3bi6i9A/jxnVQfAk2f/RYb
         xjwg==
X-Gm-Message-State: AOAM533w0vyY2EvTwGxh4zKexeRqtPNBL/f2LCkcQPh6Mwgo5sWQhBy6
        p8prFr9y7DwxTmf67q/xHYxCuN6Tdtt59rYZkzmgaoiJkiwOXoqfgn1WuuP2pYuD38Dq7Y14fM2
        cvFW8CoJPO2vpYnDZ7hCuun3+hUkEbSyM7SnO
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr9662196ejb.198.1620391989175;
        Fri, 07 May 2021 05:53:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx3Z+9lizDuJOODp1PHOn4ynHaHjZttKyHDznmtmt2QFV4vRXq1H+M273vfCF/TzadAicR/g==
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr9662180ejb.198.1620391988967;
        Fri, 07 May 2021 05:53:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id qh12sm3415986ejb.109.2021.05.07.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 05:53:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] debugfs: fix security_locked_down() call for SELinux
Date:   Fri,  7 May 2021 14:53:04 +0200
Message-Id: <20210507125304.144394-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) is zero, then
the SELinux implementation of the locked_down hook might report a denial
even though the operation would actually be allowed.

To fix this, make sure that security_locked_down() is called only when
the return value will be taken into account (i.e. when changing one of
the problematic attributes).

Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
debugfs when the kernel is locked down"), but it didn't matter at that
time, as the SELinux support came in later.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: try to explain the problem better in the description

 fs/debugfs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 22e86ae4dd5a..bbfc7898c1aa 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -45,10 +45,13 @@ static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ALLOW_BITS;
 static int debugfs_setattr(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, struct iattr *ia)
 {
-	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
+	int ret;
 
-	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
-		return ret;
+	if (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
+		ret = security_locked_down(LOCKDOWN_DEBUGFS);
+		if (ret)
+			return ret;
+	}
 	return simple_setattr(&init_user_ns, dentry, ia);
 }
 
-- 
2.31.1

