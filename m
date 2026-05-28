Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862F327C18
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003380; cv=pass; b=GB4sDHw44vHgjs0lY/cFMMrU2Wp8+4YCozhdWDzJAhYzfNoUj5ednIdMw7czhgUzra1M5emh7KeLh0/5GA9gmqgZvDEOcUkZ9qQpMtsjTcSJuuXVDhchskU1STFNZabQWgSefV45rV15SfjdwSUgAEMgCfeUgw7M+i/gzR0BUxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003380; c=relaxed/simple;
	bh=Ncbg13Bfamus+jnari/icxx7ws0F50OoFIVKKibBv+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XETV8vycJxJQVTDRf6/jv83Y745lTfu92n6LObCrCalqtVBZjjux4Smg6H7QPjFyYQ1WlAXHgZ/s+37kfCpen3jC5k2lBJ93dXBP0+kJqWpXJM4CZQD2n4z9hqvL3/8oGHmlyw8qnHS79li3978ZkywZIctgcyPdFFgDndUtZsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qiu/l7u9; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qiu/l7u9"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso22517138a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 14:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780003377; cv=none;
        d=google.com; s=arc-20240605;
        b=CtALQasoyxxeb5TaPy2iBrKpu+x1oLIDpJ2m4WmhgD3zx22fI57lyrTBA6A8ldt5bQ
         m4poIAVPKK5iBocF4cpRJGjTBSvnYEeMRPZg7fFsODO5SaNmFnFwKRbSO7MzplC0Fdd5
         3pff5sqdeBGLjP6JRH4SRlYbGB2WoIfWzJ6170a27rWQomfRnzp5+r5GbZUZDx6tLihk
         ZMoVPo5apPWHeGfA3eV9xC16ut4niII2UpHNoPybAIK0FDm6tg1F5EQKu2VrjvHqDqA7
         0LfL5KLisu4rSVlfRk1NwMiwh0FF/Uk7m/22eThEzmzaVx99awOso5T4AcbJQXIrjObi
         2uXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+j9QyzKRilLqdIe/G3BIBz72vNF5lshTYZV8C6a9A7E=;
        fh=004QNhPYBWRRXXTMRls2R5lrbCSExAb3wCd2VNgcbFA=;
        b=lafS+72dqsWDz7Au90nn7Ry/7nPaRrqvYbQ1kwUrZ8uGgBAZbAPxW5bmvxycGH5iOm
         gYVvgTzI7N9M3iR/voKYX0uAPFm4ZrOhh10rtyUFOdMZUizmXRf/w9M0bGhe3F1v44qA
         tLnycKWFKMz2QR/iYXb2NFNihJyyeaVht3/MW3oPa1xgV9Gq7bT7oikagyAvnOToqlkz
         y6VZs282b9CmRIh2ctBG7fGN8QMqqjMUXoMgGDSwcKR5Hod1Z8oknKFftQSbBy8wDgtt
         dcrYW/1QZEnJz3gK8CD5C+dAZV7L2899EgDCMmcn36J0oGbKtpp5t5E2jeELWWqjd9TR
         Hj8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780003377; x=1780608177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j9QyzKRilLqdIe/G3BIBz72vNF5lshTYZV8C6a9A7E=;
        b=Qiu/l7u9OzZdkL/2DZg3QHfOY0mAmxY2rfKqrwqFLvco5eXXZbums9033sxd2SkFqT
         D671Is8cBOS/+6CX2GVJMIsrQ7YCV7oFUYM8EvNsVKfNV04HHiQAWf1qPYvw6dfnxRMS
         sLdYKkXORGESN4PTSOELoTKNSxjc4LVfRGwSqg+CnoXdpu3TPoQrb8Wak7N5hNiuPXY4
         aHDkIWe0OKgwU5hrX1NoFA7uBOFDdJEonWZGdzTOfEQGrF1baZciWjsIyX2+WvVJvc7j
         8l0S9ehU2zr7A5KbIL5R4X2Qft5lp1FKLpDef0G3svQMd86xSysHpXSgWx0eVDUKq/SP
         qB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003377; x=1780608177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+j9QyzKRilLqdIe/G3BIBz72vNF5lshTYZV8C6a9A7E=;
        b=mdjBRbrACL3OAMrCE54cj919t5KXVmrJYNpKnys9y/50SSoKmwNcaysBGjqHXr/eOX
         NDKtZtPTlxbGkMT+A6WWV6PrXNgf83KSxTjuumZvvuvqdPeUgrf9+p72ucz9/3/xlD59
         XUTHwhI+bavSLYVXaOdw/Qs0PuHEq8QuHZALgLTYkwRQxkEngSQ7Oh6o4n/VP8fh2rOv
         vMve6vtIlD4uhZiIo1bTGwzperNTfb2v7Es+Gjcrqm2wkl0WOFJYOKA1qp5S/Qak2cpd
         hnrIF4Yn/BieD0bHatKUg6Wu/GPKE/fpYhCovO1PipmEDmDhHtTHt1hENTqRHFzRUP0j
         LtHw==
