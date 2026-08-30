Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D531D730
	for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121033; cv=none; b=E3g9ovaXm+yD295ZNcjWf1fmJnPgBjgbIBFBftusc6ZJEikiuW7rZP7TEvw95p68iO+P19fOExb1HTsmZ8H7fOjfAbazP9Rc1zJPcAXQiLK7nnd1bFLcNXKuI144WhfNl0LX6epGMJkDCCuhvDl/OUsdWeYtlE7odluY9Lkw+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121033; c=relaxed/simple;
	bh=f/CraVslGraq/5v+2fXAMKOP6bZGEG+2lxqiFAm2vk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9nX1c22BtUtB105xiCI8qDr8iESt8xvJm8SI0xO3pXaOnNVhpD8mimTU8pCeNIe6jXOTBvmxyCnd989R/LjHuS+SF0j97Mjt7lvpzrCsNUWdTI/VSLF6M17k4x2BRifgIJjn4t4T4+oUBE/F9GQuQrlePfWpsFYE6NbrJ9s7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvQLILea; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvQLILea"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482e4998d28so1937723f8f.2
        for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121029; x=1788725829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xz4w4A2CPC2oBpOuImVyjCDcMdVG2rtFR3i2CLf98XA=;
        b=qvQLILeaTPvBfl5xJ7WBG6zPIK9H/YjTXu6WFJJYBNzIE7rzLFjMzpXEBMpqmN295x
         i3frPKp010MJgTgnqPsqYGkAV96eLSPoVxkrYWY6DUpJEynCvg/03x9rJjfUXyIrJISr
         SfkMtXYmYyjjReajoz1GDirPwAZSIzR1PzaQVgB+0L7oNXaQFa5082IlyAc1MkrtPuxS
         TkiN04h40BOnmI+ky1ncZxIjOTvq/nm2A0KxGWAupAvrSt8W7oFm9Zbv0hvTAGONn3DB
         kDJE2YVie/38nrQEmeK1mWkAO/EjHN1xXlVBZOC5LrlFMHJTp1dkhAAcc/Ddp0Vs0jUL
         6hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121029; x=1788725829;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xz4w4A2CPC2oBpOuImVyjCDcMdVG2rtFR3i2CLf98XA=;
        b=mthx3kwnsYJLd1bJsy+SHdDGt0XWPu4p29dbGKToQCYVDKmCZrqs3++uvpclfu/9kI
         xsKPOHCORaTOhYxSIzVJ43Dug7Ja8nuFTh8kS3rLMWCCcqE/beRYway83Th8OAX4Rq6B
         COsHprCxVvLrhEpkljHG+ArSch3+zV1TYvwFLYNgR1biA7YFC9EEyOGnJl+pg1a6O3hU
         T+qydUdsLUUb/EASwenZZPhhNu+8rOViHCkoIQ3mpOHipbrHXRIH6TUVlqmic1YTiZQ3
         zElZaImOXy19IWFb2ZJvfpoawKwRm+4fVWdIaqudmDFibj4ZflWu3sHMNseC8vuAyAfi
         qZ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwEvBm4NN88Ni6tZYdgniTwIu8ltzqjHyWtjidlIIPBSwRnaKDZLOLsycE0N+ZePid58QADdZUmK25WdIODSGmJGWEI1uk=@vger.kernel.org
X-Gm-Message-State: AFuF++nD7H8Cxxu+3dMFnrGs0YIXFNdxRQsXWfG5O2OesfnJcl1Kosok
	vy1woFVZ5KeJkByy2oEZOlXZ+yjsjMA1zJ39/7HBxy6947Qx9xWM/Th7
X-Gm-Gg: AYBFou0yQxZpJej3f/XU3qbAZyf2vBb4cvHFKv7c4IFltTLCy5KBPJ+EscGb8CmRtU5
	thAEr5qrl+sHiWTiIkRCgIpHu7CUF2JH4JyPVVPCbQ+ert8MZOk5z3uIMKvjnI+w86UiyQX4WPS
	/WeneX05MAbYtv3jQGxneTLEdAzeSFhBC47YOPz2Ph+IkC9Kjhh0PrT1ymubQ31h1YCTpVeXZLN
	T0oaOVm0ZxZao+vB59E8rKtC2mVS0xnAs8qMw+JzccR3Bs0AccrN+83PqEDEzaLaSaJsTnL/DAj
	qhlFAGd22SgDeQA43OqugHD2FqNszFi5DJQ6T0GaEWI5RLG+C8JTFz6X2h0n5jS8a3FMReX+gTh
	M2YxtNZR3kv1Iiu9W4LR4/TcUG7Ad+0MeDgxYh1qle9Qi/dDXdAD4PpjeS2156txY71Lg4pNHOj
	d/wfbPhqyTTDA8aglIfftVQ+PpN0TEZy09JOIGUhHX09yuk9eqavUAApOvpqxN/ALWAMld9HRqk
	VuEZupxs/qu9Q==
X-Received: by 2002:a5d:5e8d:0:b0:484:3328:2f6f with SMTP id ffacd0b85a97d-4843395c662mr13687693f8f.28.1788121029480;
        Sun, 30 Aug 2026 13:17:09 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac7c01sm18901239f8f.14.2026.08.30.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:09 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 5/6] samples/landlock: Support MPTCP access rights
