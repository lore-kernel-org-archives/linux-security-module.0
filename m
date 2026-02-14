Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754752D47F4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Feb 2026 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771065303; cv=none; b=N5vofQ8hCFwxK7lK9Z2KrhEzpqW58+1rXsoQtkiV1r7UE8TmIGIj533sLs0MvWUWxsdwqu32k2Ym8ONPA7oo/GMebBySH7JGI7YgKllvEeePoB+g9DMx1g7XnK761S5UaQbB01ZnQh65dNptmk9RYYxDHHQC44bgDm3U8LblMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771065303; c=relaxed/simple;
	bh=u1Wxja1gauD1O5RiEDGyoOwkz98nJacqW2IThEPcaK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/T3AznRFOFFuvQgxz7X/9l57b7hQ/hMjmWSkfgsIApERD9NLNIMGBxNRfYh+UcSSjB5lMcJRfMRG7qtUQYsjHEDflkoirFCNuotuvyvkcOAQ8ux35J/djQsvV5wsMVERZZ3cDufdQzrzpyUYtKCO66R2qUhKEMH8wqqs8gZ4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hOCYFvQO; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hOCYFvQO"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fCllt1NvKzh1S;
	Sat, 14 Feb 2026 11:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771065290;
	bh=X/Bqhtx4te0C9TSLyPEcs9ydTX8U6OfW0sl5QAGJkks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOCYFvQOlFOzisHjaZeLTFBdAqry8nalMLT6DYD7rgXBCaMvdofcOXJ77pD/vlxGR
	 giXVKn0HCCnZID6SZh3kSVvykYwHHdgOwhuqestsDv95fHpgMjZZ3qe0RhyfgRGgcr
	 LPaqIB5hyuYlIfxMrcrq3gVbPDu6ldq2tSs56XgU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fClls0w7Fzb5G;
	Sat, 14 Feb 2026 11:34:49 +0100 (CET)
Date: Sat, 14 Feb 2026 11:34:44 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>, Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, netdev@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>
Subject: Re: [RFC PATCH v3 0/8] landlock: Add UDP access control support
Message-ID: <20260214.aicie1xiquiT@digikod.net>
References: <20251212163704.142301-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212163704.142301-1-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

I had a chat with Matthieu and here is a summary of our discussion
(Matthieu, please complete if necessary):

First, this patch series is hight quality.  The remaining issues are
related to the semantic and the capabilities of the enforced
restrictions.

1/ Simplify access rights

It would make more sense to have only two access rights, one to set the
source port and another to set the destination port.  The source port is
should be handled by LANDLOCK_ACCESS_NET_BIND_UDP, but the destination
port is should also be handle by a unique access right, something like
LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP because it can be set with
connect(2) or sendmsg(2).  Any suggestion for a better name?

2/ Autobind handling

If an UDP socket is not explicitly binded to a port, inet_autobind() is
called and provides an implicit port.  In this case, the socket_bind
hook is not called and we cannot enforce any kind of restriction
(without relying on Netfilter like SELinux does).

The idea would be to lazily detect previous autobinds when one of the
socket_bind, socket_connect, socket_sendmsg, or socket_recvmsg hook is
called.  This would mean to attach a Landlock security blob to all
sockets and store their state there.  A better alternative would be to
only rely on the struct socket to infer this information, but we're not
sure if this is possible.

3/ AF_UNSPEC trick

As explained in patch 5/8, the network stack behaves differntly when
AF_UNSPEC is used with sendmsg(2) against an IPv4 or an IPv6 socket.
In a nutshell, because the LSM hook is not called while the socket is
locked, there is a possible race condition that Landlock needs to
handle to avoid policy bypass.

It's not clear yet what can be implemented safely but one new solution
would be to implement a socket_setsockopt hook to detect (potentially
concurrent) change of a socket type and store in a new Landlock socket
security blob the state of the socket (e.g. if it was IPv6 and it is now
IPv4).  This would enables us to detect a malicious race condition while
allowing legitimate use cases.

