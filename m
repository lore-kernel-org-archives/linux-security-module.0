Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC63C4542
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082994; cv=none; b=Gs9oTAOVjSouWPmnhxDxkNjyLPYexizojkBInDPjzYXi+JeXWX1EgNuL2pQLCjhxfXPqLsTHjgOv2m+RQj2sUvDu6r3IE0qx8NvGNUvWsQxwvcuJlHoUoF5V7boJB+Fy2oTO33h5VZxD3DFvpsqgrZGSVcQxC7MJH+6vvcH9QsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082994; c=relaxed/simple;
	bh=WFPnFxbwM1qk5swnx0UWBaRtNOeTH0KE1lmswKZ8xWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsoauTzObXOQTXYezp5GSnhy6xocXAAyXgrWrp65sRwvoG4KjDorOVVyvlJ4uHYUBcds/6vwJlAu19esoEQlMwMliC5fmbGRJJUe0Jih38XAUVg9YCwQKkA3p6lOQCbo4xGdotwzYAWzmAesN5KjtNFuMv5THOJepmztVe97f9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ny9QJzw5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ny9QJzw5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so29677535e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776082991; x=1776687791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O5YuZjQJmi2cXLn9WuzpS74EUatiiwwT6AzsGjUOqYQ=;
        b=Ny9QJzw5yvd4BT2U/rJFZ7/0Co2tUKbgXJIvLQiBewmyTuNYjy8v1crJYa+8HZFMA8
         5foK89H0zxU09pISMbA+FDKUp0sUJ33vK3gZUsnamoIuLzCUWVkIAt3iNuxVGBZ1kE3Z
         xHZ3u35LfSZyE0OSzCg84efVBx5wrd9S9WRXFu0Fi2PpeezanglrBfGglIl2vLbnOpj6
         kalA0x2sU4G4itaa8VugkQn3OD3sKC7HYV79XDjCmyoCVTkNUwJZaEtK/lCZf3RDWwG1
         SuCUPjeRZQjx6G1Zyyb/7WTuh51vIuosH0qy30pBRJxrqYJBKHyKFVv+wQHLsckolWTB
         ey9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082991; x=1776687791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5YuZjQJmi2cXLn9WuzpS74EUatiiwwT6AzsGjUOqYQ=;
        b=byVG7IbxOhVNHIRgGnaPIbNcywTOYw2irpLKu+sI0xezLfeZiM+LFA2tvLZBugDPKJ
         P5pgIet1nGyLsAuuGRureKrh/JWPQmsFBbSWv2VykOyBiHx/m6pv1ehbcSlkXviN5AxQ
         2NxoyeEHxn8k2wVIYojOYK47WdjE2K9DMlm+p3enyuVd+kynl+RF90C1/cTZcsp4vdZI
         dhQ0MDH78GlTZVdeVDGHeYeKe4rMdWS3SzgitmJjHuwIGmdfpuymZKM5+rHnGLBUvS+I
         qv2BVs80szawfgqrBdzWlME4Q3phkxynleITiAucE6SjUCpZEB3OdLVmuvFHY25R8PSM
         HIrA==
X-Forwarded-Encrypted: i=1; AFNElJ9ouwvJmKG/E/e6Iz2547NXH7AWBIHvhNSI7z5YvHDnIZYIXJCVuwoHPcHBqfFqFcvKLjkTC4hVZ5W2+6S5dKjrnlLcUtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtbBytyvA+mrsYjbdMutZgjmTVWpRSzsDl8UT/Lt0HbRCmVlz
	wcjAmSLc/JHZ7Mu0XN34i6HJ95qxfOsPrJzl2emAsvbbPp51wfdeeK518niqlevHpg==