Date: Sun, 30 Aug 2026 22:16:49 +0200
Message-ID: <20260830201650.67050-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830201650.67050-1-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the LL_MPTCP_BIND and LL_MPTCP_CONNECT environment variables to
restrict the ports MPTCP sockets may bind and connect to, and the
matching "mptcp_bind" and "mptcp_connect" values for LL_QUIET_ACCESS.

Because MPTCP sockets use TCP port numbers but are not covered by the
TCP access rights, LL_TCP_BIND and LL_TCP_CONNECT alone leave MPTCP
unrestricted.  Point that out in the help text.

Bump LANDLOCK_ABI_LAST to 12 and drop the new access rights when
running on an older kernel.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 52 ++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 1c514efecafb..5eae6fe7467f 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -67,6 +67,8 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
 #define ENV_UDP_BIND_NAME "LL_UDP_BIND"
 #define ENV_UDP_CONNECT_SEND_NAME "LL_UDP_CONNECT_SEND"
+#define ENV_MPTCP_BIND_NAME "LL_MPTCP_BIND"
+#define ENV_MPTCP_CONNECT_NAME "LL_MPTCP_CONNECT"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -353,6 +355,12 @@ static int add_quiet_access(const char *const env_var,
 		else if (strcmp(str_access, "udp_connect") == 0)
 			ruleset_attr->quiet_access_net |=
 				LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+		else if (strcmp(str_access, "mptcp_bind") == 0)
+			ruleset_attr->quiet_access_net |=
+				LANDLOCK_ACCESS_NET_BIND_MPTCP;
+		else if (strcmp(str_access, "mptcp_connect") == 0)
+			ruleset_attr->quiet_access_net |=
+				LANDLOCK_ACCESS_NET_CONNECT_MPTCP;
 		else if (strcmp(str_access, "abstract_unix_socket") == 0)
 			ruleset_attr->quiet_scoped |=
 				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
@@ -373,7 +381,7 @@ static int add_quiet_access(const char *const env_var,
 	return 0;
 }
 
-#define LANDLOCK_ABI_LAST 11
+#define LANDLOCK_ABI_LAST 12
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -401,6 +409,12 @@ static const char help[] =
 	"* " ENV_UDP_CONNECT_SEND_NAME ": remote UDP ports allowed to connect "
 	"or send to (client: use as destination port / server: receive only from it)\n"
 	"(caution: sending requires being able to bind to a local source port)\n"
+	"* " ENV_MPTCP_BIND_NAME ": ports allowed to bind with MPTCP sockets "
+	"(server)\n"
+	"* " ENV_MPTCP_CONNECT_NAME ": ports allowed to connect to with MPTCP "
+	"sockets (client)\n"
+	"(caution: MPTCP sockets use TCP ports but are not covered by "
+	ENV_TCP_BIND_NAME " nor " ENV_TCP_CONNECT_NAME ")\n"
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
@@ -418,6 +432,8 @@ static const char help[] =
 	"  - \"tcp_connect\" to quiet tcp connect denials\n"
 	"  - \"udp_bind\" to quiet udp bind denials\n"
 	"  - \"udp_connect\" to quiet udp connect / send denials\n"
+	"  - \"mptcp_bind\" to quiet mptcp bind denials\n"
+	"  - \"mptcp_connect\" to quiet mptcp connect denials\n"
 	"  - \"abstract_unix_socket\" to quiet abstract unix socket denials\n"
 	"  - \"signal\" to quiet signal denials\n"
 	"\n"
@@ -449,7 +465,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP |
 				      LANDLOCK_ACCESS_NET_BIND_UDP |
-				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP |
+				      LANDLOCK_ACCESS_NET_BIND_MPTCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_MPTCP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
 		.quiet_access_fs = 0,
@@ -556,6 +574,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		supported_restrict_flags &=
 			~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 		set_restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
+		__attribute__((fallthrough));
+	case 11:
+		/* Removes MPTCP support for ABI < 12 */
+		ruleset_attr.handled_access_net &=
+			~(LANDLOCK_ACCESS_NET_BIND_MPTCP |
+			  LANDLOCK_ACCESS_NET_CONNECT_MPTCP);
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -600,6 +624,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
 	}
+	/* Removes MPTCP bind access control if not supported by a user. */
+	env_port_name = getenv(ENV_MPTCP_BIND_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_BIND_MPTCP;
+	}
+	/* Removes MPTCP connect access control if not supported by a user. */
+	env_port_name = getenv(ENV_MPTCP_CONNECT_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_CONNECT_MPTCP;
+	}
 
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
@@ -684,6 +720,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				 0)) {
 		goto err_close_ruleset;
 	}
+	if (populate_ruleset_net(ENV_MPTCP_BIND_NAME, ruleset_fd,
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_BIND_MPTCP,
+				 0)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset_net(ENV_MPTCP_CONNECT_NAME, ruleset_fd,
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_CONNECT_MPTCP,
+				 0)) {
+		goto err_close_ruleset;
+	}
 
 	if (quiet_supported) {
 		if (populate_ruleset_net(ENV_NET_QUIET_NAME, ruleset_fd, 0,
-- 
2.55.0

