Return-Path: <SRS0=NLeN=V3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A79C0650F
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jul 2019 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C2E206E0
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jul 2019 12:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHZd4YOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfG3MYu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:24:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40362 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbfG3MYu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Jul 2019 08:24:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so29757660pfp.7
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2019 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3OJFxf+mUWoz3h8BXrLdL53qyDG3CcJuYs/0iyxKF4=;
        b=lHZd4YOtFXL1Gwc2xUvnMZ7Or2UzfTKDyw87HagAQzlXqafH7TIxkdoiJQJhmsgk4P
         FycQZDE8Qu4bgy/7+a4uDb9S9UKbhoubw4F01cu1xYmfVZcQaREf2QEB/I0toxi4LgV4
         /Mc5qRfpVdt9IGSYE+PYQWd1uaC515Ivb0mNPROtzmMX3fyeZicOL/5NY2SydG/NPcjK
         d5ThhCpIPGKBu8b6Wozgxk84LfNSFs/rNEEV0Es9qC5DSpJhEOcwlkDf9eGlwYHM0jVw
         INZyrebVn/ruh2+hKI2DdNFiOodeC0dZpYVQH8uuutCbtk35xar9PYrCyF2hfi7NebdX
         n+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3OJFxf+mUWoz3h8BXrLdL53qyDG3CcJuYs/0iyxKF4=;
        b=Tv60HBKVyZgYj7NGKgjPzR51Xtjhxb9InBgr6TAqU0mFPKokBgGJ3C3iz7vjEFDThG
         rzLUdXkLB6cLTQccXTg3LZb4KVvVRyoSFgvVH6ZtQthHvZKm5abFvqpwaYHexxQInBDm
         D8r5PShvqaPbszvRxiH+D9laPdoG+uWdA41yScFy/kca24lfV0SEwRVhFPB4CyfzcORx
         tIA7M13x8RPwJBFoJtGjt7YvufAm2S4XJlChA0bqLuWXtlS2Bknw3C7udnp1epJCE/Pi
         a1t/A1CGH72ymFyfjRO0Vuz8l9YgvBhW/RodSBM7qWq2niymu2NL509EHYhsMDfoR1J5
         2glg==
X-Gm-Message-State: APjAAAUPBgUYnveN7xtxUJPn/eVyK2hIA9JVyZ4wfXJ3qEDM8mrMUYew
        QNGhpsip5QHHmrm5f9AksXX2+A==
X-Google-Smtp-Source: APXvYqxEFprObBZEwR/k8yDSG0nJjc12vVIRVRrSEx17eih18Q12o75QCDIVmcsVL8aPvfWAMIaKIg==
X-Received: by 2002:a17:90a:3247:: with SMTP id k65mr73468902pjb.49.1564489489600;
        Tue, 30 Jul 2019 05:24:49 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:24:48 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 3/6] tee: add private login method for kernel clients
Date:   Tue, 30 Jul 2019 17:53:37 +0530
Message-Id: <1564489420-677-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There are use-cases where user-space shouldn't be allowed to communicate
directly with a TEE device which is dedicated to provide a specific
service for a kernel client. So add a private login method for kernel
clients and disallow user-space to open-session using GP implementation
defined login method range: (0x80000000 - 0xFFFFFFFF).

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c   | 6 ++++++
 include/uapi/linux/tee.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0f16d9f..2c2f646 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 			goto out;
 	}
 
+	if (arg.clnt_login & TEE_IOCTL_LOGIN_MASK) {
+		pr_debug("login method not allowed for user-space client\n");
+		rc = -EPERM;
+		goto out;
+	}
+
 	rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
 	if (rc)
 		goto out;
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 4b9eb06..a0a3d52 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -172,6 +172,14 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_LOGIN_APPLICATION		4
 #define TEE_IOCTL_LOGIN_USER_APPLICATION	5
 #define TEE_IOCTL_LOGIN_GROUP_APPLICATION	6
+/*
+ * Disallow user-space to use GP implementation specific login
+ * method range (0x80000000 - 0xFFFFFFFF). This range is rather
+ * being reserved for REE kernel clients or TEE implementation.
+ */
+#define TEE_IOCTL_LOGIN_MASK			0x80000000
+/* Private login method for REE kernel clients */
+#define TEE_IOCTL_LOGIN_REE_KERNEL		0x80000000
 
 /**
  * struct tee_ioctl_param - parameter
-- 
2.7.4

