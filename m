Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116972599
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491267; cv=none; b=PM8asbdhMVcrN3vAkq9YaBZZrXlYSPe9aE/YRPyZcLaR58tu+WvZMi8BbCMGmosKjOy+WfiMfvfqPay0rfpnOF1LfKvu52hOq9mBacXrhMuWvP5b7l0iSfDTy1ZHZdHVL/RcER8/I0G+ha8ivtxoNwl3nQl/cHKXsbmJEnJ7PhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491267; c=relaxed/simple;
	bh=5ll/RnN5CSa3huloi/E7ODBFlk3+9udHnADQ2A9jSWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tCFFscDCU7zqSLB57cZpjgSd4gY076IhMQq75aWXATBK2PKvOdp9g5kIDvFWwqr1kCxt9b3teAMmU+usVWToCxi0CluVyS76FTYkqflGdRMSOK9wpM2s1oaHXpw1ey2t8NuVZB0at4AtgMlbKuYY1l3iKOqRI2eFnbf/f9ROsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pe1qq5YN; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pe1qq5YN"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0e6cbec8caso4464843276.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723491264; x=1724096064; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn0bAMYBH/wp1bamvdW//YivlHMzsXTAiGRF/WgQc1Q=;
        b=Pe1qq5YN9XOD0UV4XyAw8UDNNnEzjmmDt+0cBbuPBZ/uq8E1jQxaRUA5yUFbiMGQgA
         zX3TBa6Fb+l5Pq3qMUmbXM/nVDD9yho9ieby9WS7ARcJoDxBcqcxkIpb+7od+tzoiq8w
         m5PJDCYf2Tydcp8XJmnnyPz++ZvgZRzU2mIaAIJE5fay5ufrrnJhla1KYexNBPTnjNw4
         9rUKAISU85bNANq7ratTQ+7v+eKjA3AJByDWzitMd3krFKntmh7F7SM6QvQ6ajQxgccV
         H8+lO1t1rxtzqihTVUDKWEu0bBK8CQNKNjh/ezJ2t12svX3Ul8GnBrWUPr182KmNLxu+
         gEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491264; x=1724096064;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jn0bAMYBH/wp1bamvdW//YivlHMzsXTAiGRF/WgQc1Q=;
        b=LmWP0lO+ojR3zoroz0UdLX2GMveiuGdwk4oaEGokYLFFK5c8GKshukvQqQ5Q3nx6P3
         Sk1rkCpvkhfHVRmuuxTLjMl6h+IyoZCnkuHX6hoY10Tr1PLYaMd6MLoPS6GdqND7JLOA
         lcuv6WC9hTyZpnatPDCPFSZjX+w3YgmDRkjDX89T+eDu0fbVozh0x3aZWp8KTcH57EaQ
         14TKIpTv+fadpuHQfdhjMYgU8AHOMZz7aE6dZQerheg/1pncwDyG80Etj1AKOSxjQUDM
         dF9opcyktgec+G07R8YCm1WN1Vh7Iv34B8HLyX0avwbyikU9W35waZYl2elJli30ysTT
         rIHg==
X-Gm-Message-State: AOJu0Yy13LZoZyS1tmT2sL+wSglai/YDCFZZ03y6i86uVmhVnI/k7C2v
	tnsV9Thk9jTMIqm6p63ANpnUR1BBTddyotn/+tku/N9jkn1wjEJa+VSg8Gz51x4Y7q5eEAAFnAO
	oqoGFY8kidD3ILtLL7txiRy/mvBvqtZrJa51y89gBt6cMXOk=
X-Google-Smtp-Source: AGHT+IEupBIY2FNEz7fEuwpEEkicjxVvEygNcDGjD9uhhg92OcmQjsN1pRc4JVCPyKpfrTIEUFhPpy/KpcPrCiMfS18=
X-Received: by 2002:a05:6902:982:b0:e0b:eb96:fd90 with SMTP id
 3f1490d57ef6-e113d2902c5mr1711204276.45.1723491263871; Mon, 12 Aug 2024
 12:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729215702.318099-2-paul@paul-moore.com>
In-Reply-To: <20240729215702.318099-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 15:34:13 -0400
Message-ID: <CAHC9VhSbuK-MLt3uMxZ1MecfcNY_aQAR5CYox5fxGsr_QbZjCw@mail.gmail.com>
Subject: Re: [PATCH] lsm: cleanup lsm_hooks.h
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Some cleanup and style corrections for lsm_hooks.h.
>
>  * Drop the lsm_inode_alloc() extern declaration, it is not needed.
>  * Relocate lsm_get_xattr_slot() and extern variables in the file to
>    improve grouping of related objects.
>  * Don't use tabs to needlessly align structure fields.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h | 82 +++++++++++++++++++--------------------
>  security/security.c       |  2 +-
>  2 files changed, 41 insertions(+), 43 deletions(-)

Merged into lsm/dev.

--=20
paul-moore.com
