Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE1236454
	for <linux-security-module@vger.kernel.org>; Mon,  8 Dec 2025 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220557; cv=none; b=I3HFlIy9G1pT+uGA2dVxt5WALrhpkgiDiC1ZyP/dLBd5MMiJKi7YmoGDGrfs018dqmc/Y4eYgxm9C6ZUcGhK7buU0leQmZ/Opac9MQ9eO+xvuhQzIIbSsphcRF5VfO9QRojd8SdSgPxEyWm3zv1uRG5YlIrEgBZU1lyNuIHglhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220557; c=relaxed/simple;
	bh=gH9hRI6fwOd+Bcs6CAoTJtBdbZZnzJQ2gyhDof5a1J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ljnml59VhqmXYWBT5CylPGgBnKAvUBCM2Dhx93jriuBBYyYgTQer/YS1NO+XueM59nsnY2yvvJ0yvAfZrNpWHoid5PE2p2oXQ7nx4zwRLaPpl9QeJUn5LQoYBqtjqJCM4OeMvQUpU0K6lm3XVoehw5zBx/jHVF9IgFO/2YoVAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alr6m92r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alr6m92r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05B3C19422
	for <linux-security-module@vger.kernel.org>; Mon,  8 Dec 2025 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765220556;
	bh=gH9hRI6fwOd+Bcs6CAoTJtBdbZZnzJQ2gyhDof5a1J8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Alr6m92ron8IFTxTpvu5RobgKO2LPgUby/J6KzgIunZyLjZw9D9t8CSU007dZHKMC
	 LYVye8JDayiymrmuzm+JgxbcTjq2c84qev9eEzVjiJX0jBasjnZcLtolKk34P9TGoc
	 BibVdOUWxgYT2BfleTYCdeHquDe/wWN/L+gP6+47gIeGBZyShz7YWzzT6Yw1ODibjc
	 /jsD+b/TAKdHW0XxZhlOm26xHTy6mlxTj2+HLoD1JSNLiWdu4QXI7aASX+R7eEEkmi
	 B9ouNhDRtVb4v9VgUvdijyyOFI7zR3RrGBu1qj1rhOjxFYV/xyiZysBqUQRuETUgHW
	 62gg6HsHcHjTw==
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29844c68068so61640175ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 08 Dec 2025 11:02:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJYWJImF/Y0BESLEuwD/oi1hBkmQOJUOdZZe/zDBn5Uk1IrdwqJZ9atq7JZYCmg3ZOKMAYWYst0O2NlrrsAjGnZXXPoi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmhLmVVPaCXb5oGpqsOkUsmeWYEhE7/gFX+Vrxh2UAUiaHpKx
	t0xq3P+sp/IY9WgU5+fKgZ1Cs7JfcV0tR8x6yZ3qXSzAZtZLmmJh06WnoPCeVJnr0Ont22IlE2O
	YHNaiNXsYMEVK1xmMwHi8dGwu4c9X2mM=
X-Google-Smtp-Source: AGHT+IF991Yf/NPL51jBh57pAjCHOLOBS4tsmCRemwoG96Ivo6U0E6cwlWulUGOLuYxcZmZo7A/YFe2cOJMhe/iqLX8=
X-Received: by 2002:a05:7022:3844:b0:119:e56b:9583 with SMTP id
 a92af1059eb24-11e0315de66mr6506661c88.8.1765220556270; Mon, 08 Dec 2025
 11:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203193718.504344-1-yiconghui@gmail.com> <CAKtyLkEyD9UVxqbmODVOAymE32aE7X4Xdbqj6H3BMGyhn_PQqw@mail.gmail.com>
 <3748b276-6503-4c50-a394-e5b75c1eb7bf@gmail.com>
In-Reply-To: <3748b276-6503-4c50-a394-e5b75c1eb7bf@gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 8 Dec 2025 11:02:25 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHsfEsXvD46Gw97meciySQbzYqwRPxaeK6r8ChO9++1kw@mail.gmail.com>
X-Gm-Features: AQt7F2rggtRKFAbUar_vff11jZ7abb9KI2ocB0wfCsY1Ob_lAnOW4nHzZoiESqE
Message-ID: <CAKtyLkHsfEsXvD46Gw97meciySQbzYqwRPxaeK6r8ChO9++1kw@mail.gmail.com>
Subject: Re: [PATCH] ipe: remove headers that are included but not used
To: Yicong Hui <yiconghui@gmail.com>
Cc: Fan Wu <wufan@kernel.org>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 1:04=E2=80=AFPM Yicong Hui <yiconghui@gmail.com> wro=
te:
>
> On 12/3/25 10:25 PM, Fan Wu wrote:
> > On Wed, Dec 3, 2025 at 11:37=E2=80=AFAM Yicong Hui <yiconghui@gmail.com=
> wrote:
> >
> > Hi Yicong,
> >
> > Thanks for the patch. This kind of cleanup is appreciated.
> >
> > Commit message typo: "audit. c, audit.c, policy. c" - audit. c is liste=
d
> > twice.
>
> Hi! Thank you for the reply! Yes! My bad, this typo will be fixed in v2.
>
...
>
> I have manually read through the functions/macros/filetypes in policy.c,
> policy_fs.c and audit.c and found a few dependencies that are used but
> not explicitly included, like minmax.h, sha2.h, lockdep.h, string.h,
> capability.h, kstrtox.h, sprintf.h, array_size.h and err.h.
>
> This might be a stupid question, but how explicit should I be in my v2
> patch with the dependencies? There's headers like
> "asm-generic/int-ll64.h" "uidgid.h", "gfp_types.h", "rwonce.h",
> "compiler_types.h" or "errno-base.h" but I'm not sure to what extent I
> need to import them, because I shouldn't be including them all, right?

Hi Yicong,

On second thought, the cost of this cleanup outweighs the benefit.

Let's drop this patch and keep the code as it is.

-Fan
