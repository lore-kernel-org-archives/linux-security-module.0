Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EA30C615
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100126; cv=pass; b=AalTcQOWT0YM0/As3PX119+hYbTJN5h4f+4hvOH1oauXxXxQ4+b3o1Zg6aK3nofIAE3m+0JTTH9Mda9nbAjwwEceEkvZGPRICiKZ09n8KmOSBi1d7nMnHRYJtEv7qe0l0/wmywB3rjYEGouL4hoMq17vkDlfh4GKp7yybEmZqZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100126; c=relaxed/simple;
	bh=BQM1r/84FZPbEMnLWJoJvWekthijTM0FKoc/mFAshIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxmYsbvhM4EfYZ7nZgEycZKKn7sY7SnEtH79yhDWnl1C4y4SYARFmE8VZUR+qWV7L7h5xi0Rg3oLSFAiMKbP/8Ext0lL75ZaYF/APszm8ssVCY8ub594Pl58MWc97/hvU7QSERauKV1mfvR+1TpaKBwylKBg0TMifEfpylryu9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAtB3k5a; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAtB3k5a"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a871daa98fso30068795ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 10:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100125; cv=none;
        d=google.com; s=arc-20240605;
        b=VvFROX9Ne4ylxB1fn0aozHoCdd27je9WTivvNuQXeaSj+Laecjn3LPrQv8/LoCX/vf
         +7DTw1LYls5VgHTs+xlTgO+RP0vC1GidCfJ1ipYkuvKexqqPRSps02hDTKdJdQbuOPvi
         Yo8hZb8v/NpI7MpcKsYovAKFaW02EcOY7UHJfcuEV6D/4VTzu0/LIeJrFN3xdI5Cht4j
         YZl8ut0Lx82lOrzqEahnEScumTCnIaxG/NiUMjlQ1mTHG4SkgO/u7KRA8zIaV5PQI2r9
         0SHQrMLr24M7l8RZ9FfToiMpF2oiKjdtNyGGMjdCQPjo/DDk2cIU/HvIQl/FT1daiwEh
         dj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dWX7XGvryaiW8Ur5s1Ezqi9J3CllCXkzBbQJ6ajKvPk=;
        fh=LSQwQxF/2sM0B5VUs+p2/m/ZfuQXwAlfye0AtSlzdyY=;
        b=XgVlQwPHUPU0/R331kT02EtxYJeLHqKY7Hm5TO0tlVrA3tCxPlHEfoqB3pqtGg03CZ
         SE8qm3EDhTzyqVv/q2fCFcNmSlWgnP407G2Y5sxALpL6GY0Z9wM8y85YCigip6xA11dY
         047gBpp0u2tm6GzvErdXHXUCEBVvO8xuduMTYgAaynrPWIZm2hMEkaPMj1wGnFf6/weC
         a3eOJ784CJts92LWjSqWpdOnYaacvZZ46M4F0/3GYCg2h2o9VCDdvUWgR0CwJSeZUyH2
         a48wvys0246pg3GqXVSgKA4a5v3Ox6K39a1DLZ9xvlwipRZyeUCeTlf0hePXola7jRw8
         hMtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100125; x=1776704925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWX7XGvryaiW8Ur5s1Ezqi9J3CllCXkzBbQJ6ajKvPk=;
        b=PAtB3k5aRBT76QupBndnqK090LTmojvMZLV0FVnY69rrOXqcAK/9cFKr2qpQCq+wZy
         MhhfX4MziE4DgDg1nN88UhY5M2XYiARcMxNyT3nGVkBotfmQQYQHyHjZKgp2vgOEJUjv
         r6syp/R6pVEHGrzat6JLarYouoil2X2EtZsXOZQv3y7ghDz6Cj8f3hbUfzx0O1V5mBGU
         Ee+KGZCzXfRwDMgChl971pTMdTaLba4zMpmKsn/EObJx+V7joBp5yNjeWbAz8LMPgtxY
         RRzf5yTbwIVXGRJMYidp6PDDJhdV+Mg9fgc31zQkS2zZ/nVq08Ls3rDkUjm8gHXDgTR9
         cYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100125; x=1776704925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dWX7XGvryaiW8Ur5s1Ezqi9J3CllCXkzBbQJ6ajKvPk=;
        b=EjOtV11NRRwRhdUF2u3LDdsOca3ynImtU4DKe101XIB4Z1w16m7qxmetKZIx6y/9Mm
         j7RSyPDFpFhQbF3NdLXhEqcBqwbSi+iAxoqfEX95iApSsGrPXN9c4hHQ/fevTeOYb5qx
         UTxXA8IUDp26QvPEw1G0dK+pZlQVLUY42ez/b5knCpl0jzQt4Fp6RZ7a/66Dr+S+9J6X
         lCJY7Qc/ecc+BtcStr+SJfMex+vkhNo/4EHn2ArgrkgkwfFvjog2zdH0/aKLecu3PBid
         DshEbEMT7z0WEIBzgkiZNsrKZfYnMHafCkvI9NOmTRkEDA9bk7Ox5sm7d7IB3u8Ot0Y4
         OhCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9khZVOKVVSUtROQ6fB4izpWErn7YWHOsJ+WNoka4aePvi67kGokXqXJxlM1kSHn+xPDMupheJyXRDNKiJ96lTLmvGCg08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGifb2CalvO9rXqRVusS4OEfJ3FwlWM/2kUuLZWb3fuoG8/ZLT
	CRLlccPI1kHmlx9Jy4VDCqCuLphdunRTQBtUz6Jb3JE3NvAqGTdkfscxcL0wHXoNu2f4Wia6eR4
	JYneJOTkuYdvw8KmpF+ceG6y9rixpAhY=
