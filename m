Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68777148300
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049264; cv=none; b=tggHMoWJ2T/V0lSBt+Gt7xENWLnAJL0eW5S4zKWVg2f3T6u4HXgnU32haY0zcXu0R9idJpxp4+bV+LuQE+1UpfxseTfX9gMxM8B+lt320MrjPOvBK+t8Jh4w+pk2NrTL1tHsVV3bpd6TXnK4ziCZZiIrK4V81536E2psfuXU3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049264; c=relaxed/simple;
	bh=oq8mUdG/jkS0lSxlKIdzxgum2wxYbcShGcVGCSN2uWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmzikyaouJc1kE4wtR5Gipj6hCP7qZiQ1HloY50Chd+ywoWJyRS9SU1Q3GY6MFFERPLjm2r4WShD9YSjZR9PkxNZ4h9hgsPbSdyz6+03l27dvDEJd3hQAt5VjVz2mwsTxsaHIOJufndjDcLEvAov67ZA3AzTeBYYhexHc2njFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KT/goUs3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KT/goUs3"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6092387bdd0so10562757b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709049261; x=1709654061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYuQmAMRp17o2iSEsObXlVBh4IvpFKiYHuMKIilc630=;
        b=KT/goUs3G4tkhAzI0sG2QwyBx+hLl2Od3Se2eNjcKekdDmi2OTyO1/aAYWTAfbQsWV
         UWlvoasjW0ASPMCxC1kgUphitOyxXdtAF8MXhEi1DHwFLLG4VmdTINzANZyxGahPVQlp
         iW90VUNoV4PkoTrzDIoCwnsXfhrxYBkqRvvTo/c+Drte0qU5laL7I9hBFUpyvLTPMHg/
         IG+FqnmYBH4Q7kFvcI3wtVVs2wyYMR7MqL7K8PNS8YSeIOnaeZOlembGr4J62TfA+rKr
         BkaBeV1MlzTOSgefK3LMLsTuQui6jO+s/zKPtQ5VQ2Tzt/rFKEO0lGBsuyInv6HRqEf4
         yx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049261; x=1709654061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYuQmAMRp17o2iSEsObXlVBh4IvpFKiYHuMKIilc630=;
        b=AY2tlng4ZalvyCS6wZjHAfclF9pz0A3QZ7/fdeiVBUD+B/7iYFQPVMRX5toFmtuHIl
         BnQ1yoPU87OLwdlIZwaNKRJpRYewDTaEfYNKWFA+BFSfbCsH6OrdIKF+hPPhuXhpfxQr
         0JAK2hKgtP5T/djDpPhmljGAXr1rht7XYydMiKd89wuPu5YAdtOE1XF4EIZdcK4G+esD
         bzyaCTEYRKoh0Z1ErEgEkKmJucguCktdgNRFT8Wmb0LIIQHxBrlEh2C311Mge0ijsSKd
         vKHuaoFeed0FsLUvryLqod4nWriDbqC2xN3ik878c+EjP+RUsfRVPmOYGGCgKqiEpCG7
         DTIg==
X-Forwarded-Encrypted: i=1; AJvYcCUFVJqIA0c3/qtgKp4TBJOmQsm/AW0KmudEkGVd+hBzVmCIRF7NhLMt7N1mRSIHl+XvUNOcuf/MCj3VP1Hnx8luQV5MUJlllDpgCXP8w6hOTxkswg8J
X-Gm-Message-State: AOJu0Yyu18UAVxuKzSdbiElo7toyNNnRyuhkpeqR0DHUOPFEVvWxxXdP
	+BkyiB5JIm4kV+UyovFsEhmMS9dpFPUYTWJLH5yoQynJYtusMDqmThvbMPLY1Rq4MvYj/1XY8au
	DobTmI0Q6DoPN7zlrJDcN/nufoNvvV4Uog4S1
X-Google-Smtp-Source: AGHT+IF63JmM1ee0bnDzpGok1tjmtP5zb7sX/putD3q/YfGjFjhrbQZXgNVFBvpTSzx7Pyt+wxsNf5D6Y/3UmDUaE7A=
X-Received: by 2002:a25:aba8:0:b0:dc7:443d:d9da with SMTP id
 v37-20020a25aba8000000b00dc7443dd9damr238618ybi.4.1709049261467; Tue, 27 Feb
 2024 07:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227093604.3574241-1-shaozhengchao@huawei.com>
In-Reply-To: <20240227093604.3574241-1-shaozhengchao@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Feb 2024 10:54:10 -0500
Message-ID: <CAHC9VhQVdEsvSf0zqOTnduJChcQ+S26N=3vy0x_6n0QDDP04FA@mail.gmail.com>
Subject: Re: [PATCH net-next] netlabel: remove impossible return value in netlbl_bitmap_walk
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:28=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> Since commit 446fda4f2682 ("[NetLabel]: CIPSOv4 engine"), *bitmap_walk
> function only returns -1. Nearly 18 years have passed, -2 scenes never
> come up, so there's no need to consider it.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/ipv4/cipso_ipv4.c        | 5 +----
>  net/ipv6/calipso.c           | 5 +----
>  net/netlabel/netlabel_kapi.c | 2 +-
>  3 files changed, 3 insertions(+), 9 deletions(-)

Looks good to me, thanks for the patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
