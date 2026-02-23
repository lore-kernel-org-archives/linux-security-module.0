Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638628FFF6
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858781; cv=pass; b=PdYx15cNr0sPFvnTGM7oruQ0YoMzcG2FXHkKIizzOEpXjaS1HnpBw2iFiRCdgzr4fPIK5/l1suD6fwlAYeri4+ht+gPFEzbwjB6+AL+TB6dh+bX5rEYBeHEugP4XkDioOqWy2nGUmKMwF10Ze/RJUVkhW4R3q1Xc8FVkK5dZN28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858781; c=relaxed/simple;
	bh=Ua5ebazVPkVAaROdqBahoTBmr7z+xfRmyIun4rznWkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AztcWdna6pporowfelj3Dzp0jGW+imWRQq26mrw898L3WqR+VBrwUEf5t1N3nXaEXTxjRoUFafw5JvMfJNgkjDkseCeuH5pJ55yTameYt8hFR83rfqxBCKy3eblnmrx7OoLj8ogZVIfBmdrbGsoMiDsMUq4j5mpJRT+lxZ5FBXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=PfnHG04+; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PfnHG04+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a95bfdb31eso18287715ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 06:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771858780; cv=none;
        d=google.com; s=arc-20240605;
        b=XBbf2mfNv/+3Jt2FdcxmMu/s8kI5cTwcvcjR8fe8btUKi5RUUOoefanLn3a4TXPxec
         OfV3vq9Xla8cfi7rfSaMUyApL+unZENkO4RKrXZiF0d1S8Cq9QgjOEfRgZtCctfgnyqA
         ewIXTTueJjvVHmyFYTrsCq8xbysxG0R7/b7zb1x28MfggbGqPIfeO0aCDJnwNflnX7gx
         Rjk+huePFHUeQDwrSdDmlrGly97+FQurZ00GeIMer0yi7YjycnqTZO5gQ49bzNl88Zfv
         xf387BZGK57MyeNqE9yF8Kh6xz6kkfbZnGeCbaV5sRDSuGODe34BOq9rG8PvpE4NXfiz
         FKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        fh=GOOgkd0B4DgN6wvuMgg6L84obKlWuG6h1seo2wqlues=;
        b=i3SIR2jYHFe5LpgMVGr6/n3dRirin/DFXZFrrM1zjU0JhZ84h/iTGaaG7w8m/eiolI
         t1oLj4tmPSSXj6xBra+Woo/EaaqwOFFRaRW3SHEOT9f1Rx3ltd54EBxkereXxyXD9YTz
         ZNTqgRs0WRR5T07mBr80J+6DLwKKu10OhhEwDX+rAfMHUa6gZjDhi5kE2PEuBoOwPuj7
         bf/0h1QyIdnLEMCbgmchX8VmKTVxMe4Ikj7KqVU+tU0bqHgz20KpomeUGlxlEgqv+3au
         ly5j2O8XFcsqZ53SpR191XWcdhBkAT2drYBRTPxr/UO41jhzebgCHMLwNO2xKEhhg9+A
         1OAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1771858780; x=1772463580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        b=PfnHG04+XUnWCp92qHHPIornNbkLV8rre0fZd5MujhQEJl2ndftjWe0RUiLXXNBZz7
         9zI55kcPuY/gnrNSm+aHDJsRy3nua32X01EgZJXd24oY+wYhOanPizHIQCR5R5GVJorn
         wrZ3Z3UX9F34LGKkHKGBAtZHdTOFuIQUkDqDjoHCqf5jJnrR9qo2gjW+A5xIGeLfxQhP
         bndT7JOOmrNad4HrmPyCEuniA/M93g6LtxNDP88uZ3RKqdi+ATI5ayzoX5djeawA4tv2
         xTG9lYg3Rdk7hmGUyvT0ZEZnJbHFBMtVDRxVyUejDH4smQCR+/0bv9BEYs73pnJsbjZO
         UXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858780; x=1772463580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        b=q6Tf8jZTiXY0PDCpCZd27CM37sBRYN3I430mNsIs9hMCVueB3A3Mf4eakw3RfqDNQL
         ozfa+HOHRsUsA0yDwv4K6/cDuaIuP3PxP2fomOEFzFqN+GpNeoKOHBO5BP73vcP4MTeA
         Sx+horQJGWwDP6tQ+42qkrKEBrPQ3lpOXWvPqkziFMarospiKVlMC0ASvWNQ/jsOAVBC
         i0L4DGG1/4QZR9ovxYlo7F/F/54xBpQdzGDvjmdeqQT3DYe5K82qByZNyLMW6gFQv0JG
         SnGYGEASqkLLgFccoHhxenwmg+fr9KcgA6fA/a5/a0VtHF10Ch7BO3JI0xws7nYoWaO5
         pWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9IV+OUx3R3mLmyuty9Fgvp06rqRyX5VdBf1kbOZddK4u4nNfL88SSpj72VHNfUyMVS5n4UQuf9sjRHPqCtEoMTunUNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEqbaP/tNcvPVH3P7i8pWHtWfN563tXjjjZ6HaH/nNyfV73TU
	vfJGb84u2gNPYVMOMSH4PfYkKNZNzhNktaJUb3G9HsYL0sZ/22A+uXB0+Yi1tfmApOzlgvTByrt
	AEkvTJ18euEzJXwCVPxgSeI03evESqYdo/YC6DPLJxPf3KIza//M=
