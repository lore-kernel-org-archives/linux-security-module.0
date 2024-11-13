Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759741FF7C2
	for <linux-security-module@vger.kernel.org>; Wed, 13 Nov 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511313; cv=none; b=eJkTI5Kx2vlYxFS24hG4daLsAwT12HBLYn0NTg22J7vp5Q7/9qtRVrbTczV4vmCifrIxb3U+MFEnblep4BkqNBRGNK0tRso852+nS3OtXRxmjg4rz3VnvpArO6ygjjI+ECoJWYe8AuPV0A52H/mSmaqhI/UhL3zcDw2HtlIDlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511313; c=relaxed/simple;
	bh=oQqLj+VTG52Pd8JpuUEISAjkJSUrTrwueurA5xER+Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2AJgsSBAhY2m+MeoZRdkMp4UMN1EQN/H1oaAkIaNYHFW6pJn4J3LWS9GdyXHg+5WkN52OZuR61XbIWrEc9tkTddMeLMtIlKg5ThVE3466uUzWF2v7p4GQfXzrGYwLNSt2hVlORUyyl8oeO/iPnMWZhzcOG0H2LIoEmcazmeRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZaXq2ZJ7; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZaXq2ZJ7"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XpRpN2n0nzpPM;
	Wed, 13 Nov 2024 16:21:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731511308;
	bh=jjAbEbcMySB+5Dq2slVS7gS9u4ZlQ2TKG5y+0STveNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaXq2ZJ7B1AxWTWiQ6a8wWVNQ+PYgUTTajpNs6/os/UM5l6BwL2w2L69DnzrLQ+Xu
	 uynFLpcTj2mvRQak4nYaVr02NmIFyPITeB1LWzTHB5DWDrbokFJ75IO2vmoQr4U/L7
	 QsYd6Uy++HS//FMbOxYqwlE1v6KmLauZTJK+AsGU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XpRpM3hdMzbrt;
	Wed, 13 Nov 2024 16:21:47 +0100 (CET)
Date: Wed, 13 Nov 2024 16:21:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 12/14] landlock: Log TCP bind and connect denials
Message-ID: <20241113.oThieDiehaa8@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
 <20241022161009.982584-13-mic@digikod.net>
 <2345615.iZASKD2KPV@pwmachine>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2345615.iZASKD2KPV@pwmachine>
X-Infomaniak-Routing: alpha

