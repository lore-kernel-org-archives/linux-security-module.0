Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275869;
	b=uir33+CDMb/SNlaXzWvZDiFI+ljiok3nMfBtJrWNI8vAeoUb4GvxZfpgG5Uq0xdJ8wdO
	 LWVmIfPhz4PHsP6+D5URv88F3dHLIZv27PPEOQvdr3UMczGN3wkMLaGPHrjuu+HOodDfB
	 QbZ3yNjdMTowfD95UjPHJ3lXyCBfkDU98ncNd1TrlrQqHVIXM5kyzvhcdEa/GZwwXIv9y
	 hIzS+luoZv2+ly8u4pmVmKcb5eRUB9g2SMRS1jvsUH+/IqI7+ysDYG2SYn5CFEpml+P1k
	 p3y0vv5rvo5M7SiWStYVnlyCS5XZ3yg+/oN2gFxNjeOLD7ZsOfxwBC8k2eEXkHBJg5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=8Jb0QjN+ngY6etMxQOZMOoIlhB+546T+PND1NORcPzA=;
	b=0YuyHOnfhBnZv55I4xp5Y2XmbtSwy4gXRIkf8KsfsNWyp/2lTpNBO09FmV/9fMrZsP5l
	 tZ9+SIANF6+ssNkhX5GxPvXCVv3UjhPvUIrMIybn0WeKzbzIvhDHzDM0qhcZ56RKbUBU5
	 9HgeRBzjwy2VEbE2WHVmu3qIVkbQc9fZ7hdPfDrl3ayC/GkQkx/CsY7pWLrStD0eXoVq6
	 zQjwOUhyRxbThRk0hrZnw91fBNoxzSblUK1BLMW9EwkdeEuw1tFzzval74m7JtU263xv5
	 Ib90xPOq8kJeXhGV/mKj3in0dB2iIx710xRRpJF4bAPsRYYBItfdXS//t1VZGwX14Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Jlnl/QUT";
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE33606A323
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 12:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE33606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jlnl/QUT
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4048584447so165199866b.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793275867; x=1793880667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Jb0QjN+ngY6etMxQOZMOoIlhB+546T+PND1NORcPzA=;
        b=Jlnl/QUTtPccNXi+ZNNtbAqFpxXTju7rbaudqoEAepuOGdczXzyFQiuTlvKV9TRJFk
         Fp6YrBzWkmYN3bqS/G8vDFtnVhiAlhRXvYxV7V3Wg4R2R56JN4EzGTkxQscvA2DHXocH
         xqv3pRmejhrrxLL6D1jiPl6quIY++yph2+5UyvcgdWP33jRH+zU9UlGvQGFJZw9M4vFC
         ah2J/703hoBaTXZRxbDhVBoL5SfyHkCEuaYbCEzb9LGTWdPAX6cLywrWb24VDZrVPpED
         i84/UyEbcaXba0ha2kGdCV6YnJ0ZZq2iJ/jvKqL+jER6wtiVUy1Jw/OVcWsxlFH9UdV/
         cpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275867; x=1793880667;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Jb0QjN+ngY6etMxQOZMOoIlhB+546T+PND1NORcPzA=;
        b=RbgIhpX8FcKUKsmr3Q17r/DGHzd3SXxHSfrFjit4W7+pFxzJ79nToqmY6y0q535APs
         f6vRJ1ZaKu9hzhM5uMzh6ki/y9vGAGE/3v6v6ID7dCnx4CHSdZIBul45krDuh7irap7o
         Jy4GZCBp+gzNxgQKZETf+6UZ/hoU7eiW92dvroWxCuZGVVk6QxhBfJX5/JVZklPTe7wN
         fT1pkyRPFK7VWO7EWThBckktR+4RFu0okSaXsBa8tkRbSAboyrIv+Lha0HbwQEgUAKSD
         H29Du3ia1ZFInJxvMuLUIyW+/kYEhoP1SO9R9KR/eb/Q/07n2+CHNzm4Z3Vk9ejECC8Y
         5RbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO9fk0sNRPaocR9K9yHLUOw/p34uCQUwj/BjfbXwybQsJEXnbmgX6nxd6oXX+dL7RZKcZQFeV9WGL4aJu3r92IulQkDyU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwC8oAAMeZmDIOBo9vOAfcJ61dXxuXfJ2L554+PuMWqxQOXKO4
	nnBNZEZtRENJpPevPgXTrzfPAkumCrP0TqLw3HcYQvrH/gJKPIhtJ+k6RQzAN3ds8N5SaPqS7w=
	=
X-Received: from ejoy1.prod.google.com ([2002:a17:906:4481:b0:c49:cd3a:2b6e])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:ecc5:b0:c49:d058:6901
 with SMTP id a640c23a62f3a-c49d05873a3mr206311266b.38.1793275866775; Thu, 29
 Oct 2026 05:11:06 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:11:06 +0000
