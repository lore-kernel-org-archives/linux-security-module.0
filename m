Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EB8C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 17:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B406823A5E
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 17:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbhAORp2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jan 2021 12:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbhAORp1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jan 2021 12:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610732641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tyk+XUKuUhBpf0TcrmLm4g0VHSsyZ1b9KM+hnKhbYTs=;
        b=NwiiGI4XrdxZg5U49wCuEApuXDuSqgJ4nBzU0g85aVyO1hk2BlPMIjbc/IeI4QExceKWab
        bBTWdKTzGiseUClhGGVGnWrRoQsyv9++Vwo+uNDGtSMdi8mzB66NnaDP5dcoHwjv+bJdKN
        Vuv+In6vhfV/5jOopPnJEMkG+cnGtYw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-Nf1qVIOdPxuIN9bdcH9yyQ-1; Fri, 15 Jan 2021 12:43:59 -0500
X-MC-Unique: Nf1qVIOdPxuIN9bdcH9yyQ-1
Received: by mail-ed1-f72.google.com with SMTP id g14so4212558edt.12
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jan 2021 09:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tyk+XUKuUhBpf0TcrmLm4g0VHSsyZ1b9KM+hnKhbYTs=;
        b=uMhdn5DpJCUE5CJXyFfMXkI0LBZjZQ9oADUyLJXl7iPw7HwCdukD6PJrg49LMVnjlf
         FlzG9YHeXXYDIFNgQU3po4bdfXxgFIO+zMNCRciPx4fs2TW3WXZ0EXqdSHapLOH+A18P
         dx+bSPwj3Oi3y/tZgIvezAsTkvgvX8fSzmYQBQb0DVKjf9Ir/s3JeMJFIxQi68CvwbGE
         7Gq5+G2Hl3WAFu7gGRMmIdtSq2n6DmPdeHL6HYFsUy7ABm11CGY035ZQFczAyJFWoaop
         yI6CUvIgitlITiXzTYR6ycP2EsBQ1nKkneKWQ9qJyVXRgALkNPHJ1NQTop8hLQFSo5f9
         Jzpw==
X-Gm-Message-State: AOAM531UZuGoli4Q8jWbY7OP5EMQ7tsbVZjPdB0J2+Uw82vhvKRwQF/S
        hRh+rx5ssAVeWrKBPjQB6PwM5tXTTU1RORvnjUbNYG1ZncAWl+JlUeBQqT426aAVxLFI0k1mP4p
        aK2emqiI2oSs3sFHlNys9yNyfgYOD7HF75uJB
X-Received: by 2002:a17:906:af92:: with SMTP id mj18mr9287072ejb.290.1610732638699;
        Fri, 15 Jan 2021 09:43:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsn0zz9t4rpo3MQAzVYHc7JsrMrRKrqprK3YStrjTRhLBmoPn8x51DJyxSYyEOp8bN2E1Hlg==
X-Received: by 2002:a17:906:af92:: with SMTP id mj18mr9287060ejb.290.1610732638474;
        Fri, 15 Jan 2021 09:43:58 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id g17sm4010343edb.39.2021.01.15.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:43:57 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        David Quigley <dpquigl@davequigley.com>
Subject: [PATCH] NFSv4.2: fix return value of _nfs4_get_security_label()
Date:   Fri, 15 Jan 2021 18:43:56 +0100
Message-Id: <20210115174356.408688-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

An xattr 'get' handler is expected to return the length of the value on
success, yet _nfs4_get_security_label() (and consequently also
nfs4_xattr_get_nfs4_label(), which is used as an xattr handler) returns
just 0 on success.

Fix this by returning label.len instead, which contains the length of
the result.

Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2f4679a62712a..28465d8aada64 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5971,7 +5971,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	return 0;
+	return label.len;
 }
 
 static int nfs4_get_security_label(struct inode *inode, void *buf,
-- 
2.29.2

