Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544F4C636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBQD0q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBQD0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:43 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318FF5383B
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h24so4347442qtr.0
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SryULUYH2PAsc3B7d7OGuXLPbIFGe1iIvF4t6xC+G7o=;
        b=ab0VEELihmn8WpeVPQ9/ud7aFZSGYgZ907IBKUPLDusiYcqNF4qp240CqNH5Zlv3ps
         zHTt7ZnaiZrLX9+agoaKxIRPRAEUvL1R1hldKKdtW+Ocg+nimsFtW8YVcyadmzHKrpYj
         fLMJvE3i1H11CYXU98Dj43MjQn5KsTe2kCDtEZHx5HH5FlMKuRtC+6mzZfG+09e7/Owx
         vYylLqaw/zHARZCv8g0mwzbYbHOya3rn9p6J2g4Lb8DNKon+bD1OlEloxgWpLNoCtdP4
         pmKUhRJVjv3srSI+NVQ2SKQH4fC4FZQ2o2Ooe/DzBFO7kxHK3zrjxdrVRHMhsrIk8XAa
         Kkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SryULUYH2PAsc3B7d7OGuXLPbIFGe1iIvF4t6xC+G7o=;
        b=LNnLbb8qWMvdia2e0pPC3RuejOjcRssJ+849U6h/YdrNBmK+4BOnaRhn6NN2RV4SjR
         K0FeXuv/a5rTMiCsNA/doPFctZizWUeoOvm8NPhk41jqa7VOz2bKZbGZsvjxQAswPC21
         upNpBx1J0TsWuVm8qemZy3SN/sY+SKrM/Suk4R/tlEnoEvJyCi0arDDcPc5gzgubi05I
         Gy3US2d+I/+tu79ZrM1svWr3Bh2mU57shZWp7q7EgcprRUCrhqkH0zpnm8npWs59NBjj
         RjF+jrQdepQsxcACNixI+fSzPjStPFfwD1SCFGyCP8m2kBxYBal/Cb25HSGmPEaYVFuE
         Lg/w==
X-Gm-Message-State: AO0yUKWrw2joZmPvGMm+Ae/O9hYSM3HPEDt/Ub0mGz+wBm2bjyql7dgO
        YMSsUAr0fbXcx89vCaB77AS6smrP0cXPQno=
X-Google-Smtp-Source: AK7set+Nk8/HUjvotjyGdFQqEDNGMJpFxzcuEqLMyiSmmamQ6++Jxa5VJPjDPpbl3MeYAWDarCnP4w==
X-Received: by 2002:a05:622a:1c9:b0:3b8:5057:376a with SMTP id t9-20020a05622a01c900b003b85057376amr13352070qtw.66.1676604399716;
        Thu, 16 Feb 2023 19:26:39 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id 19-20020ac85613000000b003bd0a4a30aesm2428836qtr.16.2023.02.16.19.26.39
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:39 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 08/22] lsm: move the netlink hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:11 -0500
Message-Id: <20230217032625.678457-9-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 13 -------------
 security/security.c       | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5578a13729bd..ba2daec1bc35 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,19 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for Netlink messaging.
- *
- * @netlink_send:
- *	Save security information for a netlink message so that permission
- *	checking can be performed when the message is processed.  The security
- *	information can be saved using the eff_cap field of the
- *	netlink_skb_parms structure.  Also may be used to provide fine
- *	grained control over message transmission.
- *	@sk associated sock of task sending the message.
- *	@skb contains the sk_buff structure for the netlink message.
- *	Return 0 if the information was successfully saved and message
- *	is allowed to be transmitted.
- *
  * Security hooks for Unix domain networking.
  *
  * @unix_stream_connect:
diff --git a/security/security.c b/security/security.c
index b43000cda9ff..e067e54a5cfa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3457,6 +3457,19 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	return LSM_RET_DEFAULT(setprocattr);
 }
 
+/**
+ * security_netlink_send() - Save info and check if netlink sending is allowed
+ * @sk: sending socket
+ * @skb: netlink message
+ *
+ * Save security information for a netlink message so that permission checking
+ * can be performed when the message is processed.  The security information
+ * can be saved using the eff_cap field of the netlink_skb_parms structure.
+ * Also may be used to provide fine grained control over message transmission.
+ *
+ * Return: Returns 0 if the information was successfully saved and message is
+ *         allowed to be transmitted.
+ */
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	return call_int_hook(netlink_send, 0, sk, skb);
-- 
2.39.2

