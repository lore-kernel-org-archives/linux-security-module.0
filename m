Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E6306764
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367158; cv=pass; b=pS0PTD/Ei/UNYQZcdUDcGKPxC8bbG2NZQvIO7QwsT9K6v4eOvf4aJM9QVCRwbSkaxm+ZoOkk5/r6SeZCtb0xw1s3QuOMcXq/euT951ykDkd6C6UO2ECQLq1QE2EaFlD2hCtYaYhQq76SVLSqnhoQiO4CHrgiK5XlNOHQOqcqn6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367158; c=relaxed/simple;
	bh=SHfdS2VEWAub4TyYyXoE7ajtUpi3U0jl7n1AyOddBXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIOSvqRwNdV33CWG6mkyJBPG7TcWEcWO95PX1dVzjk3hk99c6UWKQKgycuZPggddD4kSKUnEDUbeGwKhH4+KUiIFAB3axm6O1WVcNiwlIE2t9+ennyKd5Wyl6GMFdJyfSwspCwexnzGKEyPnE3m/Bf79tfd7I+hkN1yLU3XweRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hy41QQgt; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hy41QQgt"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so3079067a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 19:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780367157; cv=none;
        d=google.com; s=arc-20240605;
        b=EI6Tap8voBzHmiJW9G5/wC40KeK5ZNIY+Z6zm/OKl6MYHL/K3Ln+uDRDI8raydub++
         3iBYzSP7fQ08wWZs4cPzIfqSFuLpfeaM+fw4JBqfuU4M9+tRedR2hm0QimfaQ7HMNnBk
         feaNHL9ukzqhSlnAv1oyKQY0z5/R0jjskP2TfkYgakm7M0rB9DfYIi5DosNl881z0XxS
         9/mR7UJgBFKM7YKRWXzve0ipDqITU0DeMMRlj7+BEkp5LgT7g/NXwv8nhoErFPQDEE+J
         R+5EGbg0PRo026+zUuqmxvbObWYvEqVZ1VVmaYECk627Q1A3F2QVyvD/2Y0AcM8cc9Pb
         0uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0Z1nJtgWy+a38xLnHO1hVIRfg2cTqLRzxBCr4E8BSQ=;
        fh=72uGn3ZXOlirR+WZj9+/JYLzOJh6X08XkjEIfxr3vbs=;
        b=ejhYMPQMySf+65hRJsyqXadwwCRe18z0wNW87oeSz7kJJ31GlNxmIlqXv4WQPq7vik
         1cpKEpHdEdpKry92x9souxhO3Q7+Z5jI18UcX0AqaOmlZzLv8xpaohRYZQ1Gh6efB2tg
         lcJ6+q218WOmMZsrTZ/ZkxG82jipB3ppVHCjDGcFYA4e6fYh98dJYAvq340BsSFFn0MD
         b3zlH64xXLqEJ1Ke03j9xc4anGM6iTK1/yGfOE64wR0p2gH1qkAJVlUvNwjrhPdBdf9h
         temGuMJsvo1yt4+r/r22xjFrl/0CfcDr9LivTm73IXrmFIuf7A6ZF5e2+zZaT5SVC8BG
         iBTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780367157; x=1780971957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Z1nJtgWy+a38xLnHO1hVIRfg2cTqLRzxBCr4E8BSQ=;
        b=Hy41QQgtm4LHC0BkWBuC7zmrfKiGZVGcNEZcTj1ohBYWlMZ8rIj95OlPqefxtiB121
         v/UXCmDPUicVucAGuAU/8Acy09ylN2cgMBQQsL6sJL5LVjMmYINJOuzVgO7Xu+99dXK1
         JyWqanz7UKuM7QeMrIAdRQqFzTxhIelWOr2OskNSVN7Ka+FwG+n+HwRbrOQT1MAly+RE
         MeAOCWDPZ/IFFvOlF6dzVbJGbtqw0KReP5KeXGxU6SDdF0SE2M9p561vtP8upPY1XUhH
         aNo22xa1SVLB9Q2Of7FGEaKl7hSaYV5D1OUhM6sm/8P07lY8LZ2lIbtnEK0jxtLejOhv
         YPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367157; x=1780971957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0Z1nJtgWy+a38xLnHO1hVIRfg2cTqLRzxBCr4E8BSQ=;
        b=qXKKrJfW0YfYjWGfpgF0Nwb4wZWWX1KoilvZKvZWsR+5W86Pv043rZokvJgD1wnlqc
         25+ECF4ROEhd3tQ72JW7a2vOIN2Pzmgh7tRPVAhwSEfRSsscMziFGnPaNVqxGluIwABD
         fGLLrQJ2HW/iH32LuNtQKMHc+GOsWtvNxxCKDpJyVGaS8g2SEsN6XM6cMKu7/CPTGsTP
         R6tPm/wlObQhKzZLYZIKIfRSVtdvxrbdcTHYSNQ6sr4d0/c2AEZV0Jdfnk1nyhZ67g+Z
         4xml18fMNfYMjHSCpVhVNRgUFppGXhy9sKD0KSNwMvb7tgqrDBwOJkcKh3s1oIWzCfbw
         6GLw==
