Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F943FB075
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706174; cv=none; b=V7XQV54fpaZCpu5Kzpa7sNd9+FPC8j8B7uRHmgYnuqOTxCKzQ3U35nSahP0F8w8hPa30187nZyxYqFIiY9cAsuN2hL723pyv21N/5YrVCbvtJJAbYKXfWT4HrjgGoFBx+em7yVBPlDU/Pk0UUR/SJxqkgfWrccpKCIkuNJZneFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706174; c=relaxed/simple;
	bh=DW6zU2zOMsFZI7KDUAES4xQ9+xPurQXeOEmfIhtkeF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuMoYw9/GHu26xHS6O9x6gGqmCC8KuqBQtvaFW95bYmWi2yZ3IoIvdjDtggRRD9oayFa9lCUuYPBXxo7QbxytVZUyJ6BwaE9Gt7//t0IBSiEdy6/uvBaddlSjKIXebB0M0WDV53va8QbqvSx8RyNC0Q6x4O1kqA/6K8J4EXLZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OGam9oUy; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OGam9oUy"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ggR0415QKzd9x;
	Wed, 17 Jun 2026 16:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781706163;
	bh=RwmEzQ+Rlqy195PCTmMZLaQG5VPFhIgJkiiDmwpaCho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGam9oUyF651V2o8AF4gyiC7WhSJX0Z2Xg5DajQ328tL9+z+4b9pmmPCZvYYsnT41
	 JarXu/ulqHSKkcucaecD+bJo9k0UQrWzYaxkidJsq36yFHHNh76xPa9Lv6H+gFYPUB
	 ClJOmm/S5AiRqMGF9E6t2p04hRcEfQt+mtZaiOOI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ggR031zwnzYCV;
	Wed, 17 Jun 2026 16:22:43 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:22:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Subject: Re: Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast
 Open
Message-ID: <20260617.eemahv8ui7Ee@digikod.net>
References: <20260616201615.275032-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616201615.275032-1-hexlabsecurity@proton.me>
X-Infomaniak-Routing: alpha

Hi,

Thanks for the report.  This was previously identified by Mikhail and
Matthieu, see the related issue:
https://github.com/landlock-lsm/linux/issues/41


