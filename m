Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F32D7DE1
	for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042450; cv=pass; b=qqwJ1QwCznAFh7GCTmIWr0+bnrDRswX0jpHsI1hvOS8+ZRVarFy4PWh5HhHI3obm4O2ffJQB4+z/d8fJybJdK8D/DVBbI8jk0VzxTQHglNEgcDXfvNkZ7793E3DjwpgtyExZsSZKFjbwnxZuuXmWqvHwOIRM22+P+cmyOgEXfkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042450; c=relaxed/simple;
	bh=ezrs28hh800Wrad6rqosq13WMeXBTafZNVMfGZxxrPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfbTtpgXxs1LBKfxNI3tKZxScW/VoqbiEcZimChX2mw3AZ3jXVhp6aARfSvL/m7PLivrwv4e8+jJzojaybEzyff9HI/QRsQNu3bdUbMf5oAnhCLPfF9uXW1ex9AUHIbyvMoincnY/OTtFlvCl5LjtdvVBdWdZPr1/XXph4l5P5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NFDbDlxS; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NFDbDlxS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adec255754so2362975ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 10:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772042445; cv=none;
        d=google.com; s=arc-20240605;
        b=OqsVgOjoEuXB7aXgcYB6O7xRg6K+eVvioXo9RrR3uQ9L7EJqNBctbWXl8MJYFPoYCg
         KqzMjboviiVvXY+EeHcvqDjMtqRxGc/mj/dvEw28/Yv3tMAXQFNvIrQ05sb7pCR0Vlr0
         bpVuwmra6tGJJKocP6QpiqWMLMIt2IV0CZuflInl8ewTRcW9RMSDJdl33XzUZMxONBE/
         iQmuVvgHGD0s5twoO8Pb+kWc2+2ijsVE11dkR9HzC4A8dmyLjbG8gmN4QE9lqXKIka7d
         K/6PN2zxXfWwF1AI6ZWdoJVX4l8d3WmNQvSmpwpxJS4cZsIipTNLDW+hEqYYj56fZMCJ
         uwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        fh=j29apCo6HOO3ghX8sNjS9rVDT+lN6UCCKvJD1ir2sWM=;
        b=EMDOcUXSJymFfwiOGDQO6N244jDNwea326Nz38sWa5on8mLtEdx7LGCeXrpxBSYFlG
         BGUhhOjixzEy34q+rxE3T2bN4QxEcfqu382bXS5pugFrINo350EqbnjH4hkyN2M/beLf
         mQkAM+eX+rWRXzKxSmsR0d/xo/YvVAOwmnYim4ofAmyGpKwfa0QE/rd6G2zKMyZ96RHc
         JD77/VGF8jTRasd8GyC4bYpgIRwcyG76hJao4AsTv7dfEgxMy8akCLk+g0g6oZ0m+wJf
         KMuf+3Xm8pYCheGaqvtl4kTrOrFWD5K/pdansTb64L5BDGn5is2taSUJ3uemr7srB/1y
         50hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1772042445; x=1772647245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        b=NFDbDlxSchreCFA4REu5sfMZ42uB0CaSJZwym2B2f50pfwhGNXTkGUb4PqUXjK23km
         55rxRAMwMD/NQ9xEmOADEXNr+1otfMj353teENNrKaC9NxPJuJbh9mGCZRRJX7tx/uYU
         IcfrP4gI+j10pyNC2u6KuhjzLjXpU8jtcZofjpsemTJkJF45bwWyHeIq+rX4HJp/VgMJ
         Khnzz2oDTHvYevWSNGZh5krarObAwnMIp5FhNBlnAe+D5WuFU4J2j+btYH76tvy/RNtm
         KqEhrCM63QjjRt+guPxF3m4fSWvlCat1gG/AjDmspcNfBuR5m8u+krLmPvVbeGn1WpET
         ZC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042445; x=1772647245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        b=aqG14TDZK6FKZPSTzszo5SdUSMmMjzjM0NSWyoOiqeTZQg32i6nlTOZa4rzetii4OX
         8+ButnQq/euOo7Dyp1JKfl7/tzn+Dq5WhrDFUS7nAPHdHQC/I/d9XZE0phIRXGAoZyP8
         BqNxp3yPB+CSUwfSj8Ds8IoZVHzxXDJaRhpacMVZiGFVEI7FlbxxPCTZvwqxVMfU3oiO
         IpkRl+Yh2q5H1KPM6v2d+kRfhVMQb9wRL9b4SrjzeT+IuFkf0mbFcAQ0PDIRzh/OOmf2
         RR2InzcdbZJYPCr+Wg6juQ0UlDkEYOCTe/7hFwq27hPD9QJnIfxZiz3nn2tKD7zBWBfm
         7S0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6jmXmVmoLMOlz2yq90vpugIN6YIZ+SmLapQSh/tZZhxHxhMB/6HqH0mIkhQjyc46zKZn0j2iLf9Abq3WX8cmoBxxrFcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQceCVE/OPazHe8oTSadvYanSl/JqWqZk+hMb9yf+Nf0PW5Zxt
	HRS/0EXPshe04x6krLo6clDT2/EmQzjYWedpVK6x5NKnabls+paPBwjQTIcGKY/Y+7KION8j14e
	ogQ86s7yCbck0zce1AikiFRqYdh99sa6Fj2JpOdG4
