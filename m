Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011E225788
	for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484612; cv=none; b=byqaSVBcEBXiYBH70K+DmckPopVLJqyUqx0aJxtwtrjRQ9mmOXmP8m3Hh8wDQtWlCX8bbCkL7nUj83dueAWaeKoKk9UGvhRI4/AtIo3MzpLtLnVhbECby2u4BLvrOptDfI2K34neV9dgWLtkp6lCkf6BCCVGCsgqTSjbFcqfwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484612; c=relaxed/simple;
	bh=JhZwWnLCTdg3yCiw3MMzwoZqkff9bBtvXJVizO7ydCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCDn5kuiyfm6jWMXqmI5JWVno7EQWdyHEDb2N9C6N6FhQxOflwipJ/3axus8Wx8/li4yQzDj+ElwyGSXoK5sHZ0ngwvavtJ/ly0L6bH7m188UrsxIVyqRFvYSNEHTwhm56viwvt3c3m94aKiBmr++UeFQlzK28Uxi0HiJ+DuR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=whFcw4t9; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="whFcw4t9"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gMdCy3RLjzhHj;
	Fri, 22 May 2026 23:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779484094;
	bh=pJedgZBhIKgsTYK6NMF6GB4drKbNP5Xm+N//26L//zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=whFcw4t9c1xIX1SEPczFSQ3pWa2NTEKoPFkOBbpCaWqa+fEnvNMdSEDSNg9HVKWYT
	 zFZouUgPashqOaGgMTxlogZOyvqIt/MMna0VBfwpCHQuYI2yhGP1vWWTQI4Of/U1F5
	 Bx4pCSkq+N+unh5NE0vC28ZoYAWY+Rieqny/giY4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gMdCx5DBnzsgy;
	Fri, 22 May 2026 23:08:13 +0200 (CEST)
Date: Fri, 22 May 2026 23:08:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/7] landlock: Add UDP access control support
Message-ID: <20260522.saibiuZ5ailo@digikod.net>
References: <20260502124306.3975990-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502124306.3975990-1-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

Thanks again, I only spotted some minor issues.

On Sat, May 02, 2026 at 02:42:59PM +0200, Matthieu Buffet wrote:
> Hi,
> 
> This is V4 of UDP access control in Landlock. Thanks to the round of
> review of v3, access rights have changed to something that seems easier
> to use and understand. It adds only two access rights, to restrict
> configuring local and remote addresses on UDP sockets. The one that
> restricts setting a remote address also controls sending datagrams to
> explicit remote addresses -ignoring any remote address preset on the
> socket-. The one that restricts binding to a local port also applies
> when the kernel auto-binds an ephemeral port.
> v1:
> Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
> v2:
> Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
> v3:
> Link: https://lore.kernel.org/all/20251212163704.142301-1-matthieu@buffet.re/
> 
> The limitation around allowing a process to send but not receive is
> still there, and could warrant another patch if there is a real user
> need.
> I'm just not super happy about the clarity of logs generated for denied
> autobinds ("domain=xxxxxx blockers=net.bind_udp"), due to the fact that
> addresses and ports are currently only logged if they are non-0. A later
> (coordinated LSM-wide) patch could improve readability by replacing != 0
> checks with new booleans in struct lsm_network_audit.

Do you plan to send such patch after this series?  I guess we could add
has_{port,addr} fields to lsm_network_audit and handle AF_UNSPEC too?

> I'm also not
> exactly happy with the integration in existing TCP selftests, but
> refactoring them has already been discussed earlier.

Can you remind us what was your concern and the potential fix?

> 
> Changes v1->v2
> ==============
> - recvmsg hook is gone and sendmsg hook doesn't apply when sending to a
>   remote address pre-set on socket, to improve performance
> - don't add a get_addr_port() helper function, which required a weird
>   "am I in IPv4 or IPv6 context"
> - reorder hook prologue for consistency: check domain, then type and
>   family
> 
> Changes v2->v3
> ==============
> - removed support for sending datagrams with explicit destination
>   address of family AF_UNSPEC, which allowed to bypass restrictions with
>   a race condition
> - rebased on linux-mic/next => add support for auditing
> - fixed mistake in selftests when using unspec_srv variables, which were
>   implicitly of type SOCK_STREAM and did not actually test UDP code
> - add tests for IPPROTO_IP
> - improved docs, split off TCP-related refactoring
> 
> Changes v3->v4
> ==============
> - merge LANDLOCK_ACCESS_NET_CONNECT_UDP and
>   LANDLOCK_ACCESS_NET_SENDTO_UDP into
>   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP (everything that might set the
>   destination of a datagram)
> - make LANDLOCK_ACCESS_NET_BIND_UDP apply when kernel is about to
>   auto-bind an ephemeral port for the caller. Block it if policy would
>   not allow an explicit call to bind(0)
> - only deny sending AF_UNSPEC datagrams on IPv6 sockets, where there is
>   a risk of the address family changing midway
> 
> Patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
> 3457a5ccacd3 ("landlock: Document fallocate(2) as another truncation corner case")
> All lines added are covered with selftests, except the "default: return
> 0" in current_check_autobind_udp_socket() which is not currently
> reachable (net.c goes from 92.9%->94.6% line coverage).
> 
> Let me know what you think!
> 
> Closes: https://github.com/landlock-lsm/linux/issues/10
> 
> Matthieu Buffet (7):
>   landlock: Add UDP bind() access control
>   landlock: Add UDP connect() access control
>   landlock: Add UDP send access control
>   selftests/landlock: Add UDP bind/connect tests
>   selftests/landlock: Add tests for sendmsg()
>   samples/landlock: Add sandboxer UDP access control
>   landlock: Add documentation for UDP support
> 
>  Documentation/userspace-api/landlock.rst     |   89 +-
>  include/uapi/linux/landlock.h                |   35 +-
>  samples/landlock/sandboxer.c                 |   40 +-
>  security/landlock/audit.c                    |    3 +
>  security/landlock/limits.h                   |    2 +-
>  security/landlock/net.c                      |  161 ++-
>  security/landlock/syscalls.c                 |    2 +-
>  tools/testing/selftests/landlock/base_test.c |    4 +-
>  tools/testing/selftests/landlock/net_test.c  | 1146 ++++++++++++++++--
>  9 files changed, 1341 insertions(+), 141 deletions(-)
> 
> 
> base-commit: 3457a5ccacd34fdd5ebd3a4745e721b5a1239690
> -- 
> 2.39.5
> 
> 
