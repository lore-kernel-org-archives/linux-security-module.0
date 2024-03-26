Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052F13CFA3
	for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480731; cv=none; b=hFOJ+2McEVx2b4V0mB98PAI+P729rdXLAE3rSnpISBVmrjNzQY7e1en3lc1Q09nZPSTiPoZMtKEv+f2yFZ3HkGGtl2VnmmM/ENf3FM95TBu78PaG7Y43UpCzYhXbo0a7OQIsHpC/76DFK7rsNx6g6szJIbAD9P34ny0wpQSE51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480731; c=relaxed/simple;
	bh=rIylzLX9J4lI4zws2LlXbhQ7UBlTM78dlQkpCoGuNZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9jkIWvV+4XhZOTmf1WSWV4z3HcXVtexpLHAIlpvLpLgKfRotZ/Nss9TaYn2Z/huxi5sWL0e83krQhLjdpsR5NDAkgknNgLHN7QYRT5LNA8RgmZdy5pIBrlfq2LBqDFHZ/TQlgYFUvteO2tS4I9oDkVzDiKvlfqgkrXgrdoWrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dd+KwLFj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dd+KwLFj"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609fd5fbe50so65521547b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711480729; x=1712085529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYgOqn25gz9ie7H+12IzY1nGkmV5SX8eunsh05XgwQg=;
        b=Dd+KwLFjuRZAD+4bISi9lY88kQwFwPRI9NXNiCTV6coGU5moFOYV9PfHPv5ndBM4Nt
         pbsS7dN7DezMKf1xFptgtr+DUggi6aJhAk3nZIg+blx6wgw/RFFd773CH0KSQtKqquQG
         e0GpWHrUrugJG4o4aOKQBEMp9FxAf9m9D4mhPB3c/rOHN2f4XsWHmPI8AP8ltEGgbocW
         twGQZuoU6SWNp2gg//d5PoNZaTIITQTkcZuBsq3p+V/oqp3h6ZhuJw7/Y6toUvKRsd6j
         6GnoIpCyr9Ywgo28HTb9rnUuYWeZXZGF2bZczifK6jxYeoq3l2gFAL/hYnv5MLLEuCuN
         fmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480729; x=1712085529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYgOqn25gz9ie7H+12IzY1nGkmV5SX8eunsh05XgwQg=;
        b=k5kCboh3PuBBn23EUbtzkccLCpk89rzn4CD+LXt9Ae8RHYw9f23eySAVz4aoPO+Jei
         C8QcARB5La8LYIqlVEsi7NzF9O5Y1CKZTeQATS9XjBSDJoy5+W0EyOHQFMkhA9xFDXVy
         QOJeFSPg5SW12uY5yRPf7/pgxpSwzsXdQixsQW/RqJi+qqJnrgaFjhHNSK8mi165d4Gp
         y6J/DW/PQadifT2NL+fycMKsDANIicRO+Py5AwQPsmZ3tmhdmY9fsCu+RoW++gBaPRWr
         2nax/SvVSAYwRdAZvVEY6SJ1Bx7ANZe7BTYob8begZQ3nDsBVmd7cxVegbKEqNvoKMWX
         uVUw==
X-Gm-Message-State: AOJu0YzD8HC6zIW5L2gUkXRaXR9x6OlNGLKe1TyMYypLlpwiC4AxyMpd
	s/y9Rp4VS/SCT8aLqxSTxJvClnruRUQQR2npt5U4lck7dbJaZ0RxngGtxDliXOKlFP+lMJ/Sf1M
	XvZExXZrtR7kPZRhfpXANvpHdW2QZnKPeBjvebZraz7ti8uE=
X-Google-Smtp-Source: AGHT+IFc2eIKJ7d4YLg5xPwKn3eSXqib+pnZt/naj67Aoraqg2lZyHWdIy8LStTjQAxLscv6AnlkiFaJa8XuhVWngDg=
X-Received: by 2002:a25:ac48:0:b0:dd0:2076:4706 with SMTP id
 r8-20020a25ac48000000b00dd020764706mr3510341ybd.31.1711480728958; Tue, 26 Mar
 2024 12:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315125418.273104-1-cgzones@googlemail.com>
 <20240315125418.273104-2-cgzones@googlemail.com> <CAHC9VhTOmkpZu-zUEcvWJxLVHwoUnTcPxhBexs1ZKjr_LRKx_w@mail.gmail.com>
In-Reply-To: <CAHC9VhTOmkpZu-zUEcvWJxLVHwoUnTcPxhBexs1ZKjr_LRKx_w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 15:18:38 -0400
Message-ID: <CAHC9VhQZNpz3m-YBrKtuoX1Ve4cPQ3rr3Y1ONjXA0hcsu7RqXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] yama: document function parameter
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Mar 15, 2024 at 8:54=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Document the unused function parameter of yama_relation_cleanup() to
> > please kernel doc warnings.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/yama/yama_lsm.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> One small comment below, but otherwise looks okay to me.
>
> Reviewed-by:

Bah, let's try that again ...

Reviewed-by: Paul Moore <paul@paul-moore.com>

> > diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> > index 49dc52b454ef..f8e4acd41b72 100644
> > --- a/security/yama/yama_lsm.c
> > +++ b/security/yama/yama_lsm.c
> > @@ -111,6 +111,7 @@ static void report_access(const char *access, struc=
t task_struct *target,
> >
> >  /**
> >   * yama_relation_cleanup - remove invalid entries from the relation li=
st
> > + * @work: unused
> >   *
> >   */
> >  static void yama_relation_cleanup(struct work_struct *work)
>
> Should we also take this opportunity to mark the parameter as '__always_u=
nused'?

--=20
paul-moore.com
