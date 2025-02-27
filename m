Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040661D5CE3
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674725; cv=none; b=Hgd8BAQxCG6u+mJ2H5tt0MTPYtIJefi7Y61KUQMFZS+0ks1jED+A5f8FTu+8wsOGC/rRl3n8dlK+FpGRlkm7NC3LI98Z3Ycxh1K4m0sjH+ZDUUToZsIQALrRq/QU7wXl/PSfozzExNnmi64BgEAOFQiYXo2WX3XzrTqLRhvlgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674725; c=relaxed/simple;
	bh=DABk5HGlcnVPtrWTwBOC3Bxja7Ae6t+CZeMoYMJ8cco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NS/kDjw6A6U+EiZj0mwdmCF+ElLiAleeb4Z3ciiHvQZLdpnnptR+cohNeHfjAGlCayk0BIuHQrS0nGDPgnEsLvI04jTFOX4UNKQXWGVCykHOCy1XJSbLPNyZSXzCrXUzMaxQ/8jmtBfANCSU0A9JsOm8iG7LSPdH8Z6TDpXkGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fbhShm+I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fbhShm+I"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f6c90b51c3so10989577b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740674721; x=1741279521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y2OhTDfbYUPSi0n+YD3zUk4WKi/mnjXGnIuCw7tFnM=;
        b=fbhShm+Iwr3hZAUE7me8u4Z3uS2OFwI6zCOTmpxtz9/K3qDYbqXIws+dxvKLXbtOA4
         yjTAWdA4Uabbb9EnnRi3oNrzLELgBJjTmLMBQsH2tLZm8ecw+BdRIMYzpvWCcN5aQHhO
         iwZgPRx5h3WNjSI3aL1cz2Y8qEL/JZwz+eODkbJPHm0/Er2zuMK9cln6QvcsBz68l10N
         WZv22CcxK5tGIzLxLp/HtyTTy4eqSDGAXjUfRdmwgfch8P+1Po8MBVsLHzeSmAYm6YMe
         sgznogmM8jhKJEgknAPGJ8L2YOrsjnG5prdJ+j/U+jvy8r7HI+kieWPFuFVD8mHCupcp
         Hx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674721; x=1741279521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Y2OhTDfbYUPSi0n+YD3zUk4WKi/mnjXGnIuCw7tFnM=;
        b=gBvfJaSHia/PN4y9kNpD19BHZnYoLp/QTuIgZYLwWQS0Fu6HDJmBbqVcyfYx4BOw84
         vf7x493AfmTXjzHDFY9bJ2jmD95usAfbPJuf069EyVqwjmxYegBUHEbr9lX7Hwt58qTl
         yH3SSeAc731iEstehVnj8Z08EAJ2QYibxKJyhpKfmTtORlu5OC8cTNweBNnQICP0IY7l
         DhLTGTruk4/8DENSX2A6ig/vVc0f5Sg18OhoD8Z/rAZHSlSojzZj1pgon3KmLhWHJte7
         Ptx3VAG+raRA7g5/baYE9s+IA7ljaX27BRQPwii5LU+LNHffFYyLuq9oByKOOIDdQlKk
         whQg==
X-Forwarded-Encrypted: i=1; AJvYcCWVsFSTCklBNpmywiMKsPccs9CBJj6eXY2ZtWVSPb45lJhDOCCSjIupqC1VftHtpuHFvBAu9y4RxIT4uPkn+lXRTbuma8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TKv3Osik7hgrd3Z7uyFfzaxraWQCouzdLh6pGQEVtvrs9w0/
	wK1AfF3fE/CYuHQz1t7ilrrXoUjWpmeTffajEl38sFnE4WWsoV+VuFqIwuyrAqSzMlpnOZ48AfZ
	XSf+JfaRzUkDgk3EGjgVgyWZRjbK5P+Xc498m
X-Gm-Gg: ASbGncuUUKX0zC3mPB5WLsSnJ0sAldP9i8LCiv5x86vu52TF9EKQTPWYFWrZ0v1980Z
	p64zZQqBi4yDgrX4Qh0C+0a2Whxn2f8nOpc5+JFc0rsJFUUF6Jg9p0j47zKLOlVS048cF3mvgRB
	WLWxZdw1U=
X-Google-Smtp-Source: AGHT+IFstoV34sDpQuH0KrhKiFYaxdU0llmPTWK3akgTdx0dj5ICycOhcMBiHKd218R+yYYVWSp1yVZs1fdJpBpbIKU=
X-Received: by 2002:a05:690c:a8d:b0:6fd:4441:3daf with SMTP id
 00721157ae682-6fd4a14d07dmr1458727b3.30.1740674720751; Thu, 27 Feb 2025
 08:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-sysctl_const-pcmoore-v1-1-d9f918dbb0be@suse.com>
 <CAHC9VhQpkyqaJsxj9_d4d6Vpc+FVbSnH_HeAFAVEdj0trGCh1g@mail.gmail.com> <D8362ZV7Y4YI.PJTF4OC88RQK@suse.com>
In-Reply-To: <D8362ZV7Y4YI.PJTF4OC88RQK@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Feb 2025 11:45:09 -0500
X-Gm-Features: AQ5f1Joe4xg5_zcs96-PQy9e8tNorgl6hzcdkI4Dodr8p0sDbqo9j3WaMuiILYo
Message-ID: <CAHC9VhQfC3kXt39qBS3NEHtGNqNhD1SpJ103_kUtOCi0HTMDHg@mail.gmail.com>
Subject: Re: [PATCH] security: keys: Make sysctl table const
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:47=E2=80=AFAM Ricardo B. Marli=C3=A8re <rbm@suse.=
com> wrote:
> On Wed Feb 26, 2025 at 9:21 PM -03, Paul Moore wrote:
> > On Thu, Jan 23, 2025 at 2:50=E2=80=AFPM Ricardo B. Marliere
> > <ricardo@marliere.net> wrote:
> >>
> >> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> >> ctl_table"), the sysctl registration API allows for struct ctl_table t=
o be
> >> in read-only memory. Move key_sysctls to be declared at build time, in=
stead
> >> of having to be dynamically allocated at boot time.
> >>
> >> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> >> ---
> >>  security/keys/sysctl.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Looks fine to me.  David or Jarkko, this looks like something for the
> > keys tree, yes?
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Thank you for the review, but I believe this has been done here:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D1751f872cc97f992ed5c4c72c55588db1f0021e1

Even better :)  Thanks for the update Ricardo.

--=20
paul-moore.com
