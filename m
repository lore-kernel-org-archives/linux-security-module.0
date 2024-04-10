Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723815A4
	for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713740; cv=none; b=DmbKbkzDtRe6f8tulxRLH0lpBmg1XBhGDMbnMKtavt0KdzvanE/xHv0AnFeNrBJ0qFb3PHiolqvU3HsFJwwp33rmzfgNeJvxXaZWy0ukao3fbfEmvc/WBDZyQ4h/1TXikR4HXMXKi/ek0E5fzZj3unokVgwgL80aO6F+5WqieGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713740; c=relaxed/simple;
	bh=Tlq5PKYgfjVQwHjKSArfm0zJBC6APmomxQw5HPw/nNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpSIhneFxujyYKpyoEmdxyybEY7kUOUdZUBRQKdqBCGK9jiHgr8StyZPMdTmrHQMRxHMxkKsCVYLSCLknNGeSrZ8ML5/nJSGcqs+5JQeQ8mjckKoNgWuzwgzXZ0sdZ013CFVtZDFsKNOmvLoDr6KGStbI2uFUxQRB1koe4vPWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OProwLlK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OProwLlK"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6164d7a02d2so68141527b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712713737; x=1713318537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDzW7P+/b4vEUXkjkixrG26uOcENU31icXjIOvAAdWw=;
        b=OProwLlKFXaKe0jaWSt0sXck6Zje1/RpbhlWxwhTUdEkq5uDCj9RJCKwZ61LEHgcv8
         f1YgiYYyMvOrEMrd6bydnvLKqRHzbyIIWys2jzLBR43UTbaK8178Xph074HakzFF21xz
         RbIhtJA6i/dGDhG5gysSuw0LGFh6KzZ8amhqM/IZ++4Oe+mq3yHR1hrkOhsA3o47uGTR
         3LHMotwtKVdMmgaGOcG0Lyb7GpURJppWrr0boMfn4AYi+CURALxPwCrQzsNPt/nQpo/R
         y4N0X76F2Fpk1vI4e3L+pQSck8uC/3qHVmFNOKg48e7PY++H/nLkTyjvHY3ys4PHiUPy
         GB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712713737; x=1713318537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDzW7P+/b4vEUXkjkixrG26uOcENU31icXjIOvAAdWw=;
        b=MeWF7yV7dXSmd0bvpOpFwj3SlWcWISAgnZ7IWyFEHS6gDnvtnU9ChuZP85qroTrbcv
         eZGKj2n5k9YPmKhq00wZdP7szMWcv69+NDdN6NmhKatKe1XpRtxPrt1nu5iWpb7CoVgA
         mBCu946EuwuERRoxl0BO6t8qN+YdOt1aevbxb0aRQhwXTxFgALnzDsvSthNoAHyjwSda
         johbM5motzZyfNOMZw8dWyNVOvABnyNsVaYZyycbp23qf2cyoEp4yDw/xduwJ3XCGqZX
         4/C7Cor5S87ylU4pHHayJm0pPrOC8uba2rqaCDhooBX9+iNcaC84UaM+Ry+7XpZ2vt4T
         2iRg==
X-Forwarded-Encrypted: i=1; AJvYcCXG0vBD3ZKGqN2aBLZrUQnTINKm+yUr9Kcd1h7thht+3PBYMnzGTQne0W9SlPPkxhc/PHlHZFUnzyz9jG8V9XeiS8WKC1Oe0tH602aVR7efVYBvy+sd
X-Gm-Message-State: AOJu0YxMsrnm9z63QoYSlYtaatvq5VV40/I07wj50UmQKLB2L67WYW6+
	C2CCpVKCFi2hLa0r+Ke4yNt4blGmmE2O5i3+eNK+O2NK+M8LFFhtPQxNyXQBEupLgUB1sk1wb5n
	4zIzUQGr1epevUQ2xBf1TxAfwbA6SC933H6xER6ss8Oo40vG+Qg==
X-Google-Smtp-Source: AGHT+IFVkztx1wR3Co1j875GyrjRcxInakP/NfaC6gZSN8ZUjq/+glJpk/aT42MEMxiTa4IDvIQHh+TT/6jLuLvjLAM=
X-Received: by 2002:a0d:eaca:0:b0:615:101d:285c with SMTP id
 t193-20020a0deaca000000b00615101d285cmr1473311ywe.3.1712713737315; Tue, 09
 Apr 2024 18:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
