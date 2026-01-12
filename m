Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250033E377
	for <linux-security-module@vger.kernel.org>; Mon, 12 Jan 2026 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251196; cv=none; b=RRPtwkXrrI6QVF/pgGfZl7lHKgRIeIF7sRUH0EqrOjnzt+R72K88lq5FCjvH7FHFzBR/11i6dyPTdwptHUUwsh5KhAu9JqRJyExkghi9CXkQhfW8THWEABLu+t3PLuXTMmpv1X6VQQNWBRRVLVVH4YVa1SC/ahGNBikUznOLr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251196; c=relaxed/simple;
	bh=2f2JZeVGWCW6MseXjXSM2VcjS00tFAddsU9KnOxeaeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frBmUgbvFnF+0GUx6X+wp+CnP3eqqnL/Z7fYlSXI/2v9irmJfgjoJYhhqJz/UowGnev50WWATQdr34A8K5NdxIhJnPrzGFc8JL2kM6qXdeMY7+xycDPtrdZ95DTi4NrgvphxoBfxlXRYkT+bpKm1jX+KSwcBlmm2IXTY+bhgqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmqqOUJV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmqqOUJV"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so9965995a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jan 2026 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768251193; x=1768855993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6OT3Y3o4F52r4hCTWjlx3c+S7vYLsCoyZBNF3ULoc70=;
        b=ZmqqOUJV3X4LwHQxNm8JyRT7XheHOLOiUMapGQm5tXtgKc6nTwL/WpYMIbItzhDfU5
         /PYgYwSCSS4HqX9AvO4rPpGUQG7i4mfjhLxF76XAQVjRFArkHy71TfKalx92+vmjizd+
         A14VTTVd/ZlpZQ7/VQHOlxWAY5JKT4d0t5vqXOJsD2FOqvfsUsP7s4/n8mKQjTliAP2j
         7tzNE9ORpaRh4bJksOFKWO1Jx/GOmqBYd4DCLEwJ7rod+la7BFVGABLTZ7+7p4EX1n+/
         KW+LnP/Uy5M1Ovz5Ytb7jcPSslxAlC1yNiS84dInO2hgiBSzhZYCO9G6ATEYq/FIaaZZ
         kA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768251193; x=1768855993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OT3Y3o4F52r4hCTWjlx3c+S7vYLsCoyZBNF3ULoc70=;
        b=lsesAnMVWZxOSGXFAULhJ6UBBqIBgtipZUlGtnh7DzOJcNCehBioOATE26/uqaL6iJ
         SHQjQMit+LOKWZbkl2sAkaVSnIWw+qw1g7MhmpYl+AS8UvF4QCanaJ+fX9DnO/XtcZCJ
         P+du2bz3bGvNQKESXcdb+hkbw4YV7KM/sSp0Wx5DcmwnSrMugXSRP43+25iB6ihU6iB6
         ng+tph9o+Uc/Ns0k18sRBonlCaYNJWkMlnNLH37zTqUDqdHFA/lVq1lA6zs4pLDy59/E
         hvJmenzgvAMCqwk6Iq3nqQWXc5bdWiDA9Ryk4sfwRDXsM0FIjPDa9iMWq3/0USGC5hCT
         BFSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6CwTJ3SXHQSA77IfVC/55aslxdlhpfl7KsMVQawhCmhxqF9TK3IUuuOCEplz0bCM8FR2dxU+GA1Je/Jk37mmsTHguyFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEKyNTYar0DMQCQvXF5EEZjHoItyXanydd/n1+StQov0zzkek
	JEUaX4Eyexq+RafgSz8fIlXYRNPZcMgSZtN/bq21JoFFIkQvJmyLjEwEntTuhjzk
X-Gm-Gg: AY/fxX456EDx8ZUBgrvrTwyIWObcaCEFjZm6AlGnaidqeFYcPlDmLB9JFWIfn2Goe28
	Y8ICgTWgDFFVSZE5rRv9SQlCZv6gTYibGRB4qomfzjDV06aU9mez2WgVa279rCGLjr2q2mVkamX
	EXs/sf8vUIQTp99Zz4seQMCxePTCSXXSe26tU8xAYNZbkJ4zK3tdNDw9aTMyQl/HBqFuteTgexx
	g6eqaSs2TmrtugTN4WNZsR6cqr11iTYjVrzD+dE0OHO/4TYQxvP2r2EFszkPBRVAt/4txVAO9fT
	NPLNk9e8jZCrQHtCeEe2D3krNF2unFC0G0UEv45ym6jWcaXntjEQsWhpEJB8C2Xycm6Qsln95Hf
	MutU+bP2ZrTYJKX2o9bKFhsw1xc4YjfBHwYZqbKbiv37wI/qncQCLFSEu87hN+e+tWCstar0F2S
	HIhDRdgGnDU35u7bfMgby0pbWLnAQr4fPk2w+V
