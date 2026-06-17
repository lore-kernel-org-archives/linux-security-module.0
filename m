Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B33B1B4
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662844; cv=pass; b=qp2a2lFNgO6GfyYz5wj0z0+GhFwlJRFP/kZeMZ/yKzrOd1k0NhTkjULdib3sqyW2GsTwHD6x/OvY7eKgNqOJ3H0TJs4sYfcZc92K5oRAjgIR5VWDcZPOTRSovUJc9I4cOsWaxsfve6rv6sb+nrjBDT3AKVoJJqIhaYd01Esm5+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662844; c=relaxed/simple;
	bh=AMPQnUYpygK6FIcZ14/7t5A8fOJ+npmCw9faJljwUGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5oEJUik7hwig2f01J1/j6tqsMXGreOAqgRqN7L5glKpegTaWAZD3q+HQ/j0SCcGXd1JekKPSwuVpfmOe0tM9wJBrCMDi15uPeMxdsdAtf7Y6OV27bL3P60aP3hMMYnqp+wph20LTEeWNDAeCLxiD8Cz6ZzEZHm+pDsi7DoVxQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T8ci2bLR; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T8ci2bLR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso5308544a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 19:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781662843; cv=none;
        d=google.com; s=arc-20240605;
        b=EXpVj7Z2tXqpyqdMFXUfiVp1WdTiBIENT1eDi2FylNWUYyoMXVnIQb0tJrbWcQ+fAU
         0pyNuc1qlGhNcXeSQBoC1anTH5orUru21uUHqSNlcs9lAybckXOLuYUcsc+1yWAosMiI
         wEaVgd8lAwqxQn7ktvH+DFL7pJTAqkv7bR6FLqL7Ps1gD6ymtvjUxmEPPaSR2d6uALCu
         rTRwOJwK591WUWrXNPmGV5XXDPxeRIMwHk0GhZmQUwYEfzr8oRre3lXvOB+wBAwDRGIu
         qTdhZtxxJ4rgnw5xqaky76oJ4d3XCGJmR/Ya8MApLJJ+EAT2IeVst8CCdperT2pE4foJ
         L2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xnCH2xzLuqc+3Jfi7d5JBNf1kt13tjywRYwCEyR5/Qg=;
        fh=0s1Ud5b1Wc5thEQTc+a/unA4LClgZ+iWtADFDk2XNig=;
        b=AuKNg2cdx5eq2zXnwzwH/EsRgdaVKdyHnNjx2nRMMZY7x/ZrKE2AOSxqvt4rJL1NH4
         KwJC/8ZIKyugxo7kNBXj4wOw+EXPq06OQAvBt6vay2yb/rs1FadTcv+uDKkzILLsOEjc
         t+YaPiOTjoUPfIIjcBORGdIvjh3/II0Fn76pJzqdTlRRUrhc2k8Z4cRFeWwBSM/M0s7P
         HXTkTKSc41Y4QbA2oCn+DF7t4djBgtflpsNxYR4s/R8QsaW3z1fM71BUSJ0IgBJwuhRa
         ytxHLhMfuezc25hyzuiMTIGrT6+bowyq95owNbhiy9VskEW0W8GESbQShMovDaF0O390
         ntqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781662843; x=1782267643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnCH2xzLuqc+3Jfi7d5JBNf1kt13tjywRYwCEyR5/Qg=;
        b=T8ci2bLRgnYSxg6YWsQXmFInUvhjcRJ0el2oCX4yxxXHnfxLckkyNCVMMiYm4FZY9Q
         R3TQOHfLlQA2QJ5Gjzq2BnOkRMQnJMYHf9boPY2R6lBoOrm6aqM6zH4fCZcmSHrQUUDU
         RimoC49GqYuwDCCjiv+ha80O1FFWnV729wyAg2wmYsqQC3glm7rIIDtHDG2MRy7e94vc
         ZP6ISoMCO/GOMhsZF3Fk4pEBMwiW7o6twIrYsbuuv9T4KrJXmdwHaF5zUAWp2NRdhDfD
         pU/mggJRlztfcBvlcC2tNbuMh1iyKme9s0g9V2Yyn8IAl6fuUQGocZG1rymee6ZEuYA6
         M1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781662843; x=1782267643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xnCH2xzLuqc+3Jfi7d5JBNf1kt13tjywRYwCEyR5/Qg=;
        b=C5prHfno5dD20tCjRbMLaoKFTO9mLBwPgTlJP9z7WXt6TTEJ4ectMx0W1WRDgsfG8p
         UnrQEeuzNyxwb8I5m3HHV0O6y33Wj1Rhc0qLWlrR5kT+NwKryWEWCWFZVGOlEz3lF9V7
         gFA8GxqRQzPYd6CUEnfX3FBKBX3+MWAe5iVQNqjaVoFlXhw12tyicBKWZXTn9GVdppE8
         23Goy67fGxprtT9lcdZR2bwPPTs+zbSmPcoul4ovQ1C/5w5UMwukDBXjPS9QeyQqPZ/A
         8j2NZraAp3uXVc2Q5xP6dUpMEOQ1kzJivwIwDdKIUUeTLrQ+TyE7gmiHLsWRp8YD42BD
         2a7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Sbbx5UGPNUTUhQWoloZLZm/lMVN0ey4VX0LBcC4u2WuMjUVw4LjWMZVQRQjqjlRHT/lnGV6jSR2kd63XKw3U0TwDVDqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWErYd3xb5NAx7orrJ107bGb0y7ImwIQG36+GGl6MWYsi9/S7
	8lSWHrCely3aaECfe9r8+TixxRdig1cwArfZWypxQFTu9CHkUfyIn6DAAFddeLasawtQWybbXNC
	1EXjiv5VEo0W17fOowAf4HmDN+rM5tV6IS+IAV2Hx