When such deny would be triggered, Landlock should log that, probably
with a new dedicated blocker.  One reason is because this should help
users to understand the issue (which should be very rare), and another
reason is because audit_log_lsm_data() currently ignores
LSM_AUDIT_DATA_NET records if the socket family is not AF_INET* nor
AF_UNIX.

Paul, not sure we'll need it now but, do you think it would be OK to add
a new case for LSM_AUDIT_DATA_NET to log the socket family for
AF_INET/AF_INET6/AF_UNIX and also for currently unhandled families?
Something like " family=%x" .


On Fri, Dec 12, 2025 at 05:36:56PM +0100, Matthieu Buffet wrote:
> Hi Mickaël, Günther, Mikhail, Konstantin,
> 
> Here is v3 of UDP support for Landlock. My apologies for the delay, I've
> had to deal with unrelated problems. All feedback from v1/v2 should be
> merged, thanks again for taking the time to review them.
> 
> I based these patches on linux-mic/next commit 1a3cedbdc156 ("landlock:
> Fix wrong type usage") plus my previous patch "landlock: Fix TCP
> handling of short AF_UNSPEC addresses" to avoid adding UDP with already
> known bugs, duplicated from TCP. I waited a bit to get feedback on that
> patch and no one yelled, so I hope it's acceptable, tell me if it's not.
> Link: https://lore.kernel.org/linux-security-module/20251027190726.626244-4-matthieu@buffet.re/
> 
> Changes since v2
> ================
> Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
> - removed support for sending datagrams with explicit destination
>   address of family AF_UNSPEC, which allowed to bypass restrictions with
>   a race condition
> - rebased on linux-mic/next => add support for auditing
> - fixed mistake in selftests when using unspec_srv variables, which were
>   implicitly of type SOCK_STREAM and did not actually test UDP code
> - add tests for IPPROTO_IP
> - improved docs, split off TCP-related refactoring into another commit
> 
> Changes since v1
> ================
> Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
> - recvmsg hook is gone and sendmsg hook doesn't apply to connected
>   sockets anymore, to improve performance
> - don't add a get_addr_port() helper function, which required a weird
>   "am I in IPv4 or IPv6 context" to avoid a addrlen > sizeof(struct
>   sockaddr_in) check in connect(AF_UNSPEC) IPv6 context. A helper was
>   useful when ports also needed to be read in a recvmsg() hook, now it
>   is just a simple switch case in the sendmsg() hook, more readable
> - rename sendmsg access right to LANDLOCK_ACCESS_NET_UDP_SENDTO
> - reorder hook prologue for consistency: check domain, then type and
>   family
> - add additional selftests cases around minimal address length
> - update documentation
> 
> All important cases should have a selftest now. lcov gives me net.c
> going from 91.9% lines/82.5% branches to 93.4% lines/87% branches.
> Thank you for taking the time to read this!
> 
> Closes: https://github.com/landlock-lsm/linux/issues/10
> 
> Matthieu Buffet (8):
>   landlock: Minor reword of docs for TCP access rights
>   landlock: Refactor TCP socket type check
>   landlock: Add UDP bind+connect access control
>   selftests/landlock: Add UDP bind/connect tests
>   landlock: Add UDP sendmsg access control
>   selftests/landlock: Add tests for UDP sendmsg
>   samples/landlock: Add sandboxer UDP access control
>   landlock: Add documentation for UDP support
> 
>  Documentation/userspace-api/landlock.rst     |  94 ++-
>  include/uapi/linux/landlock.h                |  46 +-
>  samples/landlock/sandboxer.c                 |  58 +-
>  security/landlock/audit.c                    |   3 +
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/net.c                      | 119 +++-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/net_test.c  | 691 ++++++++++++++++---
>  9 files changed, 869 insertions(+), 148 deletions(-)
> 
> 
> base-commit: 1a3cedbdc156e100eb1a5208a8562a3265c35d87
> prerequisite-patch-id: 22051d5d4076a87481b22798c127ce84e219ca97
> prerequisite-patch-id: 37a1b44596a2d861ba91989edb1d7aac005931d6
> prerequisite-patch-id: c7be1c906699a2590ab7112cdf2ab6892178ec07
> -- 
> 2.47.3
> 
> 
