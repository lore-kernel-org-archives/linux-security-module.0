Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793282135;
	b=Yi8E3z/pmsIffQ5zFMazW2n7tf2vUvNAOvJOt++c87i88LJ3eQqM3y2uw2whks2at2uC
	 iXgARmUNPivm4J+YVxVzRpS8g3rr8hzFKTnOl5Xigc5uzUAhnUffq0JqYRLtSKKYPdNBL
	 RIzFEhAYNafm4v0ih5WQhuF3Nd7GInbnQ9Rnq73q4BPLNl7vjYf8BoFSTYSAPb7aV43a7
	 jxC8UAL1sMdreXHJRVKUc8VhqIppxQeVwov+/KaOvrNkCWkF79IlqTps1qriEdy2Pirik
	 gtjAgAPJ535+fWqPXtjaHlTXT7LZE5a7Ke64ZM0VbTct99gP8AvN/8QsSJB3XJjyMlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
	b=G5DtF1NG35nEPrtu/vlPTgmN2+YLlp3RwnlbkorQi1VhBEs/RdRJG/xZQDAmtw/cl91R
	 7ebgGJHrieGhiC5tediBCNu6asHDXbgpt9akhXwkaPW8ssab2Z9trQNSz7DsBj2L/0T8i
	 mOFecXgubCeLX0uzskF0Qu10d3Mo2lJxV7pUWb3jKozz91qxHoyiEAiNOMs0fo9MwP2Go
	 5Fzcz2qMG/swBpV5R9EC/sqYiU7Fm43JFKuyRANssjw4mmL0pG/F4N9yh4DSlW1o98F1X
	 n/pNTTOQIig0OBzxbMJufnIZNnvidcgxcttydkFcd5enHbdnhK85K2zr+dCo/zA35Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGgxo2bz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BF606A334
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 13:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E80BF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGgxo2bz
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1222182a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 06:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282128; cv=none;
        d=google.com; s=arc-20260327;
        b=rH2a0NxC3MGF4+w4aVA7iA0tV806eZMVeFR7+PuOBAWbKlIoa4qRE8Bbg6LuNroano
         ZGoAetxyYOJg4d9J9tWuYudM7n7gk/8G9Fz80GgsOQVGiw8A16syCwh+bLcYFd/WtSQd
         l7V+JFG7wM+thVEHvw/E1sZh+k3cIWJ22oYHI+JrJDfUJOB3qVqxMybvsrbVNKOxFPot
         Fl5+9oFlVFf9/lM66e/PMwd0H+ac6SjTOXaYIBsx8wir13670qnHDSo3bU3qPlZaOylc
         gEsU/iRZKOyyvlaXSB0ZkL9/LwENQruItSEZG/cCQ5LRCa1ZwzKTeQUZa8XGT1Brornd
         G+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
        fh=AGPj5dT08UwM3LtdsHwqt51RPf7I2JNEOX9znhCRFos=;
        b=dQ/NazWMtHz7cUCla81JdUTwyS4GBws6+BA6X32nQxRL1G/8v6Tyrrg7WvhMJ5HKJe
         wzX7kpgQIdh+g6bX2MKJpik1Lw+SsIDiDphpaoVZFKb5Hc7NOwFzo2bgiYkE4nNm6/m1
         MLGp5iGJ0clzUL7ypk2mcCDFRvdAMWPOPSmvHDb0cigCNKrx7S5yW7CsSHZT9HaIoXNp
         9NgnVy8/8jA1OM9k8GA29VNnuFPVTEOOX6tZu6LUL+7pnzmH05HFTRpYQChnkbhkr+Iu
         W7WiJkBfPD7VaecNe/nxa3hD0nIm/OQs8tE0/7w4J57M6o/4DtCDUtlPOrlupB529nC2
         lpYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793282128; x=1793886928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
        b=XGgxo2bzPESNJHJj81my6LbAb+llfrYuPn4f1O/RqicgPYqYE4W1n5faJUWGcWshDl
         fmEoBCnVHMUIfG4P9nVCKK/WGE81mxzrnh1RiycRm0MKvSdx5q+5ox6pSQWgHCfadGZ5
         I39Ww7Bi8vBcr7MC/jWzWTTyHGKU7x5dy4FFsZp0mRG847VuLXu8LpDLcqowv8NyJ/Kw
         257yYxHetFdAX+rh00go80ltLQv0jFB6icf8ODp5eHgqWYdU1cxXX0UPBrh3UmjetmjX
         1hFf8NDiVDIl+AEPnlKitF5h+BHd5r8Bv3yNJ/VU2iX0HpptoJ0CYYtYT6OyqTjyYcPJ
         nCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282128; x=1793886928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
        b=1an2GRdXJSrT5BQMPFi5GkxfgQv3gj5Ggf6v3guYWImhaHttuU1k0ZodFa+zL2glE6
         8S0dUUv0S1ur8OLwgLja7E5jDXQnqXz6dOwuah1bysDxCo16rH5Xr69rpunLh2fnfb6o
         mpuYO5S3/z/D27TSV0jF3i6rl7k2Vl1viXERDTkAI8K06Sbpmm6+tS5CvvuDwtZo+Tju
         VBzf7EcMFHTBmDwQUXmLIz9PA4/lqqScoTOUTkhXMdSG5Y5q6+t/IdT8W8AScnQmeP+i
         tv4JTQ+n2tRvERyD0oQ7NN3wv6Orifox/AxmN1GRR9ZIifIy3zt9AyOI9sfdchFwzVx6
         qaKg==
