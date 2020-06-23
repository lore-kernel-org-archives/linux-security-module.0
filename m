Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4AEC433E2
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 23:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D25220780
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 23:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DUDXf0pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbgFWXir (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:38:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43432 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFWXio (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jun 2020 19:38:44 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id D777E20B7192;
        Tue, 23 Jun 2020 16:38:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D777E20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592955523;
        bh=hQwK1gRYRMLEuO0Gi1zguKsW5VTmFG8FYoY12ORsrOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DUDXf0plUaNojGDZ23fU0oSPNmgLJL03VYNfdTRWB9pLofs/PPDcZXbuTP4f8yp4b
         8sI+5Z+FMSaweeOMImg1yZV0lDLfnHkBZ6ngLuwsYzARXrn6ltrQq3mBi++UjnqXJ5
         kJEleUxLEDIa9zBzsUZVnQZwPwWmqrxT9lyMSaCM=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] ima: AppArmor satisfies the audit rule requirements
Date:   Tue, 23 Jun 2020 18:38:23 -0500
Message-Id: <20200623233823.904882-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

AppArmor meets all the requirements for IMA in terms of audit rules
since commit e79c26d04043 ("apparmor: Add support for audit rule
filtering"). Update IMA's Kconfig section for CONFIG_IMA_LSM_RULES to
reflect this.

Fixes: e79c26d04043 ("apparmor: Add support for audit rule filtering")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index edde88dbe576..794ebb5cbf74 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -54,7 +54,7 @@ config IMA_MEASURE_PCR_IDX
 
 config IMA_LSM_RULES
 	bool
-	depends on IMA && AUDIT && (SECURITY_SELINUX || SECURITY_SMACK)
+	depends on IMA && AUDIT && (SECURITY_SELINUX || SECURITY_SMACK || SECURITY_APPARMOR)
 	default y
 	help
 	  Disabling this option will disregard LSM based policy rules.
-- 
2.25.1

