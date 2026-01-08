Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87C35580D
	for <linux-security-module@vger.kernel.org>; Thu,  8 Jan 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867447; cv=none; b=AvAx+0DS8Ubghpq6fSgcvsPS+V0TVsN3e7mCIWF6c4n0C2xzdzmtAKeZvl+Zb+rSv538ERlzW9CCWrGk4M5gZdTSBZwlRcFiZrTyPY3IQFGt3uL0QyBowdmKIDmqve/0UG0HT6vqJVKkkUWT3XXrO9fLoN9NV7PQPBs20cpaZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867447; c=relaxed/simple;
	bh=Ogh8tAOoOjINkJI4yg6EZF9WR+UCZs8B5H9QpYxebYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoPxqqpb7YLIVUIq1zDr0B0GyJnv7Ze3/ymqUNWp8PJJeKJ8BVGFqTLGPErXcubOJv1iBsOwxf3BWSZI6ZcGWxLHaKdtPH4s80Ze8mGwBpJIUsCq41rRg7z+vpHXpuxXei1DjdLV81w1uiJVYO/HOft8ILR6zs1I+s8s5l0qAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WW/z2JSe; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WW/z2JSe"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f3a10dcbbso2287565c88.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Jan 2026 02:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767867437; x=1768472237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ1fs3Ohphla2JOGra+RJtxs+PcO1u7EwjOa/BB89TI=;
        b=WW/z2JSejySQzKm0tAXNzhnxRVch7X7N50GYxAXZbi5y5dCU/RvVSYI97dMly4SWS0
         vRHLhdojmEfx2ZSN/TsEbgGMikmjXx9YlYHLohotcQ3P7LVcH83sIiNyf7mXGTXAxTIu
         fy+6JMK5DXstvnlJfgofzMVU2iEJTtRwmcyYpv30hzNtyGZwiemTlUnV19Fwa3p/LYgY
         RzFJoHW9F8Im6ZL5RVn4g+EHaait+6HDVkVA0xiQoMmK/DATD0eaIr/uLJt+3ZL1duTD
         3Hsj9LRPANhjxy3+TmW+uYMgl/xA4v9yAWmGz/SY0KVuC9tdVAIgedTW/HrCocGBipIg
         H5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867437; x=1768472237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ1fs3Ohphla2JOGra+RJtxs+PcO1u7EwjOa/BB89TI=;
        b=PixWFDLV+IIWBRhMs+IrtReH4g1I2V+ieA2simRF40Hk73HRAKh/8pySDwBfeygV5w
         VgyM1qoWrq5M4MfLrRq2ASfU0guxu3WPZNRv957t5XweyvZ+61RecoJVeC+lK1gVEY6H
         jH+3c6uQkxuv71QUfkwSTYAQ+HNY0D5DpXeQL9uPEArZQJLERfRylVpctqIyzRHa24GI
         O95MRBVBm+DTNgbDIKFomguLSnZxy35+pDYO2WxBgg6mvf3zFV7dMtViHBFI9S6QUqPV
         3Y+yTWdq2bpBdu6qHsu8iBQHZwqhYgzXOJlPkXrC/2tyfXyfs7SVuz8Y0h8gYwJMIFd3
         LeBw==
X-Forwarded-Encrypted: i=1; AJvYcCUkGLyynt40sjeqW6AQphbbPHujTJQpjAYoAIMWdlmrBIWvJmGr1PEtRKyxfMK+jFHqiffLW3qUt0/Hs3JpM+8uVIkYM80=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBJNR6GiFSbHZceuXH7hmFUvMx31mKUvU0RXNFcOQm9m3md3B
	16krBLrF6CuYa7rbknOSW1O1DYodkF0/4ZAgwBuybsfJVLFd94lGgyGjc5ayAS98TNA/SfwZc28
	9CoVIuOmsTLCmFpEaq3v2zAJ7K2N52VrSKpI3iOSO
