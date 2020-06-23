Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA4C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B5C20720
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p8I54MFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgFWAeq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47544 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbgFWAeY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:24 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7D5C820B7192;
        Mon, 22 Jun 2020 17:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D5C820B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872464;
        bh=EIfQa71W+wSH28J/gAtVyVwZP6jN6OZSnsojTGHhpic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8I54MFObjdsFyRtrc3RrhsboG9BU+0JnbS0PSdcE++h8wp8dp3T6HijlXsuyxZBq
         8rfyjIBvTLiVOWzIgowFzyMGwzxgRMjp5LmX3kY8gg9eizLjx3ZpO8jG3MbVjbw2JM
         KWFzYLA2SdX0C7IJY+jAwp1aCcSq+jBLch7k/rnM=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 08/12] ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
Date:   Mon, 22 Jun 2020 19:32:32 -0500
Message-Id: <20200623003236.830149-9-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The args_p member is a simple string that is allocated by
ima_rule_init(). Shallow copy it like other non-LSM references in
ima_rule_entry structs.

There are no longer any necessary error path cleanups to do in
ima_lsm_copy_rule() so reference ownership from entry to nentry becomes
easier.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e33347148aa9..e9c7d318fdd4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -306,10 +306,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 			continue;
 
 		nentry->lsm[i].type = entry->lsm[i].type;
-		nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
-						GFP_KERNEL);
-		if (!nentry->lsm[i].args_p)
-			goto out_err;
+		nentry->lsm[i].args_p = entry->lsm[i].args_p;
+		entry->lsm[i].args_p = NULL;
 
 		security_filter_rule_init(nentry->lsm[i].type,
 					  Audit_equal,
@@ -325,13 +323,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	entry->keyrings = NULL;
 	entry->template = NULL;
 	return nentry;
-
-out_err:
-	nentry->fsname = NULL;
-	nentry->keyrings = NULL;
-	nentry->template = NULL;
-	ima_free_rule(nentry);
-	return NULL;
 }
 
 static int ima_lsm_update_rule(struct ima_rule_entry *entry)
-- 
2.25.1

