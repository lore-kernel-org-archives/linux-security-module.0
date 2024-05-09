Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DA12CDB6
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295547; cv=none; b=c/oMKJlQUJE18gFxuicyBrJkLg2Kn9fuY8tiXhJOBILko6JTsNufi62qa/Y27dyB9HGjBQhYbbmhrk/lD8PjYMvoJXZUq5tcZG//sCEG0sJtMBe7SmrmBxP0dahorbebho4M9WreJN3hevv0VXb7u2lrXJ3lT+nktQMUxuZSGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295547; c=relaxed/simple;
	bh=6jtL8Tq51/6D1tJuPGm0Kl2FshQGs9RlrJmrJmmfe3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/1w3XL7lDqNmfeIha/6NBqDrtZO1CdVqLf8i+RsVR/0jzrXKQ1h8zHWFYwB/AwIG1ooaIoHT+xn1FjZ0lUzWzCb/Lfu92rWw6tyFqr0x3vXk0vQ25oVivLiIg9u58q+Wk6IJZ6VMUVSXeaVgc1Z/XjA7+hmHea69JMSDuQse90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnVVXoFT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnVVXoFT"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso7092a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715295543; x=1715900343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1vau91hxBMnWZHVkH054+8jTk5Pa/DNJnVVz4HmL40=;
        b=GnVVXoFTnT9ZaLKRqrF5ZXsK5zLuCheZZudzfOfQi6gPm4n/QETZ0sOWxLxh6r2rI3
         19GJlhsoj4X8j8Mf+3s5N1nPAjBqLy8ZY3ZKy7xF7WdQW6DbeJ+NlKQDS0JhVDm1TBX+
         42JSiTnJT7j92d6kYrn+r4lXLmkzT5yyHur7dYOnOiFnt72q04xYHC2Z7hs/sglbHtAo
         t91eN8KfbbmQpegOG9igaBDtPz9IQ/r58mhcbZj/RUwNUAe1eV8CRGKlqnIQNX/K0p66
         JaJlhYBFctMhUWtiyWjkXIhqWg+B4mBUyzMh6hcgaCz5NHxqBzUA9gA+CcLQL++rZg/N
         MO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715295543; x=1715900343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1vau91hxBMnWZHVkH054+8jTk5Pa/DNJnVVz4HmL40=;
        b=v1dVDqqhiFrUd9SeI5LL6M56NsOLTOqYL6u+tzTfEQJXt78fd/+dAauTD/w+HtVX//
         36zG3gEhCqjRm4jYU3hrAZXU4uFvcUXTXzOAfeZjuGfu3dEC+xRgLyga1bOTajNWmIip
         iIP2zfiF8hV6yLparNQjStYf8Qk6LGyzxoU2GhwXM/9reMDC8QxXxzWnEdqfwUceyKqT
         2coPnjY3u3FHnEfps1Z7w/Ojdo8ryOpURmFdeOd6nyB3cbAopkKahRAYyZQW+IE6JHyv
         E7NtPwnx/jo/rkxJEUBLvtaehEG181oL5hO4/LY28ArAaDGQNm+lnVMRU5LrPsBoTJSg
         4c+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr3rZM7bFAyRfA3YncIus3IaDb4CzIH4+Db7/IhwqOcMEZkJ/L7HPF8NXGclZTob4Jk8vrgxyXABCUN/4HKNsivLr1VLripx0VC7geg/m5+l7Q5Ec2
X-Gm-Message-State: AOJu0YxzV4P/rSbPz74QsuhxHfmuayhF2vLNPSkYrOhIkFgmbmUxDsyj
	O6uHLWT76WZfwSRA+nusRVWLvcGSFK4nLSz8AFu/86SvqoQ4rGa4frGYbQ1I1634chJqtcqTQR1
	hjEjGQrUWGHfJCjykZXHsdJCYKZBUULpAj6OQ