X-Gm-Gg: AY/fxX6X++JOvucqeo1H+glhFK5QlZlWTWB4QYhpsYYTbcMnNa58RyDwAnLta+ZhKXT
	/SEJ0Y+/OGLKa3SBaDdBjXSbjlT1W7C1iehpRNSSmb8ufulFiIncNrYXvd6HieS+v1XS+yDsp96
	Gy3jyEzrw65TtjbO0V4p9ZiPRTJz5LdSF23v7T6F90LB5ezHxh0TLHQc57tPAug1wRM73Bjj1Q+
	phZosgwLMiWLeE91l2QrvV2/V68eYp6EaoIPopn29hbWvzBPdj7z51mSGpYQS5+0BTG8ShXo7cw
	0+NeHHaDxnPWdLqNN6EP/g7wRYLcbA==
X-Google-Smtp-Source: AGHT+IEMMbaQfZ7lBCEbNvFvi7mbfGcSl9hnMwuZ0q+ABdPgHEIYL9VhTGNA99HN668kF16xmTxfRs7XrSrMkqOwvT8=
X-Received: by 2002:a05:7022:23a5:b0:11a:c8f4:3216 with SMTP id
 a92af1059eb24-121f8b14c84mr4064588c88.15.1767867436254; Thu, 08 Jan 2026
 02:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com> <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
 <aV5WTGvQB0XI8Q_N@google.com>
In-Reply-To: <aV5WTGvQB0XI8Q_N@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 8 Jan 2026 02:17:05 -0800
X-Gm-Features: AQt7F2rdIe6CkrQHtb0o9QvKbxRtFU-yNoPsYBohXhvgwop6uzgiOI8WxkEiNf4
Message-ID: <CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:49=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> On Tue, Jan 06, 2026 at 11:33:32PM -0800, Kuniyuki Iwashima wrote:
> > +VFS maintainers
> >
> > On Mon, Jan 5, 2026 at 3:04=E2=80=AFAM G=C3=BCnther Noack <gnoack@googl=
e.com> wrote:
> > >
> > > Hello!
> > >
> > > On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> > > > On Wed, Dec 31, 2025 at 1:33=E2=80=AFPM Justin Suess <utilityemal77=
@gmail.com> wrote:
> > > > > Motivation
> > > > > ---
> > > > >
> > > > > For AF_UNIX sockets bound to a filesystem path (aka named sockets=
), one
> > > > > identifying object from a policy perspective is the path passed t=
o
> > > > > connect(2). However, this operation currently restricts LSMs that=
 rely
> > > > > on VFS-based mediation, because the pathname resolved during conn=
ect()
> > > > > is not preserved in a form visible to existing hooks before conne=
ction
> > > > > establishment.
> > > >
> > > > Why can't LSM use unix_sk(other)->path in security_unix_stream_conn=
ect()
> > > > and security_unix_may_send() ?
> > >
> > > Thanks for bringing it up!
> > >
> > > That path is set by the process that acts as the listening side for
> > > the socket.  The listening and the connecting process might not live
> > > in the same mount namespace, and in that case, it would not match the
> > > path which is passed by the client in the struct sockaddr_un.
> >
> > Thanks for the explanation !
> >
> > So basically what you need is resolving unix_sk(sk)->addr.name
> > by kern_path() and comparing its d_backing_inode(path.dentry)
> > with d_backing_inode (unix_sk(sk)->path.dendtry).
> >
> > If the new hook is only used by Landlock, I'd prefer doing that on
> > the existing connect() hooks.
>
> I've talked about that in the "Alternative: Use existing LSM hooks" secti=
on in
> https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
>
> If we resolve unix_sk(sk)->addr.name ourselves in the Landlock hook
> again, we would resolve the path twice: Once in unix_find_bsd() in
> net/unix/af_unix.c (the Time-Of-Use), and once in the Landlock
> security hook for the connect() operation (the Time-Of-Check).
>
> If I understand you correctly, you are suggesting that we check that
> the inode resolved by af_unix
> (d_backing_inode(unix_sk(sk)->path.dentry)) is the same as the one
> that we resolve in Landlock ourselves, and therefore we can detect the
> TOCTOU race and pretend that this is equivalent to the case where
> af_unix resolved to the same inode with the path that Landlock
> observed?
>
> If the walked file system hierarchy changes in between these two
> accesses, Landlock enforces the policy based on path elements that
> have changed in between.
>
> * We start with a Landlock policy where Unix connect() is restricted
>   by default, but is permitted on "foo/bar2" and everything underneath
>   it.  The hierarchy is:
>
>   foo/
>       bar/
>           baz.sock
>       bar2/        <--- Landlock rule: socket connect() allowed here and =
below
>
> * We connect() to the path "foo/bar/baz.sock"
> * af_unix.c path lookup resolves "foo/bar/baz.sock" (TOU)
>   This works because Landlock is not checked at this point yet.
> * In between the two lookups:
>   * the directory foo/bar gets renamed to foo/bar.old
>   * foo/bar2 gets moved to foo/bar
>   * baz.sock gets moved into the (new) foo/bar directory
> * Landlock check: path lookup of "foo/bar/baz.sock" (TOC)
>   and subsequent policy check using the resolved path.
>
>   This succeeds because connect() is permitted on foo/bar2 and
>   beneath.  We also check that the resolved inode is the same as the
>   one resolved by af_unix.c.
>
> And now the reasoning is basically that this is fine because the
> (inode) result of the two lookups was the same and we pretend that the
> Landlock path lookup was the one where the actual permission check was
> done?

