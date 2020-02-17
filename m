Return-Path: <SRS0=tuct=4F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED3C35254
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Feb 2020 11:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7DF20836
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Feb 2020 11:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XanMa1jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgBQLj5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:39:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728531AbgBQLj5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Feb 2020 06:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581939595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QRFmFOmaNTRD1QIBloTftoDjLg6oNQM+MmQJYi2gh5g=;
        b=XanMa1jpVQcsZpyHjBPsD6HX4wHG8PCWSnQmdnH/p7fVMT8hagzWNO4sJkiJEQ1pG6l3st
        JcdEo8YqS/yd0zDx2WJ2++9YLMahnLj+MYtEemGcAHKbZz/XiG7EaOqX3cEmgHDnAXCubx
        yKcDaHE5JV+vzxBdFfeeBNpKImrNGlU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-DztxwA2wP6e81b4sS2YXsQ-1; Mon, 17 Feb 2020 06:39:53 -0500
Received: by mail-wr1-f69.google.com with SMTP id a12so8817843wrn.19
        for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2020 03:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRFmFOmaNTRD1QIBloTftoDjLg6oNQM+MmQJYi2gh5g=;
        b=jvUsU/q9mO5QlN8rt7AW1LzBvxajHkw7jfeGCHWjqafT0jZW9FbI6bDrOhi4Xd4IWL
         u3FgwVR0H5Xz5yNVzoYp6YAaNJJ9JisIaKEMXy4xVAESVeCyETzJkZ3CpzT2E2qd9TUO
         f7M2OClnkLFEWm9FYHFUcWtkMtCdPKFwAj8eI1gtMFwKL1nfMp9CfW+R/ZXPXOLu7TtS
         0aSMsnKbEAh6GjMn5DgevMvxXQ4LEAQ0aJMtr6Qy9RlLb0LBl2mxSN2u7VUAcbL0Y8S4
         Lmy3ttk62eVTImS/LBIIxCl6OHcHGYeE6a2+DP90A9uyXs6EgzpNR++747GVb1hYPT5A
         cWBw==
X-Gm-Message-State: APjAAAWnNYVl2HRob8ygShZvICbevP/xq5FRmKlqbpTkPBjvoV9/CdZ9
        YBZRilEQojqptS/V5LivOov+yY75PYJGx+uUdbqaMlf4PdmucCpi3GWvHbuf2MjOKelXfiQ+Jr1
        VaD9qsvVPBr2SaIdIFAogaRjE7t4M99d//nj0
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr21650602wrt.253.1581939592318;
        Mon, 17 Feb 2020 03:39:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwN2okTJcojI/z4Sv+jYqgvwukj9C5eNn7FosG40Fd5mXfN5sJbwb9Yjzx0ib+Co8jWunrSPw==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr21650582wrt.253.1581939592064;
        Mon, 17 Feb 2020 03:39:52 -0800 (PST)
Received: from minerva.redhat.com ([2a01:c50f:ab80:6700:527f:85b3:5615:ff0b])
        by smtp.gmail.com with ESMTPSA id y6sm620529wrl.17.2020.02.17.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 03:39:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Eric Richter <erichte@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-security-module@vger.kernel.org
Subject: [RESEND PATCH v2] efi: Only print errors about failing to get certs if EFI vars are found
Date:   Mon, 17 Feb 2020 12:39:47 +0100
Message-Id: <20200217113947.2070436-1-javierm@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: DztxwA2wP6e81b4sS2YXsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
from the db, dbx and MokListRT EFI variables into the appropriate keyrings.

But it just assumes that the variables will be present and prints an error
if the certs can't be loaded, even when is possible that the variables may
not exist. For example the MokListRT variable will only be present if shim
is used.

So only print an error message about failing to get the certs list from an
EFI variable if this is found. Otherwise these printed errors just pollute
the kernel log ring buffer with confusing messages like the following:

[    5.427251] Couldn't get size: 0x800000000000000e
[    5.427261] MODSIGN: Couldn't get UEFI db list
[    5.428012] Couldn't get size: 0x800000000000000e
[    5.428023] Couldn't get UEFI MokListRT

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

---

Changes in v2:
- Fix flaws in the logic, that caused the signature list was parsed if
  the return code was EFI_NOT_FOUND that pointed out Hans de Goede.
- Print debug messages if the variables are not found.

 security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898aad56..f0c90824196 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -35,16 +35,18 @@ static __init bool uefi_check_ignore_db(void)
  * Get a certificate list blob from the named EFI variable.
  */
 static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
-				  unsigned long *size)
+				  unsigned long *size, efi_status_t *status)
 {
-	efi_status_t status;
 	unsigned long lsize = 4;
 	unsigned long tmpdb[4];
 	void *db;
 
-	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
-	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
+	*status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
+	if (*status == EFI_NOT_FOUND)
+		return NULL;
+
+	if (*status != EFI_BUFFER_TOO_SMALL) {
+		pr_err("Couldn't get size: 0x%lx\n", *status);
 		return NULL;
 	}
 
@@ -52,10 +54,10 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	if (!db)
 		return NULL;
 
-	status = efi.get_variable(name, guid, NULL, &lsize, db);
-	if (status != EFI_SUCCESS) {
+	*status = efi.get_variable(name, guid, NULL, &lsize, db);
+	if (*status != EFI_SUCCESS) {
 		kfree(db);
-		pr_err("Error reading db var: 0x%lx\n", status);
+		pr_err("Error reading db var: 0x%lx\n", *status);
 		return NULL;
 	}
 
@@ -74,6 +76,7 @@ static int __init load_uefi_certs(void)
 	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
 	void *db = NULL, *dbx = NULL, *mok = NULL;
 	unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
+	efi_status_t status;
 	int rc = 0;
 
 	if (!efi.get_variable)
@@ -83,9 +86,12 @@ static int __init load_uefi_certs(void)
 	 * an error if we can't get them.
 	 */
 	if (!uefi_check_ignore_db()) {
-		db = get_cert_list(L"db", &secure_var, &dbsize);
+		db = get_cert_list(L"db", &secure_var, &dbsize, &status);
 		if (!db) {
-			pr_err("MODSIGN: Couldn't get UEFI db list\n");
+			if (status == EFI_NOT_FOUND)
+				pr_debug("MODSIGN: db variable wasn't found\n");
+			else
+				pr_err("MODSIGN: Couldn't get UEFI db list\n");
 		} else {
 			rc = parse_efi_signature_list("UEFI:db",
 					db, dbsize, get_handler_for_db);
@@ -96,9 +102,12 @@ static int __init load_uefi_certs(void)
 		}
 	}
 
-	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
 	if (!mok) {
-		pr_info("Couldn't get UEFI MokListRT\n");
+		if (status == EFI_NOT_FOUND)
+			pr_debug("MokListRT variable wasn't found\n");
+		else
+			pr_info("Couldn't get UEFI MokListRT\n");
 	} else {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
 					      mok, moksize, get_handler_for_db);
@@ -107,9 +116,12 @@ static int __init load_uefi_certs(void)
 		kfree(mok);
 	}
 
-	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
+	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
 	if (!dbx) {
-		pr_info("Couldn't get UEFI dbx list\n");
+		if (status == EFI_NOT_FOUND)
+			pr_debug("dbx variable wasn't found\n");
+		else
+			pr_info("Couldn't get UEFI dbx list\n");
 	} else {
 		rc = parse_efi_signature_list("UEFI:dbx",
 					      dbx, dbxsize,
-- 
2.24.1

