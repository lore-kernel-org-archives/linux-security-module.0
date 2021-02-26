Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B3C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Feb 2021 09:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953FC64EE4
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Feb 2021 09:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBZJzK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Feb 2021 04:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhBZJxq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Feb 2021 04:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614333140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Iss5bF3Zlx/Ff5LawrjWHEmXl82q+Z4V6eLXuprUC0=;
        b=fJ0CiwoLCl6pmkI4y1D+xH5X1cChTamr9Kiy7QnFWBHsYgnBxQGF3l9S0anm4COVwBcsLQ
        1vVu1UtWn1Nq/6ciTk0ApULr7DFT5NzX6b/i+nl7CVxkic/9L6qBei9aQdNzoc9/zQDM15
        comix3rcCvXLhM8NeRBedgkhbKJ/cUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-PnJ4o6IUPw2dAGGbDTNZbA-1; Fri, 26 Feb 2021 04:52:15 -0500
X-MC-Unique: PnJ4o6IUPw2dAGGbDTNZbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CF30803F49;
        Fri, 26 Feb 2021 09:52:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB0131001281;
        Fri, 26 Feb 2021 09:52:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 4/4] integrity: Load mokx variables into the blacklist
 keyring
From:   David Howells <dhowells@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, dhowells@redhat.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Feb 2021 09:52:12 +0000
Message-ID: <161433313205.902181.2502803393898221637.stgit@warthog.procyon.org.uk>
In-Reply-To: <161433310139.902181.11787442834918634133.stgit@warthog.procyon.org.uk>
References: <161433310139.902181.11787442834918634133.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Eric Snowberg <eric.snowberg@oracle.com>

During boot the Secure Boot Forbidden Signature Database, dbx,
is loaded into the blacklist keyring.  Systems booted with shim
have an equivalent Forbidden Signature Database called mokx.
Currently mokx is only used by shim and grub, the contents are
ignored by the kernel.

Add the ability to load mokx into the blacklist keyring during boot.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20210122181054.32635-5-eric.snowberg@oracle.com/ # v5
Link: https://lore.kernel.org/r/c33c8e3839a41e9654f41cc92c7231104931b1d7.camel@HansenPartnership.com/
Link: https://lore.kernel.org/r/161428674320.677100.12637282414018170743.stgit@warthog.procyon.org.uk/
---

 security/integrity/platform_certs/load_uefi.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index ee4b4c666854..f290f78c3f30 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -132,8 +132,9 @@ static int __init load_moklist_certs(void)
 static int __init load_uefi_certs(void)
 {
 	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
-	void *db = NULL, *dbx = NULL;
-	unsigned long dbsize = 0, dbxsize = 0;
+	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
+	void *db = NULL, *dbx = NULL, *mokx = NULL;
+	unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
 	efi_status_t status;
 	int rc = 0;
 
@@ -175,6 +176,21 @@ static int __init load_uefi_certs(void)
 		kfree(dbx);
 	}
 
+	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
+	if (!mokx) {
+		if (status == EFI_NOT_FOUND)
+			pr_debug("mokx variable wasn't found\n");
+		else
+			pr_info("Couldn't get mokx list\n");
+	} else {
+		rc = parse_efi_signature_list("UEFI:MokListXRT",
+					      mokx, mokxsize,
+					      get_handler_for_dbx);
+		if (rc)
+			pr_err("Couldn't parse mokx signatures %d\n", rc);
+		kfree(mokx);
+	}
+
 	/* Load the MokListRT certs */
 	rc = load_moklist_certs();
 


