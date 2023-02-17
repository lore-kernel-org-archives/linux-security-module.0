Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD3C636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjBQD1A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBQD0p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:45 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53B4D61D
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:44 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e26so59825qtq.6
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx5RnoeqsWMkyF9r54r84IsyP6auWb4mLof5PwpW+4U=;
        b=OoyexwPsQB/2yf5CC1NcoCPbDhv0FOdpDOpP+4oaRF2McjfpOQbwfR0OcwnzYBFWph
         4dgUv+le7Fx6+93lDeK3TqIe99EsCML21E7WdKHsZKFkznmc3y+Ge+AeWyFN/vps7sEo
         GrBsFchx5Yc3Zk3TCiQNJT4p66XYflszfXCQV4VQLwnacpmCnBjyfDUSEzakThiAVC8J
         pPmy/d9XqVZxLgZRyb+24f5jtkZKrq0zkO5x0qj5IP2fLTrwEfXtC7EUbWNEYwVV/bPz
         B26ADO/9NQTW08sqJd1xfXSCOiwwK9nwHqytVViM/1XCsU+APS3noNULZloDjSsEKSLb
         Aqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx5RnoeqsWMkyF9r54r84IsyP6auWb4mLof5PwpW+4U=;
        b=DGnA5ZPXGNmDbpCvnQH9LQEGKseSsd6tMqH58aKB8EOAcwYbtG7bjChWrl0pq4O5LH
         jie8UfMZpMUTX1dHazouMBZrKydviy5W6IJSHtj/q97Kejv0/3Y4DIeWPHgMpC1/f9dZ
         NweFsGBciAOKEnYORyNYCWha5KzErKXgbluo/qAyrfPcBMZYNILxna2GERWuRiqZxYSw
         oZvl1Zaq5sWCp9bRExWOm8eYd2xlycJxJAOpjz8RkHLULgJa6Xy7Z4jzrrwWqXkbZezF
         WLwhjl2Ehx8PPXi0vMwVCdORSP9ZUGkd3MbDdFCFHf/JoCErbAWpYBfiZuWtchAYJQOB
         k44A==
X-Gm-Message-State: AO0yUKV9bMN1pNV59GKgGTEJjdmQ9fjwJM3tFXRmJDz+rmkyfVGugCzJ
        uzMhsQHUq+KmKloBP8763O6nK0+iF76Gx/4=
X-Google-Smtp-Source: AK7set+ZHJwfdWLeE0xzvs3uEhg95BYsrQ6V85+ze72xrDp3NXrTX3X0OdPyiIgbt5FqTs5HoHA2lg==
X-Received: by 2002:a05:622a:5ce:b0:3b8:629e:afd9 with SMTP id d14-20020a05622a05ce00b003b8629eafd9mr13115840qtb.17.1676604403524;
        Thu, 16 Feb 2023 19:26:43 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id r207-20020a3744d8000000b00706bc44fda8sm2438332qka.79.2023.02.16.19.26.42
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:43 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 11/22] lsm: move the SCTP hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:14 -0500
Message-Id: <20230217032625.678457-12-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 33 ------------------------------
 security/security.c       | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 531d141083ed..bb460e0b1ff2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,39 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for SCTP
- *
- * @sctp_assoc_request:
- *	Passes the @asoc and @chunk->skb of the association INIT packet to
- *	the security module.
- *	@asoc pointer to sctp association structure.
- *	@skb pointer to skbuff of association packet.
- *	Return 0 on success, error on failure.
- * @sctp_bind_connect:
- *	Validiate permissions required for each address associated with sock
- *	@sk. Depending on @optname, the addresses will be treated as either
- *	for a connect or bind service. The @addrlen is calculated on each
- *	ipv4 and ipv6 address using sizeof(struct sockaddr_in) or
- *	sizeof(struct sockaddr_in6).
- *	@sk pointer to sock structure.
- *	@optname name of the option to validate.
- *	@address list containing one or more ipv4/ipv6 addresses.
- *	@addrlen total length of address(s).
- *	Return 0 on success, error on failure.
- * @sctp_sk_clone:
- *	Called whenever a new socket is created by accept(2) (i.e. a TCP
- *	style socket) or when a socket is 'peeled off' e.g userspace
- *	calls sctp_peeloff(3).
- *	@asoc pointer to current sctp association structure.
- *	@sk pointer to current sock structure.
- *	@newsk pointer to new sock structure.
- * @sctp_assoc_established:
- *	Passes the @asoc and @chunk->skb of the association COOKIE_ACK packet
- *	to the security module.
- *	@asoc pointer to sctp association structure.
- *	@skb pointer to skbuff of association packet.
- *	Return 0 if permission is granted.
- *
  * Security hooks for Infiniband
  *
  * @ib_pkey_access:
diff --git a/security/security.c b/security/security.c
index 844670d7754f..1ada27c7917f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4132,12 +4132,35 @@ int security_tun_dev_open(void *security)
 }
 EXPORT_SYMBOL(security_tun_dev_open);
 
+/**
+ * security_sctp_assoc_request() - Update the LSM on a SCTP association req
+ * @asoc: SCTP association
+ * @skb: packet requesting the association
+ *
+ * Passes the @asoc and @chunk->skb of the association INIT packet to the LSM.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_sctp_assoc_request(struct sctp_association *asoc, struct sk_buff *skb)
 {
 	return call_int_hook(sctp_assoc_request, 0, asoc, skb);
 }
 EXPORT_SYMBOL(security_sctp_assoc_request);
 
+/**
+ * security_sctp_bind_connect() - Validate a list of addrs for a SCTP option
+ * @sk: socket
+ * @optname: SCTP option to validate
+ * @address: list of IP addresses to validate
+ * @addrlen: length of the address list
+ *
+ * Validiate permissions required for each address associated with sock	@sk.
+ * Depending on @optname, the addresses will be treated as either a connect or
+ * bind service. The @addrlen is calculated on each IPv4 and IPv6 address using
+ * sizeof(struct sockaddr_in) or sizeof(struct sockaddr_in6).
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_sctp_bind_connect(struct sock *sk, int optname,
 			       struct sockaddr *address, int addrlen)
 {
@@ -4146,6 +4169,16 @@ int security_sctp_bind_connect(struct sock *sk, int optname,
 }
 EXPORT_SYMBOL(security_sctp_bind_connect);
 
+/**
+ * security_sctp_sk_clone() - Clone a SCTP sock's LSM state
+ * @asoc: SCTP association
+ * @sk: original sock
+ * @newsk: target sock
+ *
+ * Called whenever a new socket is created by accept(2) (i.e. a TCP style
+ * socket) or when a socket is 'peeled off' e.g userspace calls
+ * sctp_peeloff(3).
+ */
 void security_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 			    struct sock *newsk)
 {
@@ -4153,6 +4186,16 @@ void security_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 }
 EXPORT_SYMBOL(security_sctp_sk_clone);
 
+/**
+ * security_sctp_assoc_established() - Update LSM state when assoc established
+ * @asoc: SCTP association
+ * @skb: packet establishing the association
+ *
+ * Passes the @asoc and @chunk->skb of the association COOKIE_ACK packet to the
+ * security module.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sctp_assoc_established(struct sctp_association *asoc,
 				    struct sk_buff *skb)
 {
-- 
2.39.2

