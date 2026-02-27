Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846E258CE7
	for <linux-security-module@vger.kernel.org>; Fri, 27 Feb 2026 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772158723; cv=pass; b=MKhUZfaakjXhhe6yJE2rQPsh8yOcxUDDpxBUsTSWO8VoCfa5gZqIgVRSBAez4td26oHCf9AIVyXX/j7B+/5yxVbi7EP8+Rx0B8vJ+1zft4xA0YAjGrU7IFLkVTciyUU8Rg9z9jBHuNYGN1qVRyqZujKGbXKGf9Mv0JBAibrXxiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772158723; c=relaxed/simple;
	bh=7+T0QT8CrbFsXxd6NbWTB0AZHVLKdAcByNSQNl+1lec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayw0RgpcqzPEMO1U/8ocbi919lGKounsiRlwUimMbDDDl4l0ujG+UHmg3TDQh99VU7HV/TjUKaXh0Qr/EkAV7XqNTTkCtS0VzKWyrs81CkUIhIYDjLamT1tOCrJJVsL4sK/Vw6tIAXXrz+ECVqTM4ii/lBgKFF4ucgs+wnn6Q4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZZiYtVam; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZZiYtVam"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e77ace76aso606295a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 26 Feb 2026 18:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772158721; cv=none;
        d=google.com; s=arc-20240605;
        b=Ae2yW8VrQh69Rp0UBh06ybrVf59jusitkjR/GbP6n16GCAhSFqnABRq9coKjAsD9xN
         lTmC4/jlGdt1XuR/1TfUKmw6lY+bCngbCSRP9CmnzjaG3M6aLbLWgdnZnX0RxQKuzBQq
         unpfSlkf0lPuYFPflTaC6EY9UWiEyol1yWO2rUP5WnQTuNKoCovKsQXDdKuFeTQthJBB
         jFCKzrmsDH0oFbbpzdZZVvUEQRaKOTfUQgz+Rkw+lLKPU7IdV0d7KsSflHHIIP2T1keQ
         j1W4XvX13ij126dY5eJtHwvjn5p/86XEAE/jNQ3ggN7zaRJu/4BMCSoeQYGt3o5jQO+o
         qxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BR8KYqHbAXGX8+yqIay8WrPwdW9BrA2BmWljrO40nUM=;
        fh=KTeZXUJ7qPyU+to1EYY6+vyhs85Do8qY4VSfD+BWy8A=;
        b=PRLVvoQ+0h0I5hN+0MUkY+lsAZ719TQskHVJm+zp0UyPyPlq2bR6l8IKtSR8SimJQ8
         tKGFr5OuhhvLCei15xISMsPWq2ByBXFbsM4SRJ84VD9NTfFvwmpWx4Ix+sTMSmreyDMW
         lELSu8XGovK5GN+aKk43QzFQu5oCaamgl5Lr9vZh+orGqQWhXj3SXoCUX8a9EaELllxs
         ip7LqH0+j22jowTH/b8MY8iEJPyoetSG7Kryy5gIYdo0WA727sb1xFsB0c29Oniv7Zqd
         PqBhoPevG/dpuL4Ai3x4D5DK2eKtjkHP+79ZhDdS9YPEOkfcPls1rWlteTOeUSLacj5q
         2C2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772158721; x=1772763521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR8KYqHbAXGX8+yqIay8WrPwdW9BrA2BmWljrO40nUM=;
        b=ZZiYtVamPBuA3hYbSVKiTR7tgadXU/joGliWBRxf9Lb3ABmlnMmL6QDjvvWWfitU5A
         +lQdO92OLdnA9hLQv9ixs0NYeRJT7bAyF2sS1x9o5cTjFLE3ODPhpd4qe09sKq0wjb+I
         Xaq5xpesxK3vWy91SEaZlzL/ZwiVLMxG10ZMvTDhYufh5KaRQyxARLE9FBS5OcOWY7sB
         ZjUgkTXBmsW61ZOWnCSQCM4FvAqwoVqRsP0DOAu8ftq48cnlmxjaH8t+WbUi9xTpzZWr
         JKxpu3312/OE9EapB0NA+kLBuExbcmbz8FRFHDU2KCvAZFKxLxvPssNZcMFgUKR6Y+BQ
         cCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772158721; x=1772763521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BR8KYqHbAXGX8+yqIay8WrPwdW9BrA2BmWljrO40nUM=;
        b=K/rsLkENe+orTytYrZk3bySOlKOgTFgKBu8Fidx/SHuON+iLgJ//ltSnqwcEEd3jJ5
         Iut5kQ+e73XXkeamTYMi3msuKrGzjUDGpbcQapUPAkr515DOZa3EgMHpKWN6t1Dcy+OB
         k5b5hAoEEpztioxh/XfdeEMg0Oa5Id6iMcEoJ1vdSd6f+wfi6ymAjclFh1+TYFs4YFyg
         1Z+rDM/Ld9pTVlDdLaU/0MEPUMfXUyv6syNbe6MRw8gGEC/WR6HIgsjjkrQ6Tza0Jm5a
         sTaE5yZfbG/iNY4G6JDWPhHfODjzCQ5aqeVPOqneDJcIoLXvc7eU0u0tfZOkfJHPF1ZY
         S08g==
