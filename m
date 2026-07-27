Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830E345CCE
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193732; cv=none; b=Fw+p8sgMD6cQSeIVLDdkPGgLIxQ4PHk+RbIG5wpqrLjG5r20w7FqlGqgvsgga3/ZC5A/IZ24WSq8zAmJxhB1k+Hk8S72H8O60VVp/x6Q4gj+rr255OlSOUzDERoVXiWQHgw4iD2YkBi5b1Xkrw9pqxXNYqiFlMgMXJRVgTngP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193732; c=relaxed/simple;
	bh=Rlw3TMtjG+DXzcW8sjo+jheuSWMlsqSKVPzs0JsgDPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqTNE4+8bN4rmOmujPe5L9QHm0s8bDHUemXdwcQIgyxvjCrbsgShlF+1XuUci8s5Q8k0Zdv/ayJllPSQ7jOjMrUGyvBlX+oiax5TJQgBjdX3v5mK1rzd0EFJ5CvTmVG3yb0klMC4RBnjP28NF3wAXPog9krwqiNlFbUK46x4krM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/SkJd7C; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/SkJd7C"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81f3b227a4aso41164127b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193730; x=1785798530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nY/xukgSNDJ94ErXRWC/QdmaMAgse9n4lIgbjHfqs/U=;
        b=Y/SkJd7CZykheJcVRiVYhY4d180GsuRVjIlgi2Qpb2BdE/drJmFKiddt2g0n1ivmXM
         0rVxApujYGdg1YH8/pDn7I4sMvw5zjt1Zrowm/qJiR4FZBnn8kB1hqdOvjHpmz7PSRXO
         3GfCjuzzWBBGfR03ETt7aq3yZGlHn0rEgpc2Tqosn/E8zv8MQqdAs3teEh/gq2PPRB3b
         hAH0X6DYoudxxlj+bDJSpHlcB+UNfESfjad+rWGUPM4gli+rR5XwrquMfpJUBpj5Dwtk
         +wLZtdusoiAJBxeF54Pq3D2p4K/na0CdLnG5/7oFcEX8VqNl65k6uDd0blEeZmDykGPF
         kXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193730; x=1785798530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nY/xukgSNDJ94ErXRWC/QdmaMAgse9n4lIgbjHfqs/U=;
        b=R0QguvqLxXwePBbikBDrPnxO2j4h18JsUl3sZROfo/SKJEBXZwvJibn6sSDZG4Ns0v
         LufA2LkwR4bWWcmIe1aE3cXN/VTAj+Mxd7pyjDi8hZp6hAD3gpyuCc0UeOlpTzekUxiV
         pi0ORZTM8Bnf7Ym6I7s+usScczQyOqHc/x8I3utXScVOYcXHrrBlv5iLAVppbAoQ3UKW
         seZNZaWtmdSEGQB+anCsxApGHjVJjcFEeOmA4OF6PEumkDCimWDWoTd6WUN8oaoFIHSV
         vZTHYRIrY3bR49cA3pgLCS+RQ5Io51pRjQHeVYImg8jhd+r6nkXBHAIbv63tSkJRa0sL
         InnA==
X-Forwarded-Encrypted: i=1; AHgh+RpLEeVJ6ulE99eSSji69iW87TEH9dmXnlM+DAAOj8kiKSBwEZItRk2wsXIsbkYz6VHF4acXv9pLYNtgz2ztcPjNNEwotyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbN2GoOCZVBV4DvJZEIm4dwyYMItpNv8NBbS6mgRogwvMYbHT4
	EBLsCUS0yl0b3PhUG60UaqBrH9tM0hTjF8lOiQySTqQfSxRdsb+nUmU0
X-Gm-Gg: AR+sD10kFpxOt7fXY6c+CP6zQZjDLcNsXEp6UP3Vd7G27CnShGRq77lkvA05ZNKDtPu
	tx+19hZrNEH+QlxGHFwvaj5kvIQKbAGwIG5AdzrCu3Ld8aFO3SZLzFEqfvEnOKfwjEjvxr/6k+J
	NYkB1rkCKjAHYHLSUNrh9x5TeWgPgjE66b0eRk90SH81xk9xKFVH4va0UCB2nwFUy9FjA2IUZQC
	/bxwI0loGGTJM2TVuSIu+sfzuWsokvtM2rdU/f39PINt5rf9oHiO0BAoS0bKY1Yi7WoZagUM6xE
	8JTSj8wZ7XN6DuH8ggjRlLqTsGUI8x1vhQIlnd073h6NQ1KKfkDiNKjF33wSxLYZkf5ZH6gL1Dm
	MQdeOL9luDsJpzPz1EGM/pZcYuLd7adsfsdpeD7WHUYvtHI7W8zJ8HQte4YdJqFDfvl0vkYMQDe
	XEBk0vT3Ynea/ZLnmYsTBdh8qwr57PUORB4nP5ricpUYvQyIk=
