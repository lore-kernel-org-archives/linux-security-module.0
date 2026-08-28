Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829F3BED44
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787951459; cv=pass; b=XBpPDBUbutHXc8YMc8l4VYzR0kt+lY7S8JvL+iDQsacJXIqYKCtdOC7kpDhPu9QEdXCQ0cX/2mDL4CBU3f5gQVnqxIDgE7KHV3KaWmGxvvCkZwQCEP52848e4l2bQlcb2j/Emd6/5eegYhg3Tt6yXijARctK4tabYamWuxXwzgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787951459; c=relaxed/simple;
	bh=mtCf7Axavx4JuRDXMpzt5yIYvFz1DJFkcnTltfwKTRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5piH0G3DZha774e8PIZr+LUFjtCQQ8ETJo9fzH9pj88BPNonXJrOjjSb1vUzMGq5dTb5tNVBrFArJwzMZ6XKO4VzyJ9V+iC7G4bymrlTb3aUGqYI3qs3nW+fvzN6d8U9CojrnKnFbHaSphQfG+2gIhBkKDh+XHcQHRJRjnBuKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NZNj2bX6; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NZNj2bX6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d58efc7356so16353375ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 14:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787951454; cv=none;
        d=google.com; s=arc-20260327;
        b=lKtkswZrU/jOpGh568ft5/WyW2alVTmQF44kDmVo4sYgdl6t1VQOfrofe123N7v6aH
         e9wcWUMA12HNLWXkmV7ACU5IukcPxCnoTFb7VlZr9ndQm/p98HsyzJZru/IZbMPCVd4s
         ZU51d6stpS4nz7yAN+4y1c9/DP78ZmmU8C6wg5OaXWhBP4NixpS4mXfgBlKxA/6/SG9l
         2mUiizijhSNuPcyBCFKAl14hh9Uugfuwsy3b3oPA++68jzIU/OzqbROwjWoSN4541WIB
         8W4rq9g4TJIUCvrAw9nzlP2Ef8iGfzQ6BZa0ZQ+g7IX7GlKAStcSk7ucTKZwWsxYLA8l
         ACUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tScSPJONssrRk2WXz6/33ewRDUw0skQt8yglR8/KZoI=;
        fh=qP9gXhiUDlniicl0BOggRN37obUxAvz3tLpf/JPfK58=;
        b=B2LBDD1wG/AQ6Go/IGMilBPpzWarHAP8lTbam+QcCIuEREEuvPHnl71azBkJtO7euL
         kd3ysREYnlndurKepeXjJu3kvl1g/WgNB9PQ7Qwrvc/4mELssIjyPoojSq76wr9R0Imp
         LIrlhuQYnGBz40hKczjWuQgJox/9TIVWL8nF+w+3unPnp5xYy4rxzBxlfit6/H9yb51H
         jTq6JxrHtCfrJmTJIXC7E5PpCeOAvv2tIecQQJCJ89CHKwBHeSw53bq5zlnpzMPdcm2D
         IXh2we+ee0hsqndFiN8tIQZ7vzixyxoG0pB5onXWRAYLaYEUgCyRNWSeA6OzjQx+m2pX
         3KWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787951454; x=1788556254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tScSPJONssrRk2WXz6/33ewRDUw0skQt8yglR8/KZoI=;
        b=NZNj2bX6xbKkjBScY8ghAre5fofb9cbsSoh+5RuNYI6yIIoTaMKNOa6qDa6644Op2F
         QUCmKx0EaBdbau5hqBLcmYyiyaNZvbR5SV/bpw97WqPuPbc0OKsSoho6dQMZpG6w8BdO
         Hfd9ptINnaKOciZkS25LPGo0ww8FLE5OGxoC5+IMkphaovKKrsXKq8n/9XGuykyzYnPs
         TmA5M36fUYnN/S6KoTp7hgAwrHj9I1Pt1z4TLs+i7rmCowJnhHktBsbJllX4n19etVx8
         /V1XG5K3R/FypX9MSe2rqlj5agtfCOz/XodCuWUY1YLOD3i6CyjfiILNgzfnVfjXXFO2
         kFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787951454; x=1788556254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tScSPJONssrRk2WXz6/33ewRDUw0skQt8yglR8/KZoI=;
        b=iIsbQ7PfTd0W6DPP6F9fjOwbRY5FCV3j3FJFXIZ8KHR1rIuW158zVYhvGuekmSQv15
         CH3eNa0M7m8M+GSxfHrQi6zqCAf/xF0LSDgPURKl+X6FxbQu2KYLrc1KzkB/6G8Ayg2x
         1764lv6TQHqAKI5W3vfgo29ctVqo5cI7wawqnYCh6em+bWW+nx38HFYSeCMg/mfq9EdO
         OiXfHwMFBle2oFMRy9HjAiFvS8Xlh70uuSOtlNM+xPENASiL3WpE+T3SsgHJsdRPh1gM
         igZk4xOhFqJSq8V8/TDw6AZv4FU9tkrpKum/E3wdSiOtiicbliFxs7Is2PGnFBRiJcM1
         zGsw==
