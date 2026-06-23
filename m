Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723030F526
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199212; cv=none; b=pY8cQdHYva1ugDytPXWtzKT035bmC5eAuzp4H/CNO1COzqav4OfpKcXf2B0z3qah6Qw+m4FTov7ZcG7n4KxBzO3hnRJ8tqr8z07tboRrcXkOS3EtWoPS8rYq+9zDsgKXF4iLr4Cav3oXFwhpZrsQI9Us3f3KJG89wIOysr1sYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199212; c=relaxed/simple;
	bh=3W2ASo08aMFwFoHpHWWEoo9Ez7Aewm1FJVWvQ7LB9yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB9rIlDuAp3+uKG0qPlPfU+qB0v6PFyEhDYrZtgo75VEqPG00Dindy4tajqe6olBKEQcuQBrYVsLp8TUKiHbHF3+aQed/Dpd8r7N5PZytX/VhpB+ESikqNC0Pz4Cci5H9uStaDffy4HF/IpBdIlLQsVBixTABLSn420bku+E8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=U2JVznWY; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="U2JVznWY"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31DD73F2C9
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782199208;
	bh=VtiODct+vGSBE0csrOhtv0/Ers0Z2p2uvuaH7HNY7Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=U2JVznWYaIfY5kuX2BM3W9ZgQHwUuukuuHxyXfGj5OQo19Ilb5EL/MHnFp45inoHe
	 M3RVCMdFZziy1jqO60mJDyv8PWKGAtEQ3rUzDsqSISst4MyEV9xiyqLziWP8Xc4GMi
	 xEoZ7SLaNOJcKoAtlljprUE3dUou1oyua2HfzCikJoEvgJWi6muIh1xZpILCAQHSaN
	 CCnsbWroHL/YMfDsPJ1pU2DsY4DF8qGSvGnlUD06lvU/mphyxT+DtHosDtn66OQoV4
	 cpOCj69hBENdMO4NaHJwjQJW0vXGjiMmo4rF1E6GhhtIedjiPmivLYCAl2jYzK86iS
	 DKKi6qHxEAB2VEnEpKsJ1Ui+6KOtFX0FJ613R0eV2LAl3mrr14YqCI5ehc151ryQOf
	 /emHMX8wNAvat3+j9rMpTRG6C0QzN/pOJjSFo6VdTSCYHWG1v1XHByRTqHdcAM/nyI
	 G1V9fGptTtKlopLD95AefOtOhdidCxZBLGJ/n4iI3b6JBrbGsK3va3VW7k831jRqZJ
	 piLmHE3dLnJJhL1NPddxCHuuUmN2nZXwBkSv6E8NPyqHtnbjzHxN0zPKZaCi8KwCG0
	 MbpEGCbocuCWdTU7UQ0NQbiKbC/xVXjfyNFzkk0OGJzPrXM2zNznbhxsdzeY1uZRpL
	 yZdbYvMtw6OLU/9XGS44fGYg=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso109939165ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 00:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782199206; x=1782804006;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtiODct+vGSBE0csrOhtv0/Ers0Z2p2uvuaH7HNY7Vc=;
        b=bgWGRvUE4GNeFDBEfpZYXLlPAbKUi2Dqo0xh5nELNKSOzsXgYvsF1StIg8k83O3zB6
         QRXfjKPbfiU8Ls1sayhJ/cEWBacumdWfw9dJeB6Nl0RYm1rnoYZShARR4nqaMrWW/UXi
         74jBNcKcsiQv1YB+muThO5phriICuzs/Ouyj1COCf+11p050fbGNSZsoAPdR5R7eX/8F
         YtVc4Wc2tCsAbJM45ZmZjugD+Sd/tu4jGh/hji2BxTw4E4Q45xMdDZxsahkn4YdGYnsl
         a2pU/8j5mXeKgRPTb2+fXWHWEHV2yrtBsQ3Pohxg/Fu/f6YzRjhtMK5Wn2zFjIWh2ald
         2Nig==