X-Gm-Gg: ATEYQzzW9plho2QX9pcYIpTZzt6jvf8cGOHzU47dQ6y53WzlK0Rfxrazz7Dkwylg+RM
	+dEBbQNFWY+ActMQBNMHKSdxccLMcFGLzdkzomJCc/w1YRZ0m5TTo244QP3DdRjUhR1yK3mvHK/
	WMDg8dfTJsjP9ZRQOQTepPMKhrkJr3nMv1UJRKIrrgprAiF81U/wAS43IvWwxtKK9UlV7u/quFj
	h/HLms1RRO28z1mc9HEKusCctnv4+uAqAgQUU2mmAKMljD2boAkQDvnFT3/MnNyU2DilukLT2O8
	+85HcZjgAKyDb+aCtpTDuFc0BAlwn4wepW0tCO/D6JV77/ZI22hEdHtYzLgfqJaGvTvO7KqwAUb
	1VYvHsbs14TFRTgi6LQ60QcumaiS8ShI=
X-Received: by 2002:a17:903:1210:b0:2aa:e6fa:2f67 with SMTP id
 d9443c01a7336-2ad74511a69mr96850605ad.29.1771858779863; Mon, 23 Feb 2026
 06:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v4-1-bf0cd7f9b4d4@arista.com>
 <701de3f87f0f6bde97872dd0c5bf150bfc1f2713.camel@huaweicloud.com> <89f51356ba5e630a8c305e5f65abd2f3ace37a48.camel@huaweicloud.com>
In-Reply-To: <89f51356ba5e630a8c305e5f65abd2f3ace37a48.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Mon, 23 Feb 2026 14:59:28 +0000
X-Gm-Features: AaiRm51Ex5szTVumxkie8rxUGv5c2Mexa2CnyFm86CE9yaxb63DUCIaTBGDvtsE
Message-ID: <CAGrbwDQgySNjK8K68PpWmKdhe0h7AuMeX78joqsC3bjiY=gyNA@mail.gmail.com>
Subject: Re: [PATCH v4] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roberto,

On Thu, Feb 19, 2026 at 8:55=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 16:20 +0100, Roberto Sassu wrote:
> > On Tue, 2026-01-27 at 15:03 +0000, Dmitry Safonov via B4 Relay wrote:
> > > From: Dmitry Safonov <dima@arista.com>
> > >
> > > ima_init_crypto() skips initializing ima_algo_array[i] if the algorit=
hm
> > > from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
> > > It seems avoid adding the unsupported algorithm to ima_algo_array wil=
l
> > > break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip)=
.
> >
> > The patch looks good, although I didn't try yet myself.
> >
> > I would make the commit message slightly better, with a more fluid
> > explanation.
> >
> > ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> > HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> > are places relying on the algorithm to be valid because it is accessed
> > by hash_algo_name[].
> >
> > Thus solve the problem by creating a file name that does not depend on
> > the crypto algorithm to be initialized, ...
> >
> > Also print the template entry digest as populated by IMA.
> >
> > Something along these lines.
> >
> > Also, I have a preference for lower case instead of capital case for
> > the file name, given the other names.
>
> Hi Dmitry
>
> do you have time to make these small changes, so that we queue the
> patch for the next kernel?

I've just sent v5. Sorry for the delay =E2=80=94 I got busy with the local =
release bugs.

Thanks,
           Dmitry
