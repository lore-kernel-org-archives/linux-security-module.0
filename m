Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630858;
	b=EIbwIxW550RBcEPrkEeFnj5zyVeoCZfouxNDK5MvsBTjbIDmjngTLEdzZAtY0juWfuAh
	 /797fsqaQa0/C194L1PkajeDw7S4fl/2d2JsGW2xC48oXbD/G0SGOuOJ6lNV58lJEvNY7
	 yu79MwP98bqhjjoJoaHaARwcDE8HQZiyqcVR3TIe+nfCWaw1/TtTb17mOh/bZxk1EHYS7
	 bPLLBjj7m0EMEOhwWxHU3MchRpsEA/Kngs7cTfexKxwB0os87GHDBEOvbly+Wgmt4LZJp
	 C+eLbNBOT28COKSE23xAdfM3Rh/6YaR8vZCqS5+DCibWFdTwDGkP58nAxbyeGDGsBbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=897VUR1Y0AyL3m5LEwhgtHzM2U8GbpmCKC8JwdXi/Bg=;
	b=FCPrgfbMNa4V2SXvsQP4SgF4gglNFYU/OHMEVbXlrxkiG1HHEgShbkJjR0ijuzPP5ar+
	 FY/Xedi9mwt79cFj71LTpgRaGA7MgtGiTeo0qqV87kweZ6dDQfa84jwDtHekDpI/1jmlg
	 3cV+Ko2+FxqXnQ0S1yaZ8eSQvEfimbg+zYcKLOfbgetAbaBSYYnclZ4Ziv67ssMPVOjvs
	 I9m+Qhpl80DefbMQQRplu/wDTsDJXkaOScdLE5r7z7MoFoxYxb/8ZfFGO29lGDqT3DMhh
	 PNLGE6Inorq0G26yzQ1qtXLzimRucnft6Tx3VOWaDgDVpV2AbG3Y6RzgQ7baeh7i8bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN5RvwZa;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906F6083631
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D906F6083631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN5RvwZa
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso27519555e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630856; x=1794235656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=897VUR1Y0AyL3m5LEwhgtHzM2U8GbpmCKC8JwdXi/Bg=;
        b=oN5RvwZa624xv4WqsYp/zGWSDFY1J5pdyaRarX5w77NY+FDxEky3CKWBYmT2/K8uIe
         WEbTnHzPquf/zs0uo7YpkUK4c/KQNWxNMP/mX5LxIpmjKpbMG5lYQdhYyTuIbmVfvjIF
         oiW4M+xifyQMXgoC38NLC2+QoD2UGPYEgzsZZM3TjoYmir9audxB+XQgzvOePRSpBwO/
         c1TCzykCLeqxWcqU3TyW79Q5YWdJqyMZ6/88CvFLSZQwll6rd//s3ScFX8wX4uBY7gQ9
         0Jj3F8vK7Hw/1S59rK5xulmlBN1i48G3HWHN3Zn4az7jRfCEKWfbCfsCN77yfAVklXhT
         pw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630856; x=1794235656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=897VUR1Y0AyL3m5LEwhgtHzM2U8GbpmCKC8JwdXi/Bg=;
        b=QAoPHhqy3WoIkzYaLoB3cq3vMCOA/kPSig09mCwdDBd9O4W8+hBtfcbLfo9/Y+RzIS
         qGPJz8vYCYse3Tsbf42xPiqKgrycASRmsOmLg0y13fwswnOwCgQBpeX9DVq+fi439xQT
         2wexbAy8/PkhMU3pZvDP7wzOUZn2t/07nV6AXXYbYlZJ82LAL35yVHQphuKc0f3ub+OV
         2t6NrPZIvKstdQEYEQFvkjRT6xWRCkAevpq4uxEHWvvbOSCu+9vxL4271RCndbo+rzpo
         mV5wlXnxAFXz2+5ru5pVTKy5ekkMrnrKUB1MQQKNYzoUSlNcFvET60shQ7y0/3dY37HC
         SCzw==
X-Gm-Message-State: AFq9FYKAER9p21wjqdt+IyKK7Uzu8IL8B6wlB9xiXCNk8fvLPagQcm44
	nSKOkdsUySCggi/TnbRQHHyYW7eADZJLVh4CNV7YReI/Gv33z0qTQRs6
X-Gm-Gg: AYBFou0AVge0KxjjoKyCgxSgYBRgSbxza1fnOvqM9jVX0RQND3+gLvq54u4fmBrMj2j
	TdwDroxAVcQ/xNeoyNWR7P5IqZyJ4/0EbmVyXo4qaivCg9gvOsIJouwQO2+f7cCB9xY57qv17RS
	iLCytQ/YsyDlSVkXUU2ZLnfeXONkpQKqgnMM4OaOS59r+G+vwIOSqojkznkDWDLRiYwdLEcJMDx
	Dv4+kV0i5jW2KEjxWziWCwCcK1Fe9o2p/xckwr9LD3nI2M0CEhcmN560EJ3FPPtEKTpe7CAe4SH
	Mop7qLSmRWPEgzp9jeMFn/JqcaVTeDUnbAav4A+omnZ3m3vWyZURXeyYi94N5U5/z+qlz5CRNHe
	VR1hRCOdyBZBjMWwA6jyp4Vi8ypTlPmbJ+mMTz2L9Utaj7SW6ZC1JlD0FedI4z7gnLu02g4qosN
	8yTDytqC1CAHGU5fgTtOGvAl6I7kx7AhbnA9LqbQ9JVVgArajoG6CPRzMo23EeXFMliMbtq+6Yp
	PWim1pk80YDJf38spK6wmwU0LXyUuCSFmP0RqAK4NCWIO2Qp/9g56Ol+w+Chy4qlw5hlkv5yVGs
	z3Vi7rYuDTITVT9SNHd/aK9r3ZVZoEku8uxTd/Ro
