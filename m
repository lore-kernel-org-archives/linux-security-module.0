Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE12E9757
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317887; cv=none; b=FQRzlyZhB97l7wySJSC8fAVkUQy8GOIGnaeQsD9VWHV+h7Qjl+ww7ED0VwwlClt/T57/Izi4AIHVIq2l+m1+ttz2Sxb3NB+3eolqP0z6s7J1/keHM0s9PfTi6t+hoH19wfZrCxPBU7459RQ9/BKbDO0nglvmUEG+8Il84Pa1tpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317887; c=relaxed/simple;
	bh=kMehjDSkTzuk28YahKrFij+FunqVnt1oKSMf5uBlkL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRRKqEh0zUJ/+UG6c+WA0vsGYm5oRzcrqyXfo1Wl6YtYNlxdz6Mz7UgppbxSYHwAIXKVr1J/EGCmmpwsH7ZRDbm+Pcp+8Vb1PmJuVxa7CGnnegVsa84mjhm79JD8DmsHaa94uEr/VAOAyb/x/UnGpDuQUHJodzQOBuRxrXVaUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsmMHjhK; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsmMHjhK"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b5fb2f7295so16291121cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757317884; x=1757922684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMehjDSkTzuk28YahKrFij+FunqVnt1oKSMf5uBlkL4=;
        b=rsmMHjhKimOseAVXVuiajauE3AER+bElyPLg5lBVb9VdOsGLxyHYTlwE1qTX+ydqlE
         EecuhdXPezJjcBiNBMQZx4cLBc95NddeJ/2l0oT+5ZSGuYZeFUlUmtsGiUyX9j1Xpd9n
         oZI3eYP/ROJT0IMn/FDW7Tav6ZAt7mSpTKKomlfakIfomE56/8GWD71nbiHhSPnTkryk
         sGAALW5AbBd76+roIgmtAPyODBSWnw0UZXHBeQWz/Tu3QxCYezXnt8QWo/uho3+8LTAv
         rjWH1A2FE5SAHjbC5iYpqnP7QAzb+j2dxx+IF5lnAkjvQjv8FqALcgbBJbclYySwOtGI
         LIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317884; x=1757922684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMehjDSkTzuk28YahKrFij+FunqVnt1oKSMf5uBlkL4=;
        b=m4d54Z7vOWjxMD95NEwPhPbfckjbKFffMkCLvL2fVRyRw/Hc7NpFuw3xkiGb/q3/y7
         yEXqXlxzVU5jbui/ybpl9aP1qZChecCK7CpGh/CycVlxuzjgg/d5eCvusZw0jLO3lWc1
         dlXSPL9QyjxAVvk0OJLZWRo7w85cF38UB5xje3P3j+mHqGDFDJJXWPhMghCQX2wtgInI
         p0iQWAnjjQTTCl8kfl/hbLCmpNEmSjSzurKxgbmnWsFIxusR/GpAlAmjIQWlyFP7xkc7
         /cDpEx+gUzUJK1i11I3Vx9XmJhJXVSVQMFmIYvFKz7j7WSrXdFsMOBQtkZxXEcdFDboe
         gXEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZgJCZhDcwFrVVBbQNcc5PL2MiAytHDz+xI4OtAS2lpP1RHVdzJzWbUCJAVQ2/0qVGxwbvBQs4pRIrNJ+2+3LB2G4GeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDOforLibfJ4LAGNvnp5cq6v6UZxeOjhHuGHj+h9DHoodc6Gh
	f0yAMvJ2cKbmj+hjZ4vsRvn42LtEnoPzd7uR4HesVt1cmOKNF5pw8NWccsSrUw8cxZtutKQDOxR
	h2nkQ9cUJQseaOrFy2/nwwkr7eZCtbFSJ8h0t+wxQ
X-Gm-Gg: ASbGncuQw7VGrJjp22wK2Gi/xifqxqEFmX7gWxgiI+JUiiof8iCZmNa8xCDV9FjrkOQ
	dkoW3oKQ6rFl1BuKYp+tBRXFrMkvWF6945tcELFz4BcBQIiHQLCK7ktSuoq4qVNW1K1g0iR56NO
	/2ePp1Ch6Q1ZzDtW0zWBHhgSk0SG3QpySQgDF2hfbNNYW9u9DN8jNTyJYTsjljP2KM/T24yEtWC
	7yZhjxVG5jvRw==
X-Google-Smtp-Source: AGHT+IHhAakUmNgkfHukrapxhUwnzHE8QLHc4/O1oiLMcZSXfgqGNdNJiQtcA8gmS0prV04C3JxmHb2hTprCt/epFAA=
X-Received: by 2002:a05:620a:3f97:b0:7e9:f820:2b7e with SMTP id
 af79cd13be357-813c7963615mr681926885a.84.1757317884045; Mon, 08 Sep 2025
 00:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908073238.119240-1-idosch@nvidia.com> <20250908073238.119240-2-idosch@nvidia.com>
In-Reply-To: <20250908073238.119240-2-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 00:51:12 -0700
X-Gm-Features: Ac12FXwKtbvabH2QGt1i-gWCfIo7jNYLuwa4l6s1ON0SXOaJWQVmtg9-_RcrBhE
Message-ID: <CANn89iJ6aodRDPYRw9hYP6gVai5TAV_J2WU1yzAsPCU-56-Bwg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/8] ipv4: cipso: Simplify IP options handling
 in cipso_v4_error()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, paul@paul-moore.com, dsahern@kernel.org, 
	petrm@nvidia.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:35=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> When __ip_options_compile() is called with an skb, the IP options are
> parsed from the skb data into the provided IP option argument. This is
> in contrast to the case where the skb argument is NULL and the options
> are parsed from opt->__data.
>
> Given that cipso_v4_error() always passes an skb to
> __ip_options_compile(), there is no need to allocate an extra 40 bytes
> (maximum IP options size).
>
> Therefore, simplify the function by removing these extra bytes and make
> the function similar to ipv4_send_dest_unreach() which also calls both
> __ip_options_compile() and __icmp_send().
>
> This is a preparation for changing the arguments being passed to
> __icmp_send().
>
> No functional changes intended.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
