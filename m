Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C840BCBB
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352854; cv=pass; b=WcF88qi6pCA1Aeox8zeFJ+2aK2bMUsXs+Cmh1+xJUHCGI5BkTzd4YxzsLqta/ZoL6/UxTrz5jdfqqCzLinFcflpuTnRV5bNftcmizCXO9A3BSCV8Ao+kZgbl6AWWN6eXpwthE7aY98Aki7brWHEo6KtUTV029bDGSnL2YZdxmh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352854; c=relaxed/simple;
	bh=uSwsGj7z13o5NrJE21iC68UKNr7h5yOq6P5JpP5TNDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bcSyPxt62NLdYBfJgzcN7Hs7joe6LqFodeTjNaqnt3EZInXyI1THVLOYPUr7biJJxJfcnjKV0Nj1MblfAU1JzvswmXCPVAon0TX29Bk3+iEV1XvNNPdjTi5L3Pry8zuEtjQimIhB6Qp1WXWQLMO0ejdy64I0y0/NaBhxTiDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=U61hr0Px; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="U61hr0Px"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a9787a156eso10101731fa.3
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 12:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792352851; cv=none;
        d=google.com; s=arc-20260327;
        b=AomssViGK1UYjmZhNC5BqlFabtJ0QUYEgdAC+KTjXTsNqcbps5W7plWIELk/JdLiQw
         NPnqeIoKVtQPiC5HpZnN+1nkxTsHBvMA9Zsrfzt2d/y1SYF7cAKU1gUDUo2q5O7o41/o
         JT0M424xxZhOPgG3VEHdfdbqlJ9Oruw3G6MbSJ1lDUjYCjkWU0UkaXORL/t3vbpGHl6q
         FPCSwzIaaaY38p+kT2ljltOmMfxAsARrEMQSYeGW1i7gc5T6eLZXjtvR4O8o2JqpcAj6
         DngWYoQvWY04KplsmlVnLsSKDImklrT0qLUOWinX3Ni+ZW/tG1jBUU2yQ+T96vTeaHyy
         islw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        fh=6Jrp5usOVwD+H2HGU4BpDgNE9oVgMgzu3FtHifUTPAM=;
        b=HQyWCfUUC+I2WvdO8vHNsXuP65Q6HxexnqVbOHCyAoXi36hEF0dGDwqAobr/7N4pMi
         ULNn36eUCNAXXrw91RM4unRO7NKVw6iKJV9NosSw9gj8bHGxLeItr4ruYsYmZoBseb0R
         gI/xBJOVHfq7HVOZJlGBWjlTJKZgWqs+B+K4mEZgst00ds2QDT4tsAK8mTtmT4YFRSsN
         SN/5Wg8B0Bl4kQCQ71nkZQpnOltJbgqWG4pyYUKcHe89tfjAWsSw51yGtsT35w6uoA6N
         lOFT9e1IAPGOW8wqNWbyvuov8w6k/kH6t6n9DF5PdYjjJo8a9krNmQt4e43H5xftldTQ
         unJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1792352851; x=1792957651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=U61hr0PxGjsekFN/Peus8SSvsCkWL+X4cEShlWPsXJwFZsPSOlvUCsybYg9BgwgJRd
         4XnxIJgNM2UxnPRJ7LJ9ePNZaMA3S+v2khZQd28a3QJuiBcuUaNEpSAyegrHLGxeAQOF
         XWhhz9z4gvoj1jD71wUdmMg7TKUgBLlQEbfCfdSDreL0vc42Gwa+0w9MuT0mJeW9FjHk
         InbXbqmJqWqFBCaE7bhMzpyoImihsnstJokhn5vCptf2p7cb0uxL1CtKsrsoOoa51lXm
         tyklrtgAN7N7S853vG7iCSHElYqHLPGyLpCn9vrAZ76I1HHBL84qCv0LlLe1GVF1/qq2
         6Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352851; x=1792957651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=kx8aYiFS7eYzu/T9iKeEVTznkWzOqnHxrtobKZrE2CRQAAvXYrRd0Ayiui6h/Hk72e
         0ossszZ6F/gtvnPLDmvA4Rpg2jktKfdId4JQ3+NofEol5pSKgQqrAAyCf76Um01oNdE4
         o+9FfRY4uqb80R7xRqcEE94toK6DF6rRlzuwR2bhOvTmg7IENS3X2oeqEeWWTqfI2apN
         1yqDCTlldyAGZhZvOJYh//6BG67rfn5845Jxx2UKgxZU3RooIaIXVWRcsQu3BGjqXyZy
         WGLoHChRnmKw7pOI+6wrlQF6b3PxYyM2oePh6wayTm/Cwnm4EgL0ASJb9QroYzIyJ25U
         cmPg==
