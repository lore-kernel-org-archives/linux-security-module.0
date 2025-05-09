Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD3366
	for <linux-security-module@vger.kernel.org>; Fri,  9 May 2025 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813027; cv=none; b=ZEETMkbuglTVeteKinpWoB4XADnGh4+zqnTRryt1uM4uj3YDMbdxufzpZ97UEFop21Uac67WV7+39xTqU10HalQYKHcu2Qsh/PdGHG/rlQgyAu8HMclLGG+CqK1OLJSyjXqN7hSROzXZWXEzA9Ua/zOdVwbCphIf6r3nWTt3cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813027; c=relaxed/simple;
	bh=hXYUgfcRcZ0idNz4sZYclBKQTfqdhj8XQ1R3+qzWvmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxB02n+rkeREGA6K8INgfz+IO90yfpE+RUfG7lh1YiDDylagyHOxYfuon5aXxLi1ODblEya5ZQrPKmzn4bVr5afQfSQPqfkkGh/s1/uy8JTPeZGxG9scy8e5ohtV75svKtBEjZCJDL/7FtbW1lyeKLtJaeGrKtnuuJUJn8mb1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YScNymSn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YScNymSn"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad21a5466f6so219851866b.1
        for <linux-security-module@vger.kernel.org>; Fri, 09 May 2025 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746813023; x=1747417823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXYUgfcRcZ0idNz4sZYclBKQTfqdhj8XQ1R3+qzWvmg=;
        b=YScNymSnJ82LiUurayQVR2mhHQKn51BKtc9k/duEuJ9O5S2ypFHIhJdcOmiBBGO2tI
         VUmaqHGoQikY7sUY61XV1e+LAZg+MVlyCqjUOgOMN3kotAJ/4hzQ/ELYRTddppMjZgeW
         SQb+NSRclESaxaIA//OwOUELmCoxh2NJHmsm4TdVoRD0zDsH5vZhtrBrEvFjXhocTfF8
         9N0wnTQKs4bp6fEF3Tg2nniapqM4//aHJqPrIBEVCAWhBElreOf4lceYgFCS1nwVhKWG
         ZDQkCfK9ck910RAFjHaDQeo8gbKVBe2dzUfZ8lQEPZmJbRadjbtXjb6X12wV1ZbXw1Rl
         CFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746813023; x=1747417823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXYUgfcRcZ0idNz4sZYclBKQTfqdhj8XQ1R3+qzWvmg=;
        b=rpI2/SJpgxHUyjxqmUFhWRHCRsjeTt+HEAn+VVhj8Yfu5mxz2n8ssIuSaubTJGYSk3
         Dv0q85rDmU8BPz84exQ91yFqBcE2z2T5uKOT7SGI3439oL9U1f7bVo8wPkE7lkPtcGbY
         ueLv9uKYbgwhBRtkcrqkVkMR8Ra/rEhRwLNQOG+z2h7EbIgDsHi/BAp08BGBZWwnSq6m
         yh88PnKZ/tCsal4yLoDsro61srlD5CXk3HchPdk3rjAL16xoZpW8VpGAG8Vr1XpPSDV8
         Pt0sXsnMyHt1/RJAlACyog8+fE5Pk36UKMfIFJamb4NzAkNiduA7bOqJIkD9lAPxrpn3
         f2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXJSPLTPvPYsPZo6vA3UstaxM13FllEG8C9cDYrkqMcrzIbgp2uvhH+WMZnNhOiRn3/7Rap5mass2LsWqGvMsAwIHSgx/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnsa8BCN4wUwuXuXuOAYrCjJCuYM4XmDgldXOs5hfNOnAxUg0S
	klsHmxyoy8Tae8QkHX+3IAKwVxd7lu7XEAnDRRlB9PRoAiD2bCU/Blmbet3OREb0GoIkFdlduJK
	pHTE11TLrbmdTGZWVVFuNCEwd5qc1gtmd6ShiHA==
X-Gm-Gg: ASbGncs7JcZcrqASL2C8x3kj7Hzguj2D46z9vyvlC4UT3Fqwy6+4DFWCySDXInEFJpJ
	C7sUW1yObgu0XxzgwbIBG89JsZn4tTYeP8/r1ozOuxKqc1JRGbarzfWQNPbHqQJS5bWyCrmuhYU
	MOidpOT58ggi7A26F4iRCFJe0C6sYwybULd4gPJRVrQgWFzx9Go7I=
X-Google-Smtp-Source: AGHT+IFoPNJ8Dn1D7PC2I1I3Lnsb7xPO29Mz/jGZ0QXFMtKW673+I5DgnI7PWJakyUpu/pz02gax/i7eOCvEQ78NOZ8=
X-Received: by 2002:a17:907:6ea8:b0:ad2:2f9f:d4e6 with SMTP id
 a640c23a62f3a-ad22f9fd922mr102861766b.5.1746813023404; Fri, 09 May 2025
 10:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com> <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com> <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
 <CACmP8U+aLY7wmEqdb=a_tpDCY5LaPGb46DU+jSD3bCXX=JUAuA@mail.gmail.com> <CAKPOu+_=ocLeEqcaSMjb5qqrvi6KAu3GYJa19Fqz_dm3a5F77w@mail.gmail.com>
In-Reply-To: <CAKPOu+_=ocLeEqcaSMjb5qqrvi6KAu3GYJa19Fqz_dm3a5F77w@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 9 May 2025 19:50:12 +0200
X-Gm-Features: ATxdqUF-rCrSRV__2NvUqKFg_ImO5SZ8lKubSNuaaFLKL60oMmR70s8S_RLahBw
Message-ID: <CAKPOu+89waVOi90bYsNk8C4AmNEYeZGiDD2PseauH_zCvyRw_A@mail.gmail.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
To: "Andrew G. Morgan" <morgan@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, paul@paul-moore.com, 
	jmorris@namei.org, kees@kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 8:33=E2=80=AFAM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> What protection do you mean, and what behavior do you expect when
> setid execs itself? I see this affects:
>
> 1. reset effective ids to real ids (only affects NO_NEW_PRIVS)
> 2. new cap_permitted cannot be higher than old cap_permitted
> 3. clear cap_ambient
> 4. clear pdeath_signal (in begin_new_exec)
> 5. reset stack limits (in begin_new_exec)
>
[...]
>
> Did I miss anything?

Indeed I missed something (but this was apparently so hard to find
that nobody could answer my question, until I found out myself).
The "secureexec" flag is not just used for resetting pdeath_signal and
stack limits; its primary purpose is to set the AT_SECURE ELF flag.

So yes, my patch is wrong. The "secureexec" setting must be excluded
from my patch.

Max
