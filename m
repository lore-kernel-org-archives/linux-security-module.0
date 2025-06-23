Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366491E25F9;
	Mon, 23 Jun 2025 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660903; cv=none; b=sJWMRrUxPtP0wRL7zvZsLWDHT376Wak25Wa866UHJI7/lo7N6KhpWA1CevuVX4F+ncr676mmB/PlzNOz/SIMopReMZApYqTadXfANHvr4ejs1pHW2QeQOrsXNScsIxlS+oiET9+BtRw5r3Pe0N87i7VzHbfQVmfSh/xFC9/mhok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660903; c=relaxed/simple;
	bh=nSlAUT7DEiOlZgPvZksi/805csn1PaOvi1yY70A7Fi4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=CG/SnG9vC0yMkRfNRUsY1rcmFGmeOV+HeV/HO5NwziMZk0E2iLRbRdSW1W/3NBKu0D6jbw8o7DrOihsvDpoaXDknVBVEKG3+xme/EEpO8l//dfZUEE82Ys4yHenygWsWCzYWzqHXzGdIgQKODqGOSqQkvnIZ+cDum0c03Dbd3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bQdlb12fYz5FHRy;
	Mon, 23 Jun 2025 14:41:31 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 55N6f9ua037902;
	Mon, 23 Jun 2025 14:41:09 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid31;
	Mon, 23 Jun 2025 14:41:11 +0800 (CST)
Date: Mon, 23 Jun 2025 14:41:11 +0800 (CST)
X-Zmail-TransId: 2afb6858f70736f-018ff
X-Mailer: Zmail v1.0
Message-ID: <20250623144111491BDFs497HCFyciwxWW5SG4@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <apparmor@lists.ubuntu.com>
Cc: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBhcHBhcm1vcjogZml4IGRvY3VtZW50YXRpb24gbWlzbWF0Y2hlcyBpbiB2YWxfbWFza190b19zdHIgYW5kCiBzb2NrZXQgZnVuY3Rpb25z?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 55N6f9ua037902
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6858F71B.000/4bQdlb12fYz5FHRy

From: Peng Jiang <jiang.peng9@zte.com.cn>

This patch fixes kernel-doc warnings:
1. val_mask_to_str:
- Added missing descriptions for `size` and `table` parameters.
- Removed outdated str_size and chrs references.
2. Socket Functions:
- Makes non-null requirements clear for socket/address args.
- Standardizes return values per kernel conventions.
- Adds Unix domain socket protocol details.

These changes silence doc validation warnings and improve accuracy for
AppArmor LSM docs.

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
---
 security/apparmor/lib.c |  4 ++--
 security/apparmor/lsm.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index f51e79cc36d4..4317881d9542 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -84,8 +84,8 @@ int aa_parse_debug_params(const char *str)
 /**
  * val_mask_to_str - convert a perm mask to its short string
  * @str: character buffer to store string in (at least 10 characters)
- * @str_size: size of the @str buffer
- * @chrs: NUL-terminated character buffer of permission characters
+ * @size: size of the @str buffer
+ * @table: permission-value-to-string mappings (NOT NULL)
  * @mask: permission mask to convert
  */
 static int val_mask_to_str(char *str, size_t size,
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7952e8cab353..e41b85a06f12 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1122,8 +1122,15 @@ static void unix_connect_peers(struct aa_sk_ctx *sk_ctx,

 /**
  * apparmor_unix_stream_connect - check perms before making unix domain conn
+ * @sk: initiating socket
+ * @peer_sk: target socket being connected to
+ * @newsk: newly created socket for the connection
  *
  * peer is locked when this hook is called
+ *
+ * Return:
+ *   0 if connection is permitted
+ *   error code on denial or failure
  */
 static int apparmor_unix_stream_connect(struct sock *sk, struct sock *peer_sk,
                                        struct sock *newsk)
@@ -1153,10 +1160,20 @@ static int apparmor_unix_stream_connect(struct sock *sk, struct sock *peer_sk,

 /**
  * apparmor_unix_may_send - check perms before conn or sending unix dgrams
+ * @sock: socket initiating the send operation
+ * @peer: target socket receiving the message
+ *
+ * Performs bidirectional permission checks for Unix domain socket communication:
+ * 1. Verifies sender has AA_MAY_SEND to target socket
+ * 2. Verifies receiver has AA_MAY_RECEIVE from source socket
  *
  * sock and peer are locked when this hook is called
  *
  * called by: dgram_connect peer setup but path not copied to newsk
+ *
+ * Return:
+ *   0 if transmission is permitted
+ *   error code on denial or failure
  */
 static int apparmor_unix_may_send(struct socket *sock, struct socket *peer)
 {
@@ -1264,6 +1281,17 @@ static int apparmor_socket_socketpair(struct socket *socka,

 /**
  * apparmor_socket_bind - check perms before bind addr to socket
+ * @sock: socket being bound (must be non-NULL)
+ * @address: address structure to bind (must be non-NULL)
+ * @addrlen: length of the address structure
+ *
+ * Performs security checks before allowing a socket to bind to an address.
+ * Handles Unix domain sockets specially through aa_unix_bind_perm().
+ * For other socket families, uses generic permission check via aa_sk_perm().
+ *
+ * Return:
+ *   0 if binding is permitted
+ *   error code on denial or invalid parameters
  */
 static int apparmor_socket_bind(struct socket *sock,
                                struct sockaddr *address, int addrlen)
-- 
2.25.1