On Tue, Jun 16, 2026 at 08:16:22PM +0000, Bryam Vargas wrote:
> Hello Mickaël, and Landlock folks,
> 
> A task confined by a Landlock ruleset that handles
> LANDLOCK_ACCESS_NET_CONNECT_TCP and is denied connecting to a given port can
> still establish a TCP connection to that port by using TCP Fast Open, i.e.
> sendto(fd, ..., MSG_FASTOPEN, &dst, dstlen) on a fresh stream socket. The
> network-egress confinement for TCP connect is silently bypassed.
> 
> Affected
> --------
> Any kernel with CONFIG_SECURITY_LANDLOCK=y and Landlock enabled that supports
> the TCP network access rights (Landlock ABI >= 4, since Linux 6.7). Confirmed by
> source inspection on mainline (v7.1-rc7) and reproduced on Linux 7.0.11
> (Landlock ABI 8). No CONFIG beyond Landlock + IPv4/IPv6 TCP; TCP Fast Open client
> is enabled by the per-netns default (net.ipv4.tcp_fastopen has TFO_CLIENT_ENABLE
> set), so no sysctl change and no setsockopt are required.
> 
> Root cause
> ----------
> LANDLOCK_ACCESS_NET_CONNECT_TCP is enforced only by the socket_connect LSM hook
> (hook_socket_connect -> current_check_access_socket). security_socket_connect()
> has exactly one call site in the tree, net/socket.c (the connect(2) syscall).
> 
> TCP Fast Open performs an implicit connect inside sendmsg:
> 
>   tcp_sendmsg_locked()            net/ipv4/tcp.c  (MSG_FASTOPEN branch)
>    -> tcp_sendmsg_fastopen()      net/ipv4/tcp.c
>    -> __inet_stream_connect(..., is_sendmsg=1)  net/ipv4/af_inet.c
>    -> sk->sk_prot->connect()      net/ipv4/af_inet.c  -> tcp_v4_connect()
> 
> This path establishes the connection to the address taken from msg_name but
> never calls security_socket_connect(). The only LSM hook fired on the sendmsg
> path is security_socket_sendmsg(), and Landlock registers no socket_sendmsg
> hook, so LANDLOCK_ACCESS_NET_CONNECT_TCP is never re-checked. __inet_stream_connect()
> itself carries no LSM hook (only the cgroup-BPF pre_connect, a different
> mechanism).
> 
> Notably the kernel already mediates the analogous AF_UNIX implicit-connect on the
> send path via the unix_may_send hook, which Landlock does register
> (hook_unix_may_send) -- so the sendmsg-implies-connect pattern is recognized, but
> the TCP Fast Open case has no equivalent coverage. The MPTCP fast-open path
> (mptcp_sendmsg_fastopen -> __inet_stream_connect) is a second producer of the
> same unmediated connect (by source inspection; not separately reproduced).
> 
> Reproducer
> ----------
> A self-contained, fully unprivileged PoC is available on request. It forks an
> unconfined TFO-capable loopback listener, then in a child applies a Landlock
> ruleset handling LANDLOCK_ACCESS_NET_CONNECT_TCP with no allow rule
> (landlock_create_ruleset() with handled_access_net =
> LANDLOCK_ACCESS_NET_CONNECT_TCP, no landlock_add_rule(), then
> landlock_restrict_self(); every TCP connect is denied) and tries the forbidden
> port two ways:
> 
>   (1) connect(fd, &dst)                 -> -EACCES   (Landlock enforces CONNECT_TCP)
>   (2) sendto(fd2, buf, len, MSG_FASTOPEN, &dst, dstlen)
>                                         -> succeeds; the listener accepts the
>                                            connection and reads the payload.
> 
> Observed on Linux 7.0.11 (Landlock ABI 8):
> 
>   [1] connect(2)            -> ret=-1 errno=13 (Permission denied)
>   [2] sendto(MSG_FASTOPEN)  -> ret=14 errno=0 (OK/queued)
>   [+] listener ACCEPTED the confined child's connection; payload="..."
> 
> connect(2) to the port is denied while sendto(MSG_FASTOPEN) reaches the identical
> port and delivers data.
> 
> Impact
> ------
> A sandbox that uses LANDLOCK_ACCESS_NET_CONNECT_TCP to restrict outbound TCP
> (e.g. to keep a confined component from reaching an internal service or a
> metadata endpoint) can be escaped by an unprivileged, self-confined task with no
> CAP and no namespace transition -- for any destination port, since the
> implicit-connect path never consults the connect hook regardless of address (the
> run above shows one port). It is an integrity
> bypass of the network-confinement property; no memory safety is involved.
> I score it CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:H/A:N (6.5 Medium) -- the
> confined task escapes the policy authority that defined its sandbox, a scope
> change; 5.5 if you treat the Landlock boundary as the same authority (S:U).
> 
> Note on the in-flight UDP series
> --------------------------------
> The "landlock: Add UDP access control support" series (v5, Matthieu Buffet,
> https://lore.kernel.org/r/20260611162107.49278-3-matthieu@buffet.re) adds a
> socket_sendmsg hook, hook_socket_sendmsg(), but it returns 0 for non-UDP
> sockets:
> 
>     if (sk_is_udp(sock->sk))
>             access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>     else
>             return 0;
> 
> so a TCP socket using MSG_FASTOPEN still bypasses LANDLOCK_ACCESS_NET_CONNECT_TCP
> even after that series lands. It may be most convenient to fix this there.
> 
> Suggested direction
> -------------------
> Re-check LANDLOCK_ACCESS_NET_CONNECT_TCP on the implicit-connect path: either have
> the socket_sendmsg hook evaluate CONNECT_TCP for stream sockets when the call
> performs an implicit connect (mirroring the AF_UNIX unix_may_send handling), or
> place the check inside __inet_stream_connect() so a single chokepoint covers
> connect(2), TCP Fast Open, and the MPTCP fast-open sibling.
> 
> I am happy to send a patch for this if you would like me to.

Yes please.

> 
> Best regards,
> 
> Bryam Vargas
> Independent security researcher, HEXLAB S.A.S., Cali, Colombia
> hexlabsecurity@proton.me
> 
> 