X-Received: by 2002:a17:907:9404:b0:b87:17f6:6f12 with SMTP id a640c23a62f3a-b87355c8cf1mr65261766b.1.1768251193006;
        Mon, 12 Jan 2026 12:53:13 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d1c6csm1959967466b.39.2026.01.12.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:53:12 -0800 (PST)
Date: Mon, 12 Jan 2026 21:53:08 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260112.a7f8e16a6573@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260112.Wufar9coosoo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112.Wufar9coosoo@digikod.net>

Thanks for the review!

On Mon, Jan 12, 2026 at 05:08:02PM +0100, Mickaël Salaün wrote:
> On Sat, Jan 10, 2026 at 03:32:55PM +0100, Günther Noack wrote:
> > ## Alternatives and Related Work
> > 
> 
> > ### Alternative: Use existing LSM hooks
> > 
> > The existing hooks security_unix_stream_connect(),
> > security_unix_may_send() and security_socket_connect() do not give
> > access to the resolved file system path.
> > 
> > Resolving the file system path again within Landlock would in my
> > understanding produce a TOCTOU race, so making the decision based on
> > the struct sockaddr_un contents is not an option.
> > 
> > It is tempting to use the struct path that the listening socket is
> > bound to, which can be acquired through the existing hooks.
> > Unfortunately, the listening socket may have been bound from within a
> > different namespace, and it is therefore a path that can not actually
> > be referenced by the sandboxed program at the time of constructing the
> > Landlock policy.  (More details are on the Github issue at [6] and on
> > the LKML at [9]).
> 
> Please move (or duplicate) this rationale in the patch dedicated to the
> new hook.  It helps patch review (and to understand commits when already
> merged).

Justin, would you like to look into this?
Please feel free to copy the wording.


> > ### Related work: Scope Control for Pathname Unix Sockets
> > 
> > The motivation for this patch is the same as in Tingmao Wang's patch
> > set for "scoped" control for pathname Unix sockets [2], originally
> > proposed in the Github feature request [5].
> > 
> > In my reply to this patch set [3], I have discussed the differences
> > between these two approaches.  On the related discussions on Github
> > [4] and [5], there was consensus that the scope-based control is
> > complimentary to the file system based control, but does not replace
> > it.  Mickael's opening remark on [5] says:
> > 
> > > This scoping would be complementary to #36 which would mainly be
> > > about allowing a sandboxed process to connect to a more privileged
> > > service (identified with a path).
> > 
> > ## Open questions in V2
> > 
> > Seeking feedback on:
> > 
> > - Feedback on the LSM hook name would be appreciated. We realize that
> >   not all invocations of the LSM hook are related to connect(2) as the
> >   name suggests, but some also happen during sendmsg(2).
> 
> Renaming security_unix_path_connect() to security_unix_find() would look
> appropriate to me wrt the caller.

Justin, this is also on your commit.  (I find security_unix_find() and
security_unix_resolve() equally acceptable options.)


> > - Feedback on the structuring of the Landlock access rights, splitting
> >   them up by socket type.  (Also naming; they are now consistently
> >   called "RESOLVE", but could be named "CONNECT" in the stream and
> >   seqpacket cases?)
> 
> I don't see use cases where differenciating the type of unix socket
> would be useful.  LANDLOCK_ACCESS_FS_RESOLVE_UNIX would look good to me.

I did it mostly because it seemed consistent with the TCP and (soon)
UDP controls, which are also controls specific to the socket type and
not just the address family.  But I agree that the granularity is
likely not needed here.  I can change it back for v3 and rename it to
LANDLOCK_ACCESS_FS_RESOLVE_UNIX.


> What would be the inverse of "resolve" (i.e. to restrict the server
> side)?  Would LANDLOCK_ACCESS_FS_MAKE_SOCK be enough?

Yes, that would be enough. My reasoning is as follows:

The server-side operation that is related to associating the service
with a given file system name is bind(2), and that is restrictable in
that case using LANDLOCK_ACCESS_FS_MAKE_SOCK.

Also, to my delight (and other than in TCP), listening on an unbound
socket does not work (see unix_listen() in af_unix.c):

  if (!READ_ONCE(u->addr))
  	goto out;	/* No listens on an unbound socket */

(You can get it to "autobind" during an explicit bind() or a connect()
call, but that creates an abstract UNIX address. (Documented in
socket(7) and implemented in unix_autobind() in af_unix.c))


–Günther