On Fri, Oct 25, 2024 at 05:25:45PM +0200, Francis Laniel wrote:
> Le mardi 22 octobre 2024, 18:10:07 CEST Mickaël Salaün a écrit :
> > Add audit support to socket_bind and socket_connect hooks.
> > 
> > Audit record sample:
> > 
> >   DENY:    domain=4533720601 blockers=net_connect_tcp daddr=127.0.0.1
> > dest=80 SYSCALL: arch=c000003e syscall=42 success=no exit=-13 ...
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241022161009.982584-13-mic@digikod.net
> > ---
> >  security/landlock/audit.c | 11 +++++++++
> >  security/landlock/audit.h |  1 +
> >  security/landlock/net.c   | 52 ++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 60 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index 898c95ebe847..c31a4a8719ee 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -41,6 +41,12 @@ static const char *const fs_access_strings[] = {
> >  };
> >  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> > 
> > +static const char *const net_access_strings[] = {
> > +	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_TCP)] = "net_bind_tcp",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] = "net_connect_tcp",
> > +};
> > +static_assert(ARRAY_SIZE(net_access_strings) == LANDLOCK_NUM_ACCESS_NET);
> > +
> >  static __attribute_const__ const char *
> >  get_blocker(const enum landlock_request_type type,
> >  	    const unsigned long access_bit)
> > @@ -58,6 +64,11 @@ get_blocker(const enum landlock_request_type type,
> >  		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(fs_access_strings)))
> >  			return "unknown";
> >  		return fs_access_strings[access_bit];
> > +
> > +	case LANDLOCK_REQUEST_NET_ACCESS:
> > +		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(net_access_strings)))
> > +			return "unknown";
> > +		return net_access_strings[access_bit];
> >  	}
> > 
> >  	WARN_ON_ONCE(1);
> > diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> > index 320394fd6b84..1075b0c8401f 100644
> > --- a/security/landlock/audit.h
> > +++ b/security/landlock/audit.h
> > @@ -18,6 +18,7 @@ enum landlock_request_type {
> >  	LANDLOCK_REQUEST_PTRACE = 1,
> >  	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
> >  	LANDLOCK_REQUEST_FS_ACCESS,
> > +	LANDLOCK_REQUEST_NET_ACCESS,
> >  };
> > 
> >  /*
> > diff --git a/security/landlock/net.c b/security/landlock/net.c
> > index 27872d0f7e11..c21afd6e0b4d 100644
> > --- a/security/landlock/net.c
> > +++ b/security/landlock/net.c
> > @@ -7,10 +7,12 @@
> >   */
> > 
> >  #include <linux/in.h>
> > +#include <linux/lsm_audit.h>
> >  #include <linux/net.h>
> >  #include <linux/socket.h>
> >  #include <net/ipv6.h>
> > 
> > +#include "audit.h"
> >  #include "common.h"
> >  #include "cred.h"
> >  #include "limits.h"
> > @@ -56,6 +58,10 @@ static int current_check_access_socket(struct socket
> > *const sock, };
> >  	const struct landlock_ruleset *const dom =
> >  		landlock_match_ruleset(landlock_get_current_domain(), any_net);
> > +	struct lsm_network_audit audit_net = {};
> > +	struct landlock_request request = {
> > +		.type = LANDLOCK_REQUEST_NET_ACCESS,
> > +	};
> > 
> >  	if (!dom)
> >  		return 0;
> > @@ -72,18 +78,49 @@ static int current_check_access_socket(struct socket
> > *const sock,
> > 
> >  	switch (address->sa_family) {
> >  	case AF_UNSPEC:
> > -	case AF_INET:
> > +	case AF_INET: {
> > +		const struct sockaddr_in *addr4;
> > +
> >  		if (addrlen < sizeof(struct sockaddr_in))
> >  			return -EINVAL;
> > -		port = ((struct sockaddr_in *)address)->sin_port;
> > +
> > +		addr4 = (struct sockaddr_in *)address;
> > +		port = addr4->sin_port;
> > +
> > +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> > +			audit_net.dport = port;
> > +			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
> > +		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
> > +			audit_net.sport = port;
> > +			audit_net.v4info.saddr = addr4->sin_addr.s_addr;
> > +		} else {
> > +			WARN_ON_ONCE(1);
> > +		}
> >  		break;
> > +	}
> > 
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -	case AF_INET6:
> > +	case AF_INET6: {
> > +		const struct sockaddr_in6 *addr6;
> > +
> >  		if (addrlen < SIN6_LEN_RFC2133)
> >  			return -EINVAL;
> > -		port = ((struct sockaddr_in6 *)address)->sin6_port;
> > +
> > +		addr6 = (struct sockaddr_in6 *)address;
> > +		port = addr6->sin6_port;
> > +		audit_net.v6info.saddr = addr6->sin6_addr;
> 
> You set this for all access_request, but not for IPv4, is this done on 
> purpose?

Indeed, this is a bug, I'll remove this line.  Thanks!

> 
> > +
> > +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> > +			audit_net.dport = port;
> > +			audit_net.v6info.daddr = addr6->sin6_addr;
> > +		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
> > +			audit_net.sport = port;
> > +			audit_net.v6info.saddr = addr6->sin6_addr;
> > +		} else {
> > +			WARN_ON_ONCE(1);
> > +		}
> >  		break;
> > +	}
> >  #endif /* IS_ENABLED(CONFIG_IPV6) */
> > 
> >  	default:
