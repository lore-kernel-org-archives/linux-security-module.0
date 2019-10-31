Return-Path: <SRS0=Hf04=YY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8CBCA9ECB
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Oct 2019 14:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E177F21734
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Oct 2019 13:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tf+KATEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfJaN76 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:59:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfJaN75 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Oct 2019 09:59:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so4127771pgi.4
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2019 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3OJFxf+mUWoz3h8BXrLdL53qyDG3CcJuYs/0iyxKF4=;
        b=tf+KATEyMKScBhe2rDxFmvhHdhpJvsG8Ppi+Ok6s+1JY+Ck0LsQI6EgbXGwk6Gxns2
         PBhFeVi79K6keCg6KQopPP+74YLxVly8VZb6Lkf1BGv+ATKanKjaohe+f55adgBuMttF
         ghSDNFsV11Nb21uJw86b7GMyPRXXuWo3nSS9se6Vt7rIUg3OvajwiDKd2Byp1nMqXkx6
         RLI18VC7Bc7ONNECHSTu/fq24VhTJJYi4wjTUIJfJ7zE+NM+fU/oyzFLdPiRdKQgL9qR
         NVu9qVxDVu59qNFL7TyaD+bkES5v9TlqyZ9mHlOmkX4lzMqpiLj8bfpJmBr8MVXkfcQW
         HHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3OJFxf+mUWoz3h8BXrLdL53qyDG3CcJuYs/0iyxKF4=;
        b=bjR2Nl8A55BQN5TEXBXpW1sjhlxO6aXt8UmvVcYjrsFmqyMsR0ZGBTwE3BFV372hSv
         LY3KUnJxcJefu+Zv7OOMMfsK9xTyYmQmeKmTlrwrLcWdf3HYf6cAwfl/lbeIcttuWlWs
         ClzC65VY6IbjC7+LDd8fBqpmGXspcPjWq76NM4GY9Gd0LdwRRfwTolUIe/NOR6Ej79hh
         QfnDYnByK6g5Y6nzzX9Cn+FXpUyKSgySXBWbwk4u/gRUzy5qNJArgK635o7WC5biTekK
         TVQ+Dp1vdrwnRrT5bimLPxG+gxuVPNOXaolGLdPqaQWyeTyrsuT/h52or0ffk/LgiCsC
         dkqg==
X-Gm-Message-State: APjAAAU8QraiugBz9ME7vbvu2fIt5A7Z4zlpWiyGL6U91YV8xyWdHnTu
        +5VJmKRpIrXrUr9BbYS0JsMeFg==
X-Google-Smtp-Source: APXvYqx6w3fK7udP850k+SVSjxTClJG1BWGTayyOqKUy8HcRBFjYN6ROvTumbYp2kjoyQbEiFFSOdg==
X-Received: by 2002:a63:fe0c:: with SMTP id p12mr6825858pgh.121.1572530396394;
        Thu, 31 Oct 2019 06:59:56 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id i16sm3522441pfa.184.2019.10.31.06.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 06:59:55 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com
Cc:     corbet@lwn.net, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v3 3/7] tee: add private login method for kernel clients
Date:   Thu, 31 Oct 2019 19:28:39 +0530
Message-Id: <1572530323-14802-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
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

