Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23527B352
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770005284; cv=pass; b=QGVfqC0K11fZyO+ldj9y9uBo6xF7thazag5Hp7/wIJbOn4cnGF63I9NycqkhqRmRf+18icyA284GrZUa0sIHD9lMXRenqSDWRQQnfvUHDalELY/4zVgV+WusZ7dIIU3fjlzIi1lnLl0RfAD4RmpJJ5H01inzMpz4/4zbHt1Y0Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770005284; c=relaxed/simple;
	bh=YOKr40N5NMnJSSsWi5gI3boLeIf3C3Tjpjo+QN3HJjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdfz9T3v2Fzp0hQ0nRipZPzZ5o3ceLbYqEYX3PQOSls19WqvuP2HQ3Bodzvb9GCUBSCx//XO7PviZ8dmA1mGMx5Qp3ZrDEXkhbnFZf5riEopzx3xfUHzkwAeuXAz+PYn40LUoVvgvfVnUnNgRa0bXgTwCPbXsWgMGzubaQGskzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z5AuyF1W; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z5AuyF1W"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6541e35fc0so2326506a12.3
        for <linux-security-module@vger.kernel.org>; Sun, 01 Feb 2026 20:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770005282; cv=none;
        d=google.com; s=arc-20240605;
        b=Mvfa6sQ0hp88T+VU5wnhk/Vo7V7lj6vDSXBNQKlNVhBvzF9v2C/JOsPEEX0BaGlo08
         dNFdcAxS+DQo5ljVsoz3jYGtFA5Q/RYIQQUQsmlSHXWAqYlwPQ5EDuDP1sGtMr9E1Nio
         Hq7jLL1KFqyejxfI2yo3Osw3ZLiCDo4AK6wf8f1/ZebeWVcfstrpHkVuyfyyqAnKn4Xh
         kwzahmkK625RKWGhGjy9mSQl1VWF7j8Na48SuS+clbgWBkGVQIgHekFtuFmQc3L5nyI8
         FdEn0rjHJKKYezJKDtVQl0EE+Hoxd9unAvKGLAl1a7hUWkjUeIjww0MAPEOhGlvTieOO
         lksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        fh=3feCUqq7Rmc3YZIeVmm7hDkk/GukXzZLsi8R5HaWE4M=;
        b=RjQjIXwmjj2iBJt65cmzLCpDbOaqAL+J669KxMjsMkcrqNcFjKC6eeoKQUz0akq27y
         VYMqrKX+AbWiRO2YPhLHc1Wkh8Qgldkzv2G+dFWeyzb6f9zykC9HHoQHcbReOAAy/nzY
         OBuUzn9Zbz45V8j3VxP+1nM0/h+KxXbyyb6kYyUAfzQ0cUtPWiIbh12f3AsBqfxwta4m
         4x5IJR18DJSU6qPiWnbvNVml23iG8MtDVJwX5jNS2plxhh5Duoz08Ogg+dnpn+pTjhs/
         ojqDgqwEoibha7l3LTgP6/xmgv94xYJXaH95Zfc3ahd4EO1NOkNI3lV0mahZ+h+L6WNE
         qzNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770005282; x=1770610082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        b=Z5AuyF1W9uHwOuVfLhMpqNKLtetLBUPbBQWYpILdjYveYYkOdyIyGW9QYmOFt4Gq7s
         0g9i4BivZ7UjZhwbzYEqVMYSDR8Jtsd1nXXGuZ+sL9hQCKjO92cUrvN6SQBvhHicNoHR
         OPSzi8WxwfWu53RRcVttT+01EYe/613snG03dRTyYrqqcNp1n/2670gD5Rk0fGE8GcfG
         SsbF2VzKUpwAmyLOmogFNEO7QQNxeoJYqzt8OMt5ubZLsoCJLB9kmh5u5M7IQnt209/e
         rmXuLs+/hX+J9xheNgV1/5m33THNyS15j1PQYzs1/p0pBSDwqJRKGUy+y4OhIFly7SRG
         Fy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770005282; x=1770610082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        b=r/Sce5KoyXivGUsiy0crJXCH1wVArwfooKDgtr1aC7nDg7xsaNSxVkTmCAs6yanxdn
         DDFbbZcrjkzjtDmFBnfcTgAstASTDfceZ1bs5afFmVc1fXQG2wQTnNVbSoT/aymmRlWn
         S4OI5q/wW0fXUsLK1RVDoJQzzPYTiZ+gdqJDJ2NdN0ecBTKKWmC+wsw/duSGedSHhq/v
         B/9bhl9mwwMN7VsTF2SCO7hOx90zKvEEfXjtyOLnD7kvdA47Y3y4H5ccvsf0+I5sve/F
         GCdvIZ1tcKjDee2ZiRHAXB/9UuBmWS3HaAOF+dcR783kWMkEbVhudcWgbOwb3OsWktlL
         Lb5g==
