Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3D18C0C;
	Tue,  7 Jan 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259793; cv=none; b=jzMC5+vvbiPzoMp+t0CtlKhyQvNgTN3EDsDZJhb5ZTq7ViZnch702nYUboIItReYHiDnGDt8mv8JbOI9qQShcYYu+Vij0Rmb158+YGj96KP+oTmWmD0rQJsgh3Nyj7GldgbaYBlZQZCQN1xMX+RGafIDd3TelPvaGI4d/qXbwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259793; c=relaxed/simple;
	bh=A8X5KCgGOiMZOiG094DeuZLqGHxdyWaWHu2jJJnjVSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9Qm4+TNLdEwsDVlPIrCDTIelBv2xE/Fuf9m2Te0l/on1s4MzxMAfCGDL5YHRwt3WNPPhOrjt7jzlHk7Gp5Y1J0GrK8ziObXHTloi+o4h+5NCv4Tq2LOILGjXIf3UlIifuPwRoR/D9Q2wcRxI3qbe7g2gnKBVCKLeyaDlOg5VTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uKhp3Pwx; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uKhp3Pwx"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSCvH249kzcmv;
	Tue,  7 Jan 2025 15:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736259787;
	bh=B4+j3PwDoMzbfcShLrDeDnQC0GfMp+uZ0RttBZ9mUi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKhp3PwxdF3xeiifwQVjVpFYr5ibJ0aVg/+r7av3dQhnAOBKMLCfQXGiCHCBsJSpW
	 onpEzw/iWs5d4OazYExmPJiKa6sCeOtf1dXVk2649b6ha/YbvuTBNpSC3CLQLN9RwC
	 ktVqDrhaPWBne5KJz4EBzS91gRwuJZEVr6HvWSkk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSCvG1nxkztFK;
	Tue,  7 Jan 2025 15:23:06 +0100 (CET)
Date: Tue, 7 Jan 2025 15:23:05 +0100
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
Subject: Re: [PATCH v3 18/23] landlock: Log scoped denials
Message-ID: <20250107.itheepai4Eri@digikod.net>
References: <20241122143353.59367-19-mic@digikod.net>
 <1372f9de0bb265a08114a870ec086da0@paul-moore.com>
 <20250106.ohHi4La0ahTh@digikod.net>
 <CAHC9VhQsUkthgGpoNZZdXGcPS9zF2aijYfKfuNYCZB08N=UDKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQsUkthgGpoNZZdXGcPS9zF2aijYfKfuNYCZB08N=UDKg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jan 06, 2025 at 05:33:07PM -0500, Paul Moore wrote:
> On Mon, Jan 6, 2025 at 9:51 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Sat, Jan 04, 2025 at 08:23:53PM -0500, Paul Moore wrote:
> > > On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > > >
> > > > Add audit support for unix_stream_connect, unix_may_send, task_kill, and
> > > > file_send_sigiotask hooks.
> > > >
> > > > Audit event sample:
> > > >
> > > >   type=LL_DENY [...]: domain=195ba459b blockers=scope_abstract_unix_socket path=00666F6F
> > >
> > > Similar to 17/23, I believe the SOCKADDR record should already capture
> > > the socket address information.
> >
> > This might not be the case, which is why SELinux and others explicitly
> > log it I guess.
> 
> I think I may be misunderstanding you, can you point to the section of
> SELinux code that you are referring to in your comment?

I'm refering to struct lsm_network_audit, and the related information
ending in the logs with LSM_AUDIT_DATA_NET.  Landlock follows the
current implementations, hence the generalization brought by the second
patch with audit_log_lsm_data().
