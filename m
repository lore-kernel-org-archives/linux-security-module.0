Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7724169F
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058806; cv=none; b=pUdlwrTrWfXhpBZMPHugWubhDZodH3ieEyngcUAH9Sj3YwHJm8yMFJ36pA9uT6nQQ2VBViw9ph/sS1Cai7D8hLULmDszon4XmVLnZVpxg2abBqAnkwK/K6Dzni19DdQ0SBmWTRlxR0I1JzyUz0fLBdeqFKUH0/aBfJPPXMTEjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058806; c=relaxed/simple;
	bh=hzH6PANLdN5tTTnkLxqdJV7vlqd/uoM78t4ky3//LLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTNCypJJT9Q/T++AA5iaiK0yPL983LhiXiz1oHUP3PpzuuOSsOC0nFs/6WLx42p3E6Xyn5r1ZthjTPsNHy29DR+Y9p5VDIpN10zaJetPKqqv/oJ7ZC4+aJ/qDC7qD13MCIMbLVzxB6G8VIBvMKASsFTG0PnToxmQZNIl4mVDK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eC0px8Rz; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eC0px8Rz"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso2284141276.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737058803; x=1737663603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgH5uLzPUPXokFQEMqrlTtH1CzspUoJhCVBwipv1S8k=;
        b=eC0px8RzBegOqH+Pjw/Y/BbuMTFC3d7ruVw8TITcbZiGvJQYbwKGlzmJXk2uaslMQq
         bqKEMy84zJH6eajmuQMa57JBhsrr1ZJ2pZyv4HdS3Eadsn6UGP+Fn9Wt+QLmDYNuVLD2
         zXhec0Znj/CfNSmIjmRkbS5dVHmW11NNh4ttss2iTy4bK15SBWttQ/ItEHD+TQh0UrXF
         LATsT1mw7QLg7BJB/8e95S7Bb1vl91q16yQ5CZ1vWAArGpHtJYW2dO9OpBIwxjBw5B4L
         mOnUsQjClS/bcsrWuTTIIVgH30USeC0bfZN91Hbm0vXJ4iNP28QiPvQRw9yfvSJKwJJ3
         IkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058803; x=1737663603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgH5uLzPUPXokFQEMqrlTtH1CzspUoJhCVBwipv1S8k=;
        b=ZrbmVRlB060F78FIh2YwrIllavNJwh1FutrS1gr5OOG/i+a5mmILZmdJNBvNFhyiJ1
         BaCQdwc2JV+graniH2OMjwXtQ/Z+ZCe91JbgHefAin2dvmab05ETJYSr5j1LH61kIy+Z
         hZOyC5bUv00KoiMiX0PPeup6m4YeS2n02GA4yLYTTvImdu4kl3Btfa7YmoJrRKWrggE6
         tT0NT3sXfghgWylUIo0EjPtukuSQ0gJr3ZO86zqZ+8DoGbbInVOl8zuj8IsmQkiqhJQR
         nXK14OuxlZjFB+ebUX/zp0JzCT+nxnjQkIvovoCPlhGL/3flfMzS2f9lj1/XwunZ2AET
         Yq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm/q/mc4wNSaJxdQfKoUW4UG4R1Lpa7aKsqcjgH9HvRaKgca4Fr9+pe3Wfg4xxRB98lDaxpQj/QIzRshu7d3doDy6cJ44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtoBLuL/ENG+8s1Wsg16mpQegGLYq8VvG3Do8ejDXgNtzDrZbJ
	R+epEUrWO8Dgszli3Y+fuSR8/FSL4G3nt4cIdh5AAinKCybBpVXro5U/euMl5n0UVnNM2N566Jm
	tYQks3SXyoZvJ4qkLRvD2/ZHr5hY6ps70+Lhs
X-Gm-Gg: ASbGncuncym4Is+ouSun+dUv3OqeDNdv9hz8m9MCpyNKFzbvyWI5EzE9CTEVnapMKgO
	gQow5GsxrpVQmSQ1kVI61kidv3ovZrY3wFfDe
X-Google-Smtp-Source: AGHT+IHJ4Mak+9bO8l98dAIo8ibEp/prPdIFCHVfKZmp/jDOS80i8M4ujqDQKqw4Ro9BxzXybOI3kNcIj6BQlb1PY3U=
X-Received: by 2002:a05:6902:144b:b0:e57:4031:b32a with SMTP id
 3f1490d57ef6-e574031b49fmr16648786276.34.1737058803664; Thu, 16 Jan 2025
 12:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108154338.1129069-10-mic@digikod.net> <1a169f22750aec9db4d7a377a4f99733@paul-moore.com>
 <20250116.eeThieR7aiph@digikod.net>
