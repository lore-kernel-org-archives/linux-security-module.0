Return-Path: <SRS0=0oss=4I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E3AC11D0B
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC6208CD
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imrwt9tY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBTPR4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:17:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45436 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727761AbgBTPR4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 10:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582211874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H6BruQnFBwNb5cCVI9YyRz/YJpU0LA0uIbUnirbUfIk=;
        b=imrwt9tYQitkKknNjP0LYMCaZzvtGY1oamqqu6SLpUfKz8l4gu2laRC9lNmztLIdjhHIon
        dVzJPVBkkjy+aRsoSB5RTI7W6EPFDj/ZOoly6AdIp6m8RWqDaUw6jl1W+8QU/ZKOP4qBt/
        QvqOoAcKFF9AVlFaqnSXgNu8OtsNQRA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-HJ_OgUlGOHmorUtuQAvinQ-1; Thu, 20 Feb 2020 10:17:53 -0500
Received: by mail-qv1-f71.google.com with SMTP id cn2so2771698qvb.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 07:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6BruQnFBwNb5cCVI9YyRz/YJpU0LA0uIbUnirbUfIk=;
        b=RABMPCSuA1f8JQOo4op+dVe3muXi4p43OwixBwnVUKUhjM7/zgJ1cmYFgC4y2QbD6s
         SWduTIzKx4Tz9FFxqj4rM4OVhWwHt++b07tJ8512GVSxBSIWXtz1brhaWnuT4Ej+yGKw
         1nVJWYY3a5Jwxaete++R2NxL+EGpGQ9a2QmXvPR1rAvM5TtUYxo2zFBMzWWGrXvc0IKc
         lvWzr1Yb9Esz+BUBV4yzYvas+Wc2WjGs4GRPAEoafwe4FAflqIk8RcSa0+yO2cUDN6QT
         nRiYGoS8bCNBJEzuDib7aRSOBm5gRhC0xNtceOlb9hbOLPALFAyExZ4PY5Vr65VOyJpa
         mbgQ==
X-Gm-Message-State: APjAAAUXMryhQNBMgsRk5XvW74U4GAokpBg+Ae45uhFQBebO07GqOu6Z
        l+9oaZ9fTw4wNd7syHVOryh0oaAtxAqqeYHcxslNnKlzORWU0ZSky27CZ5rqNhel+RW8fgLXBba
        yaA7bWSvU4Ei0vW6QKygT2g/Sq/YDmeWMWdnu
X-Received: by 2002:a05:620a:125b:: with SMTP id a27mr26970118qkl.203.1582211872521;
        Thu, 20 Feb 2020 07:17:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqO2G7dbzhE328n3HZ6pRhOEszZFVHUuOrAHv6gOJjkLe/pbKZn/TU4r4dFq5UbN7tw8l1/A==
X-Received: by 2002:a05:620a:125b:: with SMTP id a27mr26970077qkl.203.1582211872261;
        Thu, 20 Feb 2020 07:17:52 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id 82sm649897qkd.77.2020.02.20.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:17:51 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        "Frank Ch . Eigler" <fche@redhat.com>
Subject: [PATCH] lockdown: Allow unprivileged users to see lockdown status
Date:   Thu, 20 Feb 2020 10:17:38 -0500
Message-Id: <20200220151738.1492852-1-jcline@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: HJ_OgUlGOHmorUtuQAvinQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

A number of userspace tools, such as systemtap, need a way to see the
current lockdown state so they can gracefully deal with the kernel being
locked down. The state is already exposed in
/sys/kernel/security/lockdown, but is only readable by root. Adjust the
permissions so unprivileged users can read the state.

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
Cc: Frank Ch. Eigler <fche@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eb..87cbdc64d272 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
 {
 	struct dentry *dentry;
 
-	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
 					&lockdown_ops);
 	return PTR_ERR_OR_ZERO(dentry);
 }
-- 
2.24.1

