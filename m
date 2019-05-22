Return-Path: <SRS0=vdt1=TW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77560C282CE
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB30204EC
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HavaLqMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfEVRWq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 May 2019 13:22:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41867 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfEVRWq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 May 2019 13:22:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so1385033plt.8
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2019 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYjbC7hdX1qPhVPxWx241ZqaXBcur6NUwVbERe4GTis=;
        b=HavaLqMq659vRLmLKr9/odEDzscgAqvrRMpt76u1RjvLNt7XEB7gTiJ569H4/N0Qd1
         Sm7b5Uauewp7skm7m/6LsBgTWtewvJF8JqLhfgKxnPY+CnzmKMeDISaLJ5T7hekv6b+k
         B6Cbjz+k+HwWbKUws2MgY3Bvv2mDE9vNzD3bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYjbC7hdX1qPhVPxWx241ZqaXBcur6NUwVbERe4GTis=;
        b=LC8uPbJUJQGNQkmoMOVC59lxGf/G53DkejIsTnqw2B3iUklXIN2Z/SQqOQ49LPrd2d
         mT7lL77pbzQLZpl5mGH/R5XHcEZ37pnKmmbDEawuoGWK3Kj8FEjJweJeNSuaf9ylGJBV
         vx+szKN32KoVo7YZe2kWmcsu9HgiuLAlerKLNuSdXZwgGi7eweooNPW5vANZdD0NpWW6
         bafwZEC2WOhLbzLYtU6JZfIQeLemgTDZq+QECcOpKsP/3mnObN3LRYm9esxomiCgNRYx
         rqkdBB5hNnEIdA2YrtcyZX9YnA8xx5mx8flhIyBfn78W9EZFluYRuwXa8okq3lFSbfN3
         0SNw==
X-Gm-Message-State: APjAAAU0xlfaC3vTSW3vaJuurLUdbAwRsR/os0xdOXBAIDoNwmNLIIP5
        q/8W83lzVmXnjsNhE1QUp0PpDA==
X-Google-Smtp-Source: APXvYqwnJ4c281AuY2vDRkOCmVt4gMISqMQwDad425rHf/Bi2XTxah814hhJF2oMVDFGZP0AlE0BkQ==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr40185400plr.270.1558545765865;
        Wed, 22 May 2019 10:22:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id j5sm32912825pfa.15.2019.05.22.10.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 10:22:45 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Subject: [PATCH] LSM: Update MAINTAINERS file for SafeSetID LSM.
Date:   Wed, 22 May 2019 10:22:41 -0700
Message-Id: <20190522172241.192669-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is in preparation for SafeSetID to be maintained in its own tree,
rather than going via the security tree.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..0fcd34e64fa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13561,6 +13561,12 @@ F:	drivers/media/common/saa7146/
 F:	drivers/media/pci/saa7146/
 F:	include/media/drv-intf/saa7146*
 
+SAFESETID SECURITY MODULE
+M:	Micah Morton <mortonm@chromium.org>
+S:	Supported
+F:	security/safesetid/
+F:	Documentation/admin-guide/LSM/SafeSetID.rst
+
 SAMSUNG AUDIO (ASoC) DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 M:	Sangbeom Kim <sbkim73@samsung.com>
-- 
2.21.0.1020.gf2820cf01a-goog

