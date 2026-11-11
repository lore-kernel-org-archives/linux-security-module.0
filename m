Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430700;
	b=L2OHKN623mWjwfC54R1F5XrZP3HobfY1fN09D3CsXRavL8c/QjWC1E5Fh9q/GDJBN/wK
	 IqgagHYF1EVSOba7wIIz5WZ6XQ9EcGHSHDTUoIOLEpQgq/8EKiIkTDc3Mbw55IlINbDDS
	 cP2EOFg6TvQpi81csJRTNNGKBLKFfoF6cwSd0cPE7781f2BkeKHQntxEYMwEWs+9QVPLm
	 e3vWdbVHZWzboY4aZPnXObyu0SzGkOczMQwCVN6teod899ZyKXKwdLieDHye9m2dOoahY
	 OEnjoXBPuL8S3hZmkmI0UboUC045BjM4ye7X7itQqid3djzj8ssefX2Fay+Xa1QVrCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430700;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=avo04gh6qStJl92VR1s8c2Oe2PzA3Q8Kjvs4urcmX6o=;
	b=oynZlXNSPWs5InN/mNcVY62nQBBI2zoFV6fVOcof0+X0nz9x8Cv5pN3BnomCjjQKrhwS
	 wU77CX+uJ5oR+1uE4ovF3gjREJ2wAjwC71bzTVrWVIXhyoXkb1cJFtEbLHrTj92ek3Qr8
	 yS1Nd+IKzUd3J27R1OsKchR3iZAsyYHZ9Zfty08nXQFyy/LG++OGTgiT9/c4mVILJMOPA
	 WB6fSmkIlWjmPCdAQ0Poje6dURKb8fbo+t8Non+Q8FzZG1QNvx+Yx6Ap9NyhYGpcCWjpR
	 U6mCP5VuHjIR4BkWLgxYb9hhAwlmaU66DrfXoHZa3WCKttfTad+oflkSZ+vuRRbIC4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e9CKAlkH;
	arc=none smtp.remote-ip=95.215.58.103
Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25768606A327
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 20:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25768606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e9CKAlkH
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nPc7gQ7W5bZyARiFXAg3NafxeCmsOK8St8I07Lnbg+A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794430696; v=1; x=1795035496;
 b=e9CKAlkHosCI3YtQsjI7bla6y4M1DgIdHBn8+iS1E0oSGylFnrXs4iaMGHhg2JhdY+AaNRC7
 juTNJhsaT9ONhZ/ZyePtfLAeIC1EENBS8hLn6BLDSCgfHUq75lgAweLzelyWr5ZScHpQK/PtDdT
 33WpYqHU2ZsqaS/oHL6JZKVg=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1328379f3ede4e52;
	Wed, 11 Nov 2026 20:58:16 +0000
X-Mizu-Trace-ID: 1328379f3ede4e52
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	James Morris <jmorris@namei.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <bradley.morgan@linux.dev>
Subject: [PATCH] userns: security: Inform LSMs of capability check during userns creation
Date: Wed, 11 Nov 2026 20:58:14 +0000
Message-ID: <20261111205814.3282968-1-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now security_capable() gets called in create_user_ns() to snapshot
whether the parent could setfcap, but the LSM gets zero context on where
the check actually came from. It is the same story as setid: without a
dedicated flag, security modules cannot tell this apart from regular
capability checks.

Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().

Suggested-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/all/20261111-kommt-gischt-ohnedies-469998d2f219@brauner/
Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
---
Thanks Christian for the suggestion :).
---
 include/linux/security.h | 2 ++
 kernel/user_namespace.c  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab54709..d24666a0b4833 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -75,6 +75,8 @@ struct nsset;
 #define CAP_OPT_NOAUDIT BIT(1)
 /* If capable is being called by a setid function */
 #define CAP_OPT_INSETID BIT(2)
+/* Is capable being called from the user namespace creation path? */
+#define CAP_OPT_USERNS_CREATE BIT(3)
 
 /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
 #define SECURITY_LSM_NATIVE_LABELS	1
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 57b7f10be74e1..37480f6d8369f 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -134,7 +134,8 @@ int create_user_ns(struct cred *new)
 	 * audit: the creator may never map uid 0.
 	 */
 	ns->parent_could_setfcap =
-		!security_capable(new, parent_ns, CAP_SETFCAP, CAP_OPT_NOAUDIT);
+		!security_capable(new, parent_ns, CAP_SETFCAP,
+				  CAP_OPT_NOAUDIT | CAP_OPT_USERNS_CREATE);
 
 	ret = ns_common_init(ns);
 	if (ret)
-- 
2.53.0

