Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F1139597
	for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787455; cv=none; b=RyxIE/XqB7VuZocsMG7CbvDQPpKImjts2wqncDrtlykai69XiHgIJJi1B3D7hwy3ZUotExiq3QZDT/LZy8LnpbCi/rnF+JFAZmHLciIeGhSujj7vihf+jbabBaGYr63jYCUoAputd5AGsJ8YQguxGVC9DHtmElQR23L7YfMODsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787455; c=relaxed/simple;
	bh=7tJRCi0ii2GMhIt1l0n/AkjsLxR0kD0RiGVRd2LjTWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkRj6kjILhKdyltoov3TbLpdGW5fnIVYJzbU0B+n5JrHL7rGaHs0CjHXrnRxn3J42Or7xNZ8W1XSsqspx+JG7kL9vGZ7zzrWhXPAo5NcaleVa2zswEVCTDXsZX1yjhVCWTddYey/NQECwd2IBrElGslwKWgNVAOvBqzJI4zTOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fm18Vev7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fm18Vev7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e290e857d56so1267920276.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2024 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729787453; x=1730392253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TSL/B9XdjEyCV+/degN5rGlymEtotZApdFGlr1YP/w=;
        b=fm18Vev7V5KpYbQHVOz5slEG/kDBbO2cis8AHQzk0D9BpxheHq6n3h9SShaRMC+N3E
         MJwFcWUtvdxps4RrTIBo8ZqNs/bmGD0Qb4oRfgWE4qtDse8DL+ovd/pcjtRUGkNmAeE4
         //DzwvxggdwlcmA3BfCBbZgYiImD3ILKQ/mxGHVrJlJlfF5uu1dWB2oWMG7AtRxYFxGT
         ktf5Oi49U+hBUTKC717xykEOSQ6ZI+kTcGod2SThbFaDQVA+bKlDtaCzVLIIUZWdbDUh
         nKoZe6OT/9xp2HgO9odkMBfmM9sOm4sSM9OheNRX11BqSvqY/QnzW5XCJHt7q6Yl27WK
         s7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787453; x=1730392253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TSL/B9XdjEyCV+/degN5rGlymEtotZApdFGlr1YP/w=;
        b=DiMextx6a+q2bHa7dZGuUluW3oq5W053J9wbRshIm1l9sMkpz1TDSGo/rkwAZAQjto
         fnxOXXWAKN/m9GNMeZgTFMmnUG32NLTLUCYiHqUbibRkb9BnHd5QA9erPpR99I7Wy3iK
         xsAivylkwpyNwxxkFfhZ0bB0LDKzRAYYZQn6TRrEbf/fLkBsT+IfyCInGzJlwF6Cma1Z
         RvNrNYvcFF+c5JoIIfOQ82lcVZWzE4OMuqQYTlbzAG6EMCvwqyNOtGwEpqmTcBSa9lAo
         0blb7Ml5PHiIk5iUYEKtuiTKrji6gdsmELhq6QxgKPlTEdrcgBE0RoFDg0MSzwbQSaR+
         q47A==
X-Forwarded-Encrypted: i=1; AJvYcCXuZ+EsOgYJf9kYUYYv3J+bY0ol3B5SYm1XSdM6vyXdzt9U6Bl7hwN7OtfVpEMmcMXDDalFB8yFyZCwuXk9/urim3uax+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhprdeVj3oXbCaeYUd+3VMv1bvYDvN9koO5KioV2JwGzQ7Tju9
	IGgXb1zwqkldmGArXt/Xj1AZoSjEoi4mYX0YqvCygjCUolz7Muc6VKgK489Pd8/ANdatGnvCzhV
	estaZ+PLmxHq7Juw0TNEHEZpUOo7SQX+aWeC0
X-Google-Smtp-Source: AGHT+IGJa9gs/RjChDDnTmllQ6BKnXc33rjqKLafOqz0uPltOOw4BhIDujUPxTaOIv/aaM7/OCtBzhWs6O0xxcAScHI=
X-Received: by 2002:a05:6902:228c:b0:e29:41af:e1a with SMTP id
 3f1490d57ef6-e2f22f1f219mr2632147276.4.1729787452339; Thu, 24 Oct 2024
 09:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-3-mic@digikod.net>
 <CAHC9VhRZ6Ug7ACLDgAiqQC3LPRPNM=Q5NX8TYxo-fcPA5XBEoQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRZ6Ug7ACLDgAiqQC3LPRPNM=Q5NX8TYxo-fcPA5XBEoQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Oct 2024 12:30:41 -0400
Message-ID: <CAHC9VhSPJ9j0eFnHg-b3wh+Baxv9F6GfK0rG2TAtadxWgCKszQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/14] lsm: Add audit_log_lsm_data() helper
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 8:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> >
> > Extract code from dump_common_audit_data() into the audit_log_lsm_data(=
)
> > helper. This helps reuse common LSM audit data while not abusing
> > AUDIT_AVC records because of the common_lsm_audit() helper.
> >
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241022161009.982584-3-mic@digikod.net
> > ---
> >
> > Changes since v1:
> > * Fix commit message (spotted by Paul).
> > * Constify dump_common_audit_data()'s and audit_log_lsm_data()'s "a"
> >   argument.
> > * Fix build without CONFIG_NET: see previous patch.
> > ---
> >  include/linux/lsm_audit.h |  8 ++++++++
> >  security/lsm_audit.c      | 27 ++++++++++++++++++---------
> >  2 files changed, 26 insertions(+), 9 deletions(-)
>
> While not a fix like 1/14, reducing AUDIT_AVC reuse is a reasonable
> goal.  Merged into lsm/dev, thanks!

I'm also going to have to remove this patch from lsm/dev due to
problems uncovered by the kernel test robot.

--=20
paul-moore.com
