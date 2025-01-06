Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D751E048B
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200624; cv=none; b=QxGPtukiGwZP/s+ufYTkL3ELXb36F7OHpora8WmISxo0K8ninvcob3d0ZUptzJtD+KpkNvaUDLHyxzwuyp2TScVd3SGVX/mcpD9BBdrBamwkOHo4iwXOuEjQooJicn+yYcD961nKcUFM9Xq8bjWPmajhJd34NKgJcgGIL6rbrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200624; c=relaxed/simple;
	bh=GrtQDJb+twssJLjC6Kvv/sZHfycRVnsWGZAKCD5cmCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnA3IxgZ0qZMzD8VTbezPUVf8iQAlvmqWD8OLadGFM5CzEGXGMGtqPoQQzfpexj0a+kJI2VbAVSncs0yZ4DTvB0skekeWDpuG6nudxQxnMstmnrBNXOsBRxwFC4gF4ANRawmLSXNKCMCpNhQFN58MnwcAWTEcdLfsI2x/lYxSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RbiRO0n8; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RbiRO0n8"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e54bd61e793so2485353276.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jan 2025 13:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736200621; x=1736805421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ARa0zCGvqdPtaQ+iQc5T+J1GrOh+InVYBW4pMMFrU4=;
        b=RbiRO0n8Ag3+XSX3VsIrJToBQvJPMWsXW2+lZe7iuFbqpdS6Sd+lOT9/wKSUUuw9yl
         pL0XN24hRWpWccp7NTCN81MGgfbOqwx1HkwMOAhbrUHw5x2NXOGCrJBe5jjDMizuk4hy
         ddX+gOKnA14zg74fE9ODEX/sV7O8OpK38ZfMx/UQhBXAjfdtqyf2I7YqhYKfxQUxdWjh
         at/J+mIr5wIJ68JFaE2LQV4MnixOhUdU+++c3BmbyMWGnvPxeIDhZCoib0+HmfW/KWg+
         dpfnxUSur/xYB3XKE9UB+r5rtZy/qEV845fs6UFmxEDZd8WzJx+OPLpwN6hqVpQ7eXXx
         OMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200621; x=1736805421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ARa0zCGvqdPtaQ+iQc5T+J1GrOh+InVYBW4pMMFrU4=;
        b=usHc4Yg8YGbmWtj1mIPnkAgQnYvp+GJgPCtzFJI2Jx8+cdE1gvrsbXpOd6suDMe3vb
         0gA3xnf+rPQs7i7v9qNi4C6n4tXmB6BusU4KeSVFOnnvdWhhQDxV3G8QImYs6kM0JcS7
         byEotUd+CB6iLWH3YhaFKcVUDl5gvLuqMcXmvxYWW6st6b2tBc4gFv2UHLEc33b6yPwZ
         qTIesUk8dw0c2z37dakdFdldbvSZtY6RAmwbzZF5a/ZODgpx/bYfFkw/a/PquL6SdslT
         YKuH+2h3j2eFZffGOIfV0RaV86uLidNNulrFU8uF/WY+/3vILq9X5Gk97/7Ec9fVtzx4
         cpgg==
X-Forwarded-Encrypted: i=1; AJvYcCWSl3iKKCnnuIA7HiSuAAjXrUen1x2fw2O04QRwrcrfMmed1h9+kaJoGKgwJTNLm2b43/eZqR4J6Kxvy7aWYBrFMqyHFb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5k1zgz1k+eZOedFJ1ag0eXsE/Mb7+eQQfVZjASns+3RlMMMIo
	C6M590YA2PMq188RdrbdLg35Clsc6F0Q4KhlueHd+PrSqSb2CNyNoDCkjLWK8VUZdmz/ehs40rM
	7oSm8rOn6OCa3LgHSem8TlTs4a8NoyrmFJGh5
X-Gm-Gg: ASbGncvTHq29gRsiO+qT4/LQkAnpGjjd/rpNJBybmXudSs/W76ZpIZghDwPhN7YtTQh
	pRMm0vyrRvmTp6X+pLq73Y0UEBHbP5Sq+1ZQt
X-Google-Smtp-Source: AGHT+IHPuvJvJAXeboVFnSiBK5XS83y2yyt1OxbD8VkKSr9+QTEL+xmBBRLBj+EuyKGNzWS7MFXb90EjBn/IVVYaZa8=
X-Received: by 2002:a05:690c:4d86:b0:6ef:6d61:c254 with SMTP id
 00721157ae682-6f3f82413ffmr419313447b3.38.1736200621343; Mon, 06 Jan 2025
 13:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122143353.59367-11-mic@digikod.net> <237bfe2be7b4ba5d59b3b832c23622bb@paul-moore.com>
 <20250106.ohgh8Zeu6coo@digikod.net>
