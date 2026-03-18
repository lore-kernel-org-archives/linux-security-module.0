Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B132C3260
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865223; cv=none; b=I3IO5eQeXzQKkjjoTTxHkKwUWP+1zr7i0oYk/jG7oFGGtF9JqZ9ZqEr5xgGhZ/V5tIwKUseya0rM0jp4hhq8h27oClwwb8rsewXB8MVmoqb9/JHzsK0IQLLikpITaUPPu0BDIL4lU8ysHZupdMiOmPio7AfoO47rYq28FBWAdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865223; c=relaxed/simple;
	bh=3cu4bbj+SmiAm4sX2rF31bDv0sZtySNHbbHzaX2PHwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2UqbX6tbjrloSbX2CQEnI7h1dhN8Yg/+E+Wf/Yya425mY4saaygtvp7MEUwzeg+xhgxgKP4P4Pyzg+Tn0GX2cIKdbDn5Y9gPNahSGGnBHZ2Mk8HF+8rnxufQU0TwDIdjL34gEZMC/7x8DKNO5UjXyRvFKt+uGUjJB1OkDvHnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZfI1ZCz; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZfI1ZCz"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cd8d97aa2eso40700685a.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773865221; x=1774470021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoIVbPg4RVpfqltNmpd5OJVLlGKBhj+dvXrYSn7+C9s=;
        b=mZfI1ZCzd2Hy+GXmfRTkAbhkR1MKLNlVuMP8VO69xMLAfzoVa1LxvfKV2MYZFgnlPt
         bXfaxye2g3CHBlsXH2J6m9eRPC7m+sG8kocWPQ7xoRQJikT4oh98pFoNVk+eHSEIho9z
         dPBMWVx7vichFnJV0gP2tS0KDkbeyNM+c8eUnx/KQF3wb2YagMw3Q/Oy89euhreS6lq2
         uUxuHnTW0YAGijj5OAdeIP/hLZOK0TEf0HexRsO3Zl3CEkyJCUv/6rAMRKzMuvVXtAhJ
         VakYHb6cZ6PBTjklKsvW0wH/6QpIxW11tj7GhaqPQJkkVDDBej2opMh9fR605lA8bIHC
         FtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773865221; x=1774470021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoIVbPg4RVpfqltNmpd5OJVLlGKBhj+dvXrYSn7+C9s=;
        b=tUULEf/Vaj6tNzVpxM+KlP+u2R9GnkTx+FU7qcqCD+pGGEH6QK5RXUSDjRllPZ8d22
         pDZapZjQgwF3Zlh3DU30jwJqvVsALOB+N3/iMrKazsLldfqIu8QkGpCtutd3fcqhPvQn
         r+YiCaGqS6Gy3nwjZZulvdE4rH2ct1wBpCEhTDE79xp7pt1+vQAxzjpNT2w+XAQfAX9I
         SSoT69jf3NDeu6KpY3pzK5OVFpvNNuGAsjnJazmfwBMOdUkiArzp620mhEW3RI1mOQ9O
         2BWLD6410rsQQkLxLW5Hf/TooWliajczkcZsr6GRv1li56VG6pjQuA+h6P6g+Aque/CZ
         CFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjaRCeiu50TEl8VjaWUrbpwe+Sjna5himn2iAOJX+SES9nXMUDRVyi3OkdYCIjpJeEjYmLJO8HGEYfHBwOVMjT9kGbqwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8vp4uOApXAx/nEagpTZY8uFAWpoKSH9fowiqfM1VVxx9XoDw
	QtkmZv0WCnYKlqjUF4SmzIlf5X6g9ORtqqsj5HhIYPk7kI+YSelpJrh5
X-Gm-Gg: ATEYQzxHM8kwrajojgfhD+snZiRBes+H4tXtlgtKB6pxBT5DSklJo/pfaY4GI8kJUNl
	q3tIOE3Av5PMKCOG+VljLrlMg7Ior+cV6UgvMt0siyb73J7Uv1KDl/Y5NpTaD+9IR5PTFs4kmnR
	e3Deec8xxPPIpV7yTqMtnAMCBJ9WRqkiHp9hh9C36k+66OWQOQ5mD6Ub+f5eAgCuUWE3U6BEYPk
	fEtwvhvV0YIOBJLLw6V7uqjqhjv8/d7BgXKFsuBagP6NS3dWHSSzaKb/TAX4pTSV+QuZTtYASmA
	ZnWjdmI3WX5JwC7blF67l0UXgB5h/hv3+0LcQ3eB1y9FWuW66sOYwJuwPaxotqonMKLVRutXNZw
	s4uNnmVb2oESwV//l72GT5Sms5eSUVsEt+Pu4oMZXTZJ7389U/I29M6P9Qg+gBX585fUCl64jUe
	idUROyi7ZSg9/bCIIoRT7u5PHMPgdRzah8O3S5jcdfe9lF9r8AkZvp68plvA806H74XwuwDNxST
	sVc20SlighVjjX5x7s01744TL34