X-Forwarded-Encrypted: i=1; AKwUvByeBd05MEsGLaoIultzy2S3UjC5LAwvQlR9zB+MlzlttS+jXboHHiqnIUZwnxswVMbxfW4z1HN2fxnL2zcnk8CypwsyCSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1F9n/0iLvIGUS1aStPazt9BRt524bqu8UVgyT+SiKTdhTRDXL
	ct2Q2OuGehXoPhNNTbEgNUkkVQeb8rWh/cAlMmkIPsehZ5v6TjEYA3ayiIKQy89twmfiw1J+ORm
	vVSPeIYY/p6HnLE1ZSjMQnTehN2TEKZzMO646W5J9
X-Gm-Gg: AYBFou1tMO0+1OwM9Tk4WykAKMrGuoqcGj8yYqAh/EDKCo2s9nuRzQYECn+wv184zLH
	GGdthSaViGYod1RcdD6m0aG4qy7Rr4QOum7rRILVQbnRXv9REwaKqc/GtodR2mlVwqoxHNNZ/GT
	hUDaF4GL+WGuXTnLdXpxiVOiLpXW06liVZP/A1aAWMIKM3OAVxWebjpBWE6j/X0uFgEQqa2olgN
	+NWXrXjpeec6gVuecyoWbY7vI5BCfPFQdUJh9njdaR5IBLH0qU6jWaXOPh7xZv/AMt4dqhPz9oJ
	jj65cdG4VbADWFjBpQNFaoZIq3T0VlX+ptCZEUaYMAGKtc4QoTKA
X-Received: by 2002:a05:651c:3614:b0:3ab:1639:9a79 with SMTP id
 38308e7fff4ca-3ab292b7375mr9897881fa.15.1792352851051; Sun, 18 Oct 2026
 12:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792346472.git.jan.koester@gmx.net> <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
In-Reply-To: <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 18 Oct 2026 12:47:19 -0700
X-Gm-Features: AclHuK_TjVvADO7YV_Of3nNvklGJn7yisT4mnRNh7189wUPwvl6Zlkl0ZNpg8pA
Message-ID: <CALCETrUjRpHSTBzO65uU-YaEj4espqnwDSaSLcXu653xJyooHg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/41] uidgid: let kuid_t and kgid_t hold a UUID or a GUID
To: Jan Koester <jan.koester@gmx.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:10=E2=80=AFAM Jan Koester <jan.koester@gmx.net> =
wrote:
>
> Make kuid_t and kgid_t (and vfsuid_t and vfsgid_t, which share their
> layout) tagged unions: a classic 32 bit id, an RFC 9562 UUID, or a
> Microsoft GUID. KID_LEGACY is 0, so zeroed memory still holds the root
> ids, and KUIDT_INIT()/KGIDT_INIT() keep building classic ids, so the
> bulk of the kernel needs no change. The member is renamed from val to
> legacy so the compiler finds code that peeks at it directly.
>
> Semantics of the new ids:
>
> - They are not in any uid_map or gid_map: they exist in the initial
>   user namespace only. kuid_has_mapping() is false for them in every
>   other namespace, so no capability in a child namespace gives
>   privilege over them, and from_kuid() and friends give -1 (the
>   overflow id when munged), exactly as for any other id without a
>   mapping. Anything that can only store or report a 32 bit id thereby
>   already treats them safely.

Why?

>
> - Idmapped mounts map classic ids; UUIDs and GUIDs pass through them
>   unchanged, as long as the filesystem itself is in the initial user
>   namespace.

Okay, so they pass through but don't work.  Sounds unfortunate.

> +/* Like kuid_t and kgid_t: a classic id, a UUID or a GUID */
>  typedef struct {
> -       uid_t val;
> +       u32 type;
> +       union {
> +               uid_t legacy;

Linux is Linux.  small numerical uids are not "legacy".

> +               uuid_t uuid;
> +               guid_t guid;

I'm at a complete loss.  Is guid is only unique on Earth but uuid
unique in the entire universe?  Even Microsoft admits that GUID and
UUID are two names for the same thing.

I realize that Microsoft colossally screwed up years ago with their
little endian uuid idea, and I sincerely hope that this is not some
endian thing.