In-Reply-To: <20250106.ohgh8Zeu6coo@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jan 2025 16:56:50 -0500
X-Gm-Features: AbW1kvZTl7s3th7FvYN4riS8lYBxye-y1t0qQkW9YUuzgax2JZptYODrJfZeE3E
Message-ID: <CAHC9VhR7EWDm5afnzRbVO6jkqtwtBe-UbHk+b-bED7uwisu_bA@mail.gmail.com>
Subject: Re: [PATCH v3 10/23] landlock: Log domain properties and release
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:51=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Sat, Jan 04, 2025 at 08:23:51PM -0500, Paul Moore wrote:
> > On Nov 22, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:

...

> > > Audit event sample for a first denial:
> > >
> > >   type=3DLL_DENY msg=3Daudit(1732186800.349:44): domain=3D195ba459b b=
lockers=3Dptrace opid=3D1 ocomm=3D"systemd"
> > >   type=3DLL_DOM_INFO msg=3Daudit(1732186800.349:44): domain=3D195ba45=
9b creation=3D1732186800.345 pid=3D300 uid=3D0 exe=3D"/root/sandboxer" comm=
=3D"sandboxer"
> > >   type=3DSYSCALL msg=3Daudit(1732186800.349:44): arch=3Dc000003e sysc=
all=3D101 success=3Dno [...] pid=3D300 auid=3D0
> >
> > As mentioned in patch 9/23, I don't want subsystems external to audit
> > to access the audit timestamp information, so the "creation=3D" field
> > in the audit event would need to be removed.  Assuming that the timesta=
mp
> > was used either to reference the original domain creation and/or simply
> > provide some additional information for analysis, all of that informati=
on
> > should already be in the audit log, assuming of course that you are
> > logging domain creation (which you should, at least as an option).
>
> As explained in this patch, we don't want to (and cannot realistically)
> log domain creations.  That would make the audit support for Landlock
> unusable.  Moreover, these information is useless and only add noise
> unless there is a denial, hence this asynchronous approach.

That's fine, just know that it doesn't change my thoughts on exposing
the audit timestamp.

> However,
> users may want to log some syscalls, including landlock_restrict_self(),
> and it would make audit logs more consistent using the same timestamp as
> the Landlock domain creation time.  I'm wondering why exposing this
> timestamp to the kernel would be an issue whereas it is already exposed
> to user space.

Currently there are no other users of the audit timestamp besides
audit.  Making the audit timestamp available to other subsystems makes
the timestamp less flexible over the long term as it would become, in
a way, part of the API that audit provides to other in-kernel users.

I still have hopes to rework a large chunk of the audit subsystem, and
keeping the interfaces between audit and the other in-kernel
subsystems makes that easier.

> If you're really opposed to it I can create a new unrelated timestamp
> specific to Landlock.

Yes, at this point in time I don't want to support exporting the audit
timestamp outside of audit.  My guess is that you probably want to use
some identifier, other than a timestamp, when trying to link Landlock
events (presumably the domain ID would do this?), but I don't pretend
to know the details of Landlock very well right now.

> > Also, is there a good reason why the LL_DOM_INFO information can't be
> > recorded in the LL_DENY (or LL_ACCESS) record?  I think that would be
> > preferable.
>
> The goal of the standalone LL_DOM_INFO record type is to limit useless
> log verbosity.  Including this information in LL_DENY would have two
> downsides:
> - it would increases the length of *all* LL_DENY messages

Are you ever going to emit a LL_ACCESS/LL_DENY record without a
LL_DOM_INFO record?

> - it would make it more difficult to extend this new mixed messages with
>   access-related informations (e.g. file property) and domain-related
>   informations (and associate them with either the object or the
>   domain).

How?  Please elaborate on this.

> > > Audit event sample for logged domains deletion:
> > >
> > >   type=3DLL_DOM_DROP msg=3Daudit(1732186800.393:45): domain=3D195ba45=
9b
> > >
> > > Cc: G=C3=BCnther Noack <gnoack@google.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20241122143353.59367-11-mic@digikod.n=
et
> > > ---
> > > Questions:
> > > - Should we also log the creator's loginuid?
> > > - Should we also log the creator's sessionid?
> >
> > Creation of a Landlock domain can only happen through the Landlock
> > syscalls, yes?  If so, that information should already be logged in
> > the associated syscall record (see the "auid=3D" and "ses=3D" fields )a=
nd
> > we generally try to avoid duplicating information across records in
> > the same audit event.
>
> The specificity of Landlock compared to existing supported systems is
> that we cannot log domain creation for the reason I explain before.

Can you provide a link to that explanation?  I'm sure you explained it
well, but I missed it when going over the patchset with a focus on
audit.

If the Landlock domain is created independent from any user/process
action, it likely doesn't make sense to log either the loginuid or
sessionid since the domain creation is happening independently from a
user session.

--=20
paul-moore.com
