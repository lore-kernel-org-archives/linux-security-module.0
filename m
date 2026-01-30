Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B5352C37
	for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810233; cv=pass; b=mSTMh61XZcCDDoVQHR+fV1UYT+n/4/3t7JwfQK0L2/s9PGhCe93yOlhw0A/2Hvt36DFqrVgZ3h2N7Z99MirhJc570vwk1jkvkE6IYtvJT7hXJ2pgjMmrpI9qWHBWrvLEz4/+/Ak+DZ8kQrc6DssKZmyKN9fxKrqWHRQzZYH7O2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810233; c=relaxed/simple;
	bh=ZAzvDCKA3yoG4zdUql5TXmg3+xq7tSh0DpwLUCCv05M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CflBee7uUDgP+Pq3FXijMZV8gz2QvEzIKwl+9ehZWkbovfy7v+TSuuUg4e0bktfPeekpTpgvgmXco0WiTQ3ZNB2QeWfqbdLt1hO7kxAA7Q0Ovh8nipPUJwE7E4tuGH8kg9Oa0I8jdZwox1ugn+N85HsgJQ9qp8r7fqrCc1w5VdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VpnxvS7I; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VpnxvS7I"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e93c5961cso2134005b3a.0
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 13:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769810231; cv=none;
        d=google.com; s=arc-20240605;
        b=MkDinzKKR01ydDORkJjACZj55JKy1GyBJHqiQ1ti/ALG7GVGLf/3fqbWAHeyb6IJtF
         GIlUiQwxbbMS1RknuTOisYfF8wrXoL1EvrEH6a5TAiCKPYrPY+wKPcAFVV1j8hy3qlgF
         T/kcY40ayfjR3SerRAZtZVSRsA+7/Lv58JRWV8aiYc63zsAwv6b81wIcRSqm/pfdCLzn
         Msj5GntaGCxayVNTJc2Cecm42xepCyJMU+FYz4ldTfO0ARKSyubqo8jsJufCRWowhxSr
         60J0nJtGbW0uhvlit4d33VZky+gC2g7sbNOETQRaARLS3CbkA0IFd8IjeIhlNr1RIHVP
         rT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        fh=/HeIeto54BP1rJ4RNyXZpiLeFx9erQuHaWTVEsRlyAM=;
        b=HSFG5+0f+buy6fSb4Rqd64A5/kLWgPu/2YlqJWcOPY/jkDmculAvsGWMTgObXZhAu8
         cGOJRSDG5gRTUR321YeGVxOxwIsajbEKInaIee5CJkygBzwHRfT6eBW4F0ez8e2qIQif
         ZXR97gYvz1VCdoUhwMT9FuXuxv4WHm/dJYrNZKKnUXiXhxVNOuAdOWG9JiCtsvlOmg3e
         DTSS7UICBVqC6B/KRsux4CL7BZdTxvcsVOcLc1FeNaAQWeiA4shQJTnFaBe95XwEvFXy
         O9bYGfQukN1hAVdCdi5vYbTQFLJXKZlIA+3BJWkLIrpE7ESlR1/ppb9+0IRdfNlf72cy
         5LUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769810231; x=1770415031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        b=VpnxvS7IHTGPLMs2SEC80XwggxREItMuAM1sJ6KYKkMkMzcwvL+drAx8C7btlboKxi
         Uln4MB0I2BqeiGXLpBaXLA3eEI3FL1k6/XS+LtXEgHQYSh++vFCwH2r0gPTbbJuKSfEJ
         DhXk0ec+IN2sqWJR2VrqGh3wz+RDNs1dshIYqzrI57ysXyKyTtfahMnhHY6+PxgTfZvD
         6rjr+VVy9r7auQ318sPUXShHQAMkD6Bi50k2fv9ORIZkARWfrhCJwsG8XzU4ucoRoOEI
         C91VEe1//QfNPIinWW68n88bO+Ml8rdU9jJWNb+jzFujJIhG5SsTIwWA6Kf2ODunhLfO
         eoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810231; x=1770415031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        b=o8FwNhRDN+0c6K4HZyFim+YTw1zRwGfGXzMIgslokxX1sKLHA+mt2H6ysFDm2oqNdM
         bHCTOt13KT5qONUbBwbLeRb0ma62u/q/peXTftJTUxqdwbpLEZm6tnC2L4Xhw6fvf3Rr
         V5Q+5ZND+PTL8gAILzDHi0EXJC2mSoUPMrEHpn39rJJJXKRK2RXkTbSU9fTOPcRlGi/n
         EGJiJtDCSI7d7x16Z4d5Qevoy3KH5+YOCFf/wgqpgBbzUYEzv+MsmrZAewAitTHruocS
         JmXFaN69SOw413o3KvSyXfEHYjXKuimQp6+YsdikDFRSblOH1sW1VMEBCFiRWV7MQ3Gy
         IqVA==
