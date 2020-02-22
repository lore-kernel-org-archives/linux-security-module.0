Return-Path: <SRS0=jUed=4K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4532BC35671
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B06120702
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 17:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhvXtgXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgBVRUT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:20:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37313 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVRUT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Feb 2020 12:20:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so2219593plz.4;
        Sat, 22 Feb 2020 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76mGlpp6BFJSmPDHJW6kprv/8C2HQ3fa7ORMT87pipU=;
        b=AhvXtgXr8v/7hcsVNalXOtAMxUQGg+OE/SI9/59KpjrJJKTzdFu6gUOq/LuJRpqBY0
         FYwSgXktGDhXnxJhU2U90NIxa+7RN66/jwTwRNLQhjLZWDu4ngBO04tPrP5ZGeqWwsa4
         Sby6zAhTXe+ZJh0Ro82a7S+HR0pUgR6wT4d0onSlnyKCWfcSG35Jr22+4olJ7iiexMQx
         qFkGQxPKNG65rZfE0ngObnTGSx4jRB2mrHaLqMMerAIcn3pm+dOIofsrj0NE5RO03RW+
         OcXxr6GO++1LxMqSozC0UQxPEgpBW2CNB/gtyo6QKlW3lwjmFII7A9faa5wJet69n5lo
         6yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76mGlpp6BFJSmPDHJW6kprv/8C2HQ3fa7ORMT87pipU=;
        b=pxUqQU732q/sBAfmZlkz8aFi0n2B6ybFB35k/PFbCKVKq3l3qnNAeFQAX8NPf7N398
         gn1/+TB7d+rEb7Zn1nvK6uPstK++8H2V1LjiY1xIGzgX+0Oi7FlauEpK7mifwyAuS3gS
         iAWkJpJMrv0Y4cxZsWQgN1R9EoZgEVp3r27sosQ4fxNdGPMwGvd8kV6P3YP9xeghz40k
         nkk/VDdmPU6baywDc3zLHqdZbyo+O5EpsW5t8d3Ug3IL/DRd6exfs6xGmP+0vInd77XV
         Q1pHGKI+QgrFEgS5+Mq1MXaKeAvf9NebhKUCEZPD8zrI+r1q/aerSkwOE0u6kuD3OMgL
         h1dw==
X-Gm-Message-State: APjAAAWisnf889QnUEpsFEvHHthIg50IftdwPkZ0Y56EBkyVvz2LApw5
        Bh8R6/EFXxvZAInb6MQkzYT8xzn+0N4=
X-Google-Smtp-Source: APXvYqw9ScUK576eJpHRzjT0V+dYpENY1q/4Limxa/EmkHyr08VAeeRcRXsUX3jm2jzFKbuhC3jelw==
X-Received: by 2002:a17:90a:ca12:: with SMTP id x18mr10118744pjt.66.1582392018775;
        Sat, 22 Feb 2020 09:20:18 -0800 (PST)
Received: from localhost.localdomain ([103.87.57.201])
        by smtp.googlemail.com with ESMTPSA id o19sm10305622pjr.2.2020.02.22.09.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 09:20:18 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-security-module@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] device_cgroup: Fix RCU list debugging warning
Date:   Sat, 22 Feb 2020 22:49:39 +0530
Message-Id: <20200222171938.14339-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

exceptions may be traversed using list_for_each_entry_rcu()
outside of an RCU read side critical section BUT under the
protection of decgroup_mutex. Hence add the corresponding
lockdep expression to fix the following false-positive
warning:

[    2.304417] =============================
[    2.304418] WARNING: suspicious RCU usage
[    2.304420] 5.5.4-stable #17 Tainted: G            E
[    2.304422] -----------------------------
[    2.304424] security/device_cgroup.c:355 RCU-list traversed in non-reader section!!

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 security/device_cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 7d0f8f7431ff..b7da9e0970d9 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -352,7 +352,8 @@ static bool match_exception_partial(struct list_head *exceptions, short type,
 {
 	struct dev_exception_item *ex;
 
-	list_for_each_entry_rcu(ex, exceptions, list) {
+	list_for_each_entry_rcu(ex, exceptions, list,
+				lockdep_is_held(&devcgroup_mutex)) {
 		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
 			continue;
 		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
-- 
2.24.1

