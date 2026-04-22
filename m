Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFE249EB
	for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897725; cv=none; b=AuHWxQ6orVsPcMni8rr3vqsfwPoT22XWp3yRQc2yO1vEXI4Va7enXjXU4g6tLnkcOpv50RFMLodFuHK3+SXMsHuQLwUY/Ujpx+Ggep1J4T7utkTw2Vq4evD2ueRtWsa7hfkmiZ64vBWyaNgGQL8NiVV0Xdyd5EISErENylNj9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897725; c=relaxed/simple;
	bh=bgCsvL7f5aJzYJc5+W+nNRwso8wLu2KlHbO2ZFM+rVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5rzIfc6ERAOe7/blA6tLqP3QI58G4wpq3iJ8/5mLZuuSTnlmy5i7t30RgKw0iU0223UlglU5oCHXN6GkTEaFlmalAe5Yqy0o52bl5XN8kD1Nz1ObF/ZlrtiXinAto+2vNWLHYwuC8aO840RAGO9PGhcWDnpUDFJv/zHgC4DJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=op0PZ47n; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="op0PZ47n"
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 72E473F877
	for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776897721;
	bh=W1xzzRlJ8xgOU4M+Kcr2oZKhnhQvcX7vIzo1PxDipgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=op0PZ47n0FGMKE7/is2ik+DhpiY4U+vVjCKrtwByTA2vwVvdBkWjH3A2ythJUfbwm
	 WWzmRfZzx/Y9xTxJ7aZFrq0a+19CLvEgpdzuH/joqXR5Qa7kZNX67Kk6vZQncvHGOk
	 AQ4kG1uhbO4y3+gD6t2Spv7AGI/p7xRyBfr4h/mAdqm5dOnOOIJgPhX6YbXf6F5KFQ
	 BLhxuHtl0HUSvXU80FO0PP2MAZi8TcEKP54RRlyIZT2OdS1dkm/02j0EH/zU/KKQIp
	 b4a6o8GM5GamF9b/2UjNa5yymmlXorqtc36OiCRbseEnz6q9Q+HK4qYu/NIDt7qf/4
	 8d15XsQyQ//0LfmLDp/1IgA9C6lRUE8KDlct6fhiQ6yG3zTg4nIXiFzaEFAbwTiFo7
	 qsDQDDgmERraIXJnZXAYPJUdvPyviGko4fOHUmFRcRNck36WvL8xZQ4QTotA/vsHGB
	 LaSL0UOLQyfwNdQBJ5IhR0vFddbUkZWt0qTXkhM4V0SjoD7gGmdPezmiy6qh+iUntQ
	 s7LQ2gmyiCId0qUyT/lAL/UPqoy7v4eLHfL3BnnCUJm116eOfrS63046PxFIFoPis0
	 1buOm5EQ0mrAij3Z4LX/9DHVXLqcpybGT0o3LhtBvh9r2N9uq4cAy4lDZZmo59tpQf
	 rXjl4Jj0zsylMpTT0kgtq4yU=
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9587174003aso8035226241.2
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 15:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776897720; x=1777502520;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1xzzRlJ8xgOU4M+Kcr2oZKhnhQvcX7vIzo1PxDipgw=;
        b=s1cSpic8YhCaurqv3IQ81x1SLdaG/oB/oil7O30w1R0Yxylc+R/E33ocFRRzx3QeRt
         ci/UPpHKv/hlWt3ykRxjApwkTkeK81LJBnZpXY83t8406da5OHQfSdmPlZ7i1OOO1BbB
         vl9MA7tYTzuWKBBglMwUSNEH+L1eal+3O66+XVxtZUsFb/jH5VETsJTteu1cF8g+jFRt
         4vZmAjbZWlymSbwDcYYuFt/5lOxqS413/yatJdPQdCupV0B776hfZBouBaWuYjremlWo
         60IXdL35C7vtMw+d4GNyuTJE3PdatQ9gnyMKMJStPBqY6QYVD5y+h1ftiS2844kJHZ7k
         4zog==
