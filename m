Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6B2C2363
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723412; cv=none; b=XUM3tGlhwEdFYVixp4UjE4sRB1ElMMEBPlsRGdroI3ss0Yvs4gbnQ+XOzQoqMEmV9ZEVxZVoXb3u1L+YZYfcihy5/Ic/cgksCPUJOK8BEdtZglqmTqW1qRC9NjZgsUTF5dECneqZbR+/5xK7uAqeFKUsgX0tiHPeaqVG5OOYSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723412; c=relaxed/simple;
	bh=BH9Q/nb1SHbVfJKmzTYY61p3CrQmGn4nLgNrkig4qI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0NLesxmzrNJj1TXvYXrvxqFmCrnL2TZJwSU4lUwwmAIHgDXFmi7bd5kE026/vWZVRyBAYVJyg5ohlBu1GzmBjAVuoNcKHrEgG39YDi+1+J4rBKLPtFSkSDzACkouD+UGbp/ITaqyQHWzmGrC8zQpFxzVqKxm4cv89SqySXV6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bc+dA8D6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bc+dA8D6"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69eae037da1so6410416a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784723409; x=1785328209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10OEZDPHkj5hzFYDRyfra44GxaMnslQ2JStk6ORVQZA=;
        b=Bc+dA8D6hBoktrCwxeAx5BTN3fCqD/KJ3k1RXR3aDaRAVVIs5fuc5YZqfyXCiSuapu
         WLMOFxr3uA8UtAYVPI5FTNqo5nzJijSE6Aq5PAytKIRiCOkIRw07keJgkDtx2UeF/kVG
         xX9kieUgfEXUofRZjVNzSpXOekMOo6wYWrThO57+t570Q8r7lHa1aL86VkpiFB6OJnqh
         fkRttijeBJoMmsIg4/SpI40aiNojj9OeiHWBm15jhkhabT1v23mbVFyONOurz3mIwzJl
         F4PljIUoX440sHMziSulfsanrcwSPun0E7eXhcdu0RVn7q7YrvESmd9gybdI/ZfcDt8H
         lFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723409; x=1785328209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=10OEZDPHkj5hzFYDRyfra44GxaMnslQ2JStk6ORVQZA=;
        b=I70vbU8QyWO9Iph5Y/K1s2+vOXDSYkzezNfMkTRjRa2p8WqgLuyj97r17rWmjUi6C7
         zrh/8o9aC7eUa1+7ok0FQZJCwmswZPaTcREG2G1p2Mu6OAy1ANcvmjZ5+T2dN02qSeHR
         ojocCzUT1cF8EFsJhtM1DQgjpmZNyCDEj6YRCz2veHH6CKhvjoI29sxXHo/eKeSv7Qsz
         zlKDuXQEryd5gx4tctzYuRRPoCbfMzcsp9nNgzCwo2hFHpNAi9a236+8ZWfAQj47owhJ
         CPAD+owu7hobPulAwlF7UUfuaAH/QbeiwYZXH7fYYVvL6u4+77dgrutokwSTxLGtSZXN
         SE3g==
X-Forwarded-Encrypted: i=1; AHgh+Rq27V1C6shObFCCGVF3+KXQG+Kj7YOu6YOjGECcJiw1n0JfPcdpVEBv7dMP1q6u6gynXMZamcDFzaQqhf6jKzkdbxX5qgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy975EbgL1BTm8j8vs5oT5VG0l5vbnZnHDrhSinqGs+fGOfCxhn
	s1KPwM7Ts1JixpnmTyI2IBbeRqDGhvJqd940lsthu5SrE62Ca/KKdfBNaze3EsqC9Go=
X-Gm-Gg: AR+sD120KJ0zqcRDYxILBuI6nTR9o1jKnYbz/Nj2fPNkowG4uv9gyPtkruLcw+6tS+O
	Lqk6osy/KCnFXvdH8ULJqzJISGwymfayRrR/QeCYXNNlKoToECd/CbPEoKkGTOOnL/uZ+qoWu1i
	QH7AI0dxiZKmPNZijZ0Eau+1KBImqAAU+154o8ZxMjeQdR3wdaQVhoFUS69cA75cTnijW8U5qus
	xwyGmFUkDj7FNSgYscm3KX6Datkq8+cWFTLPmv3zS/1hs2Cu2lIyB50AafNjGZZlMoSg8ixcptr
	fin8LGvMK8We0BSKD9ZIr6Rq3XjdrjjPwKIojfa3yMTlFG+vUkwevQXXB7aYV1IGns+x9rvymk+
	3GHJMM3wFbpU8CsjUy0Vtq629axMwzokSDbj7pQygFU8fLxzPOsrWy84cE3RRd04=
