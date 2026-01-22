Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243A34DCEE
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103715; cv=pass; b=XqvleFg/XOADxwbxdreZVqyXkE1awY2Hw+Rfkvt1wuyvLHaa9lO1jg6JoKThvGAAiTLSmOe0DMthGjI0zthiQ1Y8Cxgxi70Oyd2EzN00BI0uKAK3vWoBk6MBQggYRqhehsSZGBzwE+DsD3Wi7+BJRbaiyEndfF+gfokYwbkVD5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103715; c=relaxed/simple;
	bh=sDSrH6LAVHSShwvwEW9u/sV8B/uYPx1/SphcZDPIFtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vvrv71GxVqJolOOLHS3Qu42dNOm7ZDny7SqmAP8UJV3XiRue5ivzcIMLHf0Mk4Lo2ll9bM/kmJagsACXm/A4sDnaJJDz/1lekYLMOhpXSmigkgcudyziYUl41+xl8qq0zW9bXvx/cXqfWKWSDchfPr2cFvGPOWr22UVnt+l1znM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CNiZxReo; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CNiZxReo"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c551edc745eso564225a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 09:41:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769103695; cv=none;
        d=google.com; s=arc-20240605;
        b=dkoXX1oUuWwDmcdnWTBCM7a53Civfy8dFnU+uZsU980cJyzgNj4HwFERNx/2T1fr0V
         sOqpMpfozmWHnGTGKHEBP4JX07VXgkX+8Kt2gcefWAGYAGg4f2lQaJ+GPkEpRGg75sck
         0ayDv4n3GpDZqaoD0niMuFdNczkZOjOkU4i+2rtwCPhmjBVbIbdhVoCDYxfMHr1agRRI
         L9eGbVKLNj1/lKVTlpQDKlxn/1uRGRkf0BapgcWwa6ptPRm2wyXzhfvHYBMDeM6j6Vnf
         CejehllGfcvhpylA56s91Cyp5qnu0RdTPILL3xNZsYvFz+mxaeUsDwZtyTwcMh8D9mty
         0KLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDSrH6LAVHSShwvwEW9u/sV8B/uYPx1/SphcZDPIFtk=;
        fh=fXhqCiPq1+y9wC11Xz3gaI6THB/iLJoPpItGJk+mCXg=;
        b=F3wHZiq8k+beG3FrJJzzKExaX7eGuLsx/dc94VcNWH/CooumPEdBhL96NGFcw5rjq4
         0gS96aqMUHJ5zC0ZV9ntS+GnJrAFtIARCBpcYIkOkZOTS52dk4w0Z7GrQuKIGmTIs9Nr
         bF184YOruOu7Fmjb+soKmkYkbu+o6gSlU6OGdsZlHe3cSVjuvr9A0AHYejRk1VoypOAS
         AKrO/WmEniMYN6kXAf8lwsseK62t1/haV4CxfY7ld1CJ4Fqni6FtfwXHdmScG54VNyZB
         SmrkR+Y9szQpZRvWrytbwh6ZEfMHh6KUFZB2mMasb9jDsjDFxicfNBhw0Yb0TfhOop1M
         CUsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769103695; x=1769708495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDSrH6LAVHSShwvwEW9u/sV8B/uYPx1/SphcZDPIFtk=;
        b=CNiZxReodS0hOgFKguC4qINegOQIf1UtBphq897chjsoN8XQ28kieTf9KEH1f6hLDV
         3US7B3K7dlemTFWu9vZN6xH1poxif978Hgl/yJrMz8bY941gAc9fi9I4pyhYLkJ7ZzeD
         ZoamzdfN09mVkHOY+flS/BS/hI2v9ai0Xj/bVtAZKljoZplhjHgAoivoVHgtvHbmXoAn
         ToreRzwWBWCKm9PTFlYWl281Iq2AootzEGno5SyR30Oov+7r+Z/rJo+KSqF6J2XJlID8
         PaIhjg4A/fh0KmhtCFWr8h662FcMpyau7Yg80QzKTEYlO5NDm4tsTB6fG5OMGTpCyjdh
         yLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769103695; x=1769708495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDSrH6LAVHSShwvwEW9u/sV8B/uYPx1/SphcZDPIFtk=;
        b=AUJrSvcXKoAcqP8Aj2hWDw7zTRnWHijH6ZfZTqlTVHM8K5bh8Opw1Sthdkq8iUbPsr
         dQAkYV8bEkTHVKIR0qU4MUX7QXxrzbLnl7d6ZHrPRgi+thJiyQhMvLLBqvxHj0wZ5KRQ
         NoWema2EWqOdx9ajDmTfcQ9fmBXKMRLSHqtjuuKpL++QrAwNMowtH22n64NtgN+Kr+ZH
         6syYLWciacPX2rRBtzTJbXQffS0l8UAZSMtZoXzXbcZ/1gkf4tTUqPwdFshwqoVDmOWY
         jIqeGP/QQHAG9xcgKmhy1XsNjF5wI6N4dKgfmWjpdvof3Dv0rePmD1H29UqEHBOe67Rl
         2cAA==
