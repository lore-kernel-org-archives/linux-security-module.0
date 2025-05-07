Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD14290D97
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655821; cv=none; b=lC85g7qwSwRtUqm9HqM7wdHWB/ivIGLN1/aUzL/1P64tV9jXiKE80Lzwpl/BJTEPupT+tBhHPRuIXVlJwxRZ3Dwqk+t4d1wZ8nS86DUFBqS0aRBNSS3c9ohQVDbOcOm+nN4NZBd8LLAoiCspnyV7r34FhFpnu5HFhJVhcKbjFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655821; c=relaxed/simple;
	bh=dYo9vKzMaOxJPsZQzZ1VgsSgO28N/5CS+Q0P9XJ9lsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYvKGEj1bSepvKqMO/oZYNKtnEnJDacO5PQW3u7diXHCdZar5wZbGRPMdm5iPllzBFPAR2xy2oArunqmcUEZIs9Ala+xOdswL27XF+XCkIoTj4FwvlzF4VuS+P+tx7HGILP1ToHFlKg+Rf7xGlaUsXpxZhVCc4oQsra8N1ObyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GqsA1WJ6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GqsA1WJ6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-708ac7dfc19so3375197b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746655817; x=1747260617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIiUIWqYEojG1+/v0+6p5gp77rijVYSqMC0AzSN7lbc=;
        b=GqsA1WJ6PS9iRQmZn3hhsGc7s6WkiSTFhvG9wcx4JpsRJFyhBpblYpzmUTF0ZjuIKU
         A2jQIZAcaF7WR/rPStJx1kjs6xWFIPhUFeBpu6fmW+kb/gT+72vV0y6FjhnFmDkznZvM
         7H7/QdM6SovoqDrjHTE1GdJXP1ChjebX832lAYptiLg37t5H4o0mdIsz/ZQg9IFUjHeF
         7+JQOdL4e81gVUv9mo7cKn8HQ7GWBn9cWMdwVnGlq5qoTeX2EvpuxeotchBB3NJmkBwb
         rXdqseHK5HlUKJ/lVLbQOXCJexqdCJ5Bvuu/N7MI+Hx477SHUa6Ui6bMHtIWS1VjlVP2
         6nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746655817; x=1747260617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIiUIWqYEojG1+/v0+6p5gp77rijVYSqMC0AzSN7lbc=;
        b=cMv36y3w/boMxoew8vatmYfm39ewLT+lL2Ccp22eJbPok6CdzzohSwApNvx3jkjK9D
         UPy8RGPtS7HwiDzpYIjgDGOYe9k/S7C0KA6pIU9jJAUK+cVn/DUM9hU84qZNulMcKjWy
         CbmDyVDSe5H1psPbuXws7i3PdJy9ukcHqFzp9Xova2SWQjLH+UZU6EGquCd2qc+1ilJH
         8aPWkhmsf7wle7TmUIEqSQ3KutIMwtvrNf2iqAwWdgN74fTJWXskh8xxvzrEcQv8iMiC
         5rCZepdbO+qdsYdbUjM65Mir0Fdd7ct1oXWpinqe00qRifn3N++3c1jmcQD4AmtRUlsO
         G0xg==
X-Forwarded-Encrypted: i=1; AJvYcCWbXIatrkMBpt6hKUA6rKvYugatqz1PfeBRSOfFUabyPQYSHW62ZeYRepDpSMQ5HoLifBL0N7ObLm8ccpZyHDW8fHTVbak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehstVr9rIEi//903LPssSyMs0mNKKC6cj3RBYhU7SFyRVz8Zp
	L9MTu4xI7H5Mnmauw+rrp8YGzZcN/hiarrCqVVcxxpl4IhQseJfmqL+sWe781prBqkid3ALIlyn
	JoMHymKBPXBwdj+LeFod9Jfu9Sqmwo/I94jNE
X-Gm-Gg: ASbGncvytigNFFA01RzMMsWg5D/E+uNE2+k4L8YkSbWsk2M0IBncQLua0Hn5coL6mWy
	11Y/40TRaus8I4xH6OeuSluSBBty9ZgNEHIsbVQb6CQbptcvAijCKeLE72Hf1qvykWvaEWWLQ4f
	45yz00PFN920OpE77rP0sTAw==
X-Google-Smtp-Source: AGHT+IFwYzZ6ciK23Fz2b2pczQZhzZY0A6NhOxfiU/PHNVse4rkWHp1PgMap3HM1k4CDsvnj/47dt1VxNlD3Nz4tgQ4=
X-Received: by 2002:a05:690c:4988:b0:6f9:ad48:a3c7 with SMTP id
 00721157ae682-70a2cf202f3mr19770607b3.21.1746655816808; Wed, 07 May 2025
 15:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-zugabe-bezog-f688fbec72d3@brauner> <20250506191817.14620-1-kuniyu@amazon.com>
 <20250507.ohsaiQuoh3uo@digikod.net>
