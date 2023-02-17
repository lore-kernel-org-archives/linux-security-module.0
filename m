Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052CC636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjBQD0s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBQD0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:43 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A834BEA8
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:42 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q13so4306558qtx.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=os/z0/otnIfLbNDBwy3xN3D1IrBBEnr20irjaBpTcHc=;
        b=Ptqg2MWRTjXV52HArAOnm0/CBoyDvvI+rbHg9LOSNbbrLQxhWPcp6AGU3xljZsYszH
         /8x9PH7JfOPrhqocXptJMhQAJXS5q3hRPVS/QQL/A3zwhdiYpRmBRxXwp/9WLRdIeR6K
         MtHucXBijwm04HJqCa00sH5QWDAc3IUdNVYw6GRo20FjpzyaSfmRWXGi+pbbocmnj1wr
         oqS8SQP56VdnEqrUqaM9pibz6yOXCs946faw5qpZRjrqVKXLsdyeGR7BJmVMkR0Je5Sr
         riqr5rJNtWNT0J4/pPSpU0TRgaYTrPBM468Ifv/CaAQpc4xtP6vUaMRra8GEvW8On/gz
         lArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os/z0/otnIfLbNDBwy3xN3D1IrBBEnr20irjaBpTcHc=;
        b=xB4mrqTID5n3g/THmqSKb+wIRD0yZjIpvOFtriYw1RYcBaVpCeLLf0d3/QQlOd5vGQ
         acKrqnFB+rEiKDT8kl4b+7gd9JerLvdscMX4qGVNIRSx2PthyQs1F9LjwsCxm73jgepu
         yOlpPhnEfA4BjiksmMoSEBg0ZdZlVHJ07W9jIjUFmd1gr2CH66V1G3CbStCEcbWRAM2+
         /SX4D7BntAUhYRNILVQV0o1NTSCPT2pSFUrCtQSyj6VoPrHUWsbFVHIGAZu4K7oVom9h
         2c4KXmW8qE5eZBilFu1S1CydUuflKS2pjRip0v5tes86GlX6YIq06nSZIHHcq4A9uIRN
         QHVQ==
X-Gm-Message-State: AO0yUKVWc1BU5TUhFj9NOY3aQQrSf80nmQ5X+GBtm8k8jAYui3OvWdlq
        9hguoT/ymr5bsIhnFHUvRxgjppi6m7pTu3M=
X-Google-Smtp-Source: AK7set/tLrwEPunh5CIT+ESX9nqdn6e6Cz2GtgbC4L1fyjt8nLbvG+K0xoBcaxmL+O591QES7yZ+Bg==
X-Received: by 2002:a05:622a:1987:b0:3bd:1e3:d034 with SMTP id u7-20020a05622a198700b003bd01e3d034mr12502595qtc.38.1676604401025;
        Thu, 16 Feb 2023 19:26:41 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id t190-20020a37aac7000000b0073b77063a12sm1223993qke.90.2023.02.16.19.26.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:40 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 09/22] lsm: move the AF_UNIX hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:12 -0500
Message-Id: <20230217032625.678457-10-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 26 ------------------------
 security/security.c       | 42 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ba2daec1bc35..1fc1e2aa7d01 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,32 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for Unix domain networking.
- *
- * @unix_stream_connect:
- *	Check permissions before establishing a Unix domain stream connection
- *	between @sock and @other.
- *	@sock contains the sock structure.
- *	@other contains the peer sock structure.
- *	@newsk contains the new sock structure.
- *	Return 0 if permission is granted.
- * @unix_may_send:
- *	Check permissions before connecting or sending datagrams from @sock to
- *	@other.
- *	@sock contains the socket structure.
- *	@other contains the peer socket structure.
- *	Return 0 if permission is granted.
- *
- * The @unix_stream_connect and @unix_may_send hooks were necessary because
- * Linux provides an alternative to the conventional file name space for Unix
- * domain sockets.  Whereas binding and connecting to sockets in the file name
- * space is mediated by the typical file permissions (and caught by the mknod
- * and permission hooks in inode_security_ops), binding and connecting to
- * sockets in the abstract name space is completely unmediated.  Sufficient
- * control of Unix domain sockets in the abstract name space isn't possible
- * using only the socket layer hooks, since we need to know the actual target
- * socket, which is not looked up until we are inside the af_unix code.
- *
  * Security hooks for socket operations.
  *
  * @socket_create:
diff --git a/security/security.c b/security/security.c
index e067e54a5cfa..6fb279f0cd50 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3554,13 +3554,53 @@ int security_watch_key(struct key *key)
 #endif
 
 #ifdef CONFIG_SECURITY_NETWORK
-
+/**
+ * security_unix_stream_connect() - Check if a AF_UNIX stream is allowed
+ * @sock: originating sock
+ * @other: peer sock
+ * @newsk: new sock
+ *
+ * Check permissions before establishing a Unix domain stream connection
+ * between @sock and @other.
+ *
+ * The @unix_stream_connect and @unix_may_send hooks were necessary because
+ * Linux provides an alternative to the conventional file name space for Unix
+ * domain sockets.  Whereas binding and connecting to sockets in the file name
+ * space is mediated by the typical file permissions (and caught by the mknod
+ * and permission hooks in inode_security_ops), binding and connecting to
+ * sockets in the abstract name space is completely unmediated.  Sufficient
+ * control of Unix domain sockets in the abstract name space isn't possible
+ * using only the socket layer hooks, since we need to know the actual target
+ * socket, which is not looked up until we are inside the af_unix code.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
 {
 	return call_int_hook(unix_stream_connect, 0, sock, other, newsk);
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
+/**
+ * security_unix_may_send() - Check if AF_UNIX socket can send datagrams
+ * @sock: originating sock
+ * @other: peer sock
+ *
+ * Check permissions before connecting or sending datagrams from @sock to
+ * @other.
+ *
+ * The @unix_stream_connect and @unix_may_send hooks were necessary because
+ * Linux provides an alternative to the conventional file name space for Unix
+ * domain sockets.  Whereas binding and connecting to sockets in the file name
+ * space is mediated by the typical file permissions (and caught by the mknod
+ * and permission hooks in inode_security_ops), binding and connecting to
+ * sockets in the abstract name space is completely unmediated.  Sufficient
+ * control of Unix domain sockets in the abstract name space isn't possible
+ * using only the socket layer hooks, since we need to know the actual target
+ * socket, which is not looked up until we are inside the af_unix code.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
 	return call_int_hook(unix_may_send, 0, sock, other);
-- 
2.39.2

