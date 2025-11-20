Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2121B9C1
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674039; cv=none; b=CLbilE+vs2/yo0J/4CMncVw2N9j4memVkFlS6kmoel4EcSFf2SwnbwynkXjlbJn208YEEbBw9XPRBlUfcHlIs/1A7Xd/nf+ZKeepZLNHT8TmKZrtfVchfgVjdySLTlkxvuukz3p6TpMMKADbBg7GlIVn9H6zA1gGyex95nqvpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674039; c=relaxed/simple;
	bh=PiJviyXUTENYjuQjCJvFAV3sV9k/3Y27StC9iNQvcuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4bDlTyJ3M6nmfsJopSixKzLld0w7tV30S15GZ5jHJOrtBciOVTrMMjsbBHjdOffpCo/aKcGlNlNOn9GHcg0M6ItzAJBYycj5c41ktBGAqx2djftNeoEYmORDryWSIYM1OE9wgvkEQ1pUZwaOGRAShwcrU0oR9P9WzfMKX6gP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8CQfDt3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8CQfDt3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297dd95ffe4so11988725ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763674037; x=1764278837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9F5znLRdnGqMGoQlY3VLPNa03DxpxqffUCbwTxiY/s=;
        b=I8CQfDt383CPyYbnZeKZnWXK9z9bs6PN5qyGj40OSXbE1GvF6Fg7tobbVSgNJC/Zbz
         PijHYMhw3ifHCChIXaQPunzj90404ddrdbhhO6zpvgjB71JnafOHqitcyuUqwbTuhAbI
         lqIQ9gF88B413WPJBtpr1acu0G2ljTQM9+kBf4AEjrYXnlYWe4I4UsCFSe+rweKZdqru
         c2oJGnPaflhZetxU64D3c7nm7IobQw+VrYnylQPQdIutakGxHXvFAj6yVrYNItt5nRQL
         mSMtqN/JGPsQKP38f2OHTk1pOLc3SVyNtAkl9V5N9c6XPEp0OzmQOpvbJD/V+ucuFSwF
         oLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763674037; x=1764278837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9F5znLRdnGqMGoQlY3VLPNa03DxpxqffUCbwTxiY/s=;
        b=kE3dxiuUrZLE6awJODcO845bSowsG4q9G1pf2MZ63jhA3FuScDLy0GPWq3d0qpE0if
         adciPG5Pd5Y33RyBZ4AlIwVX6AwBzQUgAwpEeVlTkbSpylbTPqcNxUC+QC7g3ibp3rCc
         AKHeHmQEWwBW5YN0d38/MqNud9aGprduJRteG+8QxVO8ZOeJUUc75JW9LLWD1REPwMTL
         vJs0loFMb0L+SaBYDQLu9dipPmrxYR2nx3ZtysMQ9Pd1DHt/kq9teNDnBpHDwGtC60LW
         kH3yv/BINCwqzdG7tLA/KY91RgpwqpGM15fkb8pxOwot31uJK6zINFaDcoOp//toLKLY
         gjUg==
X-Gm-Message-State: AOJu0YzLqMb87aAq3RUFTpl9nMNVGVVHqS9jD9g7iatj3zO5ArHApLLi
	oHg4K84LUViygQcq7nNfVEtAA+JUagkt+tZ9GD6TCdizm662X2q+jxAAVUrNyYDwDoB4T9U4eLd
	iYj7wly5LZce8/9PB4BZBBT5Cje8mxjZTuaa3GCiu
X-Gm-Gg: ASbGnctpnR8d441+EROh6vljTI0nok20wrixVTHb63KpKXyPdELclhiMrYiZdhWYnPk
	tDibh5m0sPctqyLU8uVddnQ4vIIniNhSHxTPpkbEJCUveHg98yiD2QwkoA4A54bj6FFe/4WGPY5
	iZucNVnDWRsP93RG6+f3wvlU0aQrcy6jetdBmsqvY4vTtJPPGM9okUcewNnqCH1pSsN1y3EehoF
	FIkpbtuN7zKL+PS4j0hVlKFXEwifhD7XYxim5sJxPZrlcdaglwqi9U+P5UJwtrFoidPU64=
X-Google-Smtp-Source: AGHT+IEhQmlVkSXNjvvdudXybTZSx401cHWgJcd2AXas93BIq93qEYNZpj+DaNoElGgGcRmQrXagsG53EXVUUTIU1WU=
X-Received: by 2002:a17:90b:5347:b0:32e:a8b7:e9c with SMTP id
 98e67ed59e1d1-34727c4b52cmr4541062a91.29.1763674037264; Thu, 20 Nov 2025
 13:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119153636.15243-2-paul@paul-moore.com> <f3631b3b-4461-4176-9178-27fa1dc66226@huawei.com>
In-Reply-To: <f3631b3b-4461-4176-9178-27fa1dc66226@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Nov 2025 16:27:05 -0500
X-Gm-Features: AWmQ_bkIvOkp4QhZL6nFcOKVvEYdnefZaQX4jgBmFw7hKnxmDfO5OH5Y6Rbi_6c
Message-ID: <CAHC9VhQkn2b1bdMcaWwRraLDsW2Scjh0sAZGmjr7cY=GHY4B0w@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: use unrcu_pointer() for current->cred in security_init()
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:48=E2=80=AFAM Xiu Jianfeng <xiujianfeng@huawei.co=
m> wrote:
> On 11/19/2025 11:36 PM, Paul Moore wrote:
> > We need to directly allocate the cred's LSM state for the initial task
> > when we initialize the LSM framework.  Unfortunately, this results in a
> > RCU related type mismatch, use the unrcu_pointer() macro to handle this
> > a bit more elegantly.
> >
> > The explicit type casting still remains as we need to work around the
> > constification of current->cred in this particular case.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thanks for the review, I just merged this into lsm/dev.

--=20
paul-moore.com