X-Received: by 2002:a05:6402:5054:b0:69a:2ee6:4c95 with SMTP id 4fb4d7f45d1cf-69e65163b60mr7350547a12.0.1784723409282;
        Wed, 22 Jul 2026 05:30:09 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b867sm835007a12.14.2026.07.22.05.30.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 05:30:08 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: paul@paul-moore.com,
	jmorris@namei.or,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev,
	oxana@cloudflare.com,
	webprosto@gmail.com
Subject: [PATCH 5/6] samples/landlock: Support POSIX message queue scoping
Date: Wed, 22 Jul 2026 13:29:41 +0100
Message-ID: <20260722122952.42149-6-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722122952.42149-1-oxana@cloudflare.com>
References: <20260722122952.42149-1-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the sandboxer sample to request LANDLOCK_SCOPE_POSIX_MSG_QUEUE
through LL_SCOPED.

Add the "q" scope selector for POSIX message queues and document it in
the sample help text. Also allow POSIX message queue denials to be
quieted with "posix_msg_queue" through LL_QUIET_ACCESS.

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 samples/landlock/sandboxer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index ac71019e6212..59024ca53398 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -240,10 +240,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	bool error = false;
 	bool abstract_scoping = false;
 	bool signal_scoping = false;
+	bool posix_mqueue_scoping = false;
 
 	/* Scoping is not supported by Landlock ABI */
 	if (!(ruleset_attr->scoped &
-	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL)))
+	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL |
+	       LANDLOCK_SCOPE_POSIX_MSG_QUEUE)))
 		goto out_unset;
 
 	env_type_scope = getenv(env_var);
@@ -260,6 +262,9 @@ static bool check_ruleset_scope(const char *const env_var,
 		} else if (strcmp("s", ipc_scoping_name) == 0 &&
 			   !signal_scoping) {
 			signal_scoping = true;
+		} else if (strcmp("q", ipc_scoping_name) == 0 &&
+			   !posix_mqueue_scoping) {
+			posix_mqueue_scoping = true;
 		} else {
 			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
 				ipc_scoping_name);
@@ -276,6 +281,8 @@ static bool check_ruleset_scope(const char *const env_var,
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 	if (!signal_scoping)
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SIGNAL;
+	if (!posix_mqueue_scoping)
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
 
 	unsetenv(env_var);
 	return error;
@@ -354,6 +361,9 @@ static int add_quiet_access(const char *const env_var,
 				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 		else if (strcmp(str_access, "signal") == 0)
 			ruleset_attr->quiet_scoped |= LANDLOCK_SCOPE_SIGNAL;
+		else if (strcmp(str_access, "posix_msg_queue") == 0)
+			ruleset_attr->quiet_scoped |=
+				LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
 		else {
 			fprintf(stderr, "Unknown quiet access \"%s\"\n",
 				str_access);
@@ -400,6 +410,7 @@ static const char help[] =
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
+	"  - \"q\" to restrict opening POSIX message queues\n"
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
@@ -416,6 +427,7 @@ static const char help[] =
 	"  - \"udp_connect\" to quiet udp connect / send denials\n"
 	"  - \"abstract_unix_socket\" to quiet abstract unix socket denials\n"
 	"  - \"signal\" to quiet signal denials\n"
+	"  - \"posix_msg_queue\" to quiet POSIX message queue denials\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -423,7 +435,7 @@ static const char help[] =
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
 	ENV_UDP_CONNECT_SEND_NAME "=\"53\" "
-	ENV_SCOPED_NAME "=\"a:s\" "
+	ENV_SCOPED_NAME "=\"a:s:q\" "
 	"%1$s bash -i\n"
 	"\n"
 	"This sandboxer can use Landlock features up to ABI version "
-- 
2.50.1 (Apple Git-155)

