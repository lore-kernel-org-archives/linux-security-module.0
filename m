Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBDC282C7
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9996C21848
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MlUozkQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfA2Sya (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:54:30 -0500
Received: from mail-yw1-f72.google.com ([209.85.161.72]:56600 "EHLO
        mail-yw1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2Sy3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 13:54:29 -0500
Received: by mail-yw1-f72.google.com with SMTP id t17so11762378ywc.23
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jan 2019 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G0epUqFu3AmCTsfTCZBWyuwLgZxvATnBae8HP0ixIfc=;
        b=MlUozkQMHxb5n/jPhkS4DTcTd4VsaPbttFo5x9eWIG8pksOUrzuTaW5m3iXV/mtKf/
         Y+9hTZdImQ2UdWUsejIhnp0zgbQ/Kp6z55CLpGu4Qc9zI+8hQXt7d9EgBJBfGmLDdRrV
         5jqbFq7ZYI3mp9uzYqL/v3dhYRegKkXLCNxvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G0epUqFu3AmCTsfTCZBWyuwLgZxvATnBae8HP0ixIfc=;
        b=AhsS32z5aUBoJkaBZULOU+MS/K2mOKTr6ddybIpvmBmNlVDglBODUQtBa1LAyY9fmO
         RjIWlT5StjqdKa14aoe3LHsX6Eww4tgROf3iQEGbL/KcGxEE1l1QLFVhGWw6tYL0XOzr
         amTp/lYwHi/vnmyP/4DLvVTIDDYar8UY6kmXpy+6+605iCSn7akbbRB5F2GVJxd6owZh
         a6L3jZKQkiRHYyedtTBUXNuUAi7EAcZEGoupHK9fAZ2TmH1A2A4X4e50zVARG9L0+W12
         h4J77KE+zEzt+CPmrh5NhhlJwmMqlSJxP2/y+J6jbfX7JyGN4i+MUUbSHcCrAAIutoJM
         CRiA==
X-Gm-Message-State: AHQUAuZ4a0J+IRpKc8MJGoBCWxE0bWoKkd6reGZ+jsDoEPo4j8XXWBr+
        Ef+QO9j96oQn74asvff7m5DJWvS2+MJnxkBL
X-Google-Smtp-Source: AHgI3IYuvkCaYCMYauiy4MF48g2nOFC0MFUTa63C0CTHb56BRwsat5DJrrNduvdch+8ZPCiFAxixBi2AOH0e66LH
X-Received: by 2002:a25:ca11:: with SMTP id a17mr2633199ybg.43.1548788068983;
 Tue, 29 Jan 2019 10:54:28 -0800 (PST)
Date:   Tue, 29 Jan 2019 10:54:24 -0800
In-Reply-To: <CAJ-EccMgDvx81g-XgWymdYn_G5Ou8mgbef3GUbx-C_Ai5qF-pQ@mail.gmail.com>
Message-Id: <20190129185424.251139-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAJ-EccMgDvx81g-XgWymdYn_G5Ou8mgbef3GUbx-C_Ai5qF-pQ@mail.gmail.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] LSM: SafeSetID: 'depend' on CONFIG_SECURITY
From:   mortonm@chromium.org
To:     rdunlap@infradead.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

This patch changes the Kconfig file for the SafeSetID LSM to depend on
CONFIG_SECURITY as well as select CONFIG_SECURITYFS, since the policies
for the LSM are configured through writing to securityfs.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/safesetid/Kconfig b/security/safesetid/Kconfig
index bf89a47ffcc8..4f415c4e3f93 100644
--- a/security/safesetid/Kconfig
+++ b/security/safesetid/Kconfig
@@ -1,5 +1,7 @@
 config SECURITY_SAFESETID
         bool "Gate setid transitions to limit CAP_SET{U/G}ID capabilities"
+        depends on SECURITY
+        select SECURITYFS
         default n
         help
           SafeSetID is an LSM module that gates the setid family of syscalls to
-- 
2.20.1.495.gaa96b0ce6b-goog

