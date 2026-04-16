Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B65374E59
	for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373943; cv=none; b=pI46xafQnQJlXJA470xFYELwmd9wSrwyWCVUQfNuAPi6To/+nbr956v2kuvkU+cYU+t2Si/GY8eezh1UTmi61h0OtqWFdSrEGXkc8X9i8hpvTW7aBPMfZD/7OYjYjMGUyLQld1MzflKEA03yLlA/iobXcBiAgzWZViVi09dChZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373943; c=relaxed/simple;
	bh=IrYmcZF9hxAXNqt9zfpOlti0Oz+SLkvIJYPq35Swg/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPoiSK6DO0/gaa3aTA0xalZ6Y0ppKLOmj777GrUOFSQ3ql5LTx55T7tCSUX0roFbWFDnK9Ov+p3Tqh5GAYoNy48lNmPmhx9lQ8wEqgmjPWxpRpORLPkvhhQKDfarxD2Ocy2UJj7fWIXdc9kZlzV5B3zTmvJrUXTQtxUqqGjy63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAwCrrpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAwCrrpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AA2C2BCC6
	for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 21:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776373943;
	bh=IrYmcZF9hxAXNqt9zfpOlti0Oz+SLkvIJYPq35Swg/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sAwCrrpyjCeuDIwYlOGb+qhfSW8IAuUv1b2XSTzcACcQFSqbD5WndiLXGFLDqUtb6
	 1gLb0QMTTFdTbDJum4HUw+nZFDlDT0boBGY+n50w2HiqeWMKukR4W7yZN1Ba/3Ive0
	 l4w+UZLV6FtegytSbRqGK/9UxUDvJJTPhIQUAmUTUQSOwCX2xNZwbISkvX+onWElR0
	 Wy53pjyrIN965xKkiEgLFVIVQvOURzuMIxn40bn2NSWA4fq4LjoA1eoWzXd7YIeGZl
	 47AG412prmljKPORIJvl+HvA8UxP+La8pXeT1mGIcnHd3njllNsBC5hGHKO5PlPXGw
	 QA9i/zptvhU1Q==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso639233385a.3
        for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 14:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/S8WNfI3jP5DxyfOOwQB9TN2EGsa6yBJStWp9u/90nsxNJX2QO6hWcvUXS6B65otsUHBqKqvfh4YVmpw+osljdUoy7FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJ3WVbjVAQk8E5inZk+yPudSKDi3/nMbx6/nGkohszrZYfWpl
	P92wQieWwW5UyVJfEI95epXEUiCy+RoYv0+BkvTpJtWi4KA1SOiUuTI0G3WG2katSsF2r9Tuf+J
	aQXK5lct9I3i/KHIxME96vuf8dEEW0kE=
X-Received: by 2002:a05:622a:a09:b0:50b:893f:7d93 with SMTP id
 d75a77b69052e-50e367feadbmr901151cf.2.1776373942596; Thu, 16 Apr 2026
 14:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com> <20260407200157.3874806-9-utilityemal77@gmail.com>
In-Reply-To: <20260407200157.3874806-9-utilityemal77@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 16 Apr 2026 14:12:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
X-Gm-Features: AQROBzDk-eOQnc3KIcDHr-rTAWlI-wv9602XvRcYDgzfGDKiclbye-SKGL6YBWU
Message-ID: <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:02=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
>
> Expose the new BPF_MAP_TYPE_LANDLOCK_RULESET via headers, allowing
> programs to utilize the map.
>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

I don't think we can introduce a new map type for this. Instead, we should =
use
existing map with __kptr values.

Thanks,
Song