X-Received: by 2002:a05:620a:2907:b0:8c6:a5bc:8a90 with SMTP id af79cd13be357-8cfad1c20damr695621485a.14.1773865220886;
        Wed, 18 Mar 2026 13:20:20 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfacdb01ccsm292534785a.1.2026.03.18.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:20:20 -0700 (PDT)
From: danieldurning.work@gmail.com
To: brauner@kernel.org
Cc: mic@digikod.net,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
Date: Wed, 18 Mar 2026 20:17:46 +0000
Message-ID: <20260318201747.4477-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312.eNg0oog8eeHi@digikod.net>
References: <20260312.eNg0oog8eeHi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Mar 12, 2026, at 11:10:32AM +0100, Mickaël Salaün <mic@digikod.net> wrote:
> On Tue, Feb 17, 2026 at 12:33:28PM +0100, Paul Moore wrote:
> > On February 17, 2026 9:54:42 AM Christian Brauner <brauner@kernel.org> wrote:
> > > On Mon, Feb 16, 2026 at 07:53:11PM +0100, Paul Moore wrote:
> > > > On February 16, 2026 2:52:34 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > All namespace types now share the same ns_common infrastructure. Extend
> > > > > this to include a security blob so LSMs can start managing namespaces
> > > > > uniformly without having to add one-off hooks or security fields to
> > > > > every individual namespace type.
> > > > >
> > > > > Add a ns_security pointer to ns_common and the corresponding lbs_ns
> > > > > blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> > > > > from the common __ns_common_init() and __ns_common_free() paths so
> > > > > every namespace type gets covered in one go. All information about the
> > > > > namespace type and the appropriate casting helpers to get at the
> > > > > containing namespace are available via ns_common making it
> > > > > straightforward for LSMs to differentiate when they need to.
> > > > >
> > > > > A namespace_install hook is called from validate_ns() during setns(2)
> > > > > giving LSMs a chance to enforce policy on namespace transitions.
> > > > >
> > > > > Individual namespace types can still have their own specialized security
> > > > > hooks when needed. This is just the common baseline that makes it easy
> > > > > to track and manage namespaces from the security side without requiring
> > > > > every namespace type to reinvent the wheel.
> > > > >
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > ---
> > > > > include/linux/lsm_hook_defs.h      |  3 ++
> > > > > include/linux/lsm_hooks.h          |  1 +
> > > > > include/linux/ns/ns_common_types.h |  3 ++
> > > > > include/linux/security.h           | 20 ++++++++++
> > > > > kernel/nscommon.c                  | 12 ++++++
> > > > > kernel/nsproxy.c                   |  8 +++-
> > > > > security/lsm_init.c                |  2 +
> > > > > security/security.c                | 76 ++++++++++++++++++++++++++++++++++++++
> > > > > 8 files changed, 124 insertions(+), 1 deletion(-)
> > > >
> > > > I still have limited network access for a few more days, but a couple of
> > > > quick comments in no particular order ...
> > > >
> > > > Generally speaking we don't add things to the LSM interface without a user,
> > > > and I can't think of a good reason why we would want to do things
> > > > differently here.  This means that when you propose something like this you
> > > > should also propose an addition to one of the in-tree LSMs to make use of
> > > > it. While the guidance doc linked below (also linked in the LSM MAINTAINERS
> > > > entry) doesn't have any guidance for the LSM blobs as they are generally a
> > > > byproduct of the hooks, if you are looking for some general info I think the
> > > > bits on adding a new LSM hook would be very close to what we would expect
> > > > for blob additions.
> > > >
> > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> > > >
> > > > Getting to the specifics of namespace related APIs, we've had a lot of
> > > > discussions about namespacing and my current opinion is that we need to sort
> > > > out if we want a userspace API at the LSM framework layer, or if we want to
> > > > do that at the individual LSM layer; there is a lot of nuance there and
> > > > while one option may seem like an obvious choice, we need some more
> > > > discussion and I need a chance to get caught up on the threads. Once we have
> > > > an API decision then we can start sorting out the implementation details
> > > > like the LSM blobs.
> > >
> > > I might be misunderstanding you but what you are talking about seems
> > > namespacing the LSM layer itself.
> > >
> > > But I cannot stress enough this is not at all what this patchset is
> > > doing. :)
> >
> > Likely also a misunderstanding on my end as I triage email/patches via phone.
> >
> > Regardless, the guidance in the doc I linked regarding the addition of new
> > LSM hooks would appear to apply here.
>
> FYI, I just sent an RFC to leverage this patch with Landlock:
> https://lore.kernel.org/all/20260312100444.2609563-1-mic@digikod.net/

I was working on an SELinux implementation of these hooks as well.
However, I noticed that when a mount namespace is created as anon
the security blob is allocated but never freed. The free_mnt_ns()
function only calls ns_common_free() if a mount namespace is not
marked as anon. This seems to be causing a memory leak.