In-Reply-To: <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
Message-ID: <auM32mOlBLu6ZUlt@google.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Calmels <jcalmels@3xx0.net>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, containers@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 28, 2026 at 3:18=E2=80=AFPM Hallgrimur H. Gunnarsson
> <halg@google.com> wrote:
> >
> > When an unprivileged process creates a new user namespace, it is grante=
d
> > a full set of capabilities (CAP_FULL_SET) scoped to that namespace.
> > While these capabilities are isolated to the namespace, they allow
> > unprivileged local users to reach deep kernel subsystems (most notably
> > networking configuration and raw sockets via CAP_NET_ADMIN and
> > CAP_NET_RAW) that historically assumed a trusted caller and have
> > accounted for a large share of local privilege escalation
> > vulnerabilities.
> >
> > Many workloads and sandboxes use unprivileged user namespaces strictly
> > for basic UID/GID, mount, PID, or network isolation and never need
> > high-risk capabilities like CAP_NET_ADMIN or CAP_NET_RAW. Likewise,
> > system administrators often want a host-wide policy ceiling restricting
> > which capabilities unprivileged user namespaces may acquire, without
> > disabling unprivileged user namespaces altogether.
> >
> > Prior work by Jonathan Calmels [1] proposed addressing this via a sixth
> > per-thread capability set (cap_userns) alongside a global sysctl mask.
> > During that discussion [1, 2], feedback (e.g. from Casey Schaufler)
> > suggested that rather than adding another per-thread capability set and
> > prctl() interface, capability restrictions could be integrated directly
> > into struct user_namespace and configured via clone3(). At the same
> > time, as noted in [1], a clone3() flag alone is not sufficient for
> > administrators who need to enforce a host-wide ceiling on unprivileged
> > user namespaces without modifying every userspace callsite.
> >
> > This series combines both pieces of feedback: it embeds a capability
> > bounding set (cap_bset) directly into struct user_namespace, reusing
> > the existing task cap_bset, cap_permitted, and cap_effective sets on
> > namespace entry, and provides both a system-wide sysctl ceiling for
> > unprivileged user namespaces and a CLONE_NEWUSER_BSET flag for
> > voluntary per-namespace restriction via clone3().
>=20
> Why should the task's cap masks affect this?  *Maybe* cap_bset makes
> sense, but I'm struggling a bit to see why cap_permitted and
> cap_effective should matter.

Sorry, the phrasing here may have been misleading. Just to clarify:
none of the creating task's capability sets (cap_bset, cap_permitted
or cap_effective) are used to restrict the new user namespace.

When I wrote "reusing the existing task cap_bset, cap_permitted and
cap_effective sets on namespace entry", I was contrasting this with
the prior series from 2024 [1], which proposed adding a 6th per-thread
capability set to struct cred.

In this series, when a task creates or enters a user namespace, we
simply initialize its new cred->cap_{bset,permitted,effective} in
that namespace to user_ns->cap_bset instead of CAP_FULL_SET.

> Also, I think that Docker in non-userns mode restricts cap_bset, and
> the purpose of that restriction is rather at odds with interpreting it
> as a restriction on newly created user namespaces for purposes of
> vulnerability mitigation.

When computing the new user namespace's user_ns->cap_bset in
create_user_ns():

1. The creating task's cred->cap_bset and cred->cap_permitted are not
   consulted at all. The base ceiling is inherited from
   parent_ns->cap_bset (which is CAP_FULL_SET in init_user_ns), not from
   the task's cred->cap_bset. So a non-userns Docker container that
   drops bits from its task cap_bset does not restrict newly created
   user namespaces.

2. The creating task's cred->cap_effective never restricts the new
   user namespace, but it is used as an additive exception to the
   unprivileged sysctl ceiling.

   The rationale is that if an admin restricts e.g. CAP_NET_ADMIN in the
   unprivileged sysctl, an unprivileged daemon that already holds
   effective CAP_NET_ADMIN in the parent namespace is allowed to keep
   it when creating a new user namespace. There is no added attack
   surface if the user already had the capability in the parent ns.

> > In addition, because restricting CAP_NET_ADMIN at user namespace
> > creation time prevents userspace from bringing up the loopback
> > interface in new network namespaces, the series first introduces
> > an opt-in flag to automatically enable loopback on network namespace
> > creation:
> >
> > 1. Opt-in loopback activation on netns creation (Patch 1)
> >
> >   New network namespaces start with the loopback interface (lo) DOWN by
> >   default, requiring CAP_NET_ADMIN over the owning user namespace to
> >   bring it up. To block external network access while preserving
> >   localhost networking, sandboxes commonly create an isolated network
> >   namespace with only the loopback interface enabled.
> >
>=20
> The whole unshare/clone flag situation is getting out of hand, IMO.
> And this new thing makes logical sense but is really about reducing
> exposure.
>=20
> Perhaps we should instead have a small list associated with a userns
> (extensible in the future) of things that the ns's admin (i.e. whoever
> has CAP_SYS_ADMIN relative to the ns) may do.  That list could
> include:
>=20
> - Create loopback with sensible defaults for ipv4 and/or ipv6 (i see
> no obvious reason to separate them)
> - Create tun/tap interfaces in that ns (and attach them, etc)
>=20
> And add a very simple new API to do these things.  Actually, the
> tun/tap could just use the normal mechanism.
>=20
> Thoughts?

I'm not particularly attached to CLONE_NEWNET_LOOPBACK. I'd be happy
with whatever mechanism allows bringing up loopback in a new netns
without granting all of CAP_NET_ADMIN.

The main reason I went for a creation-time flag is that it avoids
needing a separate userspace API call after namespace creation and makes
it simple to get working loopback for sandboxes that want to drop all
capabilities in the new userns from the start, e.g. CLONE_NEWUSER_BSET
with cap_bset =3D 0.

That said, if maintainers prefer not to spend clone/unshare flags on
this, I'm completely open to an alternative mechanism.

Also worth noting that Patch 1 is orthogonal to the rest of the series.
The capability bounding set changes in Patches 2-4 stand on their own
and Patch 1 just makes restricting CAP_NET_ADMIN more practical for
common sandboxing use cases that rely on localhost networking.

