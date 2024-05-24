Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1482D6C;
	Fri, 24 May 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585033; cv=none; b=giBExFABKQYwJSQz2YvGXCGshEj1EnRdMEwXI1J9XEKs2SFuLTgrrAQKg3VImM4N2A+8EFKlyBNNhtkwiVXC3252uWGAdDqoq52DquA8BdyeBkvOkGccANQkD8+65Qv1zLvKf+H7+Qa720WsTArf3Xc1F2q5drkm2DOf0ZuLTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585033; c=relaxed/simple;
	bh=IkKuU4yp54waIwA456gQUHmRrLLSQ6nNxxNfaMdF938=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kh57T8ZaY+prHT2g/muBd6PJ2AqicCS7qU3wzvMTSS+8dUsixypHqYyRs83oeNJwh3wweGVDj9rvyMcohnP4T3POkskRin6MWwBGQ2s/MkRocxdWrzjgpm+7deZaXBzhavaORaJkCH8XqZB2Kqmg2wrqRIvDWDf3pY8fc1vIazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOuREHgY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOuREHgY"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so1342994966b.1;
        Fri, 24 May 2024 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716585029; x=1717189829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkKuU4yp54waIwA456gQUHmRrLLSQ6nNxxNfaMdF938=;
        b=IOuREHgY7nppp3pZEvSGIC8I+h6OCwmpgq+3/79yx6hSyQkbDUX4KhbE0FPtdpjx9+
         Iw01gfbomy6hAvgTDl5of6DbgvptJKAOt5mzjJO9EzvhkyDZF6+QBsBiq3E3BCBEFwr1
         URjeriwfYaN5SrqNfUKtjWDBFNWi6afwKf4EINNVG7uP2OS7PMpZcp2pDp8GamsyxDAI
         n0wbGWhlAwQv1sZQVM9s5XBcuPeOZeC24TA1pqpeOynRlChGk3UNPdXq8gZDnagLVkTy
         MLo6a/r7GI48sxEnU4odbNM669JVe6DRtvMKwQfWPTgqjF9JwtEwiqg8hmZZvh4Sn9Jc
         qqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716585029; x=1717189829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkKuU4yp54waIwA456gQUHmRrLLSQ6nNxxNfaMdF938=;
        b=OGBny2At0MDSjUoJrQWBaK4GM2TpcVbn1LecbCZ8xs7qQUaz5rndO3ytxABV/ty0FW
         ObucoTb0Wu0dSgdheI7d03CTCPJKUg7+6WkcK/6eZt0gN30NJfXi1Xku3hKQ9hxODJk4
         YNCsldtrKWg+GjPOaknDHJSzqWnxyGs0M0Z02ryGPuvjPMOEZ8Ca7/ak5RoNVaOF/doK
         7tHZY7/gw7rM+AfgwIkXmg/OhN3I26l2vWGrxqSGWMFV3F3QcQx8gzd451HCi8w3huC/
         MGV3m4ClAAJvt9caI60LIsoPj7bqtjgJPCaT71k9Vb9vwsHDWMT5uUmicMWw95USqXJY
         qF4w==
X-Forwarded-Encrypted: i=1; AJvYcCUEz8qPHsT70d0VniKPQ8/+VrG36+f8t5Hu7TBSN8LHiT1rTJ99TnfoP2AhqAhqy80OnnZilDxQ7uvB0oMKfPH76gAEn5WXEnCCS56TiVuH1R4h4C7Yqiq9je0dGBYsHUKdD+YAHnnjsWGoT5/7zJ2ZpEQy
X-Gm-Message-State: AOJu0YxlCjkdON0Z4RjIGOP8ujR6KiwWjuQzep4e5OfKEOB2JMUFth0e
	Qs4m2YLKctLKKvYgyj/aoPX6dSsTo//uDksx/I/kPAoTXASSvTPLHfN8CmegK/p+d2/+5XNlhoF
	WR9aDUQV1uEIlSg7KSrAqz1jeR2g=
X-Google-Smtp-Source: AGHT+IEdmDqM1TqCnfcEDk/lrtdB8utzVZ0biUE6609Ih2ONH64bkJcTijvGGyF3ozwzM4N0slFjnMuUDlJdZ2X7G+8=
X-Received: by 2002:a17:906:6b0b:b0:a59:bae0:b12a with SMTP id
 a640c23a62f3a-a626536a08bmr227054366b.63.1716585028994; Fri, 24 May 2024
 14:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com> <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
 <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com> <CAGudoHFkDmGuPQDLf6rfiJxUdqFxjeeM-_9rFCApSrBYzfyRmA@mail.gmail.com>
 <3b880c7c-0d19-4bb6-9f0f-fb69047f41cd@canonical.com>
In-Reply-To: <3b880c7c-0d19-4bb6-9f0f-fb69047f41cd@canonical.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 24 May 2024 23:10:16 +0200
Message-ID: <CAGudoHEycK3iTO2Rrsqr56_Lm69rCzMRaYz11NLrOcn5gKB3RA@mail.gmail.com>
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
To: John Johansen <john.johansen@canonical.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Shukla, Santosh" <Santosh.Shukla@amd.com>, "Narayan, Ananth" <Ananth.Narayan@amd.com>, 
	raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com, 
	paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:09=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 3/2/24 02:23, Mateusz Guzik wrote:
> > On 2/9/24, John Johansen <john.johansen@canonical.com> wrote:
> >> On 2/6/24 20:40, Neeraj Upadhyay wrote:
> >>> Gentle ping.
> >>>
> >>> John,
> >>>
> >>> Could you please confirm that:
> >>>
> >>> a. The AppArmor refcount usage described in the RFC is correct?
> >>> b. Approach taken to fix the scalability issue is valid/correct?
> >>>
> >>
> >> Hi Neeraj,
> >>
> >> I know your patchset has been waiting on review for a long time.
> >> Unfortunately I have been very, very busy lately. I will try to
> >> get to it this weekend, but I can't promise that I will be able
> >> to get the review fully done.
> >>
> >
> > Gentle prod.
> >
> > Any chances of this getting reviewed in the foreseeable future? Would
> > be a real bummer if the patchset fell through the cracks.
> >
>
> yes, sorry I have been unavailable for the last couple of weeks. I am
> now back, I have a rather large backlog to try catching up on but this
> is has an entry on the list.
>

So where do we stand here?

--=20
Mateusz Guzik <mjguzik gmail.com>
