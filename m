Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980ED35C68A
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533379; cv=none; b=oZnsXKkFPuijKsSTLyV3HgbCasdJieKHhfWpDS815sgmeJefm7vVSUbK0bap2oBT79WSUnqeKSdgtSwgwdexGi//Vf0ZUyp5lDaDgNEN1263HthHmwWbYkMToxmI5N7ApKislV5f0jDyweTsjQFh1WTYrSiNPGBMiAYUmB68kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533379; c=relaxed/simple;
	bh=4ZO9Xjoz5hYGFOJLdDMXmhkuBGBKDrNv7bARFnTuyFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tks3XIg7ZHWZbCqe5fbwdXcRfKgc2WrwEdVzTK2CEN7Z26apnm8g81WkJCGdTUUpnD6ZFuQ+KmYvM2FhU6Mu//qmqAIvY13k12Khk1EAbUp/kOLuNUvYdXm20/4cqM8NeADKi6MxjfaIOTfIGkGZ0XE8u+0/ZFC9JGcUVdQh4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=krbOLUq8; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="krbOLUq8"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBfN95QXdzr20;
	Fri, 31 Jul 2026 23:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785533369;
	bh=4LAK2DGA5czOcsfzWspcLWhICXjIs/b7DzpgUQGVH7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krbOLUq8Qcwh/911fmeBPpw5r5/qMdwTUKGIU4LSBU+GQPLP0Bdzhzw8gRDvW7Zrk
	 7EI3yzh5UDluaTDSrg7V2GqeWgCGAGm6GM+SUYcXVSvRi+Pn5Fcb3A35eTroyOFaWD
	 J9NOjIEAYr+YvUdkX4qdkb7afyxqCUNM5n/vlxGY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBfN91GnMzMw8;
	Fri, 31 Jul 2026 23:29:29 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:29:28 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/3] landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260731.gagai6she3So@digikod.net>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
 <20260717220320.1030123-2-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717220320.1030123-2-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

I like this series.

On Fri, Jul 17, 2026 at 06:03:17PM -0400, Justin Suess wrote:
> Add a landlock_restrict_self(2) flag to set the no_new_privs attribute
> of the calling thread atomically with the enforcement of the ruleset:

It looks atomic from the caller, but really this bit is set iff the
ruleset enforcement succeed and before the call returns.  Even for user
space, when we'll have an introspection interface (e.g.  tracepoints),
user space could see inconsistencies wrt /proc/pid/status showing NNP
because both operations are not atomic.

> no_new_privs is set if and only if the call succeeds.  This removes the
> need for a prior prctl(2) PR_SET_NO_NEW_PRIVS call and guarantees that a
> failed enforcement leaves the attribute unchanged.
> 
> Because no_new_privs is set by the call itself, the no_new_privs /
> CAP_SYS_ADMIN requirement of landlock_restrict_self(2) is fulfilled by
> construction, and the related EPERM check is skipped.  As a consequence,
> an unprivileged caller passing unknown flags along with this flag gets
> EINVAL instead of EPERM.
> 
> The attribute is only set past the last point of failure, just before
> committing the new credentials.  When combined with
> LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the sibling threads
> as well, in their commit phase, with the same atomicity.
> 
> Bump the Landlock ABI version to 11.
> 
> Cc: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/uapi/linux/landlock.h | 13 +++++++++++++
>  security/landlock/limits.h    |  2 +-
>  security/landlock/syscalls.c  | 28 +++++++++++++++++++++-------
>  security/landlock/tsync.c     |  8 ++++++--
>  security/landlock/tsync.h     |  4 +++-
>  5 files changed, 44 insertions(+), 11 deletions(-)
