Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C8C05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBQD1E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBQD0z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:55 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71AA4FC91
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:50 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c2so4294676qtw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeeHpA6lvQHPO/ftGpgUKQvSyPEmE3Df9MfvHzYRoGc=;
        b=ZrAJCoTjUbnKaKirz/acxVCH3IIApCF4mx6fRKixGIM3rQTXrsmtRTSpXi3yWqUdC5
         QWfPFu+vo9b4JS6ZfkffnEjKZCyeGRw6FVYnm7betGWoaJZNr+OhJYjviJfDQzGjnvln
         9iOWTNn++SJFZ5M3yFtayAdLJEjotjmn4f/MRtl0Qfq158MC4ut4ln5g0gGEUyElQuHI
         rCVOI9IBAWoYrx3kesO3ueVUhNRGKdXrdJwM7HhQBS7B09xH+ycaeOh6hSnmJ1oJ0HK1
         64mHXXNGp+m2QtXqRs9gfNr46YN+GFL1N7TEuGtkauAfGRWimK9sc82ddES/sLwNkfu1
         Wysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeeHpA6lvQHPO/ftGpgUKQvSyPEmE3Df9MfvHzYRoGc=;
        b=iELLyFBCuHf1kvKEX68V16EFzKwdvZDPA5HBaBIu5+3FYjb2qJ2XdNHDjgs0Hai13R
         lYFevI3fFVkT/C2QQaa/6JlBTKvZj6f3CRdL42vNJ1GM2OxIlgCrGeTmvlTYms4Q30wC
         uV1jD67elxJCY4FJGV34TpcRbB7eeSEVQPuzdwg0q3R6+mDRq1WCYuB4fe9synSirGf5
         h1opyGU09ueOcT66NLI+xpT2BLnFS+oTb4hLWCXKMpE3QrP64oeLUNXPPcj1Jk3WvalI
         OtWBAdn568QHipoNZ9hGi7EbxtiM79MmkGTMIbtjlQaqxLMAMo3hZuTxTvvUHAj9FTk1
         S7+g==
X-Gm-Message-State: AO0yUKVj42SXNII7wd7nU9sDofu3COkPR9k8c1QrWBPq8mwvvN+zNpzh
        b9Gg1RxgS8TUGmxfEH23zV1mofTcetGSzCM=
X-Google-Smtp-Source: AK7set+U5raHTtpzcwduoMWpxr2LatO2nOPAvp72opvfivRmOu9I938SInGAC7ZlcPwogYiiFuKfcg==
X-Received: by 2002:ac8:7f02:0:b0:3b9:c9c3:cc2b with SMTP id f2-20020ac87f02000000b003b9c9c3cc2bmr13268431qtk.7.1676604410136;
        Thu, 16 Feb 2023 19:26:50 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id s18-20020ac87592000000b003b868cdc689sm2500692qtq.5.2023.02.16.19.26.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:49 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 16/22] lsm: move the binder hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:19 -0500
Message-Id: <20230217032625.678457-17-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 22 ----------------------
 security/security.c       | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f6679fead627..0a5b3b46fc2b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,28 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * @binder_set_context_mgr:
- *	Check whether @mgr is allowed to be the binder context manager.
- *	@mgr contains the struct cred for the current binder process.
- *	Return 0 if permission is granted.
- * @binder_transaction:
- *	Check whether @from is allowed to invoke a binder transaction call
- *	to @to.
- *	@from contains the struct cred for the sending process.
- *	@to contains the struct cred for the receiving process.
- *	Return 0 if permission is granted.
- * @binder_transfer_binder:
- *	Check whether @from is allowed to transfer a binder reference to @to.
- *	@from contains the struct cred for the sending process.
- *	@to contains the struct cred for the receiving process.
- *	Return 0 if permission is granted.
- * @binder_transfer_file:
- *	Check whether @from is allowed to transfer @file to @to.
- *	@from contains the struct cred for the sending process.
- *	@file contains the struct file being transferred.
- *	@to contains the struct cred for the receiving process.
- *	Return 0 if permission is granted.
- *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
  *	@child process.
diff --git a/security/security.c b/security/security.c
index e26903e4ff75..d7a07264fb73 100644
--- a/security/security.c
+++ b/security/security.c
@@ -779,23 +779,59 @@ static int lsm_superblock_alloc(struct super_block *sb)
 
 /* Security operations */
 
+/**
+ * security_binder_set_context_mgr() - Check if becoming binder ctx mgr is ok
+ * @mgr: task credentials of current binder process
+ *
+ * Check whether @mgr is allowed to be the binder context manager.
+ *
+ * Return: Return 0 if permission is granted.
+ */
 int security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
+/**
+ * security_binder_transaction() - Check if a binder transaction is allowed
+ * @from: sending process
+ * @to: receiving process
+ *
+ * Check whether @from is allowed to invoke a binder transaction call to @to.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_binder_transaction(const struct cred *from,
 				const struct cred *to)
 {
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
+/**
+ * security_binder_transfer_binder() - Check if a binder transfer is allowed
+ * @from: sending process
+ * @to: receiving process
+ *
+ * Check whether @from is allowed to transfer a binder reference to @to.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to)
 {
 	return call_int_hook(binder_transfer_binder, 0, from, to);
 }
 
+/**
+ * security_binder_transfer_file() - Check if a binder file xfer is allowed
+ * @from: sending process
+ * @to: receiving process
+ * @file: file being transferred
+ *
+ * Check whether @from is allowed to transfer @file to @to.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, struct file *file)
 {
-- 
2.39.2