X-Gm-Gg: AeBDievzGc8ThZpM3vRTWXq8Q3eSfB0xT7nNg07z+/iIiKyP7Z9eiiUZJOGrlpCUok5
	bv4LmWGw9e/KRlOMfDJJBqPdRfTxx7FatA2+Do+TGKJdEqXXPrj2ieSsKbU954LxS4+GiCX+i8S
	u2TPTbdjjzH7aForfztyRAVPmJQkEniTg89EMbP0q7XhchJ7ezqc0XxUx6ugxA60W7LcgvuP0F1
	iPRvY/8OvRwVpgXM+PLjI2Oe8U1+vHofAY8tnqZRHEDGA2htryaS4yzIbKRhnwfo8v4nBwPVAwI
	crvMMS8=
X-Received: by 2002:a17:903:acf:b0:2ae:ce35:2686 with SMTP id
 d9443c01a7336-2b2d59393fcmr147388255ad.5.1776100124833; Mon, 13 Apr 2026
 10:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adUBCQXrt7kmgqJT@google.com> <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
 <20260409-entbrennen-turnschuh-54af9b45610e@brauner> <adoIGHwgMJSuRfE5@google.com>
 <CAJfpegv6GDFZjdGrQ=0Jahvz5mSgfJr+GvjVwws=SFX-yirpSg@mail.gmail.com> <adzgKVIhRj5t3GqM@google.com>
In-Reply-To: <adzgKVIhRj5t3GqM@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:08:33 -0400
X-Gm-Features: AQROBzBQQJs-srsJZYscUyKeQo1GJMBsNHe281XF0xi11LSzNp6_95RMzU_BCv8
Message-ID: <CAEjxPJ5XWFwv6wyznRP53yokYAq82FZ07_UfKRXXb+eP5h_oow@mail.gmail.com>
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Serge Hallyn <serge@hallyn.com>, Amir Goldstein <amir73il@gmail.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 8:24=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.c=
om> wrote:
>
> On Mon, Apr 13, 2026 at 12:18:08PM +0200, Miklos Szeredi wrote:
> > On Sat, 11 Apr 2026 at 10:36, G=C3=BCnther Noack <gnoack@google.com> wr=
ote:
> > > I also don't currently see how an attacker would abuse this, but I st=
ill see
> > > this as a violation of Landlock's security model if we can create a p=
olicy that
> > > denies the creation of character device directory entries, and then w=
e still
> > > have a way to make them appear there where we previously had a differ=
ent file.
> >
> > Look: a whiteout is a whiteout, NOT a character device.  Don't let the
> > fact that it's represented by "c 0 0" fool you, this is a completely
> > different beast.  See commit a3c751a50fe6 ("vfs: allow unprivileged
> > whiteout creation").
> >
> > Does this beast need special handling by LSMs?  I have no idea, but
> > treating them the same as char devs sounds like a bad idea.
>
> Thanks for the pointer to that commit.  I was under the impression
> that creation of the whiteout objects required CAP_MKNOD, but it seems
> you have dropped that requirement in that commit.
>
> (FWIW, I was mislead by the rename(2) man page[1], which is apparently
> not up to date and where it explicitly says:
>
>     RENAME_WHITEOUT requires the same privileges as creating a
>     device node (i.e., the CAP_MKNOD capability).
>
> So with that assumption, it seemed natural that this should have
> extended equivalently into a Landlock policy.)
>
> So if the "c 0 0" whiteout device is indeed a different kind of file,
> maybe we would need to treat it with a separate Landlock access right
> after all then.  I'll ponder it.
>
> FWIW, besides introducing a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
> access right and adding more special cases to the Landlock API,
> another possible option might be to just forbid creating whiteout
> objects altogether, when under a Landlock policy.  As the man page
> also notes, "This operation makes sense only for overlay/union
> filesystem implementations", and since these likely can't use Landlock
> anyway due to mounting, I think there would be no use case left where
> anyone would want to perform such an operation within a Landlock
> domain -- I don't think this would break anyone.  Micka=C3=ABl, do you ha=
ve
> an opinion on that idea?

Just as a point of comparison, for SELinux, I see the following
permission checks occur upon renameat2(..., RENAME_WHITEOUT):
1. add_name, write, and search permissions to the destination dir
2. rename permission to the source file
3. if the dst file already exists, unlink permission to the dst file
4. remove_name, write, and search permissions to the source dir

And the following permission checks upon mknod(..., S_IFCHR, 0):
1. add_name, write, and search permissions to the destination dir
2. create permission to the new chr_file

So we are missing the create check for the whiteout file on
renameat2(); not sure if that's working as intended or a bug.

>
> =E2=80=94G=C3=BCnther
>
> P.S. Initial patch set from Saturday is at [2], but this still uses
> the LANDLOCK_ACCESS_FS_MAKE_CHAR right.
>
> [1] https://man7.org/linux/man-pages/man2/rename.2.html
> [2] https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.co=
m/
