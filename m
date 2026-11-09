Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794260504;
	b=xD78QQDkYeQWrrzc+puTXxKlKV5ydkOJTANGX4BgIDrFgRUychNGXn6RANGtDgDZzU30
	 PBPd7UPI2xVnYE+ZqEZ0y0jaS8ZCJsxP+AeFtYbDaR7OD6SFguGi1o/LoG0I9AMnkT9uL
	 tWGMyen0iWoRB5205dvUKw0+T09qUGQZxi0Hsmf0dejQlUFYo0CLXmT7kvUUOtN6DBOHc
	 CK5ZB+63TdDYyb//yoULvMG7zyRoOL7JRnKQrdO3NHAaAwZamBaEShQ+TnEc/36Y3u+LR
	 mm/kEuql0jm0jGtrGi2yBF9cWuRtY1j4ri59uqHLxu1bbp8eaNjv7LCq+mE0V0qtYtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
	b=etonmP3vICMp15UcdUUr4TCdDFAryQHu6UHXfeRzUbSNJ27QySXbJggCF/LASh1iqO6a
	 50ofPINwPH54GBDDRCN060I/V9VUBekFTB5pmJ8OzPcRNRtc8mR4dLmqTIzDnEF5mtQ26
	 fsoOG9EO45uEfjGtfgPCv4kO3hdcWQj0nffSjJ44JovpOnn3ySJPZG7GljX1Y2wcF7Y1G
	 hu5NBhoD/Lqr5i18S6ZiTLXAz78sB+y6J339Ii1WB9hJnJmXVdpj/FhKRCHvPFtnxvBB4
	 CX4LdkPKqWGLyfa/8MnTuBOGqjIB2METxiigMX/9XhUHTGPk/TQ3/2109E/Y2PIXkvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="H8f/kE/q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38540606A321
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 21:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38540606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=H8f/kE/q
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso716183a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Nov 2026 13:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794260502; cv=none;
        d=google.com; s=arc-20260327;
        b=h+vzbr2FVdZga6rplif82oiR+FsCigq6KxL3MU73YEmSe/Xpeg5aOT6GqajIWZ6t4O
         h/4834jNxQlRy11ZZaSvHOog8fJvhYfyHFtlw4DFYeiPpNrPjuq+8hIF5SzoJ2sP/IUH
         kW2saBx9ZKOTltLBQ72GZXt7iWXgF9oVUvGSznnTKG8lmS3Rhtsf7/jwFojA7hlFNarr
         JAElZFbd+o64GjjDk49bSbk3a9ocbBPF9D15SQ24LrQh2hsiykVwDVAAqAj5k0iJt/tt
         MSKbq6377gEnSs7E7x378lvG3W4Je5wvUSDH8TKmaYFP99WtWnoNFXMHbcjvKx7+E532
         tSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
        fh=QtAAygn2Z2lg1CYR6vFHCNPYx+tNTOSHxPsLD7kRBPI=;
        b=q0GzT/NhB+YjzDpato41ALxEJXgbcCzwX30j2wYnJQBAoZWZRcbItsGI2+B44TShbM
         F1V62kf9XOD5zwYGLKb6VSoqshIchsw4t485exVOzOIbcxUb/WMcA9GlkVgbRyxndWbI
         2ORv/C3gegv235WnGLnWoBv4lX4Hpeb6BgR4YtrQJqvDdjD/ws7ut5ML9I9nPwXtsnww
         fcWbh6nWGinb3ZAmxn7YmFl3QimV4kI1Ss3cNFvWCdiw7h2hq7TRfhyXk1yR7fD0I063
         qFBdgIOqU65XXjYX9AcZvfgreQnasN1d4oBjkyRmfthRu46XItf9ArzQjq6FUli/gN2I
         D+LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794260502; x=1794865302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
        b=H8f/kE/qE8C/KJyMn+Q7ubxqQ8IyciFvzLujWV6YO7lCdYAgm2P7ZirUUZc/2EtNyg
         Ia9gX7TaYQ1KXM5BWsScq764dSpDTkjzgs2AHT3LJNnqwJhr7zizQ0++I6qfQIYUeBdk
         8OhWeqd7GlpNforRxvSMXJbsFdkD7RLL2NndI+WOoHOtD+9Yo8G8Cy8pBGsFB43Y4C3o
         GyQPb0GY34YOWttb7qIHUfJIUS3Fms6+sDFulqr3ARoeU1zJ+v4TfBgQFc9VnoNmrc8L
         EYQa9ywpyTaWda+3mMtC6t+wirBacSk0hM2jeemvyA46/hDPZfuVjmIeQ91AW/0+KsyZ
         30ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260502; x=1794865302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
        b=XNkJOhhfQbuuYd2DBkd6fnYhtKSnk8X2pl1M8CNvU9/IiVJsDuXcym9sd0e+l+7z2v
         j9dHjP8ZdWF4oszsB0b0Wc/WQ6fVpqYgFTpDw3s/G6CZZ/q/7VV/gIlPQEafsEL7y9Ob
         PT6E2dOs1JWwKPfoj3evSFMmPl80phBb1Wi4aoSZYy1QfdpH7V8zngMMHiHcGFuAdf9Q
         22yxjO5LttHoO9A9eua0lv9ySNeWr1Y7OialuMmcFscmIrD8oqiC1NHapEi/5kseLcJW
         k2hw3u1mTO1JGsKnKLQ5jz267LdX2tbgahvgCBIkVzvsZMUju8rLWISapNdcf7zljXXQ
         ecNA==
