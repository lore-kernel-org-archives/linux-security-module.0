Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926C361DDA
	for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803126; cv=pass; b=OfngoMt/6kVV83KZ6Xe3Ko7zF7RNbq0ewjuWw8JwjpgAXUV96zXfjaK/JfaQROcd16WbcZg5lkt4fT1ZO3IOXMVF246r/Fg9dcMmM/4CmPQoWCihYVH7DYXpHDNJVTdeuE6rls28T13zVz+KK3HTJAJLk1TctzsaLkqCR8YRs2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803126; c=relaxed/simple;
	bh=4SfGYEvTgZWl2OPwdJIRwSOsD/HYQ+eTSVebOXpQgdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9U7FsWE1vNyzTvOikjc/1pmx5Hqy+sBIITifb8B2Qv3W8YLEo0sAHmV+9FLruhEQMSYqF9+IaD9SJU/RoKOTU7d0cLI9vWU3YuxlbkXURUv18iX0qkFhRHHBKu9eKfR3die72NNQBobpxszjkCGBz/2Nz2saXXI3/1e092n0mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AM13ppB0; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AM13ppB0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so13582645ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 01:45:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770803124; cv=none;
        d=google.com; s=arc-20240605;
        b=Vi6zNTiu+a47YwG8E9qe2wPX7lAslUr3ke00CdOx4lkQznn4QD7CYsDEBv7X+pkOzz
         zK7lr6KunuDdqTBbJX83WpXZ2KcV00QP5MbwY3SHyV6guGzrQdskYLnNQ+481Zcx1TM9
         WEjEuvGQ33uUiosDJOZJ3Fr8FPcD/EFAz0th0f0X1rKZOR6eUBRcatVcnNdeK6vgr8BP
         y99usPToye+3y2s7yp37ytKgW1jVmk1Fl1TcXTRi1ljMYky4eRbUchza38bMQcqUfuNi
         h5dRGSAkN4sn62B4EvdsPLgjSFFwbU35NbWzYmfYK6/4eCPlNoxvra28eHfUouRyg57g
         ve8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d6sJ58XZMglWsL6NxAISCHs0d390+VHozFP2wKjDGnE=;
        fh=gLPmLbLzuBrmxHfE3+ZGg41EMXNTPynQrlVTa1hLEtg=;
        b=TgMOhOg5DQ74teFnafX3Z0iYdwkJhBWyT7KgchQBwjmZJTRI0/lwd7lnwCu6efpjO+
         t8fFsjR0AUCnUBi243h0tW63sxlbQ4dYLGY54NcnlKQ7knAGhjH8cskK7Rh7F3NIsBMu
         lBBpWAoqHtMr5RqRHV9/rKS7AbcpREEdlp8fPbiP6Y7dqFcSXig9DvTMB/cB6HFKr3ng
         Q5TqZCxJ04FIfDhfShxdLn1A/BOgD3JpfmFZpdCBcbIfviPM6as/7aBb7fuI77yeLfoK
         l5MPRC/gyGdWJH6EnTM2N+DkWemr/VJ0QSgFTy8b+7eOQZhUoZPRuapXUY682TQbfd+s
         8uNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770803124; x=1771407924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6sJ58XZMglWsL6NxAISCHs0d390+VHozFP2wKjDGnE=;
        b=AM13ppB0P3asYjLpw+jPnezhWvO2Sk8rQe7yy7jSKEWdjZ+cL505hqc03NSHF4K3LZ
         lwnHZceVes8Q/qOBhLq6K/9SgoQ6k9+W5/ZEdnWjagMQ3M8K1S7ICDGtgB81jTneEh04
         77ROxavmDDeR6NbR9BMcHjwqD0ruYZZfzbp1vfN0rCFAlE/6WwavIZfM9otuYqUpb6bs
         KBR4rt02jEAkE07Zs+AA+XuCuGpVRRXr8ut+LqPNOUnjA20YanL+gLfNHmtLRlN8nUB5
         DY5HDDh0f+KRcwW5WNFQoaeB5z+5QUSD+uItmMk46aOGqVST/W3xU7kdYe99EFMHeal+
         OQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770803124; x=1771407924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d6sJ58XZMglWsL6NxAISCHs0d390+VHozFP2wKjDGnE=;
        b=iLBz3BfXYuNKBzRCtKUq1vrt31X0wl6gC7GtGPDYaet7aZTIZnMD2suNlpWKMvK46T
         uILwOqlRMzhNx7kXsF916LZRRUukyzSeGgA8w2Rdhmq8IRkl9yU4IK6L9ZVReEB2BbIz
         w8+0uCTRieAudCH/IeEUvBGQROrDW813nO1eJxytBxFOHBnho7mkPfswEhiFn21gdA7P
         /vY8ZqE6wXFtUeX6VCOFTq9nE764jV01QD7sF+03aoYBORbOczwia9TPmD/fJkdzjwXu
         paqQsu2SKNkSVMCflH6i/qMwG98kPh8HO8ZhBRHdaZaigqZm4Y/CNHh5TOnP15OOGOF3
         EtAg==
X-Forwarded-Encrypted: i=1; AJvYcCXrzkxlbvYILICnb3fBclAWvr1/6P0yZYxhYOSXhGBBpmHNUrIgJO6WxfRc/5zsF+UeEcbB2hkpLEPY2b87unaoVvW71BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94gHrGGT7pNwSSKzy84qktKAtYCxLeGfkNpkcLmMUUk/bcf/X
	lbXq2atypQl7yGzzQXFrd3XKr047FuyON3t7nwAzIlKQiFzlwotrOo4Zj9+wR18qk78rAtMGJIf
	rm5NV7zr2oYoBde+xuJdiu6dkM33Ms643MhIE0XeHiHz4Co4cv+YbR3zw
X-Gm-Gg: AZuq6aK5octSUO958JRmN5Wx+DMn6zDmpYk9FZrxFpEYk9bnmcAHDUBp8gqWaWX91n5
	XHv15jXZZq4CqI5RTQRdwgLvlLx+Yt4X1ZQgC4cnozlkINHBFhr0R/Io5YHiNzqyiUDdhQVp4ti
	oruqnpJLJv5jwjysu+8Hp2r2jZHhQVffByHbzVa3bCIdiZa+12e4Vv3KgZOgsuVbITncvJjgURw
	URvM0E61hLjjxMGwBzGj5J5zrD7BYy9eIPTUJo8orA+on/GZUxRUAEiLHfOjkUorRl3RRFtl9hR
	ZcdqFQ==
X-Received: by 2002:a17:902:ce05:b0:2a9:6414:719b with SMTP id
 d9443c01a7336-2a964148127mr131635365ad.13.1770803123898; Wed, 11 Feb 2026
 01:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207111136.577249-1-mic@digikod.net>
In-Reply-To: <20260207111136.577249-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Feb 2026 04:45:11 -0500
X-Gm-Features: AZwV_QhiRUmFIdRcBP1SARQwC75eZdRXgTzg3GwjJsU0C2dSLp3W8Z4q7ZmZ2mg
Message-ID: <CAHC9VhQ_3UY-kZH2B+yM5Ewxjo4fa8ikiFM5NvuvY_pCOYycZA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1=5D_mailmap=3A_Add_entry_for_Micka=C3=ABl_Sala?=
	=?UTF-8?Q?=C3=BCn?=
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jamorris@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 6:28=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> My Microsoft address is no longer used.  Add a mailmap entry to reflect
> that.
>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: James Morris <jamorris@linux.microsoft.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
