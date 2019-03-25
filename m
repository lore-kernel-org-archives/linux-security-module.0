Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C836EC10F03
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 08:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ACD2087E
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 08:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfCYIF6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:05:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39496 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfCYIF5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 04:05:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id t124so7893918wma.4
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 01:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcR1QBkNoiAmBRocGma/MllV/iXwsi82EaYy80ZwgYs=;
        b=EzGKWztcyL9iRuWU5/iPCieMi/lfRb59pmNAbenFaCLvxQ6Wi5AtwuUVJUUtBVPM3m
         njSp9hKvESPDwxjGH2pONYxcsDBCYUllvh6Z6BeHa8x7+xYUeKmmfhfQrWRg8a5D2dFg
         iQq9FsrSEMrjw6CiZcnXD73Cy5s2oh51S+Oz6xbXzbJDFRwQ/VwS1Eb5ehcRa2Vj568i
         gvMP9Ka2UxYufHt/AWuzBacSNwqxaZZpI3X1YUvVv/uCesj26DF6YIGU7HiZgX9nvVZq
         3FUKj0fylEVNliYipc+SBPMaRak0qWHun/i1iT2iRmXvewATveA03iwzn3keHMFlYMKD
         hHnQ==
X-Gm-Message-State: APjAAAVN7ebL79nMBF52bgJjrc/ivsDnVYP7q2TmfB2t31ydP+cBJZoX
        Rx3dQBjyZCQClhua2X7FOnuYwA==
X-Google-Smtp-Source: APXvYqwSlVMt5qiHqwVXIYSdPb4Dr7j39pImsILBmzmomuHOr92UzaYAXgY4K4P6ExwvpQzTevKD7A==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr4261572wmd.59.1553501156251;
        Mon, 25 Mar 2019 01:05:56 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s12sm14151530wmj.42.2019.03.25.01.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:05:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, kbuild-all@01.org,
        Ondrej Mosnacek <omosnace@redhat.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] LSM: lsm_hooks.h - fix missing colon in docstring
Date:   Mon, 25 Mar 2019 09:05:35 +0100
Message-Id: <20190325080535.19475-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <201903211834.Qtb0LJ32%lkp@intel.com>
References: <201903211834.Qtb0LJ32%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Apparently without it it is incorrect syntax and causes a warning about
undocumented struct field.

Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hooks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0dd5bda719e6..b987dc282d63 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -447,7 +447,7 @@
  *
  * Security hooks for kernfs node operations
  *
- * @kernfs_init_security
+ * @kernfs_init_security:
  *	Initialize the security context of a newly created kernfs node based
  *	on its own and its parent's attributes.
  *
-- 
2.20.1

