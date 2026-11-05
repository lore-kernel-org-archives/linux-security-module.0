Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897301;
	b=zSeLlB1SDq5nmMZf0XNgvlw1A7j1eL0+Sis7N6ZLD4bSORXvsjXcEpSOzSsZzNPySbwI
	 oWgT8C4QR6Uchs1hR06Czw/aT8RJ+oJo+L39jXpp2B8i1cFhAYTluNyNcQEKtUYbWq/JE
	 ObxFviWvqwUq+1bCEm7p0bJG9WChcUJbmuNib4TP1G7LTVsL7AHYuAy7AfTVClTo0wanq
	 irtedxe/nXvdBE9DIr3KiR8KjiUnDhQzw2RDLYm4/yBZ417g41vRc8WSjLAs1YSAHYV/v
	 jfH0MOynAwdlu1fwnURs87XfQG7YC+BsBacm+wQKwLv1eAXE6j4GBvpiTEf8TUgpMWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VqiTrc04lJztf2dyTmHN89oGm1bJ8PUHM0btmGHDZmI=;
	b=VtlB1LnscOmZWMSRH962wyl5jQj2mmokaQxlnIRqp/ZuZgPZW4kG8Wgef6Uyr0/K0WVA
	 wEBW20zFiqzs9shR37sIwYAgh/t5xKbZfBtlN7Trg035OzZ+CguHc7nSyPNT2xGp1x/4a
	 dGmmAj4+F/d5phTSyTz2dWWug5lVE8KAW3yFrn3z7DZyNR2EALM+Nmo+S8x/POCZiaDzi
	 C2MF9a/tpOOsKPlQdp82eqcNBJcQMra4xsGt+QVBfnnJpqWMFh/m5cLVRPnHtjhFyBOuQ
	 fHpnq+mE9Hw6HFkY/16o6ozIam8EWTXF2jYo3JVfNLa/2XKKPpmKABBz69UuD684VKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PD82jKo7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E4606A330
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 16:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 330E4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PD82jKo7
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-945ae2daa3eso249145185a.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 08:48:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897300; cv=none;
        d=google.com; s=arc-20260327;
        b=CTzxvNekNQ8f0C2k/Gyda/27AK+Lwvl/TqryG7jhMxLG/r4HQIFl/gloiaEOhdRL0z
         FJ6zlfhTNqxUmv1zoBwkCwWbwl3+LsL3G+7NvLaIbXqrQm7crSmzkEm30jWayiHYyI0x
         MOdb9xlV/B45mXEAZ7d4u86k7GBa0DysRhskPqAHj2mSsx3/oUH2Fsy3IWVl88N/9VCQ
         1HtyKiZwdVc8+oIYpvTkWU+A9GsaPrA25WqR61tn6cCZUuJcKwHoRvFX90i+ENBHDk9J
         VGohJCpJXN3p48NW6xBwAWalOF40W0AoYxTtyLHLUlbV22GPlmrnVnS2m7wW0HRpD+ka
         ym8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqiTrc04lJztf2dyTmHN89oGm1bJ8PUHM0btmGHDZmI=;
        fh=3EyOLMLwvl7R2v+epa+P4i3iKXcU92QtlrNV7llNUjA=;
        b=q4vSUb2OY4jQEtXOqrMTR2mJlQowkMyN/06N5HCrX3I0DKyc96Fxw02Hrg8oas6Uvm
         rge39exqn9aLlo8l+br6G1gV2Juycw0lvuEU5UNSsz3pOAdyJlnjNs1j17mP9El2s9+/
         C52lrfj0fsowdmYJq295KZo5+kRZB12bgj93HzPdmDa11OoDXbAZKVpqj/fVhKZLdttg
         YpsKf02D/0iPDpaKfNc1EyoI0jNrFPlyYHO0ZzHcpG2I3RpSxkYjlLXRbM+OlehybzVd
         3cLm9Md+GLcmL7D9nflxK2l//z+TsxXGdRmVLPQh/QjznCokmyg/pxibUz4580JlFyw/
         dbbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793897300; x=1794502100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VqiTrc04lJztf2dyTmHN89oGm1bJ8PUHM0btmGHDZmI=;
        b=PD82jKo7jigK4yo/BsC4mL9gzNaCyQCuN/kPVJGkjQjdLI8tYXff0Yq6V8OcVaJvNy
         weurqZPZmulH0qGSg5NbPVImgWJ+FnTdb3j3Ry4nbirmi+Rj3QFivs4ORBwQaFRqCGqf
         QEUbVI/SqDEMT+7UGhcd921nGG7eTyZrIMcUrpbYcHWgfkjlc4bKSqYZEDRPXgz7lXtH
         DqeNW77psjBaqljc2mahGE9h0G2f7KashF5X4+pB5RTZgitOtmNbn03q4nK6XwgY7JUH
         dHKc7aq+4G8SSRybkD5tRl+j5GVa6fgvquMcqs4nqsv6V0mQuY3Plyf9y99pCk1OO04q
         xdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897300; x=1794502100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VqiTrc04lJztf2dyTmHN89oGm1bJ8PUHM0btmGHDZmI=;
        b=H207s9XhUPSxHUx2d31Pc8oHjVMCisPB3hkgBUfjAyY+1PdvDseWsWjqBdVxAmC+NJ
         Y/M+ajI7KsiIee0iCtoSkmMyotB7A6SEXFfzZWen//Xz58A/YOIILJx6SS+bm/ryDhdc
         zUJKepk3BaGT7XRGLqWMWQZZ0HEyYQJKeoPb2AjlTGSHNeX7jtVVVPapqvbVwzYPtuAv
         /ZFUz+kAC7gX9ufLb25gldloc/Lbo+AgfirQMOLtcDMkNevshKmrQggrQALn96mOe5Q9
         c+joP933+J7h1hPMCo2NVblj5yksK6v7gUBMWDNJTRlgK13NaDSOkfA5zbq6h7hDRejF
         2Hhg==