X-Google-Smtp-Source: AGHT+IHuVFTFisfvrt55ub+8UO4+Id1LOVWeasU97gGretbq/QA6WW4CiikvBa7AfpTXmMMad1SbRPJ/2IdczDaT84s=
X-Received: by 2002:a50:8d84:0:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-5735203906fmr30811a12.7.1715295542981; Thu, 09 May 2024
 15:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com> <20240509200022.253089-4-edliaw@google.com>
 <0e196143-c0bf-4d70-9735-7e6d9a69ea8f@nvidia.com>
In-Reply-To: <0e196143-c0bf-4d70-9735-7e6d9a69ea8f@nvidia.com>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 15:58:35 -0700
Message-ID: <CAG4es9Xv0Pwst+b0mre2g+QkBGoQS0cWj4xizRt+cHFJ0BTDaQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/68] selftests: Compile with -D_GNU_SOURCE when
 including lib.mk
To: John Hubbard <jhubbard@nvidia.com>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:25=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/9/24 12:57 PM, Edward Liaw wrote:
> > lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
> > unnecessary to add #define _GNU_SOURCE in the source code.
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> > Suggested-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >   tools/testing/selftests/Makefile | 4 ++--
> >   tools/testing/selftests/lib.mk   | 5 ++++-
> >   2 files changed, 6 insertions(+), 3 deletions(-)
> >
>
> Hi Edward,
>
> This looks good, with one small refactoring opportunity remaining, though=
:
>
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests=
/Makefile
> > index f0431e6cb67e..9039f3709aff 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
> >     # $(realpath ...) resolves symlinks
> >     abs_objtree :=3D $(realpath $(abs_objtree))
> >     BUILD :=3D $(abs_objtree)/kselftest
> > -  KHDR_INCLUDES :=3D -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
> > +  KHDR_INCLUDES :=3D -isystem ${abs_objtree}/usr/include
> >   else
> >     BUILD :=3D $(CURDIR)
> >     abs_srctree :=3D $(shell cd $(top_srcdir) && pwd)
> > -  KHDR_INCLUDES :=3D -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
> > +  KHDR_INCLUDES :=3D -isystem ${abs_srctree}/usr/include
>
> As mentioned in [1] (but there are a lot of patches to manage here, and
> I think it got overlooked), you could factor out the duplicated
> -D_GNU_SOURCE items into a single place:

Hi John,
Here I'm reverting the change I made to the Makefile in patch 1/68,
since -D_GNU_SOURCE is being added directly to CFLAGS now, I didn't
think it was necessary to add it to KHDR_INCLUDES anymore.  I would
have merged the two patches together, but since the first and second
patches from v2 were already merged, I thought I should leave them in
the series.

Thanks,
Edward

>
> [1]
> https://lore.kernel.org/all/ac8c217e-4109-4ca7-a7dd-fc4fc8b0a4de@nvidia.c=
om/
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >     DEFAULT_INSTALL_HDR_PATH :=3D 1
> >   endif
> >
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/l=
ib.mk
> > index 3023e0e2f58f..e782f4c96aee 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -67,7 +67,7 @@ MAKEFLAGS +=3D --no-print-directory
> >   endif
> >
> >   ifeq ($(KHDR_INCLUDES),)
> > -KHDR_INCLUDES :=3D -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
> > +KHDR_INCLUDES :=3D -isystem $(top_srcdir)/usr/include
> >   endif
> >
> >   # In order to use newer items that haven't yet been added to the user=
's system
> > @@ -188,6 +188,9 @@ endef
> >   clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
> >       $(CLEAN)
> >
> > +# Build with _GNU_SOURCE by default
> > +CFLAGS +=3D -D_GNU_SOURCE
> > +
> >   # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
> >   # make USERCFLAGS=3D-Werror USERLDFLAGS=3D-static
> >   CFLAGS +=3D $(USERCFLAGS)
>
>