In-Reply-To: <20250507.ohsaiQuoh3uo@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 May 2025 18:10:06 -0400
X-Gm-Features: ATxdqUHq8EdIoIcW3r6G08_e5ZHNIf6QppZcl2fZN3xKRzQTjRIXJBOvas1ean0
Message-ID: <CAHC9VhSXU3yPa6QiFtUpqUpmsAeyhN7jLJDFC_rZ=oRZarZijA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, brauner@kernel.org, alexander@mihalicyn.com, 
	bluca@debian.org, daan.j.demeyer@gmail.com, davem@davemloft.net, 
	david@readahead.eu, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	jannh@google.com, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:54=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Tue, May 06, 2025 at 12:18:12PM -0700, Kuniyuki Iwashima wrote:
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Tue, 6 May 2025 10:06:27 +0200
> > > On Mon, May 05, 2025 at 09:10:28PM +0200, Jann Horn wrote:
> > > > On Mon, May 5, 2025 at 8:41=E2=80=AFPM Kuniyuki Iwashima <kuniyu@am=
azon.com> wrote:
> > > > > From: Christian Brauner <brauner@kernel.org>
> > > > > Date: Mon, 5 May 2025 16:06:40 +0200
> > > > > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > > > > On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <bra=
uner@kernel.org> wrote:
> > > > > > > > Make sure that only tasks that actually coredumped may conn=
ect to the
> > > > > > > > coredump socket. This restriction may be loosened later in =
case
> > > > > > > > userspace processes would like to use it to generate their =
own
> > > > > > > > coredumps. Though it'd be wiser if userspace just exposed a=
 separate
> > > > > > > > socket for that.
> > > > > > >
> > > > > > > This implementation kinda feels a bit fragile to me... I wond=
er if we
> > > > > > > could instead have a flag inside the af_unix client socket th=
at says
> > > > > > > "this is a special client socket for coredumping".
> > > > > >
> > > > > > Should be easily doable with a sock_flag().
> > > > >
> > > > > This restriction should be applied by BPF LSM.
> > > >
> > > > I think we shouldn't allow random userspace processes to connect to
> > > > the core dump handling service and provide bogus inputs; that
> > > > unnecessarily increases the risk that a crafted coredump can be use=
d
> > > > to exploit a bug in the service. So I think it makes sense to enfor=
ce
> > > > this restriction in the kernel.
> > > >
> > > > My understanding is that BPF LSM creates fairly tight coupling betw=
een
> > > > userspace and the kernel implementation, and it is kind of unwieldy
> > > > for userspace. (I imagine the "man 5 core" manpage would get a bit
> > > > longer and describe more kernel implementation detail if you tried =
to
> > > > show how to write a BPF LSM that is capable of detecting unix domai=
n
> > > > socket connections to a specific address that are not initiated by
> > > > core dumping.) I would like to keep it possible to implement core
> > > > userspace functionality in a best-practice way without needing eBPF=
.
> > > >
> > > > > It's hard to loosen such a default restriction as someone might
> > > > > argue that's unexpected and regression.
> > > >
> > > > If userspace wants to allow other processes to connect to the core
> > > > dumping service, that's easy to implement - userspace can listen on=
 a
> > > > separate address that is not subject to these restrictions.
> > >
> > > I think Kuniyuki's point is defensible. And I did discuss this with
> > > Lennart when I wrote the patch and he didn't see a point in preventin=
g
> > > other processes from connecting to the core dump socket. He actually
> > > would like this to be possible because there's some userspace program=
s
> > > out there that generate their own coredumps (Python?) and he wanted t=
hem
> > > to use the general coredump socket to send them to.

From a security perspective, it seems very reasonable to me that an
LSM would want to potentially control which processes are allowed to
bind or connect to the coredump socket.  Assuming that the socket
creation, bind(), and connect() operations go through all of the
normal LSM hooks like any other socket that shouldn't be a problem.
Some LSMs may have challenges with the lack of a filesystem path
associated with the socket, but abstract sockets are far from a new
concept and those LSMs should already have a mechanism for dealing
with such sockets.

I also want to stress that when we think about LSM controls, we need
to think in generic terms and not solely on a specific LSM, e.g. BPF.
It's fine and good to have documentation about how one might use a BPF
LSM to mitigate access to a coredump socket, but it should be made
clear in that same documentation that other LSMs may also be enforcing
access controls on that socket.  Further, and I believe everyone here
already knows this, but just to be clear, the kernel code should
definitely not assume either the presence of a specific LSM, or the
LSM in general.

> > > I just found it more elegant to simply guarantee that only connection=
s
> > > are made to that socket come from coredumping tasks.
> > >
> > > But I should note there are two ways to cleanly handle this in
> > > userspace. I had already mentioned the bpf LSM in the contect of
> > > rate-limiting in an earlier posting:
> > >
> > > (1) complex:
> > >
> > >     Use a bpf LSM to intercept the connection request via
> > >     security_unix_stream_connect() in unix_stream_connect().
> > >
> > >     The bpf program can simply check:
> > >
> > >     current->signal->core_state
> > >
> > >     and reject any connection if it isn't set to NULL.
> > >
> > >     The big downside is that bpf (and security) need to be enabled.
> > >     Neither is guaranteed and there's quite a few users out there tha=
t
> > >     don't enable bpf.
>
> The kernel should indeed always have a minimal security policy in place,
> LSM can tailored that but we should not assume that a specific LSM with
> a specific policy is enabled/configured on the system.

None of the LSM mailing lists were CC'd so I haven't seen the full
thread yet, and haven't had the chance to dig it up on lore, but at
the very least I would think there should be some basic controls
around who can bind/receive coredumps.

--=20
paul-moore.com