In-Reply-To: <20250116.eeThieR7aiph@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Jan 2025 15:19:52 -0500
X-Gm-Features: AbW1kvapJ6OG19ZIuUJok9mpcqb68UnmkwhronhpYuIPeC2gEoZmgBs_Kw1oHL0
Message-ID: <CAHC9VhSu9ZB7nOR13VnurzYCK6hu2TsLXtQSP_XqQ5dJBX-EVg@mail.gmail.com>
Subject: Re: [PATCH v4 9/30] landlock: Add AUDIT_LANDLOCK_DOM_{INFO,DROP} and
 log domain properties
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:51=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Jan 15, 2025 at 06:53:07PM -0500, Paul Moore wrote:
> > On Jan  8, 2025 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:

...

> > The audit subsystem is for security releveant events, not diagnostic,
> > debugging, or other "nice to know" messages.
>
> I agree, my goal was to only log denials with the minimal required
> information to make sense of it.  "minimal" may be subjective though :)

As a data point, it may be worth mentioning that it is not uncommon
for heavy audit users to generate more than 1TB of audit logs in a
day.  So yes, the scale of audit can vary quite a bit.

> > > Audit event sample for a deletion of a domain that denied something:
> > >
> > >   type=3DLANDLOCK_DOM_DROP msg=3Daudit(1732186800.393:46): domain=3D1=
95ba459b denials=3D2
> >
> > As mentioned earlier, I don't like the number of different Landlock
> > specific audit record types that are being created.  I'm going to
> > suggest combining the LANDLOCK_DOM_INFO and LANDLOCK_DOM_DROP
> > records into one (LANDLOCK_DOM?) and using an "op=3D" field to indicate
> > creation/registration or destruction/unregistration of the domain ID.
>
> I can squash them but they're just not about the same semantic at all.
> One is an asynchronous event that describe a domain, and the other is a
> synchronous event that informs about the end of a domain.

From my perspective, both messages report the status/lifecycle of a
Landlock domain ID and are thus well suited for a single message type.
Personally I question the value of this information, it seems overly
verbose when the access control decisions are the important things,
but you seem to believe this information is important so fine, we'll
add a message type for the domain information, but you only get one.

> If we use an "op" field to differentiate these two types of information,
> it would probably be "op=3Dinformation" instead of "op=3Dcreation" becaus=
e
> the audit's timestamp will not identify the creation time of this
> domain.

Call it whatever you like, I personally don't care so long as you
don't reuse a single "op=3D" value for multiple "operations".

> > > +static void log_node(struct landlock_hierarchy *const node)
> > > +{
> > > +   struct audit_buffer *ab;
> > > +
> > > +   if (WARN_ON_ONCE(!node))
> > > +           return;
> > > +
> > > +   /* Ignores already logged domains.  */
> > > +   if (READ_ONCE(node->log_status) =3D=3D LANDLOCK_LOG_RECORDED)
> > > +           return;
> > > +
> > > +   ab =3D audit_log_start(audit_context(), GFP_ATOMIC,
> > > +                        AUDIT_LANDLOCK_DOM_INFO);
> > > +   if (!ab)
> > > +           return;
> > > +
> > > +   WARN_ON_ONCE(node->id =3D=3D 0);
> > > +   audit_log_format(
> > > +           ab,
> > > +           "domain=3D%llx creation=3D%llu.%03lu pid=3D%d uid=3D%u ex=
e=3D", node->id,
> > > +           /* See audit_log_start() */
> > > +           (unsigned long long)node->details->creation.tv_sec,
> > > +           node->details->creation.tv_nsec / 1000000,
> > > +           pid_nr(node->details->pid),
> > > +           from_kuid(&init_user_ns, node->details->cred->uid));
> > > +   audit_log_untrustedstring(ab, node->details->exe_path);
> > > +   audit_log_format(ab, " comm=3D");
> > > +   audit_log_untrustedstring(ab, node->details->comm);
> > > +   audit_log_end(ab);
> >
> > I'm still struggling to understand why you need to log the domain's
> > creation time if you are connecting various Landlock audit events for a
> > single domain by the domain ID.  To be clear, I'm not opposed if you
> > want to include it, it just seems like there is a disconnect between
> > how audit is typically used and what you are proposing.
>
> For the reasons explained in this commit message, domain's creation canno=
t
> be logged synchronously as other audit events.

Yeah, I've read that, and I disagree.  You *could* log a task's domain
creation synchronously as creation of a Landlock sandbox is a
process/syscall triggered event, you're *choosing* not to do so until
a denial occurs.  That's okay, but I'm tired of hearing that used as
an excuse to do other silly things.

> However, timestamps are
> useful to place them in the logs and order them according to other log
> messages (i.e. to enrich log with more metadata).  Without this domain's
> creation timestamp, we cannot know when it was created.

From my perspective this is because you are choosing not to record a
Landlock domain creation event.  I still have not read any reason why
this is not possible, only a design decision which is now causing you
to do some other unusual things from an audit perspective.

> This
> information is not strictly required but I think it can help get back to
> the creation/creator of a domain.  I'll remove it if you think it
> doesn't make sense to have such information with audit or if it falls
> into the "nice to know" category.

Ignoring my comments above for a moment, it does really seem to fall
into the "nice to know" category to me, but if you feel strongly about
it, it's okay to leave in ... it just isn't really consistent with how
things are generally audited.

--=20
paul-moore.com