X-Received: by 2002:a05:600c:6087:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4ac1765ce52mr228070005e9.20.1793630856168;
        Mon, 02 Nov 2026 06:47:36 -0800 (PST)
Received: from penguin-ubuntu.lan ([2a00:23c6:6410:5d01:8464:9a6f:2d42:8827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm254289965e9.0.2026.11.02.06.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:35 -0800 (PST)
From: Oxana Kharitonova <webprosto@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	gnoack@google.com,
	utilityemal77@gmail.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: [PATCH v2 4/4] samples/landlock: Add POSIX message queue scoping to sandboxer
Date: Mon,  2 Nov 2026 14:46:00 +0000
Message-ID: <20261102144708.920232-5-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102144708.920232-1-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
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

Add "q" to LL_SCOPED to enable LANDLOCK_SCOPE_POSIX_MSG_QUEUE
and "posix_msg_queue" to LL_QUIET_ACCESS to quiet related audit
denials. Update the supported ABI version to 13 and disable the
new scope when running on older kernels.

For example, on a kernel supporting Landlock ABI 13:

  LL_FS_RO="/" LL_FS_RW="" LL_SCOPED="q" \
    ./samples/landlock/sandboxer /bin/sh

The resulting shell and its children cannot open POSIX message
queues created outside their Landlock domain. They can create
queues and open queues created within that domain.

Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>
---
 samples/landlock/sandboxer.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 1362f08ff14b..e8e05c4d6f63 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -441,10 +441,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	bool error = false;
 	bool abstract_scoping = false;
 	bool signal_scoping = false;
+	bool posix_msg_queue_scoping = false;
 
 	/* Scoping is not supported by Landlock ABI */
 	if (!(ruleset_attr->scoped &
-	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL)))
+	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL |
+	       LANDLOCK_SCOPE_POSIX_MSG_QUEUE)))
 		goto out_unset;
 
 	env_type_scope = getenv(env_var);
@@ -461,6 +463,9 @@ static bool check_ruleset_scope(const char *const env_var,
 		} else if (strcmp("s", ipc_scoping_name) == 0 &&
 			   !signal_scoping) {
 			signal_scoping = true;
+		} else if (strcmp("q", ipc_scoping_name) == 0 &&
+			   !posix_msg_queue_scoping) {
+			posix_msg_queue_scoping = true;
 		} else {
 			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
 				ipc_scoping_name);
@@ -477,6 +482,8 @@ static bool check_ruleset_scope(const char *const env_var,
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 	if (!signal_scoping)
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SIGNAL;
+	if (!posix_msg_queue_scoping)
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
 
 	unsetenv(env_var);
 	return error;
@@ -555,6 +562,9 @@ static int add_quiet_access(const char *const env_var,
 				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 		else if (strcmp(str_access, "signal") == 0)
 			ruleset_attr->quiet_scoped |= LANDLOCK_SCOPE_SIGNAL;
+		else if (strcmp(str_access, "posix_msg_queue") == 0)
+			ruleset_attr->quiet_scoped |=
+				LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
 		else {
 			fprintf(stderr, "Unknown quiet access \"%s\"\n",
 				str_access);
@@ -570,7 +580,7 @@ static int add_quiet_access(const char *const env_var,
 	return 0;
 }
 
-#define LANDLOCK_ABI_LAST 12
+#define LANDLOCK_ABI_LAST 13
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -618,6 +628,7 @@ static const char help[] =
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
+	"  - \"q\" to restrict opening POSIX message queues\n"
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
@@ -634,6 +645,7 @@ static const char help[] =
 	"  - \"udp_connect\" to quiet udp connect / send denials\n"
 	"  - \"abstract_unix_socket\" to quiet abstract unix socket denials\n"
 	"  - \"signal\" to quiet signal denials\n"
+	"  - \"posix_msg_queue\" to quiet POSIX message queue denials\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -643,7 +655,7 @@ static const char help[] =
 	ENV_UDP_CONNECT_SEND_NAME "=\"53\" "
 	ENV_NS_NAME "=\"user:uts:net\" "
 	ENV_CAP_NAME "=\"" CAP_VALUE_EXAMPLE "\" "
-	ENV_SCOPED_NAME "=\"a:s\" "
+	ENV_SCOPED_NAME "=\"a:s:q\" "
 	"%1$s bash -i\n"
 	"\n"
 	"This sandboxer can use Landlock features up to ABI version "
@@ -667,7 +679,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				      LANDLOCK_ACCESS_NET_BIND_UDP |
 				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-			  LANDLOCK_SCOPE_SIGNAL,
+			  LANDLOCK_SCOPE_SIGNAL |
+			  LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
 		.quiet_access_fs = 0,
 		.quiet_access_net = 0,
 		.quiet_scoped = 0,
@@ -780,6 +793,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_permissions &=
 			~(LANDLOCK_PERMISSION_NAMESPACE_USE |
 			  LANDLOCK_PERMISSION_CAPABILITY_USE);
+		__attribute__((fallthrough));
+	case 12:
+		/* Removes POSIX message queue scoping for ABI < 13 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
+
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
-- 
2.43.0

