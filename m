Return-Path: <SRS0=X2V5=3T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A98C33CB2
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jan 2020 02:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8602F2070E
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jan 2020 02:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580349694;
	bh=a4KWsJRiuNAu+S0um97LfdSQg/QjtCJtt53SgVg+TF8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cP9QcM2fpDCtQ92IHD4g9X08FgIVuJRr3oyg8I3hg8PY/ROVgYEWBlJGZy2xnC4hi
	 ymGbrVgtsPVzoUMTR9SlvsfSsQPnj+G58WMKa6Ak10FeveTcoLuiTqiOPDqDpwtyY9
	 mLB3euvKJTD28yzLC65D63RPxpPXOUGilsHJXALM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA3CBd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:01:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45594 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgA3CBd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Jan 2020 21:01:33 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so2109616ioi.12
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jan 2020 18:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLmNga7Fg92j7Wp0mHpBfgEy1+qMj+VIGuo+fS2/qk=;
        b=a+JuYJP7DExfh7Xj7D1MP+WDtc/4pqFZPRUg5vQnLk8/ZyMguwk24cOHfvPd/+sGjo
         h/Bex96QHbUA/Do6IBNm3aQUtZ0/MIKqTX6OzyaprNtd5rcC2BwqmSEmVBo/H2cKZlIX
         UwRdkikLwwWO0ZxE/cPRXFdIK2yswvPPSnjfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLmNga7Fg92j7Wp0mHpBfgEy1+qMj+VIGuo+fS2/qk=;
        b=GTgdrEyF2IvIdMo9qbjBaBifnjtCbe+tMS9YJrHNvtoLH5EDXbydghZ4Fe9qYJAZEi
         BYH2q3jUj9NMvkUHo8jlIgSst5pzdjEqlF5FuiQCUR5hs7xXwnjFnSzDMVU2tmtRn4m1
         /dv1hc6TiHq40tADrP55/qCEQl4CYeECRLsQ08NSOIFr0fuPeqMJw+sU7VAsSXO5EG3E
         OG440tNLgvNjdT7/bwkEr9CFOXK71zJQkhm3ZAY6AzM1iB4cK8+6UPBOzrbiIdgyc+lV
         O0PGaVQduEuuecnYHC+EQD8MQ9Rbk6kOSAz3OOS3xlrvP4gCXVJQpnw9KUUsrwuYqzRq
         pLFQ==
X-Gm-Message-State: APjAAAVtt33kc5ArbybgWDKIJkcNZnbBco4fBRMn7XSORrJ8IonKLiYU
        IUL5dDbcf7YsVt6JKDfiyTcB3Q==
X-Google-Smtp-Source: APXvYqwIZP1v3iiH4xKUKmxt616Y3bG9d/QnCJDyKghwbYBWw8lWb+GqRRh4rI20P6dDFb83B1oLRQ==
X-Received: by 2002:a6b:c742:: with SMTP id x63mr2231819iof.162.1580349692648;
        Wed, 29 Jan 2020 18:01:32 -0800 (PST)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n17sm1306437ile.68.2020.01.29.18.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 18:01:31 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     jmorris@namei.org, serge@hallyn.com, mpe@ellerman.id.au,
        zohar@linux.ibm.com, erichte@linux.ibm.com, nayna@linux.ibm.com,
        yuehaibing@huawei.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/integrity: Include __func__ in messages for easier debug
Date:   Wed, 29 Jan 2020 19:01:29 -0700
Message-Id: <20200130020129.15328-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Change messages to messages to make it easier to debug. The following
error message isn't informative enough to figure out what failed.

Couldn't get size: 0x800000000000000e

Change messages to include function information.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
 security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index a2900cb85357..621454148fbc 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -25,7 +25,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
 
 	rc = secvar_ops->get(key, keylen, NULL, size);
 	if (rc) {
-		pr_err("Couldn't get size: %d\n", rc);
+		pr_err("%s: Couldn't get size: %d\n", __func__, rc);
 		return NULL;
 	}
 
@@ -36,7 +36,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
 	rc = secvar_ops->get(key, keylen, db, size);
 	if (rc) {
 		kfree(db);
-		pr_err("Error reading %s var: %d\n", key, rc);
+		pr_err("%s: Error reading %s var: %d\n", __func__, key, rc);
 		return NULL;
 	}
 
@@ -69,23 +69,25 @@ static int __init load_powerpc_certs(void)
 	 */
 	db = get_cert_list("db", 3, &dbsize);
 	if (!db) {
-		pr_err("Couldn't get db list from firmware\n");
+		pr_err("%s: Couldn't get db list from firmware\n", __func__);
 	} else {
 		rc = parse_efi_signature_list("powerpc:db", db, dbsize,
 					      get_handler_for_db);
 		if (rc)
-			pr_err("Couldn't parse db signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse db signatures: %d\n",
+				__func__, rc);
 		kfree(db);
 	}
 
 	dbx = get_cert_list("dbx", 4,  &dbxsize);
 	if (!dbx) {
-		pr_info("Couldn't get dbx list from firmware\n");
+		pr_info("%s: Couldn't get dbx list from firmware\n", __func__);
 	} else {
 		rc = parse_efi_signature_list("powerpc:dbx", dbx, dbxsize,
 					      get_handler_for_dbx);
 		if (rc)
-			pr_err("Couldn't parse dbx signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse dbx signatures: %d\n",
+				__func__, rc);
 		kfree(dbx);
 	}
 
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898aad56e..c3cf6575abc1 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -44,7 +44,7 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 
 	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
 	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
+		pr_err("%s: Couldn't get size: 0x%lx\n", __func__, status);
 		return NULL;
 	}
 
@@ -55,7 +55,7 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	status = efi.get_variable(name, guid, NULL, &lsize, db);
 	if (status != EFI_SUCCESS) {
 		kfree(db);
-		pr_err("Error reading db var: 0x%lx\n", status);
+		pr_err("%s: Error reading db var: 0x%lx\n", __func__, status);
 		return NULL;
 	}
 
@@ -85,13 +85,14 @@ static int __init load_uefi_certs(void)
 	if (!uefi_check_ignore_db()) {
 		db = get_cert_list(L"db", &secure_var, &dbsize);
 		if (!db) {
-			pr_err("MODSIGN: Couldn't get UEFI db list\n");
+			pr_err("%s: MODSIGN: Couldn't get UEFI db list\n",
+				__func__);
 		} else {
 			rc = parse_efi_signature_list("UEFI:db",
 					db, dbsize, get_handler_for_db);
 			if (rc)
-				pr_err("Couldn't parse db signatures: %d\n",
-				       rc);
+				pr_err("%s: Couldn't parse db signatures: %d\n",
+				       __func__, rc);
 			kfree(db);
 		}
 	}
@@ -103,7 +104,8 @@ static int __init load_uefi_certs(void)
 		rc = parse_efi_signature_list("UEFI:MokListRT",
 					      mok, moksize, get_handler_for_db);
 		if (rc)
-			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse MokListRT signatures: %d\n",
+				__func__, rc);
 		kfree(mok);
 	}
 
@@ -115,7 +117,8 @@ static int __init load_uefi_certs(void)
 					      dbx, dbxsize,
 					      get_handler_for_dbx);
 		if (rc)
-			pr_err("Couldn't parse dbx signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse dbx signatures: %d\n",
+				__func__, rc);
 		kfree(dbx);
 	}
 
-- 
2.20.1