X-Gm-Gg: AeBDiev1sY5yP8GUM/t2DRN0u2FnQF3FUpgmbOObWn/1iHLLLV2MuBae3NvC+DMn9n+
	MUn/iHuLpvJ8gwnuSikneSu4ek8HZkfp2GBl64WrASah/DBsHwEfvIGJWmEaQhUtsmFELd2fyZt
	8Rh/TZcLSa4aeN5hP/fHJv/+NT5xv23KuvVrgGObQCOOvaro/1q60Wv2N/pzCLjZquJSaRb5dSk
	YGBPMIpw8NNR5/LZXn+o1P2rgwC0oYd9WfxFvVdM4VydHqobnOpKLgS06pYF1ZkXNvmL522/a2s
	tytazRareV5Mz9PjZHdfC4UhjXvhuS7+mTspvht2kod8aTMBOiu4/ai46EJErlNX2pYUeZxWnau
	PTJgLkezDM0z/hMn1NCS/B4r21hlh046cNRYLPZFHhDFDwW+MAHHWkSdRhZyY9MiZ/43d95TBGq
	9V2rLlzoSQ2xtv9IsMVVGJ4IM7MKgiHENTM6zw3UKpLFLdR9lDEjWQsyEmQlg6BWYx
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr168403595e9.24.1776082991070;
        Mon, 13 Apr 2026 05:23:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:4828:e29f:fa0f:9dd2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3cbb2sm305428965e9.13.2026.04.13.05.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:23:10 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:23:05 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
Message-ID: <adzgKVIhRj5t3GqM@google.com>
References: <adUBCQXrt7kmgqJT@google.com>
 <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
 <20260409-entbrennen-turnschuh-54af9b45610e@brauner>
 <adoIGHwgMJSuRfE5@google.com>
 <CAJfpegv6GDFZjdGrQ=0Jahvz5mSgfJr+GvjVwws=SFX-yirpSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegv6GDFZjdGrQ=0Jahvz5mSgfJr+GvjVwws=SFX-yirpSg@mail.gmail.com>

On Mon, Apr 13, 2026 at 12:18:08PM +0200, Miklos Szeredi wrote:
> On Sat, 11 Apr 2026 at 10:36, Günther Noack <gnoack@google.com> wrote:
> > I also don't currently see how an attacker would abuse this, but I still see
> > this as a violation of Landlock's security model if we can create a policy that
> > denies the creation of character device directory entries, and then we still
> > have a way to make them appear there where we previously had a different file.
> 
> Look: a whiteout is a whiteout, NOT a character device.  Don't let the
> fact that it's represented by "c 0 0" fool you, this is a completely
> different beast.  See commit a3c751a50fe6 ("vfs: allow unprivileged
> whiteout creation").
> 
> Does this beast need special handling by LSMs?  I have no idea, but
> treating them the same as char devs sounds like a bad idea.

Thanks for the pointer to that commit.  I was under the impression
that creation of the whiteout objects required CAP_MKNOD, but it seems
you have dropped that requirement in that commit.

(FWIW, I was mislead by the rename(2) man page[1], which is apparently
not up to date and where it explicitly says:

    RENAME_WHITEOUT requires the same privileges as creating a
    device node (i.e., the CAP_MKNOD capability).

So with that assumption, it seemed natural that this should have
extended equivalently into a Landlock policy.)

So if the "c 0 0" whiteout device is indeed a different kind of file,
maybe we would need to treat it with a separate Landlock access right
after all then.  I'll ponder it.

FWIW, besides introducing a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
access right and adding more special cases to the Landlock API,
another possible option might be to just forbid creating whiteout
objects altogether, when under a Landlock policy.  As the man page
also notes, "This operation makes sense only for overlay/union
filesystem implementations", and since these likely can't use Landlock
anyway due to mounting, I think there would be no use case left where
anyone would want to perform such an operation within a Landlock
domain -- I don't think this would break anyone.  Mickaël, do you have
an opinion on that idea?

—Günther

P.S. Initial patch set from Saturday is at [2], but this still uses
the LANDLOCK_ACCESS_FS_MAKE_CHAR right.

[1] https://man7.org/linux/man-pages/man2/rename.2.html
[2] https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/