X-Forwarded-Encrypted: i=1; AKwUvBzQwHEXDAN27D1ps+RqPe5N/oTr4jnFIb2fOOrQjedX9Qz6MIkxQhoXXktyu/ghYDPk7H2xaEr+S00x+yi0bDc7E+AH5Ls=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ganBJgfs3V7UuCUzwNYYQ9cwhg604SQ3/OBRdMNM+MSHa+gvR
	vWUcZeBysne0ykohfxfEwekljh3M+u6Xv9f7GqSG9yBGW0f65EuVIi8BpM5S6p79iX84s9UiZV1
	asU+gNkUA78lHI8kSVbK0Pxo0OiyaajY/jCDm7ypMyG8xh9BW+XM=
X-Gm-Gg: AYBFou0LxVTO5zux66XUsJuXUnBfXZVVy4TcpqVdEbPx9wWObz1lUcdXYSSSf4bgDCu
	Tryi4VAXrJ2m+A9EFGlHi9qgJt+4HnXurpNmXmzRDnBvup6SoeP1kHiIu1Y27TrPH9f45K19YHv
	+2PDAh6Rf7+fF0lclrWFbQmGKnNESAdUcqbLg3RCx2ysOJg0Cvzk+e2rvvJ7O3jMp/JX4PhArdQ
	v11/BnEEZrEwdu1ScYOIVYoqBU9WmeS5hv/dBlR6xwdJqqSDzco3zsEz4q8pp0/PYVzF2NMi5Wz
	Q6OQSEt77JWwEWxTQul6C81rz9iAbdbVjMf5+zwdsCHVEIfYWAmIA3C1c3Z5kyAzV67Ir/e+ytS
	xif21q/1U0lSZQyeI2SDLbom/O2uL9OZ3IHAs2r6YQOSNm15sWNA5kx0=
X-Received: by 2002:a05:620a:29c1:b0:93f:334e:df25 with SMTP id
 af79cd13be357-9442175b2f6mr3556460685a.41.1793897300081; Thu, 05 Nov 2026
 08:48:20 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <auM32mOlBLu6ZUlt@google.com> <CALCETrUD4vh_iSHV7G0bprUFU8=c+ECo701-tXcbQ3UXBWC1ig@mail.gmail.com>
 <ausXFWLgHabezE7R@google.com>
