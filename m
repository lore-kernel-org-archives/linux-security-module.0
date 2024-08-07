Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EF200108
	for <linux-security-module@vger.kernel.org>; Wed,  7 Aug 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038358; cv=none; b=q0BKYawtArgXBdzmpYLesoFDu128tSHT7nliZs0Uh8Lq+DPgrf6Z7HhIfinS9Is/UmFPHxVSginsk/iu48WKEzT1QmYxUZezuov93JF7fqISFhUEIx2E+bqjSdbuh+A9KNsqFgdVXlkCpZRs77c+Xu8k5a45VT/lR6FNRGPqxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038358; c=relaxed/simple;
	bh=LxhoI9D8h91IiIrVyC3rOcVzclZdpcN98zJjVnIiLmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3VU6xFn7+2Qfr/ZzRot3o8fbz/FtkXZ2DcruBPVW7y5Cs8LWsFtoOpgnF6ykwGEm94hPCSMr9CD5/wzCxaM6VtMoM9vlq7LCq5IO9v4H/YH7K3DCFCP1Mm00H/33HpagwgrRP29UisZu+kQG1p2Haox3susSuLvviuT+VCWJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JP7HPeqX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JP7HPeqX"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so32491a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2024 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038355; x=1723643155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qjk1I5coQs/nVar1+nTAzLmrHbTNOYHZ49zPGhWaB7k=;
        b=JP7HPeqXt/WwVK4cF5gS7/mx011EwuSzT9V7Rls0BiRkliH1uLWKTDi9smWa110A3e
         4x8laQZnPNMQLPWS/+i5YxXxb6Jyn0mjS057S5zkMB8TsPgFvKRPZcR9lSwiG/xfChS9
         Z+KOn6voZOPUB5lN78UvBs/BBN3ezwJfYq7Ffk2gmRE11gL5DPOBb42sxr4NY5ZGjAv/
         KF1tsveQWB4f1pIl1kBH9Jf2R2pfAqtzhbOmltOHjRzIS/L/qDcyZ0Cq3axHVVvHxqQ3
         ryq8nfULMlCzA3BnE5HrG+KS2AWW8WA53B0f9d6U1i58Z7r0EeJMD3CXpkbd0fAmjASB
         N/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038355; x=1723643155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjk1I5coQs/nVar1+nTAzLmrHbTNOYHZ49zPGhWaB7k=;
        b=Cv66P4ywbDz3DWyvDf9Hil3q69C9oJUrRcNkPmfQVGqW2BSMnoNoCnpLC5osZYpzlU
         82CRrW4nkBlHH1qbcKKSz4Z4kHm0ceOxYJAUI/kivw0mTs7TtTLLJcJ6u9CQ2EMpuvUU
         fYbsSE+CK/xIeAZIlh1RHIhHM2N0nNS2Z78zNOSvbulaPrEvJePbA89/h9lnLmvnpg/9
         dgjAS5NK7G0QT+yRaH428m3cxJKm/TYTRU8BfMq4mTx9fr/KudbYWWVqYjkTBQV+cQOY
         F3nGo77eUz/vwzS63pwNHJlO2d6HT8rbDDD10ujHaxOxE0Dz+5wec04WJD4oNqSpvbhG
         WT1A==
X-Forwarded-Encrypted: i=1; AJvYcCV2OG6tIZuH3kZGceMWmk9FWDaDzaNEu/3C86/k4qgw/Vfv7flKIbU3VyuBroCETwFIcap0R5m+nD+DYhvjQwTRLqllasVP4PAijX8YwstyD9wCYNl8
X-Gm-Message-State: AOJu0Yy7pz0SNXWqkkHP1ILHY7Pv7rerr/0r7WE4mz4xPcx6a27NPqaB
	m81wd/8k/HqMp0kMcoD68BrX1CtorrnPtBNqmhIT+RkwcJoAcQgKUFrFrLVCT+YVXzXDWcYjiue
	57iN1qIP829QMMxDpJLwZY4bwwIk2Mj3NDqr5m90YkEX5PSQDyzIT
X-Google-Smtp-Source: AGHT+IGAwcSTpPPUvxvQtsojcOYxgyANBUtDcjLr//Ggm8SyirsP1mGKn0OgYNXn2QkdUw9HzCo+aw1tSHDVijLU5vU=
X-Received: by 2002:a05:6402:35d4:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bba2837dccmr204357a12.2.1723038354385; Wed, 07 Aug 2024
 06:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722570749.git.fahimitahera@gmail.com> <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
 <20240803.iefooCha4gae@digikod.net> <20240806.nookoChoh2Oh@digikod.net>
 <CAG48ez2ZYzB+GyDLAx7y2TobE=MLXWucQx0qjitfhPSDaaqjiA@mail.gmail.com> <20240807.mieloh8bi8Ae@digikod.net>
In-Reply-To: <20240807.mieloh8bi8Ae@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 15:45:18 +0200
Message-ID: <CAG48ez3_u5ZkVY31h4J6Shap9kEsgDiLxF+s10Aea52EkrDMJg@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect restriction
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:21=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Tue, Aug 06, 2024 at 10:46:43PM +0200, Jann Horn wrote:
> > I think adding something like this change on top of your code would
> > make it more concise (though this is entirely untested):
> >
> > --- /tmp/a      2024-08-06 22:37:33.800158308 +0200
> > +++ /tmp/b      2024-08-06 22:44:49.539314039 +0200
> > @@ -15,25 +15,12 @@
> >           * client_layer must be a signed integer with greater capacity=
 than
> >           * client->num_layers to ensure the following loop stops.
> >           */
> >          BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers)=
);
> >
> > -        if (!server) {
> > -                /*
> > -                 * Walks client's parent domains and checks that none =
of these
> > -                 * domains are scoped.
> > -                 */
> > -                for (; client_layer >=3D 0; client_layer--) {
> > -                        if (landlock_get_scope_mask(client, client_lay=
er) &
> > -                            scope)
> > -                                return true;
> > -                }
> > -                return false;
> > -        }
>
> This loop is redundant with the following one, but it makes sure there
> is no issue nor inconsistencies with the server or server_walker
> pointers.  That's the only approach I found to make sure we don't go
> through a path that could use an incorrect pointer, and makes the code
> easy to review.

My view is that this is a duplication of logic for one particular
special case - after all, you can also end up walking up to the same
state (client_layer=3D=3D-1, server_layer=3D=3D-1, client_walker=3D=3DNULL,
server_walker=3D=3DNULL) with the loop at the bottom.

But I guess my preference for more concise code is kinda subjective -
if you prefer the more verbose version, I'm fine with that too.

> > -
> > -        server_layer =3D server->num_layers - 1;
> > -        server_walker =3D server->hierarchy;
> > +        server_layer =3D server ? (server->num_layers - 1) : -1;
> > +        server_walker =3D server ? server->hierarchy : NULL;
>
> We would need to change the last loop to avoid a null pointer deref.

Why? The first loop would either exit or walk the client_walker up
until client_layer is -1 and client_walker is NULL; the second loop
wouldn't do anything because the walkers are at the same layer; the
third loop's body wouldn't be executed because client_layer is -1.

The case where the server is not in any Landlock domain is just one
subcase of the more general case "client and server do not have a
common ancestor domain".

> >
> >          /*
> >           * Walks client's parent domains down to the same hierarchy le=
vel as
> >           * the server's domain, and checks that none of these client's=
 parent
> >           * domains are scoped.
> >
