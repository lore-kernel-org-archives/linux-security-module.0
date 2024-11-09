Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AF29CF4
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176627; cv=none; b=fbp0ihHfj4gtw7ta+xHekr62DL/r46ac/6iMYIbpWguj4Zs+r/M21JEpxFK2bbxViERKlz+BpkSOk2vNJc3ZmNKzVc3cQIc1r1Rfp7sbtf6ZnAHda7lL0qgHHWJEN++kdjtmaRhm+U01mk4nN1T51JeDBqnJyH3bgGanHfxgi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176627; c=relaxed/simple;
	bh=mlbBETcupgCb414Ky4zumxeZ+96zYQqjYsHF7GElXuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pUYqN8bMjJq6OaZNzkHwh8eHuGEneliX528GAHof8OICqQU9/dIfDfID38Crwb8gsJvuVUUi2YmwJS6OuzDmJsOKIYiW7jCnpS9GmTA+PSXPNLVSk6MfiTy7coSgvAPgDvchqEG4Xi8I7vC4Oyugt5aq1yw/1ZYkYFi1S9M12HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpJctR3U; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpJctR3U"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso62498017b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 09 Nov 2024 10:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731176625; x=1731781425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNMtpNh0EyiH5Cih+rXzvOX64NKOibAYniapXi4mnKE=;
        b=SpJctR3U8RWNiR1dmMrHyQT0ObVPhK/x6w6xrd4SmjVKhmPqhBA2V16cA/pk4TJpIA
         3gC8TNq5T6/10hn3EcLcgB0KYPmJQl39YPwWwYdry6xPxWWBuV5p0NukxYPsNbCcBpC6
         fKCPnVjkz9twjDBy5jgxcUtBaVi2wa/1+epm4QFWAmIFl1lc5SiclQoxJQ+2LOBsVCMP
         0ghnRGSVC6Z03MZ+zyZEk2KcvocLi0PWdag2cQEqWoCVcrWFNH+oWVK/yTSSt5mTnSHS
         M9Gydr8Slzvut+20vqUV4QLClQ382mjqlsCHocw/M0zQ8IMCfQlrEN60MnU44T+DKtTm
         uY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731176625; x=1731781425;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DNMtpNh0EyiH5Cih+rXzvOX64NKOibAYniapXi4mnKE=;
        b=HwQLKayK7UY9vQMqMllWCDNZxISl6p16c0r5wCTjuRgXCB3TmPPzKx3n9uzzIgaIhg
         TcFSyJiiTpvK2GD+ayfrYPzDQl7uF1KhvMcP7Qc5j0OB6ZlcjAI6qGHCWncfA3DRcZwY
         wNjn/HMy1/ArLIDdGhuloH/PoC1YuCwFFYVjQClbbHg3DwAA/JV+/ZgHFaxlJ1x/Qh1G
         BlFkCetCeVFWhi/y88bq0N57DKC6FFHcUhRdB7fOFWQnwltSp4Ff9nR85WK6vCpB29dd
         zqWEW7Y7PDzr67kq+9KroVEhATkpGHJ3vR+L7QVaTV1s7oitlW2f6s3vxLkXYLPoeERk
         jB+A==
X-Forwarded-Encrypted: i=1; AJvYcCW6h9Nhu2HV/miryait5sW/HLB4D8CR4Ig7F6YEmefDyjuYpNsvvC60uaLMOAlbNmEh4uhggJ8kIulGCekoXanLUKE7hAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhJEJoKYPhkWR1h7nJcvIRtFcx6IB6cIuDVTBVjtXLgp8UIvH
	m9ZDBD1L+fI4NG64NQfMTQ16KQyv4G2kuTS9qoq3TXfFjRGXsgCPVT4/COwlj/LTMUcB/6rmFP+
	AjA==
X-Google-Smtp-Source: AGHT+IFb2ALdev8rkS2MP1OpmqtRhIJDwy41Rc8Ssp6CChyEzIsFEJl8h3SRKE9oiK0DStU4Ojd1+peHK9s=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:acd3:0:b0:e30:da65:7240 with SMTP id
 3f1490d57ef6-e337f85bbf5mr14424276.3.1731176624715; Sat, 09 Nov 2024 10:23:44
 -0800 (PST)
Date: Sat, 9 Nov 2024 19:23:42 +0100
In-Reply-To: <20241109110856.222842-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109110856.222842-1-mic@digikod.net> <20241109110856.222842-3-mic@digikod.net>
Message-ID: <Zy-oriCJELJSBYFZ@google.com>
Subject: Re: [PATCH v4 2/3] landlock: Refactor network access mask management
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 12:08:55PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Replace get_raw_handled_net_accesses() and get_current_net_domain() with
> a call to landlock_match_ruleset().
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241109110856.222842-3-mic@digikod.net
> ---
>=20
> Changes since v2:
> * Replace get_current_net_domain() with explicit call to
>   landlock_match_ruleset().
>=20
> Changes since v1:
> * Rename the all_net mask to any_net.
> ---
>  security/landlock/net.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>=20
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index c8bcd29bde09..d5dcc4407a19 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -39,27 +39,9 @@ int landlock_append_net_rule(struct landlock_ruleset *=
const ruleset,
>  	return err;
>  }
> =20
> -static access_mask_t
> -get_raw_handled_net_accesses(const struct landlock_ruleset *const domain=
)
> -{
> -	access_mask_t access_dom =3D 0;
> -	size_t layer_level;
> -
> -	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++=
)
> -		access_dom |=3D landlock_get_net_access_mask(domain, layer_level);
> -	return access_dom;
> -}
> -
> -static const struct landlock_ruleset *get_current_net_domain(void)
> -{
> -	const struct landlock_ruleset *const dom =3D
> -		landlock_get_current_domain();
> -
> -	if (!dom || !get_raw_handled_net_accesses(dom))
> -		return NULL;
> -
> -	return dom;
> -}
> +static const struct access_masks any_net =3D {
> +	.net =3D ~0,
> +};
> =20
>  static int current_check_access_socket(struct socket *const sock,
>  				       struct sockaddr *const address,
> @@ -72,7 +54,9 @@ static int current_check_access_socket(struct socket *c=
onst sock,
>  	struct landlock_id id =3D {
>  		.type =3D LANDLOCK_KEY_NET_PORT,
>  	};
> -	const struct landlock_ruleset *const dom =3D get_current_net_domain();
> +	const struct landlock_ruleset *const dom =3D
> +		landlock_get_applicable_domain(landlock_get_current_domain(),
> +					       any_net);
> =20
>  	if (!dom)
>  		return 0;
> --=20
> 2.47.0
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

=E2=80=94G=C3=BCnther