X-Forwarded-Encrypted: i=1; AFNElJ+AOeczaEXN60ikZv/qiQL/b9seyeaGzabwvBGMLnP9w4jfcCoZ/iDJk6pAaaQ+n616y228LkpU1cbTP6Lc0q+3BhH/e+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZb6TJnh5a3C2x9h2/RHJhHWd3Hyoh022Df2b3N2692Wc0h/Hx
	9Sk8OdjnvQQuX3yiu6yFzqHeiiH1+1b1oXISRx8M3mX/D/zxrM1Z2E0gASSEXTW4woxLocrMEQL
	PqcVUyi4ruT/x/B6fWicVy65v+6tYJgzmy/VO6iuG
X-Gm-Gg: Acq92OFtsMxifRnzrtgn6ybuMHQz2ym9aaPWfce024EzjierrAhZWl1GuCw1HC3Akoc
	Uc33qfb++sBHFGUO4qe/+/K8CAq2xe5GiAeyqAoNoj7tjbZtRoICYEAxGCRlrJTieT4yFbVK4cB
	pMxiR+k+mZYhD8nVylqIFKz/B/g9ZHTY8jl1F/rplBM/doPI2j5BOMhjeBnv+q66NsfmV4dW7e1
	wyYfcyryXR0fftyGfBwek9EBNxr8gzNBHSiA+oyHt8mW5et+zxH171TAjJBdJd/aix4kbE6lGdZ
	jLKSpw/aMjxEQiVSUA==
X-Received: by 2002:a05:6402:2745:b0:683:1cc8:84b0 with SMTP id
 4fb4d7f45d1cf-68bfa2730abmr207398a12.1.1780003376696; Thu, 28 May 2026
 14:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com> <20260528030915.2654994-6-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260528030915.2654994-6-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 May 2026 17:22:38 -0400
X-Gm-Features: AVHnY4JdrWqCzLCf9BgdCLgTvS-AaPF9oNKcK4YWpo4xq5d2lDaV1QIKYrYShBw
Message-ID: <CAHC9VhR6G5qmd3kXPas_L_SiJx=6J=wUw80xxL9Eu4=tSjMAoQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] hornet: gen_sig: fix off-by-one check for used maps
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	Fan Wu <wufan@kernel.org>, James.Bottomley@hansenpartnership.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:09=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> A logic bug limited the maximum number of used maps to
> MAX_USED_MAPS-1.

Should this be MAX_HASHES-1 and not MAX_USED_MAPS-1?

> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  scripts/hornet/gen_sig.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
> index b4f983ab24bcd..4e8caad22f381 100644
> --- a/scripts/hornet/gen_sig.c
> +++ b/scripts/hornet/gen_sig.c
> @@ -317,11 +317,11 @@ int main(int argc, char **argv)
>                         data_path =3D optarg;
>                         break;
>                 case 'A':
> -                       hashes[hash_count].file =3D optarg;
> -                       if (++hash_count >=3D MAX_HASHES) {
> +                       if (hash_count >=3D MAX_HASHES) {
>                                 usage(argv[0]);
>                                 return EXIT_FAILURE;
>                         }
> +                       hashes[hash_count++].file =3D optarg;
>                         break;
>                 default:
>                         usage(argv[0]);
> --
> 2.53.0

--=20
paul-moore.com