X-Forwarded-Encrypted: i=1; AL+hErGG3Uc6Sf8M2Dvq94r3fmag/UQm3+TItK4vF5yOaF71R8I4sTyrKF8/X/4c4KnFcGWrCRTAAT+6khQtKY0dHoJxdJoSzhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z83Tqhwy5AjApYnFrayqfqzHLfF7mmlzqWNsn332GhPlO7F3dzz
	DDDPbHNN+a9Ps5GQWB9A3qC3TugiZvM97GkZt7iss5XLVACNZY7ORJx7CxWKDufvs2eSkyvaAyX
	OVBqJSxFxsGr6Rsf6auhoLWLL3t3xiDHYHLnwHItQ
X-Gm-Gg: AYBFou1GAylbR5nMEL9MqimR3UJ0MIEJIgVGzU6QZQDJmAySvo8uI1/IWjt4n45SHtU
	Aju6pK7kB2wDsSDBDjuNt9HB6uBKETjCIKLTJUvq23hhsNaXoYIT51e9pRu+xVnxYPN0MKM3Ufo
	RF+zddd5AkqPEIrlsi1NrHV0NDnTb23aZmNcqKFSunvDQhEYoXCvN/cpT75+iju/pDkEUFg7VKT
	JV2J1lQYNVfc58rN2qllfFTAeZEW6xYq1j4E0D/ctys7nk2uqrfQkKtxziyIW90SRzbD5a3luge
	l//TUO9gUu4srhpZsCGAOr0VxVvAh5M7eJIQ2gtW2mTOmGUdwjJmjomKE4A7oP6SYOwQriwfVw5
	+xeB2FwREOqDWqqcBOTh3CPTLXXtr/92veqbfWq0kvyckDG/7SwJ1jqb3mexlK52h33Hp
X-Received: by 2002:a17:90b:1a87:b0:3aa:f2c4:12e9 with SMTP id
 98e67ed59e1d1-3b166ac9bd4mr960282a91.3.1794260502561; Mon, 09 Nov 2026
 13:41:42 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106234313.2537882-1-edumazet@kernel.org> <20261106234313.2537882-3-edumazet@kernel.org>
In-Reply-To: <20261106234313.2537882-3-edumazet@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 16:41:29 -0500
X-Gm-Features: AclHuK9JqJdznovs8kNDyDZv0L0agpYL-mePGxz4TwZJOA8lOTTp3veMhIhfUYs
Message-ID: <CAHC9VhT1oFLhRd42SVuyS1NX=t9Tn6GWLddEX1iF6sycfkdtRg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] cipso: unshare headers before recompiling IP
 options in cipso_v4_error()
To: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, linux-security-module@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:43=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> cipso_v4_error() recompiles the IP options of the offending packet with
> __ip_options_compile() before echoing them in an ICMP error.
> __ip_options_compile() updates Record Route and Timestamp options in
> place.
>
> cipso_v4_error() is called from the LSM socket receive hooks through
> netlbl_skbuff_err(). ip_rcv_options() unshared the IPv4 header earlier,
> but at socket delivery time the skb can again be a clone sharing its
> data with other skbs, such as the per-socket clones made for raw sockets
> or multicast/broadcast delivery. Writing to the options then modifies
> packet data seen by the other users of the buffer, and a concurrent
> recompilation would hit the same check-then-write race as the one fixed
> in ipv4_send_dest_unreach().
>
> Make the header private before recompiling options, as ip_rcv_options()
> already does. If the copy fails, do not send the ICMP error.
>
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> The issue was found by an AI code review agent. It was not reproduced,
> and the fix was only build-tested.
>
>  net/ipv4/cipso_ipv4.c | 3 +++
>  1 file changed, 3 insertions(+)

This seems okay to me, thanks Eric.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