X-Forwarded-Encrypted: i=1; AJvYcCVxDwITlbkw/MzBfYVBjj03mfoXrOQLqNy+nG6SxN/Ofe6MLzggwmLeC+/NKHrHQw4KvdbxU6JovQ4GAjmuETJBLcVkuEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdmN0oTAVBtFttqczmyx8RakhB6fgjNl20Vz2B3FDPZW7HhLT
	vPuNwbCe2hMbNZOqKBsPqE6csfE7OyIxsvTnT48hwldKKlsRvKAiMWNdCEfkSVIL9xRKriAdB6c
	KYYmkclVTg0ybyY2F/ZRCX9pYM/iqDUJkVAazo4bu
X-Gm-Gg: AZuq6aI8gjHHq8UZ4KObS6g5JsKHp6pTSM6gqVNBCDQJCqAik8ZbBoQaWZ71JHqjVjI
	b5tm+XY2d/g7HddJp00HhH/azxeDcHOlWNzrH3CY7zicggYiNRnAzh2DXUR82bByPProujmeHbz
	Eq8qDea5eBJX09STJ7nyrDOJMPMMN2h4b2ZPjdjnl9aPcECAvNfgOeQbBx14/PGdmUFF8/eLDMw
	FKBLC+7YQImcWZIcdoD8SSj3PP51pv+pHk59rPZLoDTD1I3O82GkjCnWjv8OVKyYqko44k=
X-Received: by 2002:a17:90b:2e47:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-3543b3e3a6amr10303423a91.37.1770005282654; Sun, 01 Feb 2026
 20:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com> <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
In-Reply-To: <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 1 Feb 2026 23:07:51 -0500
X-Gm-Features: AZwV_Qj0ZPr30GBIZpy2KTBmQCeMzIbAaQJB4ILIbQRznBk2H145kQkQiYyOBUA
Message-ID: <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 1:01=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/31 6:56, Paul Moore wrote:
> > On Wed, Jan 28, 2026 at 5:28=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> On 2026/01/28 6:59, Paul Moore wrote:
> >>> It sounds like we either need to confirm that
> >>> security_xfrm_{policy,state}_delete() is already present in all code
> >>> paths that result in SPD/SAD deletions (in a place that can safely
> >>> fail and return an error),
> >>
> >> Yes.
> >
> > To clarify, do you mean "yes, I agree", or "yes, I've already checked
> > this and can confirm that the LSM hooks are already being called"?
>
> I mean "yes, I agree".
>
> >
> >>>                            or we need to place
> >>> xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
> >>> safely fail.
> >>
> >> Did you mean xfrm_{policy,state}_flush_secctx_check() ?
> >
> > They both call into the security_xfrm_policy_delete() LSM hook which
> > is what I care about as that hook is what authorizes the operation.
>
> I can't understand what your authorization is.

I'm asking you to verify that we have the LSM xfrm hooks in all of the
necessary locations to ensure that we are safely and comprehensively
gating all of the operations that result in removal of SPD and SAD
entries.

> No authorization can be placed during must-not-fail operation.

Of course, but that means that we simply need to make sure we have the
authorization hooks placed elsewhere to ensure that users can not
remove SPD and SAD entries if they are not allowed.  I'm not arguing
about if returning an error in a place that can not handle an error
condition is correct or not, I'm arguing that you should audit the SPD
and SAD removal code paths to ensure that they all have the proper LSM
xfrm hook authorizations.

--=20
paul-moore.com
