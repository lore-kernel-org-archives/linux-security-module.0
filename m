Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4A3B895E
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936170; cv=pass; b=Y/PteA8FwtgheUYykX4bT61+urr0SZQlG9mdPsghDIGbqJ23UanOF9Sk7al2bvbE04gosHAQajiT2W/in8sbh8mLiPwCXLunKBbHpcoHVDwt4n0MZH1UDjimyd5+YAVCgQpgrruQwplllaqP5e0TRFO27AgyfRsOmWnbGb/6Ka8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936170; c=relaxed/simple;
	bh=iVfuNUZDpw/Gom5uOVQvX6ChqXT9RekAmG+OEs7xoRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMGDUYOEUnN0VqdHtnnN1U5gjESWBPM78zhen5rFOTaOUSgvslEwcHhPSKp5nn+I84LNUdGfhjsV4ONy10QBGouL0TNBjR/qzNCCqKkYfU/8CyvphH3yOSQJVWaeV6zHYchPT55iT3XF6NAxFCD+z9dmA32OS4mAhEZLlpJWRro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TKyRUaxX; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TKyRUaxX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ca15944645so8369695ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 13:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782936168; cv=none;
        d=google.com; s=arc-20260327;
        b=PuXHZOx9aL2hj3QQWQhJWejIifuHy3MEigRufzRJ3uCTJpsHPAgmjZ3CIFUy/AEya6
         OEzsnrrOj/Jb2EDP8AN7hl4kZHAb3G37UY8V8io4VimtuUZKFlQXrCid9HYjVd97swVz
         7UeVzzUtjYLkpG6rSvVu995H2D20g+YPDt4HirLbXAOeuvEfm7+KvM9bOG/iQ3sarf/O
         Tsod7WJI/6r9rgSpLaHZWqiiWZq4Vig3C77GYU0nLPsH9LKbpp7KU8J3G9cdB9apo5hS
         2ZSd5FNMLpDyennMkiILNq5QpQk9jQs0ho6hVugOjjOtwVfnaXISLAn+ZB4jrUbxLJ0J
         4Hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        fh=efGof12irP0l50yju/4WZy5ZIjl1t4zbzF2Lmz8RXZk=;
        b=c5A+CD+xKA3sD5Q742i5QaTA/kHYJ09mZ5FROcOVYEAazQ26UFgTLrhSxBF6ndUmFe
         qqmbTUePOH6xOKJtIkcPKthOswBXKep6MJ3V6yzizIvBXpP/H9Z5mUB0eNlVJY0SMNI8
         ShOpH/D7GflWzRwAqJOjUcuDCXOfxj3wpxyH/gOXDFTYgMiO7OTn4yMtRm8PCseOYnKn
         5j5v5WuuMaAAAj3Eu/NBzMl16Ll/BPANukH5+zbANa8Pks9faVQEurKfMRRi0R79qY5W
         sLerqrR5e2rO4XBUkumVk/WyptRuoEPw7UbVQdQcIVaYlvlZpl5pcqjTi+2W0JN0ITvr
         s6zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782936168; x=1783540968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        b=TKyRUaxXoeNxg6Avs0Fx7V6UYAYcR+7CGd6XAfTq3C9dUpuDZ2RUUl7We1M4tO0OaP
         /zKZBgFuOOQoedvDaM7ViqZpijeoi5X0OwnYrWjXfxZeHZYEtovi9XcAuEmHKly4nxjZ
         rdFXfFdZN2enuO6coyFzc5lvbSLcq3Swfl2zvIizXb5zTBWXMQ1yI0nSfvAysKIi7M+u
         e08777MfNMhTw680Fk9PNQL9yx6+mqpz/9WJMt/eK+w9ENAYQw9U66IUZt9OaKjNQDyL
         lomawKfn/ue/jdvLbSiQ8zzBe2A11Osjon6Ih+8Vt/eYfx7IEs8m4bp7Ps6OEsgBhQ0i
         zHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936168; x=1783540968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        b=kXHnjQdsZtLS7XDUkWTZOQzJZ4r17e8XXvHTakYJZJYGESzt7s147u9Xgwd328TqTy
         NF14C97ZQ9bcqkVrs2KfUhZzEZBcphHjtFMqvdA+YYhbiby63/7Rf1Xh5ZVr0T8odxZz
         9z4BgF0ae3RFvIF4PfGbiKgUsz3MgNhninLuff3BIUkLpPDWKyGjX9yjNXyFGgvb579E
         JuzcQgFdP8DuAhTjSMr3lKEDeEsbRK0TBlHgjmHkEb8VhTurBZF9WCY6Swite5zzFnDs
         J/o3YQ6mqjVCGCRTLcAN4z3rQPTh0x/JGmPmnPrZh/kobdUKJWjKzImc+XcrnWdA6qdd
         FxdA==
