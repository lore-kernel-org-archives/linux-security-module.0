Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CD175A6
	for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864838; cv=none; b=Rn/zPWih63zLgAwufYevPGVyF8+afbjFnrlYTCzkQA0fpQgKI1vgZTmr9DEQrggOyP+Ciq0C9EFzWRkzqRlOuQT2AsKHSXW5UZVJrnWcKFmKP0xyJywkPMNJWuQ5vUXPDku7LKMwYLDk+Df1bMp2cds0UUVCbx/iGC/ZYia8QnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864838; c=relaxed/simple;
	bh=RJ411NQukGvGANF1CFRduL37FP2qka08J+w82lPEm7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCUilWA7OeYIeUU/8HOtuQE0ZsL+6xjMygg1aHTL21IeciUXkdzCmkJqAYqwqwQuwktkEcmkSvJ0hNdKZOTo5aYWG/rXwQ9f0gAPu7BogZG2nvqBNGlnSRiyeTzevFeKNs/Fy7XDOAKhoU1fLZIZQeSx8kc1A5nUD45UwOVZglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JDa0Wbtq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JDa0Wbtq"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6181237230dso1512587b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2024 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712864836; x=1713469636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFv4I7anGu3gsDIp81FsGte3DwjJSu9Sw0xRvjxNuzU=;
        b=JDa0Wbtq06k+Qcdq2QlXWGWl4Dr81EUwzZqEGaZ1c/54/SlHMswCiAWa6xFnbU8C9s
         vfnU6mCWNRvJxY8Vcfq8TcEUIOsccdTBE8BIVzBZ/CVWLqt1A9VyU80iXJiY4lpyOx0Z
         ucMbu2I0n5YmDwWE5LVc5hcxwTgs/oeU0h7bv+oIBjOQlrWNmriqsG2Zv013zH5Mith4
         WzKGPXcuJ3Lq/HBek5b8jY3Fvl+8u2GKAc89KJtAx+Ylzeu0ycjqQcq4nEEI+rRtjz4S
         ZZqzRMC01uaC9GsrM7VbUp02KKtgxwkj8QYiplkPH7mt/Dze+WvuUZ7XDLMHXEqYBdzw
         pEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864836; x=1713469636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFv4I7anGu3gsDIp81FsGte3DwjJSu9Sw0xRvjxNuzU=;
        b=TSPH1dPze59jIZItV7K1EJC/U8U9wpa9/774m3Cbay+CzRvQmNViw83dfyU+oQ2RjO
         rq2gN4nV6Of9UgPeK44p4FEeYRnTbelyen6YJPqBdLQ+vyKHFf1VLsppA/K92dg676t0
         uEwJE6VcDaUSE+uDqTKtmm/QYmlpo2Bet7E55t5LSSAVsGJC86j7kUI9fL7rEgyR8ZF9
         64gfn9opoVAMVc/PKoRwRECqdSPVH+BbaH8PvgtnwbLJacI2qXZqaDLHrY88efEdnsH9
         TyVLds/Q3zAT9ivryRXD2mmfDdKnoB/OD+/Mb4k7kmSdDcltGlWo7uxU4bU5i6nKqT9I
         YBnA==
X-Forwarded-Encrypted: i=1; AJvYcCWbP+zhW7nlIg3SYKG02cA+Jow87nm6YxNO57OsHGnAsZhrOqOe6mTvUd6mB26a/o6wpEe5iJ8W8s6+og6fNEdITMMvoNW/2xGOndlbuEzyRhtQnJr8
X-Gm-Message-State: AOJu0YwFATalY/DaMQDOs6rwL7fspm92NpP+K2Geb5bW7v32f6pGymFf
	QTbbLqQWYr1e6jozrs5EIFjrJFBEwZh6GmoBWoW5RqzdPkUHm7QFc2XOX6wYn78/8yrZs8jAWQ2
	BPxryUG/yD7xgLqoJprMkiPpaaP+uwycLfUiY
X-Google-Smtp-Source: AGHT+IHdCoVifKEcMOd98tKe1uOMwazi7j5Yu3mssA3gOw4eknclIkt19uODSH1i1svghuYQLd8Dk21HNeZio7FiLUM=
X-Received: by 2002:a0d:e64a:0:b0:618:2975:36c with SMTP id
 p71-20020a0de64a000000b006182975036cmr444653ywe.36.1712864836376; Thu, 11 Apr
 2024 12:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1d6a20f5090829629df76809fc5d25d055be49a.1712849802.git.dcaratti@redhat.com>
 <CANn89iLyMv2JjEGRoAWb51TpxuMb5iCPb8dvTAmdJoZvx4=2LA@mail.gmail.com> <a76d497c-5d87-4d00-a0f4-147b3f747bf5@schaufler-ca.com>
In-Reply-To: <a76d497c-5d87-4d00-a0f4-147b3f747bf5@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Apr 2024 15:47:05 -0400
Message-ID: <CAHC9VhSPb11cEgneKM1vbqjiuqLgvV+y933vhuhqHinWHtD_fg@mail.gmail.com>
Subject: Re: [PATCH net] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Dumazet <edumazet@google.com>, Davide Caratti <dcaratti@redhat.com>, xmu@redhat.com, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:41=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Please be sure to verify that this is appropriate for all users of netlab=
el.
> SELinux is not the only user of netlabel.

Adding my support to Casey's comment above.  If you go the boolean
route, please work with Casey to ensure that the Smack usage is
properly handled.

--=20
paul-moore.com