Right.  IIUC, even in your patch, the file could be renamed
while LSM is checking the path, no ?  I think holding the
path ref does not lock concurrent rename operations.

To me, it's not a small race and basically it's the same with
the ops below,

sk1.bind('test')
sk1.listen()
os.rename('test', 'test2')
sk2.connect('test2')

sk1.bind('test')
sk1.listen()
sk2.connect('test1')
os.rename('test', 'test2')

and the important part is whether the path _was_ the
allowed one when LSM checked the path.

>
> Some pieces of this which I am still unsure about:
>
> * What we are supposed to do when the two resolved inodes are not the
>   same, because we detected the race?  We can not allow the connection
>   in that case, but it would be wrong to deny it as well.  I'm not
>   sure whether returning one of the -ERESTART* variants is feasible in
>   this place and bubbles up correctly to the system call / io_uring
>   layer.

Imagine that the rename ops was done a bit earlier, which is
before the first lookup in unix_find_bsd().  Then, the socket
will not be found, and -ECONNREFUSED is returned.
LSM pcan pretend as such.


>
> * What if other kinds of permission checks happen on a different
>   lookup code path?  (If another stacked LSM had a similar
>   implementation with yet another path lookup based on a different
>   kind of policy, and if a race happened in between, it could at least
>   be possible that for one variant of the path, it would be OK for
>   Landlock but not the other LSM, and for the other variant of the
>   path it would be OK for the other LSM but not Landlock, and then the
>   connection could get accepted even if that would not have been
>   allowed on one of the two paths alone.)  I find this a somewhat
>   brittle implementation approach.

Do you mean that the evaluation of the stacked LSMs could
return 0 if one of them allows it even though other LSMs deny ?


>
> * Would have to double check the unix_dgram_connect code paths in
>   af_unix to see whether this is feasible for DGRAM sockets:
>
>   There is a way to connect() a connectionless DGRAM socket, and in
>   that case, the path lookup in af_unix happens normally only during
>   connect(),

Note that connected DGRAM socket can send() data to other sockets
by specifying the peer name in each send(), and even they can
disconnect by connect(AF_UNSPEC).


> very far apart from the initial security_unix_may_send()
>   LSM hook which is used for DGRAM sockets - It would be weird if we
>   were able to connect() a DGRAM socket, thinking that now all path
>   lookups are done, but then when you try to send a message through
>   it, Landlock surprisingly does the path lookup again based on a very
>   old and possibly outdated path.  If Landlock's path lookup fails
>   (e.g. because the path has disappeared, or because the inode now
>   differs), retries won't be able to recover this any more.  Normally,
>   the path does not need to get resolved any more once the DGRAM
>   socket is connected.
>
>   Noteworthy: When Unix servers restart, they commonly unlink the old
>   socket inode in the same place and create a new one with bind().  So
>   as the time window for the race increases, it is actually a common
>   scenario that a different inode with appear under the same path.
>
> I have to digest this idea a bit.  I find it less intuitive than using
> the exact same struct path with a newly introduced hook, but it does
> admittedly mitigate the problem somewhat.  I'm just not feeling very
> comfortable with security policy code that requires difficult
> reasoning. =F0=9F=A4=94 Or maybe I interpreted too much into your suggest=
ion. :)
> I'd be interested to hear what you think.
>
> =E2=80=94G=C3=BCnther
