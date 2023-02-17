Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D31EC05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjBQD07 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjBQD0q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:46 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35835383B
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:45 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s22so58366qtw.11
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2KO/U1GMnbjWKNCR9OH5iKe9wqlpCjHaefBClgFJWE=;
        b=gDpltovinM6pc0fpd8keETx0SB+w2/aMnYuoYXA2F6tg4X2IRJKP/i5X5ft36k2H0l
         XbhJu1wqAW7S3H7JbQqPDeAXvNLDkVwmGkxewJHgrD04HSKaU1yQP+eP0qoPxIezyvPD
         4IqCgDJ2vcX2VgBoKLWcuPk/DGNuejY2+Q5o3QFX+VsmgfpwBXoaJ+/iR03krVd+E3pI
         JnBhdrVFSrDvaxRn3Zh+C/uZ4R3Tiia0kls5P8Us3CwuC1r3j5zbWfYyu4aGZwT7CNCs
         ZIkMHtn4WBxltevthdiHzN6lKxU/MJeo9dqNmx4Aif5m5BCATQChjesXAXnnoNDGpIIR
         trfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2KO/U1GMnbjWKNCR9OH5iKe9wqlpCjHaefBClgFJWE=;
        b=aKYqX9HuOi/9s5pgBZA8w+U9wGusRcE7aAUAbX28RbGp7TrOZLrg2EtvRf+yN8TDlD
         HwFISKVwfNDipZ8p6P1ZAL89cSnnMdfMr/w0gq5rk/kH+H0XVxlwwL3UuowS/7gOpgyn
         Q3yyW4eSms/Lc9VlyXh9F1xoc4QegZOXadtRqSQMV87lLneOtPOPjswv8emZO2O7/vNY
         0xfr/EipwYlPPntJuUotft8eRN+DBSMZc/zCcDW1UVIVdRcb1K2qd6/wrmpy2fWZFVqr
         9nY4gC2Kw98z4ZD1DojJ4iWESdcKY8vJ2F8fOAx3d0klk6TD/FAdm+4xNh8Q41Wm0yvr
         ImrQ==
X-Gm-Message-State: AO0yUKXvVcw9wylQxM3sx+neEmJeRZyaWaTUOfSLEkw5FJ+NtvI9s1Yu
        5eimOFOtpH4fdKjm1QbnvZx0/YOo2z2dprA=
X-Google-Smtp-Source: AK7set8g2TydCwhqU1PTYWPs93LbYwszRNS0znPYDIHS5InSIsYVkUuPvbL3+/FUokVnU0vW6SqunQ==
X-Received: by 2002:ac8:5c07:0:b0:3b6:5fc7:f554 with SMTP id i7-20020ac85c07000000b003b65fc7f554mr7575295qti.7.1676604404842;
        Thu, 16 Feb 2023 19:26:44 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id x4-20020ac84d44000000b003b82a07c4d6sm2444142qtv.84.2023.02.16.19.26.43
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:44 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 12/22] lsm: move the Infiniband hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:15 -0500
Message-Id: <20230217032625.678457-13-paul@paul-moore.com>
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
 security/security.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bb460e0b1ff2..9fc6417af980 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,28 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for Infiniband
- *
- * @ib_pkey_access:
- *	Check permission to access a pkey when modifing a QP.
- *	@subnet_prefix the subnet prefix of the port being used.
- *	@pkey the pkey to be accessed.
- *	@sec pointer to a security structure.
- *	Return 0 if permission is granted.
- * @ib_endport_manage_subnet:
- *	Check permissions to send and receive SMPs on a end port.
- *	@dev_name the IB device name (i.e. mlx4_0).
- *	@port_num the port number.
- *	@sec pointer to a security structure.
- *	Return 0 if permission is granted.
- * @ib_alloc_security:
- *	Allocate a security structure for Infiniband objects.
- *	@sec pointer to a security structure pointer.
- *	Returns 0 on success, non-zero on failure.
- * @ib_free_security:
- *	Deallocate an Infiniband security structure.
- *	@sec contains the security structure to be freed.
- *
  * Security hooks for XFRM operations.
  *
  * @xfrm_policy_alloc_security:
diff --git a/security/security.c b/security/security.c
index 1ada27c7917f..3b713ed3d29c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4207,24 +4207,58 @@ EXPORT_SYMBOL(security_sctp_assoc_established);
 
 #ifdef CONFIG_SECURITY_INFINIBAND
 
+/**
+ * security_ib_pkey_access() - Check if access to an IB pkey is allowed
+ * @sec: LSM blob
+ * @subnet_prefix: subnet prefix of the port
+ * @pkey: IB pkey
+ *
+ * Check permission to access a pkey when modifing a QP.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey)
 {
 	return call_int_hook(ib_pkey_access, 0, sec, subnet_prefix, pkey);
 }
 EXPORT_SYMBOL(security_ib_pkey_access);
 
+/**
+ * security_ib_endport_manage_subnet() - Check if SMPs traffic is allowed
+ * @sec: LSM blob
+ * @dev_name: IB device name
+ * @port_num: port number
+ *
+ * Check permissions to send and receive SMPs on a end port.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_ib_endport_manage_subnet(void *sec, const char *dev_name, u8 port_num)
 {
 	return call_int_hook(ib_endport_manage_subnet, 0, sec, dev_name, port_num);
 }
 EXPORT_SYMBOL(security_ib_endport_manage_subnet);
 
+/**
+ * security_ib_alloc_security() - Allocate an Infiniband LSM blob
+ * @sec: LSM blob
+ *
+ * Allocate a security structure for Infiniband objects.
+ *
+ * Return: Returns 0 on success, non-zero on failure.
+ */
 int security_ib_alloc_security(void **sec)
 {
 	return call_int_hook(ib_alloc_security, 0, sec);
 }
 EXPORT_SYMBOL(security_ib_alloc_security);
 
+/**
+ * security_ib_free_security() - Free an Infiniband LSM blob
+ * @sec: LSM blob
+ *
+ * Deallocate an Infiniband security structure.
+ */
 void security_ib_free_security(void *sec)
 {
 	call_void_hook(ib_free_security, sec);
-- 
2.39.2

