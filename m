Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510DC1BC9EB
	for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808554; cv=none; b=rBHulMUGBX0DvmVkRzrVU3UTPfsV9IuWYejcxRdAEHRrPJ5HdO+QueeiJTjWJNKnFeq9BO5bRu/80p19z5o4PjiQsIHpEkUcX0qO7X5kgLgvAME38rwfzZhhjTuprN94xM4OMfVmSGWvhWkbJ32H//yjWtVH/VR+4M7PswaqM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808554; c=relaxed/simple;
	bh=AJW5s/8jkcPvXTExYgwI+CkCjqIUVj3ruIOxz3gNv80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcmmiWnzRq9V+sBz8HNRQgruAgoCOoqOeHais8rodcgrluxLtCz63XZGqxvu9cgdnxWZHEdx/OhUJahlyrVX+NyTUzoNtjGkhGreuutZqIVviNPylhfm/d129dQhwAsK54ULR8va1twPDzxYZ5GHxGy3oucc1cn+iiwLokHzH6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=Y3dr0eU9; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="Y3dr0eU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1732808548; x=1733413348; i=linux@jordanrome.com;
	bh=D7J/Sg0XqzGkPmfmP1x6JDRP7z4RpcCcV3CM7rqiVQc=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y3dr0eU94rj3I7cULmHoCzBhZgSsqqf3XOqhgaR+nNKVRQhwepKHTae7IvpES8Dk
	 TvcOwJPJuwFD2SwZdkT28Sd0qSpT7GZXN1Ie9nzS3LoXxI3dM45uerPPH6GbWvkKO
	 eIYka38F7eqWP4Y8nbBe9ythtBWCztuaaC5UPDy89p5QSMbbd0b3lIrh1GdxORcKh
	 K8QO15u6R0RiTGBzwnWISJa/73TBOiWGO5rKHDIrEpfxhx7mXYzdyiIkzET4lDs/V
	 fnWZyhJu4RsLbzu7iE7wTek/ZOFw4cX9C3koZ0u9yMPsJo+x0mWGjIn0O7B9oLdIt
	 19jBM9AXVgLDfZ59pw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-io1-f43.google.com ([209.85.166.43]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lt0iy-1tfOH80aQE-011OpW
 for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2024 16:42:28 +0100
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83eb38883b5so28696239f.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2024 07:42:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZPhd2jQMTCfX8fHhmF3EnMt6lXFxFpZeXOs1LLODW1wHJWTW5+hVR43d6/pdLquODR0xc6FHVe8MKhJI/TNUU5Eug/Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wxjKkzuWik40X3J1/+fWSSrQuN6oLZQZNY0hrXPCWe98KJPk
	f47ilo62lZ8oGFRkYatPJ+xW62fAm8QqVO7NJaz4rwQfBKvWCTNNPgtKOFUplGcrmKeiH7tYfUs
	oxGReWOZG/BDFpVc2EUbS/TByL1o=
X-Google-Smtp-Source: AGHT+IGBNlJdin5B/hB1+9rsvOba57wi557PKIzJn+xl5ROfqd8b/dykEni7xmdtundWQtrTpxoyG+cWJzsBbbiY98s=
X-Received: by 2002:a05:6602:1490:b0:835:4b2a:e52b with SMTP id
 ca18e2360f4ac-843ed06a2camr859977739f.10.1732808547711; Thu, 28 Nov 2024
 07:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zztcp-fm9Ln57c-t@lei> <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
 <20241127214243.GA28695@mail.hallyn.com>
In-Reply-To: <20241127214243.GA28695@mail.hallyn.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Thu, 28 Nov 2024 10:42:16 -0500
X-Gmail-Original-Message-ID: <CA+QiOd6pNMzAxsHsr11oyJNY5V9DLAxSdECC37X_WYDHbv4v0Q@mail.gmail.com>
Message-ID: <CA+QiOd6pNMzAxsHsr11oyJNY5V9DLAxSdECC37X_WYDHbv4v0Q@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Serge Hallyn <sergeh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uNMvRpvvkKENvDITsNfLUVha/a8aJE0+W+YUwBzpDHMctUCkJmy
 ZYVulA79UIK4rD2DqVZUIiXl9uqO3a1ZaZL/pCk4kS67iVyjML++6aY5mK3a7mjJIizasfJ
 w5bRh5NgPxUKWjISpmredAQU2ozRX79PuuaRsxMNlap4/qoJBjKFD/vJ5DOWLddPEYVEALM
 YIMJKsnf4X529OWwtyf0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z1SQu6OlILo=;L68L1fIwkoLNIIrtRHcp04rfwkm
 rHjKZ8aSnTmBsZqfYO8YIqoYHLvvfvtWjoUT4yc5pk4cCzBFqANAbmk0BzVuCoYFiigZ45GAJ
 zdB7ffuvwMIQvPtNseyzePoXM5rnDmLABS3FBs41gmuwwX/P/jh73P+lBMIMyG50Wbgz8X/k2
 7+kK0MbXXAK5Bog1irDeikkEv1bh+2rlTy9c7aVGMaA94rvHa40cDg/UO204VDvU/3F6tLvUa
 snSJloneoKnbaYvX/RGAJ7w2U9fDeTTLoBOm9oYUSuOZ/uOaZElqEodoJhfLGq/FMGf1eBsRS
 8uHRmRyLd8V1/L2aWmbQ5Q1VZqxOaOqqeQLa+1hStwMZXPkQHVPr4mxzTjEc1b2yrFiMW+SGL
 ZBXtlyk3Ktc+kJBigibzXcC2qZuM7a9juIPbyot0IMlWixQm56fqwAL59K672XyKy9m8tGk7b
 4V1IimYYsBZm70RsTmuLXRhJR0dOJTlVmky45rRbMuAtzKtGz2X9I0VOtxJzODwd9FirIK7qA
 bzch8e0fOc452slGkuh+jP6RdSB7LfrmA3tquxEUW+wA4znjCchF6weHBudXn5DJgQoVgDYQ+
 YUMksqBnzwYVrNF+ZybpdV4ftd2y3CMfp1vP0xuPg4mqn7XlAIIt9IG6aa/H4ff4LzxDlxANu
 Z8okW1LPeaECQ06T5CR4cdJOR52r6l2d6iOHd+nL4ZILjAWF0BvlTgY1a0AJYRqn0TZrcQfeL
 JZ0fU4Ej34EyAP9X/mnNbDdF4y04HnAAmLKHP1SfUntIXzhzKPMwZDuZjHZAXKQOP2OMw4uO3
 l4rG2nK05op3jL4fTAxDLJyVdErnX7pI1CxIodcx3gRjUd8SL0gfIUCZVG1ysKiUoELEWb83W
 OKkBbZzbFOj3Tcza0Q/qHRbzmjjfEdkMuT2clS4rVyNvVNRBiKOtcj6oXpiHzTLa//aOfID4u
 8wk57aY7e1DtR4kDsa8Hz44xNxgeyTjq3YOJV/qr/NHtdbMMkg/9klGLcpLsI8Cds73PdQuq5
 emN7nweWJ2I59gIBYZU65/DT7HjL9ftlQ84GqCK

On Wed, Nov 27, 2024 at 4:42=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Wed, Nov 27, 2024 at 09:30:14AM -0800, Linus Torvalds wrote:
> > On Mon, 18 Nov 2024 at 07:26, <sergeh@kernel.org> wrote:
> > >
> > > 2. Add a trace event for cap_capable (Jordan Rome).
> >
> > So I've finally gotten around to this, but I absolutely detest how
> > this was written.
> >
> > It was oddly written before, but now it's absolutely illegible.  All
> > just to have one single tracepoint.
> >
> > And it's all *stupid*.
> >
> > The "capable_ns" thing is entirely pointless.
> >
> > Why? It always has exactly one value: 'cred->user_ns'. Lookie here,
> > it's assigned exactly twice:
> >
> >                 if (ns =3D=3D cred->user_ns) {
> >                         if (cap_raised(cred->cap_effective, cap)) {
> >                                 capable_ns =3D ns;
> > ...
> >                 if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->own=
er,
> > cred->euid)) {
> >                         capable_ns =3D ns->parent;
> >
> > and *both* times it's assigned something that we just checked is equal
> > to cred->user_ns.
> >
> > And for this useless value, the already odd for-loop was written to be
> > even more odd, and the code added a new variable 'capable_ns'.
> >
> > So I pulled this, tried to figure out _why_ it was written that oddly,
> > decided that the "why" was "because it's being stupid", and I unpulled
> > it again.
> >
> > If we really need that trace point, I have a few requirements:
> >
> >  - none of this crazy stuff
> >
> >  - use a simple inline helper
> >
> >  - make the pointers 'const', because there is no reason not to.
> >
> > Something *UNTESTED* like the attached diff.
> >
> > Again: very untested. But at least this generates good code, and
> > doesn't have pointless crazy variables. Yes, I add that
> >
> >         const struct user_namespace *cred_ns =3D cred->user_ns;
> >
> > because while I think gcc may be smart enough to figure out that it's
> > all the same value, I wanted to make sure.
> >
> > Then the tracepoint would look something like
> >
> >         trace_cap_capable(cred, targ_ns,  cred_ns, cap, opts, ret);
> >
> > although I don't understand why you'd even trace that 'opts' value
> > that is never used.
>
> You mean cap_capable doesn't use opts?  Yeah, it's used only by other
> LSMs.  I suppose knowing the value might in some cases help to figure
> out caller state, but dropping it seems sensible.
>
> Jordan is working on a new version based on your feedback.
>
> thanks,
> -serge

Here is the new patch:
https://patchwork.kernel.org/project/linux-security-module/patch/2024112815=
3733.1542817-1-linux@jordanrome.com/

I applied the suggested changes but left the local `struct
user_namespace *ns` in the helper (as it gets updated in the loop to
the ns parent).
Though it feels a bit icky that there is not a null check against the
`ns` variable (maybe it's not possible to reach that condition
though).


Jordan