X-Forwarded-Encrypted: i=1; AJvYcCXugQvoh6OFbnj3fyYaM4VJWHFc1od67xYtAMt4qMQvIyDvC16xw1xnANlqS8Ww5rao0CH6eJbKGH2jhgnFxt1vwsPkf8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XHIPzyLjPmwEt3dhLRN/jj/JrDlgiobSVt6O6w8c5fRCXz5N
	wSkg6FbrRobLDUKz915KkUcMDLNB6gVBXQ9a9uo9Is9nAVTFDswIzEg5Qpm/oo4V9rt1uVVlsRm
	JK7ZV9NbfyJxdgUF4Kz8k6viXgryI7k7h339+H3wz
X-Gm-Gg: AZuq6aKTXETONL3SrAwyp2RxlnPRUBzHFxNMrzRIwWntKYxyuNky7/L/bjk6ekmaZ/M
	CFZvrKtm4T9eDEnOMJ3NjcPMnhCz5tN70Op6VVDPecZ/IF/lBOv1NmSHHeG+4LMya0KSOWVhdPD
	mW3VNc85WTEYbVkOPLDITKX3//TL2fAjoxU4HORlaSVlJHr3wniesRjprzcWn9ddOUu0dFPterz
	SSF1ZSn6McASyZzj+1BNioYv4229oNFBKI2vIBkEK72FJcY4O93Ji1/F4ky22vSJaaR7JNxg6y3
	4arVwQ==
X-Received: by 2002:a05:6a21:6f88:b0:38b:e398:b9fd with SMTP id
 adf61e73a8af0-392e003c0a9mr4572431637.20.1769810231121; Fri, 30 Jan 2026
 13:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com> <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
In-Reply-To: <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Jan 2026 16:56:59 -0500
X-Gm-Features: AZwV_Qj982ND7TJxgyw6A2KozmEAmOpS-qJ0nHC9KARsT_E53n9R8n-IFelzO3k
Message-ID: <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
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

On Wed, Jan 28, 2026 at 5:28=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/28 6:59, Paul Moore wrote:
> > It sounds like we either need to confirm that
> > security_xfrm_{policy,state}_delete() is already present in all code
> > paths that result in SPD/SAD deletions (in a place that can safely
> > fail and return an error),
>
> Yes.

To clarify, do you mean "yes, I agree", or "yes, I've already checked
this and can confirm that the LSM hooks are already being called"?

> >                            or we need to place
> > xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
> > safely fail.
>
> Did you mean xfrm_{policy,state}_flush_secctx_check() ?

They both call into the security_xfrm_policy_delete() LSM hook which
is what I care about as that hook is what authorizes the operation.

> Regarding xfrm_policy_flush() as an example, we can observe that we are
> calling LSM hooks for must-not-fail callers ...

We need to make sure the LSM hooks are being called to authorize the
removal of SPD and SAD entries.  If you are going to remove LSM hooks
from the existing code, please document how that code path you are
changing is still subject to authorization by the LSM hooks or explain
in great detail how that authorization is not necessary.

--=20
paul-moore.com
