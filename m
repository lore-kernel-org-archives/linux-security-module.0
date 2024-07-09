Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650C1DFCF
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551944; cv=none; b=dHUXcQI5yLlk6+Xo2hkNEGWUTnqygvetfii8oJgDmFOUsdPloYqphCS8yumeUIDvQj1tvAq9QWVrlwQGTZV06H9Xiv4EjTZ+WXokAPEFTGXo28vRJ9XJmxKlmYegfq4Botd/oGIm4OeE0jTixp4vgxmQwG3GjZgm7V5pSGJ0X2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551944; c=relaxed/simple;
	bh=0lSY8sS7FSdXqlC2bQMt25iLlSxIwfhjNcgv1ErZNuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StqbgVl2NJ+qnsGK+hBqn7fKYh7vG4jV0118M304raurCpvd+eoZPZsw5Oi3KF7ALo81ehdukE950a41RSGV8bDn00uovaTkOrfPfaIwWw0CCMkq9re0L4Et7Dj5vRwowpnOpLMEmh0g7CjQfMHaXzM6QnQLiX6HPM7m6fmOWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fh1eDlZV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fh1eDlZV"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6325b04c275so51875637b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720551942; x=1721156742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22oPYIkXUegZik//iuLkIA/RKQ6ygZrjslJR51pDVSw=;
        b=fh1eDlZVqj8ZgsocOT4BMf0SWTuotH+L3YyPVSYmyWGE9QvFfqrEge88/7K6aV9H3w
         XkSvP5LJ5h6GdwcWuVvEukzA/9mIZNc4SSXhhWADuA0ug2eQ3n9cCFw3FaOtG3LV7ELk
         q8gZ2d3l3gWk8bV4js1vCxrYfWSZSwQ7IxK3JhnQ96qcvvlDvoiqeADfzM6ECj1pU38/
         ZoqbaCW0E1Ek+dOzoy5vsFhIkMtVpvXDv+oPIKglFCrtoSE0h7Qc/WpbrhM3CeLCgrsQ
         7s4JjJboGqZQ+xt5VTSpfdnPvXsHPSxGfoHF2fa0QAhuOJFbgeieV5KdwVJTCdZv9Zot
         RPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551942; x=1721156742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22oPYIkXUegZik//iuLkIA/RKQ6ygZrjslJR51pDVSw=;
        b=UsdYCB/CXUasXKK7uj4tqgVwN1QTPx49aSorWdC0oR5yFySlhG3CihAlg17EcpLGxb
         Zod9uvHliVTuRRfet81rkbS/dqR8OsqlbHsGiykjTnWZStzHcWSpFBpNtiXl62jJMQfX
         jBaCJET3ms24LXw/lvaiitu+t/Y9TF/9cZ1LZsOQZ8lceZ5e7hvsNHv6PGORIoe9FPs/
         6iLhDZikbpz+vb/3bQYaAvwHSFGXUyubZkmRFyUeo5oT/KIcP0b+r2a4gy9Oul5RW6Zn
         juM9/zTw7latzQeQQiPwoVimG8ZQCHzOvPJ2C2krlKX4q+FNZu079rmFKSathsGziSrN
         rpQg==
X-Forwarded-Encrypted: i=1; AJvYcCW+FKInh7fkosmORGPLBtgUl1XHHVr1Q137QbQsXDSkfrPGT1DddiIXgkD6JgCz07ZuyVIJD+eS8hbUpu74X5G9buck4H4gqUfsEfuyjDi5SE1b21gf
X-Gm-Message-State: AOJu0Yy6xQKcQ2yGTLJN1jzb9yX0ziJsyi6foXNO/k/PBWL0oNYnUDNL
	+ELd5+zTsdGlhWroUh+TN+FzOv2zbZNxWhZ0J0bgR1VF2KWeKnryi2KhjXRzh4oFSxLlWZDsSBe
	esp+lv9nf8cii2kIGZAi+iptc4FnUp0LP5UBv
X-Google-Smtp-Source: AGHT+IGhklg038a5HzgbiWQLqn94HkdHCX43xrbJmCQsjITh8ARHePNHXKlvflNW6mFrvEOict7TZp2ZMTMAFhLGEN8=
X-Received: by 2002:a0d:ea50:0:b0:653:ffe7:d648 with SMTP id
 00721157ae682-658f0bc622fmr35885457b3.34.1720551942224; Tue, 09 Jul 2024
 12:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-5-kpsingh@kernel.org> <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
 <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com> <e170a720-c6e7-480c-a54d-c6ae7cf9a77a@schaufler-ca.com>
In-Reply-To: <e170a720-c6e7-480c-a54d-c6ae7cf9a77a@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 15:05:31 -0400
Message-ID: <CAHC9VhS64J+0PhK6YJVvRe0rRGK935+KPbGMZBO4PxVH22ug0Q@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] security: Update non standard hooks to use static calls
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 12:53=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/9/2024 5:36 AM, KP Singh wrote:
> > [...]
> >
> >>> --- a/security/security.c
> >>> +++ b/security/security.c
> >>> @@ -948,10 +948,48 @@ out:                                           =
                         \
> >>>       RC;                                                            =
 \
> >>>  })
> >>>
> >>> -#define lsm_for_each_hook(scall, NAME)                              =
         \
> >>> -     for (scall =3D static_calls_table.NAME;                        =
   \
> >>> -          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) =
 \
> >>> -             if (static_key_enabled(&scall->active->key))
> >>> +/*
> >>> + * Can be used in the context passed to lsm_for_each_hook to get the=
 lsmid of the
> >>> + * current hook
> >>> + */
> >>> +#define current_lsmid() _hook_lsmid
> >> See my comments below about security_getselfattr(), I think we can dro=
p
> >> the current_lsmid() macro.  If we really must keep it, we need to rena=
me
> >> it to something else as it clashes too much with the other current_XXX=
()
> >> macros/functions which are useful outside of our wacky macros.
> > call_hook_with_lsmid is a pattern used by quite a few hooks, happy to
> > update the name.
> >
> > What do you think about __security_hook_lsm_id().
>
> I really dislike it. The security prefix (even with __) tells the
> developer in security.c that the code is used elsewhere. How about
> lsm_hook_current_id()?

See my reply.  There is enough ugliness in converting the hooks in
this particular patch that I think we need to shelve this patch too.

--=20
paul-moore.com
