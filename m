Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CFC433B4
	for <linux-security-module@archiver.kernel.org>; Fri,  7 May 2021 11:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0536F61421
	for <linux-security-module@archiver.kernel.org>; Fri,  7 May 2021 11:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhEGLm6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 May 2021 07:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235022AbhEGLm6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 May 2021 07:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620387718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=QVqywPUtpbxsOl1FKas1W35gl2ynFbEbQxX3pPLcOAanfBtJ/SD+1xb5D4aap75AHv90Nf
        p/meQHuXtRZDZx1D7RlxXv39aGzsUX4fkjHUs6tz4mmBNTaLom4+HcSyLL/g0eJn1ZQVAU
        76TGAovAMzmw/pokM/5YN8JVsyIUwUw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93--xnoouIEOom4TQTLAm28sw-1; Fri, 07 May 2021 07:41:56 -0400
X-MC-Unique: -xnoouIEOom4TQTLAm28sw-1
Received: by mail-ed1-f72.google.com with SMTP id o12-20020aa7d3cc0000b02903891695ceabso4316099edr.3
        for <linux-security-module@vger.kernel.org>; Fri, 07 May 2021 04:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=IZd11S3bE2NPwCR7VwZKCBNMbmaoMO8qzwznpK4tCBSdjvMPbNQfJJn+XGncqhwZ7Y
         1Z+83a+j3GPdGj+h7JJP9g7Z1B2CHUbKnO1BMvH0YZPu3V2K26EKEoj9kR1DvvEBGweF
         yR6cUAuSmUWsYoa65uUQUHEH8xpfs2Am6HKRX9E5H03fioxVYIbdHoLBD34Eax5S+tvx
         a8y4zUzcQn/Z1gy1FrpeGDwoS4hmtwhGMaO/z99yBUMI+bkOPsVZDJsnDjkVx0bYpo83
         fTAhu4H3pz6djZsnSv8TBuWZMGmIsqpbQi9rBYBUvqWLulfroADTuavfz/u5g57+dVoo
         hqTQ==
X-Gm-Message-State: AOAM53127TGO/wI1Zvnm1V5evesXtXeWkNehqYbH8CmkH/rGMz4utVdP
        6RXaE+1BgiWgl0VC+uSXg9JmpoIb6z4TZdOexegjmjQ3ujF7w6SbI28FrN7PaAaQfxSc+g8Vuq4
        iVpd++6jV5ppmEF6rpkTJUM9kPoShd/DoadW+
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007691ejb.426.1620387715165;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe+4tEBSZQpT+iheN+fbqzfk3Ilvhkxits1eJbgq0XcZH2UeBxRoLPxQpaOHsaIcs/iRz58w==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007682ejb.426.1620387715042;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id v19sm3356083ejy.78.2021.05.07.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:41:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: fix security_locked_down() call for SELinux
Date:   Fri,  7 May 2021 13:41:50 +0200
Message-Id: <20210507114150.139102-1-omosnace@redhat.com>
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

Make sure that security_locked_down() is checked last so that a bogus
denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
ATTR_UID | ATTR_GID)) is zero.

Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
debugfs when the kernel is locked down"), but it didn't matter at that
time, as the SELinux support came in later.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
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

