Return-Path: <SRS0=zxlL=XL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B738C49ED7
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Sep 2019 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43D3214AF
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Sep 2019 15:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BemVdc04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbfIPP3L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:29:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37631 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIPP3L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Sep 2019 11:29:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id c17so207002pgg.4
        for <linux-security-module@vger.kernel.org>; Mon, 16 Sep 2019 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YppJ3js2EZKvN43EZHaJEWiu6fslZbpD5+eMi/yBtDo=;
        b=BemVdc04SV9zqAxHK2JpBrf6xlxrDDMvxSbCWFL83kYbMfp94RFvUmIRnclQyCkrEJ
         DLDR0KdmUWGhEkN/h2NVO7lx8FG67UK1PVq7DCneG4+CHOl/Vosg1cABtQgaThKTlYXz
         aCtk9aRFzgboWM9jNZitAeuElCJtkBP+pl1Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YppJ3js2EZKvN43EZHaJEWiu6fslZbpD5+eMi/yBtDo=;
        b=aIz2FW6aRJm01Ubws6211hS88xIeoQFuoWw/7BBREv5TH2fLMMZriPzJ12AEDN6q68
         WeNktRvzu1bWHdJDSIuCK1QdaToIPcx8zYxwfpCBlfOiw6o3LYnsJW66sWxokUA2k1fq
         7w2s1sXbaUo7ADMF2N//z/kPzEKn5r6uXVupJFvqhDIe9/V+qAjleBsFRuKMNXy/fypj
         0OWLhXO3Qo0K/yNExAQrLNehjTCEYcI+yyP3SPXdLisTDLJf+H5gKXgb/S8dNXw/wdkl
         nocB2YcNgUm6wkswyFR5ltlT/1m9/bwQMZwv6j0ODOoi2YlzTZORRT3FYe7nSZk6a80C
         TMSw==
X-Gm-Message-State: APjAAAXqbUs2UE01bsXwNdSWwZyQQCt9ojLx5vjmIXOGkWjjFYtT30VL
        GH2w/7dUpjI52/rpBgOI2Cextpchy8U=
X-Google-Smtp-Source: APXvYqwIzifdMIUNaQAx7X6kPfhklpDabG1elGpQB7/Wuwu094b5TgjpUTGBBishAvqC1IN9lXTLCQ==
X-Received: by 2002:aa7:8481:: with SMTP id u1mr72702942pfn.3.1568647749382;
        Mon, 16 Sep 2019 08:29:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id a1sm34260083pgh.61.2019.09.16.08.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:29:08 -0700 (PDT)
From:   mortonm@chromium.org
To:     linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>
Subject: [PATCH] LSM: SafeSetID: Stop releasing uninitialized ruleset
Date:   Mon, 16 Sep 2019 08:29:03 -0700
Message-Id: <20190916152903.67471-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

The first time a rule set is configured for SafeSetID, we shouldn't be
trying to release the previously configured ruleset, since there isn't
one. Currently, the pointer that would point to a previously configured
ruleset is uninitialized on first rule set configuration, leading to a
crash when we try to call release_ruleset with that pointer.

Acked-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/securityfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index d568e17dd773..74a13d432ed8 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -187,7 +187,8 @@ static ssize_t handle_policy_update(struct file *file,
 out_free_buf:
 	kfree(buf);
 out_free_pol:
-	release_ruleset(pol);
+	if (pol)
+                release_ruleset(pol);
 	return err;
 }
 
-- 
2.23.0.237.gc6a4ce50a0-goog