X-Forwarded-Encrypted: i=1; AJvYcCWbeIe7d151cCfAxNBVh8W2hfKZLqICKm+1piRpFT+X/NSV0wHvYMG96KDC08YDPeVn8r67VY6/NOablayYezHZf6EBh08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nBqBviyQgmp0ffI0RY/h2MRHt88La77sPDEMLZm6aHV7Odcs
	w1V7ZIRvYMYorUdHJLRvxUfkoiuQFyLoVhrU4BsjloDY3Z/S7ujbL5s9p4lOMsymBzdZnGS98zb
	llL/B9nRRclII6zddZC8LyNPGVItTcMa9ZjSuBkNM
X-Gm-Gg: AZuq6aJfBGuH6hfDoSwBITxpFjTZLlQvs/l18C2xFuwofz6VEoD9wCW2XjusdHAzrQZ
	lTcxGmSpA9LXSzyNtYoG8KwPDyo9D46/ie+eAweXH9tq3k4zc8oSiP8nRUFkbh0QNWZbkSr6Bhw
	96RwRiSm4TeUTYErTSbNcqq9q7ywdZM5M+o/q3dfn/keMzHkxwakk/wzaqXX7d2RTJ77lRmcpoH
	KTVtOQr5zvVxCpbr+Yq7L0MMd+e66KOq5rHhu/yLSpuEqwvG/N2cdsZgvyUqjGw9DXOA5uu6Kfq
	/K/dDQ==
X-Received: by 2002:a17:90b:3a4f:b0:32e:3829:a71c with SMTP id
 98e67ed59e1d1-35367603595mr286888a91.16.1769103694733; Thu, 22 Jan 2026
 09:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119091226.3195309-1-caixinchen1@huawei.com> <b12a0d60-da15-4ba7-a526-247b5a7d97ad@huawei.com>
In-Reply-To: <b12a0d60-da15-4ba7-a526-247b5a7d97ad@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jan 2026 12:41:23 -0500
X-Gm-Features: AZwV_Qgikm3tbjc7vJqGQPtZPYCNto0xIig1lqlNoqN2OTw-g-KMTXXVKOkJCFQ
Message-ID: <CAHC9VhRokERQGaB-1Xf0AoAzmT5tys4d+e4pmVY-W-88GQ8Jpg@mail.gmail.com>
Subject: Re: [PATCH -next] lockdown: Add break in lockdown_write
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Cai Xinchen <caixinchen1@huawei.com>, nicolas.bouchinet@oss.cyber.gouv.fr, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 4:31=E2=80=AFAM Xiu Jianfeng <xiujianfeng@huawei.co=
m> wrote:
> On 1/19/2026 5:12 PM, Cai Xinchen wrote:
> > After the label is matched successful, any other levels judgements
> > are meaningless. Therefore, add break to return early
> >
> > Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
>
> Looks good to me, thanks.
>
> Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>
> Paul,
>
> Would you mind if this patch went through the LSM tree? :)

Assuming Nicolas is okay with that, I can take this through the LSM tree.

--=20
paul-moore.com
