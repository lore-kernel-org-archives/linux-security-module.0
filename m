Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DB531629
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173638; cv=none; b=kSKchLWe3YeUbhAyC+91VSjJjL02JYX+LjsrQ36YJdV7E4wNI+US6vBmPlnLMJzgFkrZJnQkdCCKpLMynlAZGf1ZqRk1bCGelOw39tpFoWL7pmZJIKF6TppruEcYCOv/0aFdxhQpx7LDCKmiL0rTXDJNB4DF8rgm8UKb/TqoRcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173638; c=relaxed/simple;
	bh=8h06L4zgt0xbnYaqADQB9yddRobQhsv4hVUNTqVY1jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugtv81k+b8ebcq4IvQQ0U8oa06FfTTXCBsKy7xb9HrCpt6gmh3Xf7oIc8mBdn/FYRSKPqRwNNXk6uOxQBT8cAsf1Ft034GQlR+aZKmgzjYJo6AIlZEqrujHbxCj9BQqD0n8YsMnsdxPa/zPcLPcZ25X9q4QTAZWWhypVZZb0TQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzNC1eNM; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzNC1eNM"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so6260125e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173633; x=1790778433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSzGnM9hkcOoFtPupK98ZapwC/NnVGSiD0/uooo0h9E=;
        b=bzNC1eNMuM1eShI2U0vCqWsQQzIXyrxi5Ku7mDQ80V18DQ8f9v4n092LXfBPxCI79z
         mx6Go3u6l9OkhDFe5z3gBNTrlFO7OUUSahlV9m4pZvi0mRsNyRdrveD3JhX5SZ2nzvhp
         NMlJ1Se3WgL4FBwhVj4GRmmCI+c/4nStaF8WTlWeQhP+bJ6i4/wRPgsyUTWMOHcibOXP
         mYWpHJ6A1JAjGBC29D1AE26M8diqDcNSEHStT1IOPpc5WMzmJW0rEPmy/7BXJNvD45x7
         wDRlZMB7kZqYENcuaXsf5GMevY1rjmsuX0CEqik6hHewgkzOaPBqvq1H/OvRjl4rCgme
         GkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173633; x=1790778433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PSzGnM9hkcOoFtPupK98ZapwC/NnVGSiD0/uooo0h9E=;
        b=q566yUtCjjJcZ1CvtTTW59/sCGZDchD8BvwNjrGBRz0/52QYkw+J4Deh24n2CzjBWL
         wr5N82YtRYv6thfr8OeHISTZIDc58yxP3Bs2OvhI9vANlvNZvZk+pd8r1G7sth9kUu4U
         qDVFITHeEJpJ7UvRKXHFXPOSq+hmN5ShqvaoYl7RsRZE+WJ8lc49QL7Vi7RJfp9aJlFP
         KvhWChA+tZeTrEX47AflLZ8CT/+o6VUA9W/hKTHLbVAM2FkKCV0zI3BNjLFpIvoEw7T7
         vgJS+fqtDYhwVPCbXVn43iEKArv0aqqRCmXZSEn+dKPSKQb9ImD+NmIh9cTnUegK2dAI
         U9Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwes1SAkQ14Y1HcZEnTHcZjr9JlQWOTWWyi/nBJHco3QCkTrWI2mQ68ZNvzdn92g4dETxmwru1F/MRLmQxfBTZc3yLiQ+4=@vger.kernel.org
X-Gm-Message-State: AFuF++kQf8sDKpbJJrLdGMXZnmHV8cuYDHHyvsJWBMDAgKFn3P6aK7oB
	69X+q1nU7sy/47FOhhjmChVyjUMlEuWNrhpi7CIe9PPEioD14r8thuyJHclUYbCORA==
X-Gm-Gg: AYBFou2wPy8mOLbwNSWmthswHDQO4E802KFPx4boxGXK7OI8kTOZWvgSx59j5Au4Lrb
	B4nN3sF8jPbqC9wNAHnuvOEUEk3csgRVPam03dKFFFKqHknWBa3H97qtTmiVEBVvV8MJh7e3PYN
	IWaXacIC2Ndk5kniBukzLWJNhk1yOSlTCTanG9XM7+LjZUNnc/Y8eA0HXDLkl0QnzBFIe6ZB1cv
	slMBapSCM74NZbWJxVkOociOUPEQ3I+ms5UyOwYOnawbpREHkR36b7Vv+wzWrrTZ78hV5Zpi562
	CBMSfUd/dEe6EHyKf6auj1o+h03ALg3cvG87UcX7GTkFAMIlYnjHBXn4raiT16ess2ML04YUpvt
	yy6qDwW/A/5ng4N0+QZjzviZ2jEYTWTkck76Y9iEAn5uaXJ3lsSbwQ4DTwn/RO+vl6MRL3yDQH4
	3u965bsDxksmBKEwUjq6eSsJ2z2fOPi8TCqwPoHafrxa0Vj6m8u5ZA1ppjh44HuSXHS6y0SFZzQ
	l0/Iry/leQYNx7rQh7/viwhs8f/sNDvdOF4t5gd