X-Forwarded-Encrypted: i=1; AFNElJ8yKEgyl/GwYE5tKKLcopK10crMIFOFR2sFYTmsHEaC8kkWoVU3iskcPH1QhDof0aY7An+1INKb1omgv/I+yc5bS/+j3J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3M6YN0OdyS+2qglFeibvTbzk84YzmhvbHJqYsLvuUBB5m/XU
	sUmizQ+sGMe9IhH3hYoQJDLKeh4qJlpHmzCZ+G21y/T6kzR3cZ0TDOIO+nH7uu1QdBuTtgVJecw
	oU7ryUnud1xzdiwU6pFZM2s9uWXpEi87MRt0Pt2qFFSdKkN1tqjHiVjFXNp51T9UKwrQBKNIj5L
	hE/hKXP40+kCaqpDCnug==
X-Gm-Gg: AeBDievSVwsCJn8D6/APHub1TwglyDNb9hxFlul5pwL2BAUPCqOHcTkYSAkiyyppn4S
	efTjDEb7X15HptXAzqDKQDAh9LxP/NfMcwH5uPyBFX2Zd1N1d6N7U6s597qt5sTCHTmN2dcwksu
	S66fy7jtHxXs2RsnEYq8QFLpYmyJ1S0Dt9G/pWbyzOM6PH22IZb4wrzHWATclrGBbXCwXXVvnT7
	LOwH+I/1umpiEp5AN6gsTtOhyepo1SY/OKkYXAqujpsfSqil8/3tilZ6wpk65sPEMdZSt5dcyj+
	m0ZdbLL55a/nMm0ou01dLkElgRk9Eb8jVuRyz3JPtiPfnkNBzL6RMHU6hoBFFGIudTvuVfCys/F
	yRKiCwJFn3OCZlHDms7w+I2nA1HtsFO8298juL6DW9SWP07p+vLLUzZiGsW01QeLKl6r9hxgY7m
	OxXVgZ
X-Received: by 2002:a05:6102:d93:b0:5ff:c64d:2283 with SMTP id ada2fe7eead31-616f7c5d67amr13534275137.30.1776897720240;
        Wed, 22 Apr 2026 15:42:00 -0700 (PDT)
X-Received: by 2002:a05:6102:d93:b0:5ff:c64d:2283 with SMTP id ada2fe7eead31-616f7c5d67amr13534257137.30.1776897719832;
        Wed, 22 Apr 2026 15:41:59 -0700 (PDT)
Received: from [192.168.0.106] ([187.95.109.208])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589097ec5csm8575275241.4.2026.04.22.15.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:41:59 -0700 (PDT)
Message-ID: <86c56735a80e98c23dd0e4f894d424f83d457026.camel@canonical.com>
Subject: Re: [apparmor] [PATCH RESEND] apparmor: Fix string overrun due to
 missing termination
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Daniel J Blueman <daniel@quora.org>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Thorsten
 Blum <thorsten.blum@linux.dev>, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 22 Apr 2026 19:41:42 -0300
In-Reply-To: <20260327115833.7572-1-daniel@quora.org>
References: <20260327115833.7572-1-daniel@quora.org>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Fri, 2026-03-27 at 19:58 +0800, Daniel J Blueman wrote:
> This was introduced by previous incorrect conversion from strcpy(). Fix i=
t
> by adding the missing terminator.
>=20

Looks good to me,

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Fixes: 93d4dbdc8da0 ("apparmor: Replace deprecated strcpy in d_namespace_=
path")
> ---
> =C2=A0security/apparmor/path.c | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/apparmor/path.c b/security/apparmor/path.c
> index 65a0ca5cc1bd..2494e8101538 100644
> --- a/security/apparmor/path.c
> +++ b/security/apparmor/path.c
> @@ -164,14 +164,16 @@ static int d_namespace_path(const struct path *path=
, char *buf, char **name,
> =C2=A0	}
> =C2=A0
> =C2=A0out:
> -	/* Append "/" to directory paths, except for root "/" which
> -	 * already ends in a slash.
> +	/* Append "/" to directory paths and reterminate string, except for
> +	 * root "/" which already ends in a slash.
> =C2=A0	 */
> =C2=A0	if (!error && isdir) {
> =C2=A0		bool is_root =3D (*name)[0] =3D=3D '/' && (*name)[1] =3D=3D '\0';
> =C2=A0
> -		if (!is_root)
> +		if (!is_root) {
> =C2=A0			buf[aa_g_path_max - 2] =3D '/';
> +			buf[aa_g_path_max - 1] =3D '\0';
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	return error;
> --
> 2.53.0

