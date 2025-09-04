Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63247BA4A
	for <linux-security-module@vger.kernel.org>; Thu,  4 Sep 2025 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022386; cv=none; b=pIjldmajDwDrhX6Mpb8E4/Apcuo/uBCHp/5mnDrbDIe5maerVPrs5yljhgkgRljzAvx/0ZVIPoPIKvWyKtYDomsVDiQ+WJeAeC/VbVYLDFi0weV3abpRf72PD7hV378NUwK3NbUTLrVAohkBMQX+X3kyvtuUWhJAzDdYxOfNrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022386; c=relaxed/simple;
	bh=UkcFu038SgzaQoqpHuqh7rm8Kk5hlryjIpk433T8ZFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkRyqnrtF1ir/tBmz14OSt32amYLP6FnOtx2kScI7n5GI8CfYW9N9mNCipHW/dO737fPFTMffHBSKrkDARKgjPxBrubwCZIHpDAmG4fKY4kLmPNpTEebR7vhKOOyjhiQ1GhtKOovYP+fAID5UGaeOa3lKm4UJuCHWYXhUD9nyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G9+uN+4d; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G9+uN+4d"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so1354933b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 04 Sep 2025 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757022384; x=1757627184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58UCbBJx7XFHUgMt81Q1QMPCRrjbTg/IHTwhF1TE8Rw=;
        b=G9+uN+4dAw/RvS1MOeW/F4F4tj36xIFiPcmhTaBt3PyoUFo9/zX+nsuhxIX5+Qj/Wo
         QFuvjuOVX4BkRawQd+e5UpAHXLiVmf8CJcjk2oSYkXKux7CokX5z4Eph1LECDNaBSu0X
         UsS1fLwMnLhkYnSeCnS71Mqzh7lNhifSgi8aFneC9FiRc7v3goHjURgEGc0/0hkS/cZp
         7d+RQU5i4oyp/E6heYca3W9BEdwlV1dTkSV3RwLXTCvrLJlDT9mTCG/BUHKxbvsXUjl+
         bPa2fUIg+0+cyFEfXel65r0IGW4ToSqx1GSOUqaOJjGO5we71RskF6/p+rPatQ4ejuBQ
         cjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757022384; x=1757627184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58UCbBJx7XFHUgMt81Q1QMPCRrjbTg/IHTwhF1TE8Rw=;
        b=mH/HxORsirv8Z1kMKkGUIV+/dpgywdZXFA0ERNNucMU/Gm85YCo/RoX5luajK46XQM
         C0hmfCV6ujazuRkUGEOXE9Dov6yUJrQk/dfDFBBDPNQxggO4XW+hboRfFNvVHAodO5cw
         +/kQ/kETjrVwkLVYcGHm6awbJ68IK3WkTvrei9FlQto8KgAAe3WPJG93fwsEuOjDmsWb
         vzatE17363/TJjb8Q63CBklM9XCVDzhKKzObM9SRiOXSDSJABj71C8BkoqsHZEN0h9CH
         zGamTB9f4Jy4imVU4Lh54kVQdsJvjeiQLLvzu9xe4WSC82zDBuNOXcgx69An2BSH3vQM
         6sLw==
X-Forwarded-Encrypted: i=1; AJvYcCXsQm0skCv8xxa4UWG6/yaCK5wlzAMX6dGD8vz5wkfNbPEajG6GhscxGpq9AkL/nOl5EHMZhKqg34OUQ1OARDXw/zNCETg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17nooFwbl47NMx/vvxkA1Pe3DAWkArbgppymBcLjeC8cU0T1L
	9InuhNWiubIGhbcINBDsYDwzC51zlPD3+ea0BvPfw/vKvzIzMGQktkdz+MaR67MkWFv7wIoQFR6
	arox12GaVb/8iIM6WCpnjzMc8Rmc5+Gqtt6jlIgfU
X-Gm-Gg: ASbGncvaFt4XrSVmIXuz+gR3jKMR7N7o2n7XnwgAyV88krxjKYitLILhVWyVVjBD66c
	GG0Cd/wJ7w5JD9X5+sXNe9aTOKjODdKVAhstOY4FALvX0BBOYv+vr3pR5E9v6QT3n7a1Y1+lLoi
	ZtsFtYnUcyc8MzSsy7byNa7ms+0OQi2LJ6QoUSut9utlUVG5k6bSG/5gK04VT3m2qitRhPqvJCT
	PEOMSE=
X-Google-Smtp-Source: AGHT+IHSmBNyZQvwAPcR/toxhKoWlcaMb7YElYq5CeuEyUQYfTCgL75F0sbfJLNBWxvT0UehgGKBnvJC1dOhHKYC0XY=
X-Received: by 2002:a17:902:d552:b0:248:fbc1:daf6 with SMTP id
 d9443c01a7336-24944ad55a3mr260481835ad.43.1757022383625; Thu, 04 Sep 2025
 14:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901083027.183468-1-idosch@nvidia.com> <20250901083027.183468-2-idosch@nvidia.com>
In-Reply-To: <20250901083027.183468-2-idosch@nvidia.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 17:46:12 -0400
X-Gm-Features: Ac12FXyloQ_dak-O_Wva3QydnpbJf4zA16Hm_GfCIDXj33RkHuULUszNqR9cDOg
Message-ID: <CAHC9VhQb8D=2=FX_JaQghA1e==s5XfMyKvdg6=1eVxjimhmqdg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] ipv4: cipso: Simplify IP options handling in cipso_v4_error()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, dsahern@kernel.org, 
	petrm@nvidia.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:32=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
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
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/cipso_ipv4.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