In-Reply-To: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Apr 2024 21:48:46 -0400
Message-ID: <CAHC9VhSMWr9OEsHQ6y=3fw+Qk_1mWg2GcCfERHD4vn9Y_XOJsQ@mail.gmail.com>
Subject: Re: Hardcoded security module suggestion - stop the stacking insanity
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:23=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> People, I know there's been LSM work on the whole "multiple layers of
> security modules" for over a decade, and it's been a design decision
> and a target, but I've complained before about the cost of the
> abstraction, and we just had *another* hardware security issue with
> speculated indirect branches go public.
>
> So I say "suggestion" in the subject line, but  really think it needs
> to be more than that: this whole "nested LSM" stuff as a design goal
> just needs to be all rolled back, and the new design target is "one
> LSM, enabled statically at build time, without the need for indirect
> calls".
>
> Because we're now in the situation where the security hooks are
> actually a source of not just horrible performance issues, but also
> actual insecurity. The first indirect branch in the kernel is now
> often the security layer, and the latest
>
> One current PoC literally uses security_task_prctl() as the attack vector=
.
>
> Yes, I realize that the "security" in the LSM name is a bad joke, and
> that to a first level approximation the LSM people don't actually care
> about real security, and that the goal is just "policy".

I guess you just couldn't help but add the above sentence.  Maybe it's
your narrow definition of security, maybe it's just an old habit that
comes back in times of stress, maybe it's something else ... I don't
know, but I do know that telling the LSM folks that we "don't actually
care about real security" is both objectively wrong and a slap in the
face.  The insult is made significantly worse due to your position;
other developers, maintainers, etc. see comments like you made above
and believe it's okay to direspect the LSM infrastructure and the devs
who support and look after it.

Even if you stand behind what you wrote above and it wasn't just
yet-another-hardware-flaw-rage-post, I find it hard to believe you
didn't understand your comments would be taken negatively by the LSM
devs, the same devs you are asking (demanding? it's hard to say at
this point) to upend some core design decisions.  I'm far from a
master of persuasion, but I do know that insulting the very people you
need to help you fix things is generally a poor idea.

I see your suggestion in this email, I'm sure we all do, and we'll act
on it.  It will likely be a while before the discussions turn into
merged code or design changes, but we'll move forward, we always do.
In turn, I'd like to make my own suggestion: do better Linus.
Disagree with the code, design ideas, project goals, etc., but don't
insult the people who have helped make Linux what it is today.

> But dammit, I think we need to put our foot down on this. The
> complexity simply isn't worth it, and the flexibility is of
> questionable actual worth.
>
> So here's a challenge to the LSM people: work on walking back all the
> silly nested security layers.

Ignoring my objections to the very premise of the question ...

As Kees already pointed out, we're at a point where we really don't
have the ability to rollback LSM stacking without negatively impacting
the user experience.  While I'm sure there are some public distros
that don't enable the LSM, last I looked all of the major  public
distros did, and practically all of those have multiple LSMs enabled
... and have for years now.

Even if we did decide to eliminate stacking, I'm not sure it would be
a net positive change.  Many here may have forgotten the ugliness that
we had in the early days where individual LSMs had to directly call
into the capability LSM if they wanted to preserve that behavior.
Yama, the first "minor" LSM (ignoring capabilities) was brought into
existence because other subsystem maintainers couldn't agree to
support the functionality; would those same maintainers be willing to
incorporate Yama directly now?  We also have the recent example of IMA
and EVM, where promoting them to proper LSMs enabled us to simplify
the LSM/IMA/EVM call sites in the VFS and LSM layers which made
several maintainers happy (although it was a source of significant
stress for the IMA/EVM devs, I appreciate their help and understanding
in that effort).  Do we really want to add that complexity back into
other parts of the kernel, one hook at a time?  Would that really be
an improvement?

> And yes, I'm aware of the random hacks for turning the indirect branch
> into a series of static direct branches by
>
>    https://lore.kernel.org/bpf/20240207124918.3498756-1-kpsingh@kernel.or=
g/#t
>
> but honestly, this series needs to be turned to 11.
>
> Or rather, it needs to be turned *down* from the current maximum of 11
> nested calls to be something sane. This whole "security layer allows
> any policy at all" has been a fundamental design mistake. It
> absolutely needs to stop, and this "you can nest arbitrarily" needs to
> be walked back.
>
> The whole "add cost and insecurity in order to give people random
> policies" must go. When the LSM *becomes* the attack vector, we need
> to just fix things.

To be very clear, the core vulnerability that triggered this thread is
rooted in a hardware flaw.  I'm not going to argue against mitigating
the vulnerability by reducing the attack vectors, but let's reserve
the rage and cute quotes for the core problem.

I'm going to bump the static call patchset up the review queue and
we'll start there; getting that in an agreeable state and merged
should at least resolve the indirect call concerns.  The rest will
need more discussion, preferably after things have cooled down and we
call all look at things with a more objective lens.

--=20
paul-moore.com