X-Gm-Gg: ATEYQzye75hwxq4z7FoO4gWlZGZmwPLtk7+T6MI5N0OPUecCAGJRQf9bbby0xgmCpi0
	LAHpy8xThQRfQc8SvcIbn+C9x/kl+l6kXiot5P1NZrhcYxEDgzsM6uebYuEr9NCdYQUATfKJTX+
	ooquwKl2Do1hX5J2Qzu/nMCFI2wl1H77T9I9FF+QAb51o8+FWM/CE9dxC+skQpLxvn94I3drg6D
	GtzFH8jy4rUFo+gsFkj5Xwp0I04awvxN0iX/fVGBzxIEf1hFnCSJcvbWNNuIddWeX9Vt1D/kho0
	E867BsJFO9I0nPhTDdZadL6TGiLF3VZzHBH2ljp4xg6AinNTRRkPzXwJyvzR5ZpB8GLpG1JFLZQ
	sB86XmbeuohcBrF/LuHCuYghx8znt/US2
X-Received: by 2002:a17:903:1b6e:b0:2a9:6165:6e88 with SMTP id
 d9443c01a7336-2ad742b4ddemr145518575ad.0.1772042444923; Wed, 25 Feb 2026
 10:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-ima-oob-v5-1-91cc1064e767@arista.com> <5579780966d26d2fd0e3756d404d2156bd55a06b.camel@huaweicloud.com>
In-Reply-To: <5579780966d26d2fd0e3756d404d2156bd55a06b.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 25 Feb 2026 18:00:33 +0000
X-Gm-Features: AaiRm50Ofcel8xIk3XALa1jfjwmSOSuMPTyZWqkq20mhBhxlK5tUNoc9kdl48mw
Message-ID: <CAGrbwDQC_jp0iYtpW5JUMqEkJPZ01O4iL6zhyMgWQxXcfrc-nA@mail.gmail.com>
Subject: Re: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, Jonathan McDowell <noodles@earth.li>, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 1:20=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2026-02-23 at 14:56 +0000, Dmitry Safonov via B4 Relay wrote:
[..]
> > @@ -252,7 +245,8 @@ static int ima_ascii_measurements_show(struct seq_f=
ile *m, void *v)
> >       seq_printf(m, "%2d ", e->pcr);
> >
> >       /* 2nd: template hash */
> > -     ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size=
[algo]);
> > +     ima_print_digest(m, e->digests[algo_idx].digest,
> > +                      ima_tpm_chip->allocated_banks[algo_idx].digest_s=
ize);
>
> Sorry, I realized that this does not work if SHA1 or the default hash
> algorithm are not among allocated PCR banks.
>
> I just sent a patch to correctly determine the digest size:
>
> https://marc.info/?l=3Dlinux-integrity&m=3D177202677128752&w=3D2
>
> and applied yours on top of that (if it is fine for you):
>
> https://github.com/linux-integrity/linux/commit/6efbd2b38b102ecbadc350228=
cc30fd67666a089
>

Thanks!
            Dmitry
