Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD136285C92
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569422; cv=none; b=B5W2i/Ivf5CsOkrX9BK814TWN/OI9l4bcRGK6l1zjj4fkt4nV6/t09OeTKrkdZMoG2j5VbmvRFNTH8ANpsLaAAkVubdcpf4MCOBYM39a4NbHkt+WUgEV91OdVbAv8GFvC/5BPrfdwxRXSObLkAmo+0gDgKFM7qmVvfgduUwIFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569422; c=relaxed/simple;
	bh=M55kfbiA5WNrGJ3r6EqFqgctDNfA8Xd3Z8+bi9BHwqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTLUxh5Mu9AXKNCeJn5NtB4rrr6lh2jKnjJ4AvwPiGZosKzOlaWB2EQqH7sIoQlMXi4OR2nvDgu5/9iqU/P8JLi1RAAiyGPP8aQqBs8UMHAtOGXf/hs+Wa7yVFEUvNT1m11VSpxkRfHdyWz0L2DXj9jBhy/bwGPL0qDddtKzYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a5L0TJsa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a5L0TJsa"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so8283571a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758569419; x=1759174219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvdWOntfA4A2sQxeMILs61f9nOsNLek7agJHp14BnZw=;
        b=a5L0TJsaSgtelL6PwfSc5g1RGH5xXQFmKj5F1lLBAeFsG69TsSvyMsSrFNtc2wPL2a
         whvVf+1P6Xvn6utJdbFrhO8fyOhXDoBY2rlST9n/D0rmICcvUF5O1dzXv9inJoECHO9X
         ilXyo8nEQz1QpOhlnDnQmz0lHxNKPiNHUrv4jk12thJRYG6FqJ7zCf790fiTUsUzjuZm
         948+9zbPqmkPppmpcFykZDpX4SBd3I5vVjLb/gpoN1c2LoYLk5oBAjhEphmxQDiMnb7x
         wAPV6rdtxYN3pr+QaE2TKzq0FR+A5G8hVdAolnBiI+qM7V/8LlkuDuBsTGO7sQfIcFTs
         xrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569419; x=1759174219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvdWOntfA4A2sQxeMILs61f9nOsNLek7agJHp14BnZw=;
        b=UXegwRISy8w6HBDHLFsxVY06bkJTKNwHT5X8qLPwIj8sH/mSvnfMpLD3gvjLkt7J4l
         SIZELVTQnvrWgUQCMhbGAaY9jduJ5VewlWGtlYuUdynnCMuWHPTd4e533wvlXJA8sV29
         VufyB9ZOLlV1D8Sd/n4mK+rDQjyCOV/ZqjeoD5BBop36gmUfTEnFXvfdxLymLUPTvS6X
         bVvlxJxCo/EB0bnggp1D7DTu2CqNZLVahUCtSowN5pnMZSFZuvA3BBDLLofQXBEftCCF
         iZvhaVQvYY+q6jl/AxHhd3y308nxin6puIWyuGVleizK4hTVDk3g0tpiOfJd8FfpPvLb
         EY4w==
X-Forwarded-Encrypted: i=1; AJvYcCX6QKwT9KW/1xJBSkg9o+B9CkQvPR3FCKX0fD4vKcCUUKPj581IyF7+gyp1WH7o2ChboRubLiGEZVWWrE9IvxWIeAKBsME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7sq/U0rDsdCW75FfQpihKl3K4+eU/1Ixbgf3ap3oLv9SkF0p
	RJazY4oZ3P58oF3ON1yeKLQ7eNCP6QxAyKnnrbvk5Xnk+3hs11KbXnzFqx5sCZA0ILImq/PT7uI
	aOcwfJkJHLlDeuqnK9Y472vjI/btrU2OT39/+ghyg
X-Gm-Gg: ASbGncvipft9G9Q0Ik9xbJ1YxRt6v9laqkrrpHWi5psSLkd2XRCkRw1FvUjFPUNDMBi
	I4+ujKCYCW1rzvLwKy3PhU0+pKCTuVVPD6CsSkyOKIHXO7yOcnvh2Yd4mt1BP6eQJIPQbkkYoBC
	aMglU/SY3g5ZJeES9tsfsriCjTAjjpYgu5PhZgWTFiHJZlE6wGLZCovE4JBq2Huks+o33hb//Mb
	QDKV8o=
X-Google-Smtp-Source: AGHT+IEiBDSh+6Em5c+U4LmqyUVPf4J6sg4KEYshuli5NnK7h8jqw5N22Ih+dxfjqxwcfWjX8MHUInxueYuNHXzg6tw=
X-Received: by 2002:a05:6402:5201:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-6337b1ea02fmr4563672a12.34.1758569418235; Mon, 22 Sep 2025
 12:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
 <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 15:30:04 -0400
X-Gm-Features: AS18NWA9HrHmx3YP496OglRtxh1AdycMtaqbc5LSlhUEUhu_PxKTgISVOm7uHlk
Message-ID: <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> When would you recommend that I re-apply the corresponding userspace
> patch to reserve this policy capability number for memfd_class?
> After it is moved to selinux/dev? Understand that it isn't truly
> reserved until it lands in a kernel.org kernel but would prefer to
> reapply it sooner than that since there may be other policy capability
> requests queueing up (e.g. bpf token) that should be done relative to
> it. Can always revert it again if necessary, at least until another
> userspace release is made (not sure on timeline for that).

When it comes to API issues like this, my standard answer is "tagged
release from Linus" as it is the safest option, but you know that
already.

The fuzzier answer is that unless something crazy happens, I'm likely
going to move the patches, in order, from selinux/dev-staging into
selinux/dev when the merge window closes.  This means that any
policycap API additions for the next cycle are going to start with the
memfd_class policycap, so it *should* be fairly safe to merge the
userspace bits now, I just wouldn't do a userspace release with that
API change until we see a tagged release from Linus.

--=20
paul-moore.com