X-Gm-Message-State: AOJu0YyYAkRKs0J/OMNNcGOHj6D7duS+LDIHPKrooqKMdQpKLtPEdw5Y
	HPMG6WUkU9qIC0u9H1GNpJEqbcPHi2031j6/kRyN0+XSOJ1aAr687ekGr3K/BfP2RWXi0nkrNWV
	dzOoAcpGE3RNEDJnp/i3h5TcyWkWKJzlMj8Lbb1T27n73TVNiswtBKl1VKpKPMacnBk1Apw0uC8
	SFFLwhRhqEC3lyi6y2/Q==
X-Gm-Gg: AfdE7cn4NziVoOBNahvm3K6MB5Bp8fIbci4zzkSTbglg8Ze1JVjxCw5sIUYRo1zrqFp
	PBT6QfyNkLVUiss6jAzJN+SY1jftnS9cg9qxuJ2ango1jPILoyIbP50b4bNf5kZKTv95Q8vDR5I
	dvge1xWaTNdxdlWVYkSwYlAP7jCJBCko2ySMutEdDfmID9L6TDe6gGNYeBtr1GRysrGnp6V831N
	vNgjHLVG+judidNaVmgxlN0J64/0vRr2SthqP5W852gPEEWmFg1zyydcsYpvdpgXwGE2LmvLfFU
	42D0wCTR2YxagNJgj3m2nApjUbsBR0/mbEZy835D55hxZXJfuAdSeC4tNHdKn8NVAT+DR3yl2Zu
	DpRJb++xoEE4SngUfOru7e+WVZA==
X-Received: by 2002:a17:902:eccb:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2c718cb09c1mr210078635ad.2.1782199206417;
        Tue, 23 Jun 2026 00:20:06 -0700 (PDT)
X-Received: by 2002:a17:902:eccb:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2c718cb09c1mr210078285ad.2.1782199205934;
        Tue, 23 Jun 2026 00:20:05 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c8bc563c131sm10346836a12.18.2026.06.23.00.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 00:20:05 -0700 (PDT)
Message-ID: <f224c592-aa38-4342-ac0d-fe35b56ca29e@canonical.com>
Date: Tue, 23 Jun 2026 00:20:04 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: add a regression test for the TCP Fast Open
 connect-mediation bypass
To: hexlabsecurity@proton.me, apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org, Ryan Lee <ryan.lee@canonical.com>
References: <20260622-b4-disp-220b400d-v1-1-69d8f4ddf57e@proton.me>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260622-b4-disp-220b400d-v1-1-69d8f4ddf57e@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/26 16:27, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> sendto(MSG_FASTOPEN) performs an implicit connect that the kernel's
> apparmor_socket_sendmsg() did not mediate as a connect, so a profile
> granting inet/inet6 stream send but denying connect was bypassed. Add a
> test that, under such a profile, asserts connect(2) is denied AND
> sendto(MSG_FASTOPEN) is also denied -- the latter requires the kernel fix
> "apparmor: mediate the implicit connect of TCP fast open sendmsg".
> 
> It exercises both producers the fix guards -- plain TCP (inet/inet6) and
> MPTCP (IPPROTO_MPTCP) -- plus a positive control where connect is allowed.
> The test red-baselines on a vulnerable kernel and skips cleanly when the
> required fine-grained network mediation or TCP Fast Open is unavailable
> (requires_any_of_kernel_features / requires_parser_support, plus a
> tcp_fastopen guard); the MPTCP cases are skipped if MPTCP is disabled.
> 
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

thanks for the tests

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into the user space tree