X-Forwarded-Encrypted: i=1; AJvYcCV3bN6IrTFTgKS/e+/KJ5MXqmeOsSqscFnKq5Os9Xq6OiSQnI5DekDkK8AXJ9geUMcUqcjWxbjAaG2WF4ZUdfLyqwP3EUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEeP+uMh8oVd/5V09jXOL+9it8v+bRJghcMuUBWGyA8YaTW3m
	fw9vzp8HT69NYYmPDp215yQ09IR7tiO4Gaq40RoJPLF0GooLxk9G2fWr+Opb8Hiu/iB4dQIHuOU
	ogzbUsQITypDEWkUafCceY8ceT/l/urFv0iLTDrWy
X-Gm-Gg: ATEYQzxNeWG7oaAO/Qt5z8WfzWmZXw8Kfd4kOZGmmU0Je4rantvp+9m8b4AJ8mvwxT9
	zonW7+H64Ak0ZI6RUohv4f50mzLOKselfAj0drCH0LeTTqA16tnc8gFw1tE2kUa4HzA5oifTfrD
	kWHCtVTi29ky7svDjVbPRzWLRKaHjqqUNOLbtHRkGRg5UF0lRegIL9jGNuO88lEi1Ap7dqdHoFB
	yCeBdt93mtcxr/n1i8++rIaywypMoy/iRpY6YWubSc4tydrGRNEM76cFUHjQaElSCTNxrggQcFx
	3G0DLFk=
X-Received: by 2002:a05:6a20:b787:b0:394:3001:8b59 with SMTP id
 adf61e73a8af0-395c3b3da44mr1289545637.53.1772158720942; Thu, 26 Feb 2026
 18:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220091941.1520313-1-aliceryhl@google.com>
In-Reply-To: <20260220091941.1520313-1-aliceryhl@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Feb 2026 21:18:29 -0500
X-Gm-Features: AaiRm503VNspKoFL9GRricgpKufCruC3UjwEoekgp11URjwD_eLxz3lfXP-kW-c
Message-ID: <CAHC9VhTwJbuXrdUFxWLVWfgk45hLScPgaC9Xb+R2NH6NGdaMZQ@mail.gmail.com>
Subject: Re: [PATCH] cred: clarify usage of get_cred_rcu()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 4:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> After being confused by looking at get_cred() and get_cred_rcu(), I
> figured out what's going on. Thus, add some comments to clarify how
> get_cred_rcu() works for the benefit of others looking in the future.
>
> Note that in principle we could add an assertion that non_rcu is zero in
> the failure path of atomic_long_inc_not_zero().

That would be interesting to add a WARN_ON() there and see what
happens.  Hopefully nothing, but one never knows ;)  Have you tried
this?

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/cred.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

...

> +/*
> + * get_cred_rcu - Get a reference on a set of credentials under rcu

I agree this is a bit pedantic, but it looks like the bulk of the file
capitalizes RCU and technically that is correct as it is an acronym.

> + * @cred: The credentials to reference
> + *
> + * Get a reference on the specified set of credentials, or %NULL if the =
last
> + * refcount has already been put.
> + *
> + * This is used to obtain a reference under an rcu read lock.

I would suggest a different description:

"Get a reference to the specified set of credentials and return a
pointer to the cred struct, or %NULL if it is not possible to obtain a
new reference.  After successfully taking a new reference to the
specified credentials, the cred struct will be marked for free'ing via
RCU."

> + */
>  static inline const struct cred *get_cred_rcu(const struct cred *cred)
>  {
>         struct cred *nonconst_cred =3D (struct cred *) cred;
>         if (!cred)
>                 return NULL;
>         if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
>                 return NULL;
> +       /*
> +        * If non_rcu is not already zero, then this call to get_cred_rcu=
() is
> +        * probably wrong because if 'usage' goes to zero prior to this c=
all,
> +        * then get_cred_rcu() assumes it is freed with rcu.
> +        *
> +        * However, an exception to this is using get_cred_rcu() in cases=
 where
> +        * get_cred() would have been okay. To support that case, we do n=
ot
> +        * check non_rcu and set it to zero regardless.
> +        */

This is surely a matter of perspective, but the above seems a bit
wordy, and doesn't address what I believe is the important part:
setting non_rcu to zero means this credential will be freed
asynchronously via RCU.  Both get_cred_rcu() and get_cred() set
non_rcu to 0/false ... although get_cred() doesn't do the non-zero
check before bumping the refcount.

I suppose we could consider adding the zero check in the get_cred()
case, but even if we ignore the KCSAN barrier, it looks like the arch
support for the inc_not_zero() case isn't nearly as good, likely
resulting in more code to execute.

>         nonconst_cred->non_rcu =3D 0;
>         return cred;
>  }
> --
> 2.53.0.345.g96ddfc5eaa-goog

--=20
paul-moore.com