X-Received: by 2002:a05:600c:8a0a:10b0:49f:df99:ff1a with SMTP id 5b1f17b1804b1-49fdf99ffb9mr29806345e9.17.1790173632836;
        Wed, 23 Sep 2026 07:27:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:c20f:9e7a:eeee:1b06])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm6964795f8f.6.2026.09.23.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:27:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:27:07 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Geliang Tang <geliang@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/6] landlock: Add MPTCP bind and connect access rights
Message-ID: <arPhu-qFxCgmfk87@google.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
 <20260830201650.67050-4-gnoack3000@gmail.com>
 <c0bf0918bd97105ee50f1436e6ff729e84cedf03.camel@kernel.org>
 <a5a2f4353d0c2a1b1f86ebf466838f5ef3de27ce.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5a2f4353d0c2a1b1f86ebf466838f5ef3de27ce.camel@kernel.org>

On Wed, Sep 23, 2026 at 01:04:40PM +0800, Geliang Tang wrote:
> On Mon, 2026-08-31 at 12:09 +0800, Geliang Tang wrote:
> > On Sun, 2026-08-30 at 22:16 +0200, Günther Noack wrote:
> > > MPTCP sockets have equivalent bind(2) and connect(2) operations as
> > > TCP
> > > sockets, but can not currently be restricted with Landlock without
> > > explicit MPTCP access rights.  As MPTCP operates on the same TCP
> > > port
> > > number space as TCP, this is a gap in Landlock's policies.
> > > 
> > > Add access rights for MPTCP bind(2) and connect(2) operations
> > > and document them in the header.
> > > 
> > > Treat TCP Fast Open the same as done for plain TCP in
> > > commit 33cb713db016 ("landlock: Fix TCP Fast Open connection
> > > bypass")
> > > 
> > > The port numbers used in MPTCP subflows are negotiated by the
> > > kernel
> > > and therefore not subject to these access rights.
> > > 
> > > Bump the Landlock ABI version to 12.
> > > 
> > > Closes: https://github.com/landlock-lsm/linux/issues/54
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >  include/linux/landlock.h                     |  5 +-
> > >  include/uapi/linux/landlock.h                | 24 +++++++
> > >  security/landlock/limits.h                   |  2 +-
> > >  security/landlock/net.c                      | 68 ++++++++++++++--
> > > --
> > > --
> > >  security/landlock/syscalls.c                 |  2 +-
> > >  tools/testing/selftests/landlock/base_test.c |  2 +-
> > >  6 files changed, 79 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/include/linux/landlock.h b/include/linux/landlock.h
> > > index 004cbd0b9298..b04ffc7caa21 100644
> > > --- a/include/linux/landlock.h
> > > +++ b/include/linux/landlock.h
> > > @@ -46,7 +46,10 @@
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > > "connect_tcp"), \
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_UDP,
> > > "bind_udp"), \
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
> > > \
> > > -			     "connect_send_udp")
> > > +			     "connect_send_udp"), \
> > > +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_MPTCP,
> > > "bind_mptcp"), \
> > > +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_MPTCP, \
> > > +			     "connect_mptcp")
> > >  
> > >  #define _LANDLOCK_SCOPE_NAMES \
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
> > > \
> > > diff --git a/include/uapi/linux/landlock.h
> > > b/include/uapi/linux/landlock.h
> > > index cceda3b3b961..2a953ba7ce25 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -448,6 +448,9 @@ struct landlock_net_port_attr {
> > >   * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect TCP sockets to the
> > > given
> > >   *   remote port. Support added in Landlock ABI version 4.
> > >   *
> > > + * .. note:: These rights do not apply to MPTCP sockets, which
> > > have
> > > their own
> > > + *   access rights (see below).
> > > + *
> > >   * And similarly for UDP port numbers:
> > >   *
> > >   * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the given
> > > local
> > > @@ -474,12 +477,33 @@ struct landlock_net_port_attr {
> > >   * .. note:: Sending datagrams to an ``AF_UNSPEC`` destination
> > > address
> > >   *   family is not supported for IPv6 UDP sockets: you will need
> > > to
> > > use a
> > >   *   ``NULL`` address instead.
> > > + *
> > > + * MPTCP sockets (created with ``IPPROTO_MPTCP``) use TCP port
> > > numbers, but
> > > + * they are controlled by their own access rights:
> > > + *
> > > + * - %LANDLOCK_ACCESS_NET_BIND_MPTCP: Bind MPTCP sockets to the
> > > given local
> > > + *   port. Support added in Landlock ABI version 12.
> > > + * - %LANDLOCK_ACCESS_NET_CONNECT_MPTCP: Connect MPTCP sockets to
> > > the given
> > > + *   remote port. Support added in Landlock ABI version 12.
> > > + *
> > > + * .. note:: The TCP and the MPTCP access rights are independent,
> > > even though
> > > + *   they refer to the same port number space. Handling only
> > > + *   %LANDLOCK_ACCESS_NET_BIND_TCP and
> > > %LANDLOCK_ACCESS_NET_CONNECT_TCP leaves
> > > + *   MPTCP sockets unrestricted, and vice versa. A sandbox that
> > > wants to
> > > + *   control all TCP-based traffic needs to handle both sets.
> > > + *
> > > + * .. note:: These MPTCP access rights restrict the ports passed
> > > to
> > > + *   :manpage:`bind(2)` and :manpage:`connect(2)`. The ports used
> > > in
> > > MPTCP
> > > + *   subflows are negotiated in the MPTCP protocol by the kernel
> > > and
> > > are not
> > > + *   subject to these restrictions.
> > >   */
> > >  /* clang-format off */
> > >  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL <<
> > > 0)
> > >  #define
> > > LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> > >  #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL <<
> > > 2)
> > >  #define LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP		(1ULL <<
> > > 3)
> > > +#define LANDLOCK_ACCESS_NET_BIND_MPTCP			(1ULL <<
> > > 4)
> > > +#define LANDLOCK_ACCESS_NET_CONNECT_MPTCP		(1ULL <<
> > > 5)
> > >  /* clang-format on */
> > >  
> > >  /**
> > > diff --git a/security/landlock/limits.h
> > > b/security/landlock/limits.h
> > > index 1a7c5fb8f6fd..d25e056b7ca2 100644
> > > --- a/security/landlock/limits.h
> > > +++ b/security/landlock/limits.h
> > > @@ -23,7 +23,7 @@
> > >  #define
> > > LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) -
> > > 1)
> > >  #define
> > > LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_AC
> > > CESS_FS)
> > >  
> > > -#define
> > > LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_SEND_U
> > > DP
> > > +#define
> > > LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_MPTCP
> > >  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET
> > > << 1) - 1)
> > >  #define
> > > LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_AC
> > > CESS_NET)
> > >  
> > > diff --git a/security/landlock/net.c b/security/landlock/net.c
> > > index 8f2aaac54b33..8541b0c07d64 100644
> > > --- a/security/landlock/net.c
> > > +++ b/security/landlock/net.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/net.h>
> > >  #include <linux/socket.h>
> > >  #include <net/ipv6.h>
> > > +#include <net/mptcp.h>
> > >  
> > >  #include "common.h"
> > >  #include "cred.h"
> > > @@ -53,6 +54,26 @@ int landlock_append_net_rule(struct
> > > landlock_ruleset *const ruleset,
> > >  	return err;
> > >  }
> > >  
> > > +static bool sk_is_mptcp_socket(const struct sock *sk)
> > > +{
> > > +	return sk_is_inet(sk) && sk->sk_type == SOCK_STREAM &&
> > > +	       sk->sk_protocol == IPPROTO_MPTCP;
> > > +}
> > 
> > This helper should be placed in include/net/mptcp.h. I had already
> > implemented one in [1], called sk_is_msk(), to differentiate it from
> > sk_is_mptcp(). If you have no concerns with my implementation, please
> > feel free to pick it up and use it in your series.
> 
> Sorry, let me correct myself. I thought about this more carefully, and
> the ideal place to define sk_is_msk() is in include/net/sock.h, between
> sk_is_tcp() and sk_is_udp():
> 
> static inline bool sk_is_tcp(const struct sock *sk) 
> {
>         return sk_is_inet(sk) &&
>                sk->sk_type == SOCK_STREAM &&
>                sk->sk_protocol == IPPROTO_TCP;
> }
> 
> static inline bool sk_is_msk(const struct sock *sk) 
> {
>         return sk_is_inet(sk) &&
>                sk->sk_type == SOCK_STREAM &&
>                sk->sk_protocol == IPPROTO_MPTCP;
> }
> 
> static inline bool sk_is_udp(const struct sock *sk) 
> {
>         return sk_is_inet(sk) &&
>                sk->sk_type == SOCK_DGRAM &&
>                sk->sk_protocol == IPPROTO_UDP;
> }
> 
> If possible, please fold this code into this patch.

Thank you for the review, Geliang!

I'll include something like this in the next review round.
(We are a bit bottlenecked on doing Landlock code reviews at the moment,
so some delays are unfortunately expected.)

Small question about the function name sk_is_msk(): Is "msk" the right
name for this?  It seems to be used as abbreviation for "MPTCP" in
net/mptcp, but it's also used in net/mctp as an abbreviation, and I
could not find a function name in include/net/mptcp.h which used "msk"
to mean "MPTCP".  Should that say sk_is_mptcp() instead?

Thanks,
—Günther