> ---
> This is the userspace regression test for the AppArmor TCP Fast Open
> connect-mediation kernel fix posted to linux-security-module:
>    https://lore.kernel.org/all/20260622-b4-disp-aba401c6-v1-1-9d74343c7ced@proton.me/
> It mirrors the SELinux testsuite test ("[PATCH testsuite] tests/inet_socket:
> add tests for TCP Fast Open", Stephen Smalley) and was requested by the
> AppArmor team (Ryan Lee).
> 
> It covers both producers the kernel fix mediates -- plain TCP (inet/inet6)
> and MPTCP -- plus a positive control. It red-baselines on a vulnerable
> kernel (the fastopen assertions fail) and skips cleanly when TCP Fast Open
> or fine-grained network mediation is unavailable.
> ---
>   tests/regression/apparmor/Makefile                 |   2 +
>   tests/regression/apparmor/net_inet_tcp_fastopen.c  | 241 +++++++++++++++++++++
>   tests/regression/apparmor/net_inet_tcp_fastopen.sh | 119 ++++++++++
>   3 files changed, 362 insertions(+)
> 
> diff --git a/tests/regression/apparmor/Makefile b/tests/regression/apparmor/Makefile
> index 345f39968..18e408f5c 100644
> --- a/tests/regression/apparmor/Makefile
> +++ b/tests/regression/apparmor/Makefile
> @@ -151,6 +151,7 @@ SRC=access.c \
>       named_pipe.c \
>       net_inet_rcv.c \
>       net_inet_snd.c \
> +    net_inet_tcp_fastopen.c \
>       net_raw.c \
>       open.c \
>       openat.c \
> @@ -325,6 +326,7 @@ TESTS=aa_exec \
>         namespaces \
>         net_iface \
>         net_inet \
> +      net_inet_tcp_fastopen \
>         net_raw \
>         overlayfs_kernel \
>         open \
> diff --git a/tests/regression/apparmor/net_inet_tcp_fastopen.c b/tests/regression/apparmor/net_inet_tcp_fastopen.c
> new file mode 100644
> index 000000000..cfc1ff9c5
> --- /dev/null
> +++ b/tests/regression/apparmor/net_inet_tcp_fastopen.c
> @@ -0,0 +1,241 @@
> +/*
> + *	Copyright (C) 2026 Canonical, Ltd.
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License as
> + *	published by the Free Software Foundation, version 2 of the
> + *	License.
> + */
> +
> +/*
> + * TCP Fast Open connect-mediation bypass regression test.
> + *
> + * Under an AppArmor profile that grants inet/inet6 stream "send" but DENIES
> + * "connect", a plain connect(2) must be refused (EACCES/EPERM). Historically
> + * the kernel's TFO fast path (sendto(..., MSG_FASTOPEN, ...), which performs
> + * an implicit connect) only checked the send permission (AA_NET_SEND 0x02)
> + * and skipped the connect permission (AA_NET_CONNECT 0x40), so a confined
> + * task could open an outbound connection that connect(2) would have blocked.
> + * The kernel fix mediates both producers: plain TCP and MPTCP (IPPROTO_MPTCP).
> + *
> + * This binary takes a mode and asserts the operation is DENIED:
> + *   argv[1] = "connect"  -> baseline: connect(2) must be denied
> + *   argv[1] = "fastopen" -> the bug: sendto(MSG_FASTOPEN) must be denied
> + *   argv[2] = family: "inet"/"inet6" (TCP) or "minet"/"minet6" (MPTCP)
> + *   argv[3] = port (the listener port, set up by this same process)
> + *
> + * Output contract (parsed by checktestfg in prologue.inc):
> + *   "PASS\n"  -> the operation was DENIED as required (regression OK)
> + *   "FAIL ..."-> the operation was ALLOWED (connect bypass) OR a setup error
> + *
> + * The .sh runs this with expected outcome "pass"; it also enables TCP Fast
> + * Open first, so an EOPNOTSUPP here is a real setup error, not a skip.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <netinet/in.h>
> +#include <netinet/tcp.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <arpa/inet.h>
> +
> +#ifndef MSG_FASTOPEN
> +#define MSG_FASTOPEN 0x20000000
> +#endif
> +
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
> +/* Map a family token to (AF_*, protocol). "minet"/"minet6" select MPTCP.
> + * Returns 0 on success, -1 on an unknown token.
> + */
> +static int parse_family(const char *tok, int *family, int *proto)
> +{
> +	*proto = 0;
> +	if (strcmp(tok, "inet") == 0) {
> +		*family = AF_INET;
> +	} else if (strcmp(tok, "inet6") == 0) {
> +		*family = AF_INET6;
> +	} else if (strcmp(tok, "minet") == 0) {
> +		*family = AF_INET;
> +		*proto = IPPROTO_MPTCP;
> +	} else if (strcmp(tok, "minet6") == 0) {
> +		*family = AF_INET6;
> +		*proto = IPPROTO_MPTCP;
> +	} else {
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +/* Build a loopback sockaddr for the requested family. Returns addrlen. */
> +static socklen_t make_addr(int family, int port, struct sockaddr_storage *ss)
> +{
> +	memset(ss, 0, sizeof(*ss));
> +	if (family == AF_INET) {
> +		struct sockaddr_in *a = (struct sockaddr_in *)ss;
> +
> +		a->sin_family = AF_INET;
> +		a->sin_port = htons(port);
> +		inet_pton(AF_INET, "127.0.0.1", &a->sin_addr);
> +		return sizeof(*a);
> +	}
> +	{
> +		struct sockaddr_in6 *a = (struct sockaddr_in6 *)ss;
> +
> +		a->sin6_family = AF_INET6;
> +		a->sin6_port = htons(port);
> +		inet_pton(AF_INET6, "::1", &a->sin6_addr);
> +		return sizeof(*a);
> +	}
> +}
> +
> +/* Start a plain TCP listener so the connect/TFO target exists. Returns the fd
> + * or -1. A TCP listener accepts both TCP and MPTCP clients, which keeps the
> + * test on the client-side mediation under examination. bind/listen perms are
> + * granted by the profile so this must succeed.
> + */
> +static int start_listener(int family, int port)
> +{
> +	int s, one = 1;
> +	struct sockaddr_storage ss;
> +	socklen_t len = make_addr(family, port, &ss);
> +
> +	s = socket(family, SOCK_STREAM, 0);
> +	if (s < 0) {
> +		printf("FAIL - listener socket: %m\n");
> +		return -1;
> +	}
> +	(void)setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
> +	/* Enable TFO on the listener (qlen). Best-effort; the mediation check
> +	 * under test happens on the client side. */
> +	(void)setsockopt(s, IPPROTO_TCP, TCP_FASTOPEN, &one, sizeof(one));
> +	if (bind(s, (struct sockaddr *)&ss, len) < 0) {
> +		printf("FAIL - listener bind: %m\n");
> +		close(s);
> +		return -1;
> +	}
> +	if (listen(s, 5) < 0) {
> +		printf("FAIL - listener listen: %m\n");
> +		close(s);
> +		return -1;
> +	}
> +	return s;
> +}
> +
> +/* Returns 1 if the kernel DENIED the operation (EACCES/EPERM) => regression OK.
> + * Returns 0 if the operation was ALLOWED (connect bypass) => regression FAIL.
> + * Returns -1 on a setup error.
> + */
> +static int try_connect(int family, int proto, int port)
> +{
> +	int s, rc;
> +	struct sockaddr_storage ss;
> +	socklen_t len = make_addr(family, port, &ss);
> +
> +	s = socket(family, SOCK_STREAM, proto);
> +	if (s < 0)
> +		return -1;
> +	rc = connect(s, (struct sockaddr *)&ss, len);
> +	if (rc == 0) {
> +		close(s);
> +		return 0;			/* allowed */
> +	}
> +	if (errno == EACCES || errno == EPERM) {
> +		close(s);
> +		return 1;			/* denied by AppArmor */
> +	}
> +	/* ECONNREFUSED/ETIMEDOUT mean it reached the network: mediation did not
> +	 * block it, so count as allowed. */
> +	close(s);
> +	return (errno == ECONNREFUSED || errno == ETIMEDOUT) ? 0 : -1;
> +}
> +
> +static int try_fastopen(int family, int proto, int port)
> +{
> +	int s;
> +	ssize_t rc;
> +	char msg[] = "tfo";
> +	struct sockaddr_storage ss;
> +	socklen_t len = make_addr(family, port, &ss);
> +
> +	s = socket(family, SOCK_STREAM, proto);
> +	if (s < 0)
> +		return -1;
> +
> +	/* The bug: this implicit-connect send must be mediated as a connect. */
> +	rc = sendto(s, msg, sizeof(msg), MSG_FASTOPEN,
> +		    (struct sockaddr *)&ss, len);
> +	if (rc >= 0) {
> +		close(s);
> +		return 0;			/* allowed: connect bypass */
> +	}
> +	if (errno == EACCES || errno == EPERM) {
> +		close(s);
> +		return 1;			/* denied by AppArmor */
> +	}
> +	if (errno == EOPNOTSUPP || errno == EINVAL) {
> +		/* The .sh enabled TCP Fast Open before running, so this is a
> +		 * real setup error, not an expected condition. Fail loudly
> +		 * rather than masking it as a denial. */
> +		close(s);
> +		return -1;
> +	}
> +	close(s);
> +	return (errno == ECONNREFUSED || errno == ETIMEDOUT) ? 0 : -1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int family, proto, port, denied, listener;
> +	const char *mode;
> +
> +	if (argc < 4) {
> +		printf("FAIL - usage: %s connect|fastopen inet|inet6|minet|minet6 port\n",
> +		       argv[0]);
> +		return 1;
> +	}
> +	mode = argv[1];
> +	if (parse_family(argv[2], &family, &proto) < 0) {
> +		printf("FAIL - unknown family '%s'\n", argv[2]);
> +		return 1;
> +	}
> +	port = atoi(argv[3]);
> +
> +	signal(SIGPIPE, SIG_IGN);
> +
> +	listener = start_listener(family, port);
> +	if (listener < 0)
> +		return 1;			/* FAIL already printed */
> +
> +	if (strcmp(mode, "connect") == 0) {
> +		denied = try_connect(family, proto, port);
> +	} else if (strcmp(mode, "fastopen") == 0) {
> +		denied = try_fastopen(family, proto, port);
> +	} else {
> +		printf("FAIL - unknown mode '%s'\n", mode);
> +		close(listener);
> +		return 1;
> +	}
> +
> +	close(listener);
> +
> +	if (denied == 1) {
> +		printf("PASS\n");
> +		return 0;
> +	}
> +	if (denied == 0) {
> +		printf("FAIL - %s was ALLOWED despite deny connect "
> +		       "(connect-mediation bypass)\n", mode);
> +		return 1;
> +	}
> +	printf("FAIL - %s setup error: %m\n", mode);
> +	return 1;
> +}
> diff --git a/tests/regression/apparmor/net_inet_tcp_fastopen.sh b/tests/regression/apparmor/net_inet_tcp_fastopen.sh
> new file mode 100755
> index 000000000..76300c53f
> --- /dev/null
> +++ b/tests/regression/apparmor/net_inet_tcp_fastopen.sh
> @@ -0,0 +1,119 @@
> +#! /bin/bash
> +#	Copyright (C) 2026 Canonical, Ltd.
> +#
> +#	This program is free software; you can redistribute it and/or
> +#	modify it under the terms of the GNU General Public License as
> +#	published by the Free Software Foundation, version 2 of the
> +#	License.
> +
> +#=NAME net_inet_tcp_fastopen
> +#=DESCRIPTION
> +# Regression test for the TCP Fast Open connect-mediation bypass. Under a
> +# profile that grants inet/inet6 stream "send" but DENIES "connect", a plain
> +# connect(2) is refused, and sendto(..., MSG_FASTOPEN, ...) (which performs an
> +# implicit connect) MUST also be refused -- for both plain TCP and MPTCP. Pre-fix
> +# the TFO path checked only the send permission (AA_NET_SEND 0x02) and skipped
> +# connect (AA_NET_CONNECT 0x40).
> +#=END
> +
> +pwd=`dirname $0`
> +pwd=`cd $pwd ; /bin/pwd`
> +
> +bin=$pwd
> +
> +. "$bin/prologue.inc"
> +
> +# Need fine-grained inet mediation (connect/send are separable only there).
> +requires_any_of_kernel_features network_v8/af_inet network_v9/af_inet
> +requires_parser_support "network (send) ip=::1,"
> +
> +settest net_inet_tcp_fastopen
> +
> +tfo_sysctl=/proc/sys/net/ipv4/tcp_fastopen
> +tfo_saved=""
> +
> +cleanup()
> +{
> +	# restore the original tcp_fastopen value if we changed it
> +	if [ -n "$tfo_saved" ]; then
> +		echo "$tfo_saved" > "$tfo_sysctl" 2>/dev/null || true
> +	fi
> +}
> +do_onexit="cleanup"
> +
> +# The sendto(MSG_FASTOPEN) client path needs the TCP Fast Open client bit
> +# (0x1). Enable it for the run; if it is unavailable (no sysctl, or it cannot
> +# be enabled) the bug cannot be exercised at all, so skip rather than report a
> +# spurious failure.
> +if [ ! -w "$tfo_sysctl" ]; then
> +	echo "    TCP Fast Open sysctl ($tfo_sysctl) not available. Skipping tests ..."
> +	exit 0
> +fi
> +tfo_saved=`cat "$tfo_sysctl"`
> +echo $((tfo_saved | 1)) > "$tfo_sysctl" 2>/dev/null || true
> +if [ $(($(cat "$tfo_sysctl") & 1)) -ne 1 ]; then
> +	echo "    Could not enable the TCP Fast Open client bit. Skipping tests ..."
> +	exit 0
> +fi
> +
> +# add ::1 if not already present (loopback usually has it)
> +ip -6 addr add ::1/128 dev lo 2>/dev/null || true
> +
> +# pick a free port for the listener this binary creates
> +port=4321
> +while lsof -i:$port >/dev/null 2>&1; do
> +	let port=$port+1
> +done
> +
> +# Profile: allow stream send/receive + the perms needed to stand up the
> +# in-process listener (bind/listen/accept), allow setopt/getopt for TFO
> +# sockopts, but explicitly DENY connect on both inet and inet6.
> +gen_send_no_connect()
> +{
> +	genprofile \
> +	  "network;(send,receive,accept,listen,bind);ip=127.0.0.1;port=$port" \
> +	  "network;(send,receive,accept,listen,bind);ip=::1;port=$port" \
> +	  "network;(send,receive);peer=(ip=127.0.0.1)" \
> +	  "network;(send,receive);peer=(ip=::1)" \
> +	  "network;(setopt,getopt);ip=0.0.0.0;port=0" \
> +	  "network;(setopt,getopt);ip=::0;port=0" \
> +	  "qual=deny:network;(connect);ip=127.0.0.1" \
> +	  "qual=deny:network;(connect);ip=::1"
> +}
> +
> +# ---- inet (IPv4) ----
> +gen_send_no_connect
> +# baseline: a normal connect(2) must be denied -> binary prints PASS (denied),
> +# expected outcome 'pass'
> +runchecktest "TFO inet - connect(2) denied" pass connect inet $port
> +# the bug: sendto(MSG_FASTOPEN) must ALSO be denied post-fix
> +runchecktest "TFO inet - sendto(MSG_FASTOPEN) denied" pass fastopen inet $port
> +
> +# ---- inet6 (IPv6) ----
> +gen_send_no_connect
> +runchecktest "TFO inet6 - connect(2) denied" pass connect inet6 $port
> +runchecktest "TFO inet6 - sendto(MSG_FASTOPEN) denied" pass fastopen inet6 $port
> +
> +# ---- MPTCP: the second producer the fix guards (IPPROTO_MPTCP) ----
> +# The deny-connect rule is family/type based, so it covers MPTCP (inet/inet6
> +# stream) too. Only run when MPTCP is enabled.
> +if [ "`cat /proc/sys/net/mptcp/enabled 2>/dev/null`" = "1" ]; then
> +	gen_send_no_connect
> +	runchecktest "TFO MPTCP inet - connect(2) denied" pass connect minet $port
> +	runchecktest "TFO MPTCP inet - sendto(MSG_FASTOPEN) denied" pass fastopen minet $port
> +	gen_send_no_connect
> +	runchecktest "TFO MPTCP inet6 - connect(2) denied" pass connect minet6 $port
> +	runchecktest "TFO MPTCP inet6 - sendto(MSG_FASTOPEN) denied" pass fastopen minet6 $port
> +fi
> +
> +# ---- positive control: when connect IS allowed, both succeed (no false deny) ----
> +genprofile \
> +  "network;(connect,send,receive,accept,listen,bind);ip=127.0.0.1;port=$port" \
> +  "network;(connect,send,receive);peer=(ip=127.0.0.1)" \
> +  "network;(setopt,getopt);ip=0.0.0.0;port=0"
> +# Here the binary's "denied" assertion is FALSE (op allowed), so it prints
> +# FAIL; we expect that, i.e. expected outcome 'fail'.
> +runchecktest "TFO inet - connect allowed (control)" fail connect inet $port
> +runchecktest "TFO inet - fastopen allowed (control)" fail fastopen inet $port
> +
> +exit 0
> 
> ---
> base-commit: bdccc1ebd2e1a1b75ceb8f87b23831fe273b9ebb
> change-id: 20260622-b4-disp-220b400d-3d7fd53bce49
> 
> Best regards,