X-Forwarded-Encrypted: i=1; AFNElJ8j4Zc05YEp4EmXG3DrCIsy/fzmzcLWG2JLB6/tUsOsoyd7TIlSBjUz0sz6l6jgEeRrxZ+V6MdurKrAZx6+tUj7lJsL0+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FI2tYb3nhSgtfOziSZjqfRjq7kLMfVzRe0mFFg9Yv/SbCX93
	hGhYqH51klCON2iU53t/435SQUzLi37LPwNd6xCa2niL2mHr0QDGVPywc/djzCFmTbJYUvpw5aA
	cdwZAkRLD1S7Vm9R9TVDhYw5HzPOZCveMXP0fxCl1FnGuEYV6BWWx/A==
X-Gm-Gg: Acq92OHSdPBNgAdEj5s40lr3SqYWaI2l8Ao1DlmM3uJjskzw+NgRBlBwsa0qcP4e7G0
	eR7dsWBl3Tb8RZvvXAMBT2eetIS9MUFla4ZM4bVttyg35mQtg7UldfXi2iPIRDe1xEaCgWWPwUw
	pUlwNsSxa2dpXiRDx1mgiHJ13lLzsafX6EsxhlmyU9dD21e1ukm1IYoB7Z6rPwWBUGJzk2/4jzn
	w7HvYpnWq2ia6CvqhrnREJQoF5cC0Ovfznx+Si5GvkwPx9UvOPC1YAxu0seUqxVzT30v+HuO9pr
	NeX/V96tmC53nOmUvQ==
X-Received: by 2002:a17:90b:190c:b0:36d:689a:cb27 with SMTP id
 98e67ed59e1d1-36d689ad524mr7937838a91.24.1780367157009; Mon, 01 Jun 2026
 19:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528015913.190970-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260528015913.190970-1-zhaochenguang@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 22:25:44 -0400
X-Gm-Features: AVHnY4LEslACqmhRDmjIDxORWlDmheu5ptft12NvTVjJPoPavYK0NILJ_kRg5ow
Message-ID: <CAHC9VhThD1mhAZDwkirTOnYxycSAghW4RxyF9DZxOH-=TUgS3w@mail.gmail.com>
Subject: Re: [PATCH net v2] netlabel: validate unlabeled mask attribute length
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 9:59=E2=80=AFPM Chenguang Zhao <zhaochenguang@kylin=
os.cn> wrote:
>
> netlbl_unlabel_addrinfo_get() checked the address length
> but allowed shorter mask attributes to pass through to
> fixed-size address reads.
>
> netlbl_unlabel_addrinfo_get() only rejected a mask
> length mismatch when the address attribute length
> was also invalid.  A crafted Generic Netlink request
> could therefore provide a valid IPv4/IPv6 address
> attribute with a shorter mask attribute.
>
> NLA_BINARY policy lengths are maximum lengths,
> not exact lengths, so the short mask can pass
> policy validation.  The mask is later read as
> a full struct in_addr or struct in6_addr.
> Require both address and mask attributes to
> have the exact expected size.
>
> Fixes: 8cc44579d1bd ("NetLabel: Introduce static network labels for unlab=
eled connections")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v2:
>  - Adjust commit message
>  - Add Fixes and 'net' subject prefix.
> v1:
>  https://lore.kernel.org/all/20260522054521.1169755-1-zhaochenguang@kylin=
os.cn/
> ---
>  net/netlabel/netlabel_unlabeled.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Looks good to me, thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