X-Forwarded-Encrypted: i=1; AKwUvBz69LK51gyQ80s+6m4ReNw18ieYIkKIgfeIPgnY4m9jzO43SaHf1TL6dH5Yzy7n6lj0ncTKU6erZ3olPyN5qXRvMrS5rss=@vger.kernel.org
X-Gm-Message-State: AFuF++l0Fv+6CmwYQYAO01w7VaXwmdGF9u5C0ACFU9awSbMbQDU0ese3
	P6lCwSzLANPzdzG6S7r2Dl+OpHVOnQG08SH4bZMWUbgr3skjyf90yCI+u8HEI1IXrXPz0Gllx04
	4bViWHgDlgLFT+xa4tbMNgUKE9wwHtAH+AZCG4Zd3
X-Gm-Gg: AYBFou0v1wcjGc03ah2nQcAFGMJmct04UwGhPXObg7erDNz6GSv3k282cfTCd3i3tSG
	OUtgCJcHU1jmuIZFGN6gtHKMZWT5Wm0iKesq66z7IDe7qWzm21aJR4XnnBrNR+GJM0hPC+qrPOE
	6Z44IdJ2WN3fzGr9QehHj/HMbe2jFPsXFCbkCjFlHvZ7KwbbqC+QGczg3EJDt1AMavRnzwXzkfa
	XiO1lWWUnBH7qpJX5k0TXxfIp3cYFj5bHOeOOj+SWB/5Ux4pJkx4BhFcTJcG8BeMH2BlUXDFFAc
	l+jYwpZRJSypwFmYjCYGoI7otVyeS1vm00Kh9iuv11LXiOH0XkkdZFE=
X-Received: by 2002:a17:903:b83:b0:2d8:d4d0:792e with SMTP id
 d9443c01a7336-2d8d4d079b2mr38565945ad.18.1787951453839; Fri, 28 Aug 2026
 14:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
 <82929c994076d95f99560ecc67f6cfce@paul-moore.com> <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
 <CAG48ez2jgJHewZYK1SVccJmBa=bjoMW80SPNcbgW2XCtZaWhjg@mail.gmail.com>
In-Reply-To: <CAG48ez2jgJHewZYK1SVccJmBa=bjoMW80SPNcbgW2XCtZaWhjg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 17:10:42 -0400
X-Gm-Features: AcwNN1WNKsySMz2VwH2iqet3Ed_WMqL6Q3m5wfbte2R22sYcRFQ3wDSSX0w0dFo
Message-ID: <CAHC9VhSHMmJn4bkRUodAnrVGTb57qZx3tL26g91jD_ocQCNLeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Jann Horn <jannh@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:21=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 28, 2026 at 3:03=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > Beyond that, we really try to avoid making LSM hook calls conditional=
.  It
> > > can limit what an LSM can enforce, it tends to be a bit more fragile,=
 and
> > > it adds some unnecessary work in the case where CONFIG_SECURITY is
> > > disabled.  I would suggest passing 'opened_by_owner' flag as a second
> > > parameter to the LSM hook and calling the hook unconditionally in the
> > > default switch case as a replacement for the 'return true;' statement=
.  I
> > > understand it may seem a bit odd, but we try to make the LSM interfac=
e as
> > > generic as possible with respect to different models and this is one =
way
> >
> > I guess I can do that, but then the question becomes, what other modes
> > of using the LSM hook that don't currently exist in the kernel should
> > I be supporting with this? I can make this a parameter, but any LSM
> > policy that actually uses the parameter in a different way would
> > probably be buggy/inconsistent, unless other new LSM hooks are added.
> >
> > If your intent is to make the hook work for any /proc/$pid/mem access,
> > including when the caller is ptrace-attached, then I guess I have to
> > move around the security hook call in proc_mem_foll_force() a little
> > bit. I guess I'll do that in v3, though I really don't like trying to
> > come up with a reasonable in-kernel API contract for a scenario that
> > currently has zero users.
>
> I started thinking about how to implement this, and an annoying aspect
> about this is:
>
> Currently, I only have to look at the credentials of the opener of the
> file - that is both the subject and object of the access. But if I
> want to provide a hook that works for any /proc/$pid/mem access, and
> want the hook to know what the object of the access is, and do it
> race-free, then I would need to grab the creds of the target task in
> mm_access(), bubble them up into proc_mem_open() and mem_open() (which
> will require touching all the callers of mm_access() and
> proc_mem_open()), store them into mem_private there, then let
> proc_mem_foll_force() extract the creds from there. All that would be
> unused code.
>
> Do you think I should just not provide credentials for the target, and
> document "if opened_by_owner is true, the subject credentials are also
> the object credentials; if opened_by_owner is false, you don't get to
> know what the object is"?

From my perspective there are good reasons for not making the LSM hook
conditional (see previous emails), but I will happily admit that we
don't have any (?) good reasons for attempting to generalize this hook
beyond what it is at this point in time.  I would suggest documenting
the limitations when opened_by_owner is false and leave it at that; if
someone wants to implement something that requires more
hooks/parameters we can always revisit this.

--=20
paul-moore.com
