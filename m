Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBF5C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27C820830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXMmBIMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDJQ4a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:56:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43270 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJQ4a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:56:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so1893044pgu.10
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/vBZWFEN+EOzvl05vZba81q+aJ2WHyZNzbuhqeb0y8=;
        b=BXMmBIMZ6oLXwcxo8A1UVpTjM3mHf6iTVlJpgyNGDhResaLnwxDzcSb8vxnqk2b2RL
         WXHaZIcAtBeG6F9gz5QPcRtTDiUXFGplUGVU27eHJp/TNnWUNKpI+w9dmbmO5z0laPLk
         qk5i4r94cKmgCWl3C87D4TW5KTQPPtt9ucRSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/vBZWFEN+EOzvl05vZba81q+aJ2WHyZNzbuhqeb0y8=;
        b=Hw2cR4cGE04jRi3DvkxczpV6QsPEAiPCmCBOQsSV3sO7jsnYX+WAamwHK64KSrg7up
         75QgwqtD/YQai8HR7BD8L5uiOqX5al0VbZEiljDfRAgsAQJQhblIleAYmiUll/XQILBL
         Cc55IfFc5N6BoGUKDZfTJ9LB1HXfoUxwgHkRh4N1/nwWEKJi8sWFSFdjxbqi9iaGeJPm
         scI12nGDCIQc1ShfT8vc+cRIwdG6Lpdps0xvs1/T47CJpcvQwea4LWGA4JUX41SVvgd2
         JJ+hVJ/veWWtBe6jwMqhWAk069Fj0nOgAoxaZm72xDlSuX4aG4tcRxAL9yk9F3sZGcVO
         gUZA==
X-Gm-Message-State: APjAAAVUF+0IQ99dV8VGZ/p9uIS8BMFsfcc2cCJMhzm+fU6891NWSr0N
        3djbe0iZbCWcwZGa0q+p1eyZQg==
X-Google-Smtp-Source: APXvYqxIplkAm/uJnXKbhMsR/ySK5mnxwlWImmQnFVBKWuvReG1RDqJg71Of9nK5ZNwTcQjPrmrCww==
X-Received: by 2002:aa7:8392:: with SMTP id u18mr18324427pfm.217.1554915389824;
        Wed, 10 Apr 2019 09:56:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id q87sm55790466pfa.133.2019.04.10.09.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:56:29 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 10/10] LSM: SafeSetID: fix use of literal -1 in capable hook
Date:   Wed, 10 Apr 2019 09:56:27 -0700
Message-Id: <20190410165627.212572-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

The capable() hook returns an error number. -EPERM is actually the same as
-1, so this doesn't make a difference in behavior.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 4ab4d7cdba31..61b84e20f2dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -90,7 +90,7 @@ static int safesetid_security_capable(const struct cred *cred,
 	 */
 	pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
 		__kuid_val(cred->uid));
-	return -1;
+	return -EPERM;
 }
 
 /*
-- 
2.21.0.392.gf8f6787159e-goog

