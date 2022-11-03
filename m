Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD84FC4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Nov 2022 18:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKCSEz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Nov 2022 14:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKCSEI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Nov 2022 14:04:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5CB23BD8
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 11:01:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b21so2655552plc.9
        for <linux-security-module@vger.kernel.org>; Thu, 03 Nov 2022 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmRSuvtVdtePdWlhI+qYfa3jkKLy3lL4+DZtMxIoK0I=;
        b=oCaws+kyFllbssoMBrcVaWuoHdvEerAiSWJdhgX2/4syWfjhj1QKDY3vH01nEt1vCn
         6+epL9ht0qOEZlWyuffULkcOVrYNaQtUOQrp36inBYo1C6HudOiAwjNrVKMTzQk3Tt92
         d2ijSkQ/5cW7KlfiSiDR6E4oiBjCKBzhXuCcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmRSuvtVdtePdWlhI+qYfa3jkKLy3lL4+DZtMxIoK0I=;
        b=x0ESwOwKWhsZKgM/QZnEyM27NKaHOSac11Ou0X1XVZYNY6gRzvRx34WRVHGLRoCjQk
         zh/3+pxmCPboXkHrQzowUTp6M08gwuqHFKb4cZfCRSQL1V353l6JXC/Y+jyBdtKci6Vc
         GIQbbDqlNcfgYi85NGgFJcadEEwwTwzyRmzqZBfUN1KsiCK9tyXRjCQOKvnS077heByR
         drZnMO4uo+Q0pCE0Hvy/nP21ce2eaHd3bjC/zw7MKeheFwfkPUUJEdLOhJ8S6+e0DivV
         cGeI6lsRqYJ/Xm7EiFOiJZdmZGg2iCRBUz+9mIWRl2ufJRwCFtFGnF2cIjyMjheBSPIQ
         3NTQ==
X-Gm-Message-State: ACrzQf1/UcGgMEjGdA9A73WrBKe/OINeDOcjXN2Nu+QdhclYMWg/5v4M
        QFLXBuqCvhSTijbQFupPhxevdg==
X-Google-Smtp-Source: AMsMyM5Pk1O0MR+psJrfWUlI0d5V4npjm5wYkPwm+68nIz1aVymvhFA0VHcpQUBKzObFd3rMSFoLEw==
X-Received: by 2002:a17:90b:278b:b0:213:c2f2:6ca1 with SMTP id pw11-20020a17090b278b00b00213c2f26ca1mr27478944pjb.103.1667498509274;
        Thu, 03 Nov 2022 11:01:49 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:48 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        gwendal@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v4 06/11] security: keys: trusted: Verify creation data
Date:   Thu,  3 Nov 2022 11:01:14 -0700
Message-Id: <20221103105558.v4.6.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103180120.752659-1-evgreen@chromium.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If a loaded key contains creation data, ask the TPM to verify that
creation data. This allows users like encrypted hibernate to know that
the loaded and parsed creation data has not been tampered with.

Suggested-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---
Source material for this change is at:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/

(no changes since v3)

Changes in v3:
 - Changed funky tag to suggested-by (Kees). Matthew, holler if you want
   something different.

Changes in v2:
 - Adjust hash len by 2 due to new ASN.1 storage, and add underflow
   check.

 include/linux/tpm.h                       |  1 +
 security/keys/trusted-keys/trusted_tpm2.c | 77 ++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 70134e6551745f..9c2ee3e30ffa5d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -224,6 +224,7 @@ enum tpm2_command_codes {
 	TPM2_CC_SELF_TEST	        = 0x0143,
 	TPM2_CC_STARTUP		        = 0x0144,
 	TPM2_CC_SHUTDOWN	        = 0x0145,
+	TPM2_CC_CERTIFYCREATION	        = 0x014A,
 	TPM2_CC_NV_READ                 = 0x014E,
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index a7ad83bc0e5396..c76a1b5a2e8471 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -703,6 +703,74 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	return rc;
 }
 
+/**
+ * tpm2_certify_creation() - execute a TPM2_CertifyCreation command
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @blob_handle: the loaded TPM handle of the key
+ *
+ * Return: 0 on success
+ *         -EINVAL on tpm error status
+ *         < 0 error from tpm_send or tpm_buf_init
+ */
+static int tpm2_certify_creation(struct tpm_chip *chip,
+				 struct trusted_key_payload *payload,
+				 u32 blob_handle)
+{
+	struct tpm_header *head;
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CERTIFYCREATION);
+	if (rc)
+		return rc;
+
+	/* Use TPM_RH_NULL for signHandle */
+	tpm_buf_append_u32(&buf, 0x40000007);
+
+	/* Object handle */
+	tpm_buf_append_u32(&buf, blob_handle);
+
+	/* Auth */
+	tpm_buf_append_u32(&buf, 9);
+	tpm_buf_append_u32(&buf, TPM2_RS_PW);
+	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u8(&buf, 0);
+	tpm_buf_append_u16(&buf, 0);
+
+	/* Qualifying data */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* Creation data hash */
+	if (payload->creation_hash_len < 2) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	tpm_buf_append_u16(&buf, payload->creation_hash_len - 2);
+	tpm_buf_append(&buf, payload->creation_hash + 2,
+		       payload->creation_hash_len - 2);
+
+	/* signature scheme */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+
+	/* creation ticket */
+	tpm_buf_append(&buf, payload->tk, payload->tk_len);
+
+	rc = tpm_transmit_cmd(chip, &buf, 6, "certifying creation data");
+	if (rc)
+		goto out;
+
+	head = (struct tpm_header *)buf.data;
+
+	if (be32_to_cpu(head->return_code) != TPM2_RC_SUCCESS)
+		rc = -EINVAL;
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
 /**
  * tpm2_unseal_trusted() - unseal the payload of a trusted key
  *
@@ -728,8 +796,15 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
-	tpm2_flush_context(chip, blob_handle);
+	if (rc)
+		goto flush;
+
+	if (payload->creation_len)
+		rc = tpm2_certify_creation(chip, payload, blob_handle);
 
+
+flush:
+	tpm2_flush_context(chip, blob_handle);
 out:
 	tpm_put_ops(chip);
 
-- 
2.38.1.431.g37b22c650d-goog

