Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171B224D4
	for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264851; cv=none; b=LmW9IDcTre+j886cTwgOOv77/OUfWqsWYrnx/pkvm+g6E2+eyrcmWpvnvHtX70jFMyHLZ4ubP7VEq1mz1UmYcE/E+fo5k5EKfOHkUIh2g7+VLdDMjin36MTPPBSHC0NlflDiy/dl983Itq7FxRElgb8XTtqfW1I7wWPGofVJYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264851; c=relaxed/simple;
	bh=CIfsby2oPpYY3kXs4oddKQZp1v5fbpImVUNDZjOnRlQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUhCF/dpJWnUTl9jGuoAzTNDuJxo+kiXsxpJ61aw6oGjwV+k1daH8DeiYJntImMH0s07GdEds2UMmGqYxAR9mDMDZuFwLj0qaeDiO8a3cfRKmsDZSKNjjtYDZN2+hwDps7iQlKaeoGYCW6XWcPgVFayIA5PXp4IhqOrs63Gix40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FqzvrUK+; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqzvrUK+"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4df9b81502eso1702100e0c.2
        for <linux-security-module@vger.kernel.org>; Mon, 20 May 2024 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716264849; x=1716869649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQAMz+e0g3nZFFrVh6fJZF5RVSqH/2InZskkKfH8zyQ=;
        b=FqzvrUK+NdBYJq1VycMOMh8ZN0tRdbaKWSMXeI/6r5UUsJOLYzunr9KGFP/DsYaMwh
         MG8zrBUsYAbv63C1DE402ZkysrdXurAK3o44FaMD2s6W5oHluZQThEztf4R43xGiUySR
         Uzj9EW2DRZtNnCYEbk5O5Dyxw2xs9y9tyUEv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264849; x=1716869649;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQAMz+e0g3nZFFrVh6fJZF5RVSqH/2InZskkKfH8zyQ=;
        b=qSJ3zrbSf52XApkZOYO7ZL0y5gjAi5RL0JNRYAD2hijfIEFvdKqVqzHXA+ONClJntr
         VFIubbpYtrmPEBAnOTq4zElE/O7o0/aWYj7HWY/iGFs2L8A8f2ovERwEVnN5p4gsPJc9
         jAfVKDQE3GcZm0UTuVFFwTj1/hqdySZhGxeedZ8mlGs3fDT4ichxvbtB18zsb71g6ajF
         du+ysY2kFOmlEyEPocR/b76Yb/YNaPw4XN6xBJmzoIraTThXpYiKNDsMX0iP2iBwORn5
         uuonX9u63tcGv+eSWVJHskrFeHffQXpJxzueQTzlcqZVs89gAqJiD/XMs+KfHbQ8Qr6i
         Izfw==
X-Forwarded-Encrypted: i=1; AJvYcCWl72opNq/PMKtzCMSC4qtACPES+CRHTjtZZeAJgwREK9mb2/zZuR9DtXYcJStW1QLbYAonG0+Yf0LVRiFpBZgjSesQ2LODIF1k7fAVM26Z/SgEmQ5/
X-Gm-Message-State: AOJu0YzzdlbJbWPfhfnrOGwnP37QesyahiSD9azz0L2JbVeV3BCZmzrx
	b30OD5cC4ASapT6tPh7EJhtB5XZcLFELhIEgmLjEeUZ6KO9G1clAuKSsZVUJEXptdhWgbfCFZTd
	iponlRJYSBjGf3D4nnUUhkpREOz8ud1t0cq5f
X-Google-Smtp-Source: AGHT+IErt01awAAr7IkOBO0CcMyBfFJYFdKpLSMo+GZEaQYY7nAl+Dw2FgYvqdFb3fdaEaa/X8kAqIyrlEk7mqPwHt4=
X-Received: by 2002:a05:6122:a19:b0:4d3:4ac2:29f4 with SMTP id
 71dfb90a1353d-4df88286136mr27403633e0c.2.1716264848783; Mon, 20 May 2024
 21:14:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 00:14:08 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202405181346.901048F98@keescook>
References: <20240514224839.2526112-1-swboyd@chromium.org> <202405181346.901048F98@keescook>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 21 May 2024 00:14:08 -0400
Message-ID: <CAE-0n50TuoSEaWmAcUoX3KDtp2ivdHmqWpaYn+dVdo4_L1H2NA@mail.gmail.com>
Subject: Re: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without
 module decompression
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-security-module@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Kees Cook (2024-05-18 13:47:14)
> On Tue, May 14, 2024 at 03:48:38PM -0700, Stephen Boyd wrote:
> > If modules are built compressed, and LoadPin is enforcing by default, we
> > must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
> > Modules will fail to load without decompression built into the kernel
> > because they'll be blocked by LoadPin. Add a depends on clause to
> > prevent this combination.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  security/loadpin/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> > index 6724eaba3d36..8c22171088a7 100644
> > --- a/security/loadpin/Kconfig
> > +++ b/security/loadpin/Kconfig
> > @@ -14,6 +14,9 @@ config SECURITY_LOADPIN
> >  config SECURITY_LOADPIN_ENFORCE
> >       bool "Enforce LoadPin at boot"
> >       depends on SECURITY_LOADPIN
> > +     # Module compression breaks LoadPin unless modules are decompressed in
> > +     # the kernel.
> > +     depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
> >       help
> >         If selected, LoadPin will enforce pinning at boot. If not
> >         selected, it can be enabled at boot with the kernel parameter
> >
>
> I've folded this change in, since loadpin also works in non-module
> situations:

Thanks for fixing my thinko.
