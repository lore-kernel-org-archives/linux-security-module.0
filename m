Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58591F2C35
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jan 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259481; cv=none; b=a67Wuulmu5vkITt1W4m5/loDkLibw1rnHzbSRCZ2f7Z8B4VNxz+QeKxc3ylLL9h6mZAmsaCEXC2LJ4Hus2eKoIaO8xIWAxjTmy6vafo55+HLHp13JbNbbZXUlb8HbCY7cKiVAr0Y+LihyWLaSz1OdlDDU0GE5PZAsKEsc082pRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259481; c=relaxed/simple;
	bh=hxhYCk1yFERYlhBGrwSAFc87/NrnOrt8ye+YSBKlpkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOi9VRBCxt3DMDq2Pp7eNbUh7xmv8ivJTbDfUWpAfVnYp/WH4W3ng82NEihTWawZB0woQUGMn1NYDXuztUg2rDuz3HGYMgbaxcG3Ytxqc+nG0xtCPsxkB1a1pnF+o4u5bFHI5Ago9wVmavWZijSNav4sVldvWxZ4YLDeca0AlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mvAefoxJ; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mvAefoxJ"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSCnB4jcCzXFh;
	Tue,  7 Jan 2025 15:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736259470;
	bh=kNxmZMX1nmlc3ItvZp/1dmwvBl+DE7X/8ebPz7ls8H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvAefoxJ4+K8BZjg7YUa0DAT/PjDfGDeNZTLtLpmeVd/CoFlZh6R501SVICUvNDpU
	 04aCyuXeEAQC5lJmwkz4UldqxktWdNIk6B7o32linEtSX9U2g7GdcQvJRjUul90oE4
	 YRFh0ajs4f1i8WPZvhfx3fmHtapr0xtIMraERIQM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSCn952s8zqVy;
	Tue,  7 Jan 2025 15:17:49 +0100 (CET)
Date: Tue, 7 Jan 2025 15:17:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 17/23] landlock: Log TCP bind and connect denials
Message-ID: <20250107.Amu1eiPohwei@digikod.net>
References: <20241122143353.59367-18-mic@digikod.net>
 <0055bef6843289ac8dc728a68326513d@paul-moore.com>
 <20250106.ea8aex7jai3O@digikod.net>
 <CAHC9VhRh+_CM5kVmuXkttCn-3f3X8TR4n2q7MzrxCBXhbb2n-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRh+_CM5kVmuXkttCn-3f3X8TR4n2q7MzrxCBXhbb2n-Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jan 06, 2025 at 05:29:51PM -0500, Paul Moore wrote:
> On Mon, Jan 6, 2025 at 9:51 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Sat, Jan 04, 2025 at 08:23:52PM -0500, Paul Moore wrote:
> > > On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > > >
> > > > Add audit support to socket_bind and socket_connect hooks.
> > > >
> > > > Audit event sample:
> > > >
> > > >   type=LL_DENY [...]: domain=195ba459b blockers=net_connect_tcp daddr=127.0.0.1 dest=80
> > >
> > > The destination address and port is already captured in the SOCKADDR
> > > record for bind() and connect(), please don't duplicate it here.
> >
> > This does not show up when a connect or bind is denied.  I guess this is
> > because move_addr_to_kernel() is called at syscall entry when there is
> > no context, whereas a Landlock denial is created after that.  For this
> > to work, users would have to log a list of syscalls, which would not be
> > usable (nor reliably maintainable) for most users.
> 
> Quick question, can you share the audit filter configuration you are
> using on your dev/test systems (just dump /etc/audit/audit.rules,
> unless you are doing it by hand)?

This file only contains a comment.  auditctl -l says that there is no
rules.

> 
> One can make an argument that if syscall auditing is being explicitly
> denied, then the user has decided that the syscall related information
> is not important to them.  I'm somewhat conflicted on that argument,
> but I believe the argument is at least valid.

I did not disable syscall auditing, I get the type=SYSCALL record for
every Landlock deny event, but there is no SOCKADDR one.  For instance:

type=UNKNOWN[1423] msg=audit(1736258533.147:45): domain=190464446 blockers=net.connect_tcp daddr=127.0.0.1 dest=80
type=UNKNOWN[1424] msg=audit(1736258533.147:45): domain=190464446 creation=1736258533.135 pid=359 uid=0 exe="/root/sandboxer" comm="sandboxer"UID="root"
type=SYSCALL msg=audit(1736258533.147:45): arch=c000003e syscall=42 success=no exit=-13 a0=5 a1=5647c6a26b98 a2=10 a3=7ffd2f5f6acc items=0 ppid=356 pid=359 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4 comm="curl" exe="/usr/bin/curl" key=(null)ARCH=x86_64 SYSCALL=connect AUID="root" UID="root" GID="root" EUID="root" SUID="root" FSUID="root" EGID="root" SGID="root" FSGID="root"
type=PROCTITLE msg=audit(1736258533.147:45): proctitle=6375726C00687474703A2F2F3132372E31
type=UNKNOWN[1425] msg=audit(1736258533.199:46): domain=190464446

> 
> > I guess this might be different with io_uring too.
> 
> There are other issues with SOCKADDR and io_uring related to how
> io_uring wants to separate the work into different execution contexts.
> In general I wouldn't spend too much time worrying about auditing and
> io_uring right now, there are some general issues that need to be
> resolved in io_uring/audit that are much larger than just Landlock's
> audit usage.

OK.  Anyway, my understanding is that SOCKADDR is just a way to enrich
the syscall record to ease debugging or tracing.  In the case of an
access control, we want to identify an object/subject, and each LSM may
have a different way to identify such an object, and this description
should be enough to identify the relevant part of the object.
