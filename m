Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19414B950
	for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779421829; cv=pass; b=slBhfABbQEqvRdIihBcDegU+34Q15QWka/kfrXnyL2hZoXeitLRBzg1V5uwarDz/CHx0erqNJ6WHmr5PeBnUB9nana6UJ8/vpuH9+zvXBlfZj3Ol+Upg/AJt4USQAZpM8G+pI57ByXCflEJ1rkPK8/PGh6BIQzux1QRKR7pi9fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779421829; c=relaxed/simple;
	bh=Cj/i9ELpLcaBpb/0YFBTwcsXmhZ4kU5PDvYEIlXh9kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKlHXcJNQ6vWF/MrBRsnop2GBm3KAKWMTdYeHfqi5EIfSstV1iS8MYNhiplkcFwNs8TZpRxhRR87Nik0tsJcNVOWGNZdXR+wLpkjVtgyQXXBL4cdmtivGIWoA5tEhsCoIyKpi/LoAKTQvpznStJ7Jpgl77E+nnC/aPogwUujsBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BvYuDdYf; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BvYuDdYf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bd80b3aa13so44526755ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 20:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779421826; cv=none;
        d=google.com; s=arc-20240605;
        b=UbBcT9Ol6TlY1kaZ2FYjVkYpL3S8BuhZmiICv8NvxdmtTEKWxU3HG8ArMAO1i0DcMJ
         ePIFeUwDAaDiNi++EzXFrEaq7TNtokacYyvA2Nl4jv2UqeLFxDdp43NsmFhiEP4eFwnI
         s0C16Y84RsCix3B/R2G/gC36WagM6LgePiMxW4eiI7ZAGZ/tCYeiHq3yDomwd5h/mMUT
         c8lC0G7ADVOwYDCd2YtJoyePFlHb0gdfMpUd1q2cSZ3li2ciNbsg8NRrsRF2Ncg9VSyW
         UqJvk8+eP1nrR5FfrMQZjJ1wIV8rWNq3pSDZRdRS8Ursst/MR0Rbj2Z6b6TMvDalJSiu
         8IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mJtD4yG4pQtpmZFI4sg7XbvqjUAopoqZlfXkYohTNJg=;
        fh=Km3NeNvkjUMnlluk9iO/dnVhVjileIwKo0yrw1Q2tDk=;
        b=SncKVI6eINQzCCIBFrFnSvXlr3yXtstfoVTHCClE7XEegvlRlSqGLuZODWY5nlpYAj
         4KzKowYFltqhhyuBvaKzHAC28QKH9hCwDsg47gnajuwKo0dRY8O17K3AazkWx958mQYE
         y4c+I3bxu0CqHN7cCc0V0jRayZX9GgdTQEayOL7kPCQ6BW+FNGp87gFEjYbLLGUOY0Xw
         QyxbqKNR3V92YUvsvbsn4WEQa18WSIm9rW6LDSzUAJO3hbNYoHXX82xBzVaMslWuc6uI
         qvhxjvxWA8er2MXITczSx5eHJ4aHKJViNHO/qqwGAlahlbXOO2Jc63N3/ihBAW8K4QwC
         bGEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779421826; x=1780026626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJtD4yG4pQtpmZFI4sg7XbvqjUAopoqZlfXkYohTNJg=;
        b=BvYuDdYfGImF7ZvIUY2X/gKGOtrGSw8ruAlrCBdSyQG23Pha8SwK0hATY4inEcpTxC
         WfDUDczbjFyAdrcNovUqWHTyLENcklZHbv2hGwOuHnR/675kGIeNnjsnzNPeyQ97zpTD
         bGYm7ti8oAEcfdOkPG0T63MckBCVTJr7dIELEJI+/VAVXtS2oA7OgGgl+OwERwzZAiIW
         WiCyOFBBXJLcX8bYX8oylykAilS5CrehPtCLR3v/X1BWrDC+EhKC9HTcPl43uHHKKttv
         yBUIxEwgNQHEbG5pAyKqQsQi8WBYhxmW1f6pc/fkt3JWQx1Q4LqZekvKgiBfqhEMd6XG
         YZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779421826; x=1780026626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJtD4yG4pQtpmZFI4sg7XbvqjUAopoqZlfXkYohTNJg=;
        b=oKG9O0OmxoL2Aig6UdPlT+TqesQmjRRaF7aMNn2kJWzgOqjDXTII9lRdsaobF9FoOY
         nf6PZxsDAYXBOaztpSER8rVD+6X6mqfJYNwLBf4+C1mZ7umJosiATZhlycHBOmpuWsi1
         tsudniexYUx1fb5hAxADPmWf7Y8vLAhHqeNdBULC7C73BF/vRAbzeoiCamgA0PMHpQLt
         VLHiRGuoKzT2uVI3ic/K0k2CCSb+OQqrsU16W3GLPsMR7wSxw2eFRrsmInVKurVIZle2
         ejtpgDmS41Xxczxl7ZDC/AUenSsYbvMZYZMWJlgRLe/vZPbwitDpngTftk96ogIIdWaN
         92AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sda5e0kHWP3tPi1TEw+l9uwOG6dWYnXMukHnMdok9DELvT2LthURtVRHeIMBFY5T2Ym/6/0nbLGpQ9bTu7SB/ZScQPUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPaWvYb/tHANvPeNKtjXY0Nv3i5lZ1dqzpQrD276gVLuAomya
	aF3ET5YPsHypzql8IvVDgHWv1UXmJl8zEoTutb59mVnr8GHy3YFluw8yNoc3g4WV/9GHmoBOzL/
	29g3af4T4wpD1WwwyqT3JAc9CsVaNEcxvYkGB7mfTEmTi4YBukxk8lGNZ
X-Gm-Gg: Acq92OF5vA8iAbb4Gif9PTiVOiVwpoMtWHVSVevyAe7PJExOkTXXjGpWU1GUxWFfwOK
	KtmGijsb4yfdkaercQLSH4/VIDVdYRpl/kxzOGYNqiHHbBxbVav/6J0QKbrblSph2Gh0hT4H4O5
	6xTOmnlYy3KqVmlS4E4CVc1FB603ppMJiRuHz9CSrKoXs3h7kO6Id0a0nzIT+ugcWmyGgxT0cL9
	P0JeUKg3CWN6dJya8djXyiB96mi/++9Vql6DXBnuqG2Jk9nIXpVpRFS+5lmSRFgbri528DoLzJ2
	aNby
X-Received: by 2002:a17:903:1247:b0:2bc:8f9a:3642 with SMTP id
 d9443c01a7336-2beb0758d9emr18659005ad.16.1779421825760; Thu, 21 May 2026
 20:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522022910.398416-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260522022910.398416-1-zhaochenguang@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 May 2026 23:50:12 -0400
X-Gm-Features: AVHnY4KHmISMm1IYd6RPTq4MlDMEp6cvrOPadkJFFg-dlbft7CyMJhlb9mqPZRA
Message-ID: <CAHC9VhSzAmZKqcOca+6UoTAJ+XrbFC8S18f+iPjL=2bHjz_YTw@mail.gmail.com>
Subject: Re: [net-next] netlabel: fix IPv6 unlabeled address add error handling
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:30=E2=80=AFPM Chenguang Zhao
<zhaochenguang@kylinos.cn> wrote:
>
> netlbl_unlhsh_add_addr6() always returned zero after
> netlbl_af6list_add(), masking failures such as duplicate
> IPv6 static label entries.
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/netlabel/netlabel_unlabeled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice catch, thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