In-Reply-To: <ausXFWLgHabezE7R@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 5 Nov 2026 08:48:07 -0800
X-Gm-Features: AclHuK8CUFetL3KNjWElY9pamqV4vOzKRAOdGaRShI4zykg0vul-u3a1dyx4v8I
Message-ID: <CALCETrXrdQRWTVdCq-V_AVpZG7g=1aCpeyNP3jLXT7VDW=OaVw@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:30=E2=80=AFAM Hallgrimur H. Gunnarsson <halg@googl=
e.com> wrote:
>
> On Tue, Nov 03, 2026 at 10:37:48AM -0800, Andy Lutomirski wrote:
> > On Thu, Oct 29, 2026 at 5:11=E2=80=AFAM Hallgrimur H. Gunnarsson
> > <halg@google.com> wrote:
> > >
> > > On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:
> >
> > > >
> > > > Why should the task's cap masks affect this?  *Maybe* cap_bset make=
s
> > > > sense, but I'm struggling a bit to see why cap_permitted and
> > > > cap_effective should matter.
> > >
> > > Sorry, the phrasing here may have been misleading. Just to clarify:
> > > none of the creating task's capability sets (cap_bset, cap_permitted
> > > or cap_effective) are used to restrict the new user namespace.
> > >
> > > When I wrote "reusing the existing task cap_bset, cap_permitted and
> > > cap_effective sets on namespace entry", I was contrasting this with
> > > the prior series from 2024 [1], which proposed adding a 6th per-threa=
d
> > > capability set to struct cred.
> > >
> > > In this series, when a task creates or enters a user namespace, we
> > > simply initialize its new cred->cap_{bset,permitted,effective} in
> > > that namespace to user_ns->cap_bset instead of CAP_FULL_SET.
> > >
> >
> > Okay, this makes *more* sense, but I think it's too weak.
> >
> > I have a sort-of goal of having the creation of unprivileged
> > namespaces be allowed in most contexts by default, *even in Docker*
> > (which would involve the Docker team changing their default seccomp
> > rules, but that bridge can be crossed later).  (In furtherance of this
> > goal, I fixed an ancient bug in newuidmap that gets us quite a bit
> > closer a couple weeks ago.)
> >
> > But tying this mitigation to a parent userns means that it's
> > completely unusable in the single-deep case.
>
> To clarify, this mitigation isn't exclusively tied to the parent userns.
> If a system administrator wants a host-wide policy, like trimming
> CAP_NET_ADMIN for all unprivileged user namespaces, including
> single-deep Docker containers, then the host-wide sysctl handles this
> seamlessly. Any unprivileged process in init_user_ns calling CLONE_NEWUSE=
R
> is subjected to the sysctl ceiling, effectively stripping CAP_NET_ADMIN
> upon creation.

Seems reasonable, but see below.

>
> Where the single-deep case falls short in this series is per-container
> granularity. For flexible configuration on a per-container basis, this
> patch series assumes that containers run in their own user namespace,
> allowing the runtime to bound capabilities at creation time via clone3()
> and have that bound persist down the namespace hierarchy across any neste=
d
> userns creation.

There are plenty of cases of *privileged* user namespaces (i.e.
created by privileged users) that would nonetheless want this.  Or
unprivileged user namespaces on systems that will not have this
restriction set that still want to apply it in their own container.



>
> If a container runs in init_user_ns (as in standard Docker) and we want
> to restrict userns capabilities for that specific container without
> relying on a host-wide sysctl, then you are exactly right. We would need
> some kind of cred-based mechanism to pre-configure a restriction for any
> future CLONE_NEWUSER calls within that container.
>
> > I do have a question about this whole scheme, though: are we talking
> > *just* about CAP_NET_ADMIN?  That is, is there any other bit that has
> > anywhere near enough security relevance to make this kind of thing
> > worthwhile?  Because if it's really just a single bit control, maybe
> > we can come up with a nicer scheme.
>
> Yes, primarily CAP_NET_ADMIN, and to a lesser extent CAP_NET_RAW.
>
> If we look at submissions to Google's kernelCTF VRP [1], 90% of the
> exploit submissions in 2026 require CAP_NET_ADMIN (and about 70%
> across all submissions since the program started in 2023).
>
> Restricting these network capabilities when they are not strictly needed
> (e.g. for sandboxing) is the primary motivation behind the series.
> However, I wrote the userns capability bounding as a generic mask so it
> could restrict arbitrary capabilities down the hierarchy, but if the
> preference is to narrow the scope more specifically to trimming
> CAP_NET_ADMIN and CAP_NET_RAW, that's completely fine by me.
>
> If we go that route and want to support the single-deep Docker case, a
> per-task inheritable securebit might be one way to do it, e.g.
> SECBIT_NO_USERNS_NET and SECBIT_NO_USERNS_NET_LOCKED. Docker could then
> set and lock that bit on a container in init_user_ns without needing a
> parent userns.

This seems perhaps better.  But maybe a bit that applies the
restriction to a userns created by someone who doesn't have
CAP_NET_ADMIN in their own userns?

IMO what we really want is a generic mechanism for sysctl-like
settings that are scoped to a userns.  And we would want the API not
to be filesystem-based (or at least not require *mounting* a
filesystem) because then we would just make everything messier.  This
would solve many problems.

>
> On userns creation, create_user_ns() could record this restriction on
> struct user_namespace. That could either feed into the userns capability
> bounding set proposed in this series (clearing CAP_NET_ADMIN and
> CAP_NET_RAW from user_ns->cap_bset when the bit is set on the creator),
> or be stored as a single boolean in struct user_namespace if we want to
> keep the mechanism minimal and drop the generic capability mask UAPI.
> In the latter case, we would still need to replicate some of the
> userns capability bounding functionality, e.g. strip CAP_NET_ADMIN and
> CAP_NET_RAW in set_cred_user_ns() on namespace entry, and bound the
> parent-owner check in cap_capable_helper().
>
> [1] https://github.com/google/security-research/tree/master/pocs/linux/ke=
rnelctf
