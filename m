Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7374FC43217
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Nov 2022 15:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiKCPNg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKCPNc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Nov 2022 11:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5331AF0C
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667488329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LWgxR1F68mKVnmdpW8+jJqPrx2L99twB8sOEHi9u21s=;
        b=WIgtf55O03Odh0YAse/P1Bgfpuxa5xboBKkd1e170mpQX2bLRH5QilH63RDRSchQTCjUsL
        mSmSrB2GE+s+OUAmLuscLwGA+btmghMFrlpIdYHdjeG6YfagENlktvoz16dU2nD/9rDV91
        wKPn5o4qcrWmPdnRZpEbBaSTd8miv2c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-5txLMxO-Pi6k2hqjK751rw-1; Thu, 03 Nov 2022 11:12:09 -0400
X-MC-Unique: 5txLMxO-Pi6k2hqjK751rw-1
Received: by mail-wr1-f72.google.com with SMTP id m24-20020adfa3d8000000b00236774fd74aso591904wrb.8
        for <linux-security-module@vger.kernel.org>; Thu, 03 Nov 2022 08:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWgxR1F68mKVnmdpW8+jJqPrx2L99twB8sOEHi9u21s=;
        b=p8xFOMwOm+19N3qnBjJ+VkVLh+DsC19ZgeXJdzrF/XOZoGgHW1jBXPgrFUFxzZCrzs
         o2cRx/H4bcaOTZ79bQudkK+O6tRdzGHA4vGDFtQduSOqSyTgvixQH48/LKWDBfch4oUB
         DiCMXLWTlligiyOGrKr3LZd9xUB2UKKLHqE7hR5FnZOUAH8++n1rgBdiq6+Fx5IQcm68
         EpguHbwnhoc+IbtJ0x1E4gbG8UmgSvhPiT7mVR8RK3Xx9Nd91R1aQI50A884gCBv4VMg
         aEL4zhb+7sJid99qGJQPaS+rVo2+8/dCZAK2Y+RRG6gBAwn8AUqxzB5iWfpmrmELNaax
         sbpw==
X-Gm-Message-State: ACrzQf3WU7ZKxCdR5G5NVV6f00M3YVvJ/innxaf9J5nnyt4LEFRjFlyE
        Ulfl0rfDE5hMiSY73l/nrY4eQ9bYc68J7AuW2I8qjfzP6Fwx7D3TahFeawY97M/ah8y4h2Og9B6
        vSnAllh00Wz84/Oh7G9wqqkh5Vjw/U2m9f/Ko
X-Received: by 2002:a05:600c:3655:b0:3cf:7082:dc18 with SMTP id y21-20020a05600c365500b003cf7082dc18mr15530759wmq.36.1667488327462;
        Thu, 03 Nov 2022 08:12:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ux4jknt5HP+aYQrcIxkNpUyABfRNH3oJZnAwXDcMOJ+KB7r/Wfbv+pV7I7knZb9J+AiUzmQ==
X-Received: by 2002:a05:600c:3655:b0:3cf:7082:dc18 with SMTP id y21-20020a05600c365500b003cf7082dc18mr15530746wmq.36.1667488327247;
        Thu, 03 Nov 2022 08:12:07 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b00235da296623sm1104080wru.31.2022.11.03.08.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:12:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] fs: don't audit the capability check in simple_xattr_list()
Date:   Thu,  3 Nov 2022 16:12:05 +0100
Message-Id: <20221103151205.702826-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The check being unconditional may lead to unwanted denials reported by
LSMs when a process has the capability granted by DAC, but denied by an
LSM. In the case of SELinux such denials are a problem, since they can't
be effectively filtered out via the policy and when not silenced, they
produce noise that may hide a true problem or an attack.

Checking for the capability only if any trusted xattr is actually
present wouldn't really address the issue, since calling listxattr(2) on
such node on its own doesn't indicate an explicit attempt to see the
trusted xattrs. Additionally, it could potentially leak the presence of
trusted xattrs to an unprivileged user if they can check for the denials
(e.g. through dmesg).

Therefore, it's best (and simplest) to keep the check unconditional and
instead use ns_capable_noaudit() that will silence any associated LSM
denials.

Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
Reported-by: Martin Pitt <mpitt@redhat.com>
Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v1 -> v2: switch to simpler and better solution as suggested by Christian

v1: https://lore.kernel.org/selinux/CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com/T/

 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed2..427b8cea1f96 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1140,7 +1140,7 @@ static int xattr_list_one(char **buffer, ssize_t *remaining_size,
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size)
 {
-	bool trusted = capable(CAP_SYS_ADMIN);
+	bool trusted = ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 	struct simple_xattr *xattr;
 	ssize_t remaining_size = size;
 	int err = 0;
-- 
2.38.1