X-Forwarded-Encrypted: i=1; AHgh+RqRn7b96gXfJi0eCbVeWpzzIIWX7IIo/HDDheN4RRKi2l5spLYJJSxUPx4iDfZr6BzDEXETAMzj4rVfU2K7I5erGdJvbUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYfSVzYWg58DTOBKsRiIUahihNz+vrgKF7NuBasbtOso/Yh0S7
	p0xl+O+CIWQ0QJ7Wsu1ILYHhKKdWiiTNWHYZmKsr91rIxjk/b8IiltWKJGbVre4Y7iX4RDl4lNv
	ZitPWwfNBNzw/Qvm+ZhmsQ+58oIjp3WiZ772e9w2I
X-Gm-Gg: AfdE7cl/DALXFWlNX/VgareZ2bvzf17fpEgY9uGDg++hTRCPYADd3jX6pv89plhmYz2
	UzEhILwKNep2ezMKnBwF5Za24v74XGntLz7yaShHGvu9wD0lKxRR/Di9EoFm5qA6IA1p3nb7zoR
	RVkJFSNo/MFNAeMW9ORMK/uiCOboPtImAWCF+iLauD92cxbktViddbehpYz4gdFoAYPzOM0piRp
	1S35trDeottKSDwnIABytzPIaN12RognokjdTHRCx6Bd+2pd5URHfGc/3/477TSXc5rR+nu
X-Received: by 2002:a17:902:e743:b0:2ca:304:f93e with SMTP id
 d9443c01a7336-2ca7e7579dbmr35871365ad.22.1782936167815; Wed, 01 Jul 2026
 13:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net> <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net> <akVvkA3kmlv_POsF@zenbox>
In-Reply-To: <akVvkA3kmlv_POsF@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 16:02:36 -0400
X-Gm-Features: AVVi8Cdkaysddhch2qqzWj5e0tZs2D9PIXTSkNjNLTTiuJP0QwrJjf46eYSL4uc
Message-ID: <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, kpsingh@kernel.org, john.fastabend@gmail.com, 
	andrii@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:55=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Jul 01, 2026 at 09:49:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > > On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal7=
7@gmail.com> wrote:
> > > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=
=BCn <mic@digikod.net> wrote:
> > > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrot=
e:
> > > > > > > > > Create 2 kfuncs exposing control over Landlock functional=
ity to BPF
> > > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset pre=
venting callers
> > > > > > > > > from accessing unstable internal Landlock fields.
> > > > > > >
> > > > > > > Generally speaking we don't want to provide APIs, either in-k=
ernel or
> > > > > > > at the userspace/kernel boundary, that are specific to a sing=
le LSM,
> > > > > > > see the LSM syscalls or the security_current_getlsmprop_subj(=
)
> > > > > > > function as examples.
> > > >
> > > > This patch series is not about the LSM framework, only about Landlo=
ck
> > > > and its specific model and use case.  Landlock using some of the LS=
M API
> > > > is not relevant here.
> > >
> > > Based on a quick look the patchset enables BPF programs to call
> > > directly into Landlock.  For the same reason we discourage other part=
s
> > > of the kernel to call directly into individual LSMs, we want to
> > > discourage BPF programs from calling directly into individual LSMs.
> >
> > We're OK for a dedicated kfunc to call directly into Landlock (with a
> > tailored interface).  Landlock is designed around its syscall interface=
s
> > (well documented, tailored, tested), and this would be a new user of
> > almost the same UAPI.
>
> Paul, Micka=C3=ABl,
>
> I think there's a cleaner way to resolve this.
>
> First, walking back my earlier email: I was wrong saying that we need to =
call
> into security/security.c to check whether Landlock is enabled. Landlock's
> init only runs when it's in the active lsm=3D list, so I can just test
> landlock_initialized directly. There's no per-invocation reason to route
> through the LSM framework for that.

The landlock_initialized flag is not really a LSM framework API, that
is still Landlock specific which is something we try hard to avoid.

> Rather than routing each kfunc *invocation* through a security/security.c
> wrapper, I think the right place for the framework to be involved is
> *registration*: have the LSM framework own registration of an LSM's
> kfunc sets, e.g.
>
>     int security_register_lsm_kfunc_set(u64 lsm_id, enum bpf_prog_type ty=
pe,
>                                         const struct btf_kfunc_id_set *ks=
et);

That implies a set of LSM kfunc APIs which Alexei has been deadset
against (see other ongoing threads).

> Each LSM calls this once to register its sets. Because registration goes
> through the framework, the framework gets to decide whether to actually
> register them so you could, for example, run an LSM while explicitly
> opting its BPF kfuncs out. (something that should be done at the LSM
> framework level).

I'm not opposed to the LSM supporting a set of kfuncs, see my comments
in other threads, but we should treat these kfuncs just as we treat
other LSM hooks today because that is what they are: LSM hooks that
happened to be called from within a BPF program.

--=20
paul-moore.com