X-Received: by 2002:a05:690c:6287:b0:81d:26f9:bc85 with SMTP id 00721157ae682-81f69dea8b2mr38009537b3.45.1785193729660;
        Mon, 27 Jul 2026 16:08:49 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:732e:7f3e:f365:cf9a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65931411sm38644837b3.44.2026.07.27.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:08:49 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 5/6] samples/landlock: Support LANDLOCK_SCOPE_SYSV_MSG_QUEUE in sandboxer
Date: Mon, 27 Jul 2026 19:08:32 -0400
Message-ID: <20260727230833.138165-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727230833.138165-1-utilityemal77@gmail.com>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sandboxer support for the new LANDLOCK_SCOPE_SYSV_MSG_QUEUE access
right: handle it by default, parse it as the "m" token of LL_SCOPED,
and integrate it with the quiet access rights via the new
"sysv_msg_queue" LL_QUIET_ACCESS token.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 samples/landlock/sandboxer.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index ac71019e6212..88acb47765a2 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -240,10 +240,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	bool error = false;
 	bool abstract_scoping = false;
 	bool signal_scoping = false;
+	bool sysv_msg_queue_scoping = false;
 
 	/* Scoping is not supported by Landlock ABI */
 	if (!(ruleset_attr->scoped &
-	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL)))
+	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL |
+	       LANDLOCK_SCOPE_SYSV_MSG_QUEUE)))
 		goto out_unset;
 
 	env_type_scope = getenv(env_var);
@@ -260,6 +262,9 @@ static bool check_ruleset_scope(const char *const env_var,
 		} else if (strcmp("s", ipc_scoping_name) == 0 &&
 			   !signal_scoping) {
 			signal_scoping = true;
+		} else if (strcmp("m", ipc_scoping_name) == 0 &&
+			   !sysv_msg_queue_scoping) {
+			sysv_msg_queue_scoping = true;
 		} else {
 			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
 				ipc_scoping_name);
@@ -276,6 +281,8 @@ static bool check_ruleset_scope(const char *const env_var,
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 	if (!signal_scoping)
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SIGNAL;
+	if (!sysv_msg_queue_scoping)
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SYSV_MSG_QUEUE;
 
 	unsetenv(env_var);
 	return error;
@@ -354,6 +361,9 @@ static int add_quiet_access(const char *const env_var,
 				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 		else if (strcmp(str_access, "signal") == 0)
 			ruleset_attr->quiet_scoped |= LANDLOCK_SCOPE_SIGNAL;
+		else if (strcmp(str_access, "sysv_msg_queue") == 0)
+			ruleset_attr->quiet_scoped |=
+				LANDLOCK_SCOPE_SYSV_MSG_QUEUE;
 		else {
 			fprintf(stderr, "Unknown quiet access \"%s\"\n",
 				str_access);
@@ -369,7 +379,7 @@ static int add_quiet_access(const char *const env_var,
 	return 0;
 }
 
-#define LANDLOCK_ABI_LAST 10
+#define LANDLOCK_ABI_LAST 11
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -400,6 +410,7 @@ static const char help[] =
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
+	"  - \"m\" to restrict associating with message queues\n"
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
@@ -416,6 +427,7 @@ static const char help[] =
 	"  - \"udp_connect\" to quiet udp connect / send denials\n"
 	"  - \"abstract_unix_socket\" to quiet abstract unix socket denials\n"
 	"  - \"signal\" to quiet signal denials\n"
+	"  - \"sysv_msg_queue\" to quiet SysV message queue denials\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -423,7 +435,7 @@ static const char help[] =
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
 	ENV_UDP_CONNECT_SEND_NAME "=\"53\" "
-	ENV_SCOPED_NAME "=\"a:s\" "
+	ENV_SCOPED_NAME "=\"a:s:m\" "
 	"%1$s bash -i\n"
 	"\n"
 	"This sandboxer can use Landlock features up to ABI version "
@@ -447,7 +459,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				      LANDLOCK_ACCESS_NET_BIND_UDP |
 				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-			  LANDLOCK_SCOPE_SIGNAL,
+			  LANDLOCK_SCOPE_SIGNAL | LANDLOCK_SCOPE_SYSV_MSG_QUEUE,
 		.quiet_access_fs = 0,
 		.quiet_access_net = 0,
 		.quiet_scoped = 0,
@@ -546,6 +558,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes quiet flags for ABI < 10 later on. */
 		quiet_supported = false;
 
+		__attribute__((fallthrough));
+	case 10:
+		/* Removes LANDLOCK_SCOPE_SYSV_MSG_QUEUE for ABI < 11 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPE_SYSV_MSG_QUEUE;
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
-- 
2.54.0