X-Forwarded-Encrypted: i=1; AKwUvBwfJUOvrwcEW2ODMhSHTfBS0vZKoEaT0hck8ez+c+7J5JEVpRUQLO5XhQOepF27RjdPvyyh4AtRdd95HMERjGGG5rWKIg4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLD8NVKG3gNGQl1IKGo+dtNb7UTS6TObaink0ZJfRMYKYT0Q2x7
	4QNwLi7Dfbz1X8NBLkIbD7HewHnhDP8Kruxqd1PlKRxUD00usIuosaZ6izxk4hHiHy2YECQ/rD9
	Ux6w7E1cK4/UmPZwSL17SFESKqMD4Q9zImj+GVm54
X-Gm-Gg: AYBFou0tlFbIgk8K7X3ofrjUkQYuTEcql6cHH9TmRLc3ENrT2PcccDBNAAruFWmhwPK
	szJ88PIgUwE8+fbWAyHnY1TOZKy3fEfjgwrTN6EXFd3qQyh0OUjx0i+Zw0HQk6nxeFlr8F6rwWT
	HqMveW5MyiwnsLScibrpe5c3lcJyicUtcm6LwJmX5BHdMkDNGstsK31/C6IebIvybuVkDAvFEgw
	k6Sx1Fn6LzB12EpYq8w6X7GmDO0exZ1xH7NQPkz/dX7ynNdZ0jltPlnkw9LQCiNNBjq2KdH53ya
	GYMtbEg5tHd7MOVXXrQ9VHTA/5wvY2LWvs8oRQQXYbY+fDvvajl2rvLptwdL82rukLcC9UHDpG3
	8c3eFgIH+nVcjhUlOI6FHPmmzgmSU8IbxwcPW8wNVMkegEj4CCRcRXqC+KaZNV963QHsn
X-Received: by 2002:a05:6402:42ca:b0:6b4:1916:9674 with SMTP id
 4fb4d7f45d1cf-6b4b0b1cf55mr2093149a12.5.1793282127811; Thu, 29 Oct 2026
 06:55:27 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Oct 2026 09:55:11 -0400
X-Gm-Features: AclHuK-Y0w0OjCWYkE0zaN1q75YJI0QAcartxP4tkuLM1kIc_ZsbNlbuifypUG8
Message-ID: <CAHC9VhRQ8E7zysipt3Kt44oC9m-eUc78mR5ipR3YQOwuBXAV5g@mail.gmail.com>
Subject: Re: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?UTF-8?B?THVjYXMgRHVwcsOpLS1SYWJpbm92aWNp?= <omniameasunt@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:39=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com>=
 wrote:
>
> cipso_v4_delopt() recomputes the option length by walking the option
> buffer after the CIPSO option has been moved out.  The walk then reads
> the stale bytes at the tail of the buffer as option data, and a crafted
> setsockopt(IP_OPTIONS) buffer can make it treat one of them as an option
> length, increasing opt->opt.optlen beyond the valid option data.
>
> The corrupted length stays on the socket and is later used as the copy
> length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths,
> where it exceeds the size of the buffers they copy into.
>
> Compute the new length from the intact options before the move and
> subtract the CIPSO length, and fill the padding with IPOPT_END.
>
> Assisted-by: LLM
> Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connection e=
ndpoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> v4:
>  - rebased onto net (fcc00b15cb21a)
>  - reworded the impact paragraph only, no functional change
>  - first public posting (v1-v3 were reviewed privately)
>
>  net/ipv4/cipso_ipv4.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
