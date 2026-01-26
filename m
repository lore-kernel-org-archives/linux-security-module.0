Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F23093A6
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466822; cv=pass; b=jSKFzv9owfofv8+i6blnQwz0KD5VUgPwcEnzh7vcj1Wqac3ivMzwR5fz6gWPReOP850Ck/HbyzpkwIEw/qSx5Di9iZMeWol6wbJ6mIT8jNBbT+UTm1CPjBVWbuPqhWhLPNBqYSWpurQM8bwwIxJjPxkrJPZE2xLb1yLAPqaS9ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466822; c=relaxed/simple;
	bh=lqktNIYdTMjsWu0O9cUIJZqK41TShWavVm6Qx5DAnug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjNGGQXRVVKCcUctcKqSJcburcdPF4OcX3SpcNKpfjzVlfY3x5CGmt//bfUqQqKQZF/1s6v7y7RojaZLNiOKGffODiOJXUljkRA1CxZBOQICcGRW/+TSeduFufOeotU9fh63xPI+yuxkRGygwQw70h7Onti2ApcufXKGT1PyNpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CHOrEIw4; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CHOrEIw4"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35338b3dd31so2364883a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 14:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769466820; cv=none;
        d=google.com; s=arc-20240605;
        b=OwAG1O9iStGVzMmL31GIOesS7D25TK7DvG1egXWaA3b3fp3s5pIeCeahfY6wfolI17
         kAtgl+ov7vGxmDU30LUot0rLoPJPaU1OuQ9uh9J8Gre8QsB8kAwJyYDei6+ZMjFD68OW
         ZGpcmf1KQkWF6JkHpafS8etqdL6hAlpCZPLbnBjerSI1QuDmNu453wAagDoDoT++bPfq
         2jaXRN2+IxhRbZCjV4estajZbsP3kbv313rlLwPPJhJ91Iv1NXWnKWcUQ8uLxjLj/GjQ
         PMVX6S3kb01gZ2TuBs+Qlf0S7//33GEqbjHg04c8uIEJfp8ClJsaYLrFHizkLr0SEUjH
         XP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        fh=J0vj6lov8kmi05Xl3XPa7NoUjUUqFTnhbgz6gAG2KH0=;
        b=ZdWOA0VoREf5Tu14arxp7Hpco/BDVENXqOfa+3CVUI39Q8cl4qjC3NNgOMW4RrsSms
         rG2NoE4m7l99CMKVMBsR9JdB4rK0AnYrWbiIq/4UObbUp8vuaKxgSIj5An8I7pYVga8b
         7okggf+xGl87o0du+vC3SATjpwI/n05OD11mnRueCdP79Ycheu0xW+xro1c+bUiNXPhl
         B7hVBllZO3n3AwDnGcFEu1NExB+jVMFBVeQ9VEY15LQTNRoNrXTkwwYpMQWzofSEV314
         xhrm2Lw0nKfRpeYhGK/NY+xvQs0ttnqWOvy7IDFr14O5T3R7mFsRxFgPC2LQDIJo/CRS
         u60Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769466820; x=1770071620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        b=CHOrEIw4Wv29h3+6QT4reb/wOWcq6qriGJfMqVdSfjJRC+v6NkbxIMw5b3jKUjBjSm
         VePFbfH24Cbeq+NbnkQKYvW0h2W/X/Dvzk4jYiFACUD/R7fdmSeggpXVNdAUVCQfVUFp
         z+Rxzq9LBV5Wvr+cAVtlfURKglgzHMq5v8tzXPkR9TzjCxBTdnG2Zo57sl3qCQWA6AIi
         5Ja4UXnPoWqp5YEj51n3UaneqVwiavLJJiSqmYavlydzvDvPtXjZZI7EmUTON/cOvUtS
         DLRsw9/zJRlnom7kcHOFhlyLeJuBAGZjI9vstGkW95qC/78WXB6Kd4d2m5ASosAfSk2e
         Tftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466820; x=1770071620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        b=TxpMy/HtxMqQL/5v/iYFO0oHUO8r1McMPt4jZ/A9lf0zDhNupC0EfGF3RbXtN4X3da
         sOYJCgL78FxINLqHCObPvrsf+2eD9ydImel2l1QmcpwCZjrwYpRyvkD7s/3aPtQ4EQJY
         fXw0ZklSiy1sVrFVIacJFqcnc+YD3PNL849XgNJD/Tg1VZjCgyVVyyadQARpbfLE99Xg
         Q271abwtwwr5ARNwSbVV016lypWxF31vP+GzbNhHOULp1suVxUk1kyhacdDyLi0BOM0Y
         a6626VZH5g4Tfjps3Ah2l+4raJmO0hxLNzMRTHQpG8LPZAoJ0agT2SJ/xMuKCvQSgLU1
         J1jQ==
X-Gm-Message-State: AOJu0YzX1W4mLA1mqb0sWOVc1VeDmw9tc6LTrOaRhHiw2XHM4J2GonK3
	iC7VrplkuJiTIrsr6RJF2c3zQvBPcuiIjtUEvTrNvrv0W+x5u1UtTFnxLKgFZGH+F/xEMM0H/Jn
	iTYDZo+TU1To7iruMz/vpbTTXS16r4jt7B9N0GMUO
X-Gm-Gg: AZuq6aLMN67Xvh0m7E6/LYQ+9c11bNuhOnSBokzm+5JQ3nHekF3ofmyQukurvHlj6JT
	rJgOelr6xCoYDh2USk4wKhmIEXDhg6304Hx9E34rXmxPTZQ9/5fYpbmIronD6qXCpwdIMDHzFU8
	a5vYo+zJgeds6+QjGVoYQQXqkcUap5r4ZGZTiVyDztG9zip9WCml3S8qRE775bJC5/tmBFv4vUP
	M/cx/IuyShgMd4qoa1lV+FnEOorLfDSY9stusga8nmuB99eFTEcsoYL75jAQ9Z7n78hTAs=
X-Received: by 2002:a17:90b:1e06:b0:343:c3d1:8b9b with SMTP id
 98e67ed59e1d1-353c4178d54mr5402949a91.19.1769466820557; Mon, 26 Jan 2026
 14:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
In-Reply-To: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:33:29 -0500
X-Gm-Features: AZwV_QhFYoGZJWFWXPGpm6UGxOEvHZUszb6YUhYdp5bqZLkPloc1U3Ty7KU9dDQ
Message-ID: <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	SELinux <selinux@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:13=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN an=
d
> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op by
> returning an error value from xfrm_dev_{state,policy}_flush_secctx_check(=
)
> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_check()
> returned an error value upon NETDEV_UNREGISTER event, the system will hun=
g
> up with
>
>   unregister_netdevice: waiting for $dev to become free. Usage count =3D =
$count
>
> message because the reference to $dev acquired by
> xfrm_dev_{state,policy}_add() cannot be released.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
>  2 files changed, 68 deletions(-)

I didn't make it very far into reviewing this patch, because it looks
like xfrm_dev_state_flush() is called by the bonding driver's
notification handler, and I don't see that reflected in this patch?

--=20
paul-moore.com