X-Gm-Gg: AfdE7cmPVWVOSFrEAg2HhU5gNSzn5/ELiHorUGmh2ruomyJlCcdT9yy7mKPFXOTyDmi
	JSlY0Mt9q2xkBIlkf48NQeygbEz27ST6SyXOQnwuCvN0hko5yotgijn7q3I/IIcsvqcdyYd106D
	2hFuAvQcy8HzBryPze0b0kH6v/hzlywpZlH/2AAU60haOUw1muaw3TRS1P46p1jfMpH186iIBMR
	k9c/0lPoOcrcwbFEJL5AdBY+3Qam0UDmWez9exFiSpFtyj4/nwrurBqvXYWpjdW0xYVi2vK
X-Received: by 2002:a17:90a:ec87:b0:36d:ae6a:22f0 with SMTP id
 98e67ed59e1d1-37c9e9c8c71mr1394485a91.14.1781662842958; Tue, 16 Jun 2026
 19:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615.zeinurej8oZ9@digikod.net> <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
 <20260616.EPh8ked0niko@digikod.net> <CAHC9VhRa8DQ-ekrmPQSg2pO9pBFj6GA9DO=x5kguGFTbKKyv7Q@mail.gmail.com>
 <20260616.aiGaim8xie8z@digikod.net> <7ia4v7biqe64.fsf@castle.c.googlers.com>
In-Reply-To: <7ia4v7biqe64.fsf@castle.c.googlers.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Jun 2026 22:20:31 -0400
X-Gm-Features: AVVi8CcLmT2NiJnxN0ELE51mZvuIEGkps9HXU2nQpLi2RgQNJurQjCV5pgbJtRk
Message-ID: <CAHC9VhQ7Oj8v7D1EzkgdCHvMKxo_Jxxr0AzrDB519PHBsrq7qw@mail.gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, sashiko@lists.linux.dev, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 7:06=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
> Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> writes:
> > On Tue, Jun 16, 2026 at 10:11:42AM -0400, Paul Moore wrote:
> >> On Tue, Jun 16, 2026 at 4:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> >> > On Mon, Jun 15, 2026 at 04:13:59PM -0400, Paul Moore wrote:
> >> > > On Mon, Jun 15, 2026 at 11:41=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn =
<mic@digikod.net> wrote:

...

> >> I would suggest enabling Sashiko for the LSM list, but not enabling
> >> the email replies at first.  This would allow people to view the
> >> reviews and perhaps make a better informed decision.
>
> I just did this: 611f4cd410d9a7f7ad923a068a6ced455e3a244e , for enabling
> reviews I don't really need maintainers consensus. (I might roll it out
> a bit later)
>
> But when it comes to email policy I do, so I'll just sit and wait here.

Thanks Roman.

--=20
paul-moore.com
