Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB63C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA3120720
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OAHZxDH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgFWAev (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47518 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbgFWAeX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:23 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 244DA20B4780;
        Mon, 22 Jun 2020 17:34:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 244DA20B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872462;
        bh=lMryd4AhJKTLUpL36wlejZZPUENN9O/oM4NUjEMntzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAHZxDH76GEa3RKGJz7Y+eNlKNRIEXoYLyx12wBuHTMTBMA4n43fb9/E189nn91L8
         SmcIPxPASWYruEolHzbIGxS6owNbCpieiytue7SX/udfNIVL8SjFhhaSEeSKHJZICI
         /dw4srnrJP/zQEDa1500ooZ+7kiNvkcBYVNj1A34=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 07/12] ima: Fail rule parsing when the KEY_CHECK hook is combined with an invalid cond
Date:   Mon, 22 Jun 2020 19:32:31 -0500
Message-Id: <20200623003236.830149-8-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The KEY_CHECK function only supports the uid, pcr, and keyrings
conditionals. Make this clear at policy load so that IMA policy authors
don't assume that other conditionals are supported.

Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 83975ad22907..e33347148aa9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1024,6 +1024,13 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			if (entry->action & ~(MEASURE | DONT_MEASURE))
 				return false;
 
+			if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+					     IMA_KEYRINGS))
+				return false;
+
+			if (ima_rule_contains_lsm_cond(entry))
+				return false;
+
 			break;
 		default:
 			return false;
-- 
2.25.1

