Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C638757D
	for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863751; cv=pass; b=gRsuDfdSCmcOOPKUip04ZtY09yv2Ul5r88lkOohqRTQLeQIYR+a3rLLNb220IDDqqq4FJo7PAyTOjVjRBtFpnDloEUf86vVFPCaLPjf2IkohGDhJdtDT84j3bZxzz5zILYiaxJFqG095AnLDtqggARbs+rEUyAGXXc4pgdYbgMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863751; c=relaxed/simple;
	bh=Mkayx51DxZT7WmGF5cFTu+eGq5VWwoqDeRy/KMEFR7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxpIz2nio4c2oR1qJYO2pY3SLxUhaSmWKJ6tc5HMrWaB8W83axH6UVtyEbUSsF8dYJo7XsEzrUhPNHmpFSfJ75/AAGfzZdVhh6/CUwtyrrLcGFSvlbp2j0sehNT2oW2FjGPXg1tGU77n748wmYG/mUgfPtpkhun3Xak8JWwefbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XlmhF7FE; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XlmhF7FE"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c742b9b7727so954826a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 16:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775863749; cv=none;
        d=google.com; s=arc-20240605;
        b=K2jMKRYdVPi1SN+voQN2nHry815ATW2g6DXV5JYy+u+w+N7lNsXWQGw5sKB+TzAkC0
         k2ViB7Z6b726glmywLCQHLOAaYku1V3wU29CU22HgFOYEvdGBnNxpa0oncJ4Eoce+NmN
         gEaitlCFxMuPgy/efoavinl3HsM255q2GQro6fslbxC3J3QZhpv+8B/wciKLwtrM1uyk
         Jkn103YsLWSkBq31rHSrf8frLjZGQc8TAePpFiXNdIqv1MnUdN4mDx1N7944LMWFe0Zt
         OOc/CS7/GPHXPC30yXn+Nhy4SbusPThs7D+/EcfHxJg2OG0k6ctnYd7QB9obffcrALVD
         1GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VgIfb/4jZRt0HRh+5ouxOyYaz9844HRhYfzdaeaTY/4=;
        fh=H4qD9RClKG7laifNz9zJuHsikdw7Q5cxmu0yUZNvOLI=;
        b=PzqTlGYwsl0Gv1PQm3G2yLEs/bZEgpLDvfM1WiW7dr1q5WUnULP8wGjMBaNsun3hOm
         N4WXLQ5ltOY8FcPSLa+/Qu+we1cdqcsFe+u79CykN10CpmrmIgDGjrU/yPe3bNC4faG/
         eCy+8xNoVZixNiwHYDSPGlN90ZYuS1FAd9A3K5+lK8euxFfzLUj3E1HOTF43wnQqa/3F
         A1SV+QD99jerln4fXIQ5uKQrBKLZbAfUHjoyDTBWQwl4BA4oHTAPtfGgtTvqUdz7kjrL
         yvpvZZA+WuXmARg29BShxwGtlfKmK9WmKze/P2rUnIw9dxgH4wfz0XfmkzdYYulPqXrE
         b36A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775863749; x=1776468549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgIfb/4jZRt0HRh+5ouxOyYaz9844HRhYfzdaeaTY/4=;
        b=XlmhF7FEwO6FNm7kDZAb025bgOO8yqHPKuUhNYUy/WuQ7ulAhanih16mUf2sDn1vPg
         UCKgoNP8YwASKGSfR6cg7ZOo0BvBg0eANlwPjKptTOAZjZa5t+zJKYax3UsfUqmQRIQD
         TQNgdQDPHw7oe834DIMGG1+8Zq98GbcT+DMDD3ibI0rYULoAte352p/LOeQ98PSw9NlM
         ib9BJZlrAbJYduiBSmioT61skjL3mYyDhtmii1n/uCqMNBhvirNgKx9BFfmXYepSja8a
         gghhM158oztKE6kRwXCMgO9RlfcUwtTFYjNWTdOtuDsMwNJ7CDdO0ebYBwuLysOQqWiP
         UboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863749; x=1776468549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgIfb/4jZRt0HRh+5ouxOyYaz9844HRhYfzdaeaTY/4=;
        b=b+wKSoKbjFumkwmglPpDCj6X0b84XaeKHtRKLK/uIazhHPv7CvAnf+vexEo3yGLlR9
         WxEo011L9fUiU/Rk/sjHMzEXgU62Oyk0odbZ/WDA6tay7m0VWI/NX+80yiv6u9uLVZea
         eAPC/dOBHdT9+fOPP0vd18xgX0OLr5NdJeyhsELyaa5pCA0jINvAGLA+5QyaB5MxMJEq
         RwSzM6pYwjleVD/43SyNYKk9zfW+zX+qntRcBDq4NoLZHgUmGhF8xMdWdq7jlq7BOn8j
         uV1HAnIqVwhzH1QssA23TMKoNSFCmb47glEHCct1eaEoLUmt4XDljNuuRGZ9GAz5ozlG
         NmWw==
X-Gm-Message-State: AOJu0YwSVGR5Zk4ybLGGhQP2wrFfzEFkaqCzs7B+k0tEsr2BW9KucF36
	5RSJAmwtnvSPjTsUGfkWsIyW98P2G3WFPfhwYe0Basti6EdSy1LmqRfg1M2+pDza0xI7uLQ1jLa
	vYU4iR0l6HpkFFke3kjD8ZIecqZN6r7D5SLvJB+6D
X-Gm-Gg: AeBDies5n6SfbaZwR4rZwTqY3OwO+qCBHpCjWe6LODbq/bywpZAMrUAajNyzlDvQwFV
	CSdnUT5b4UtcSovzT82wXL0Cz1inVhHrS4GGb7+Df40KEyhHKPYc/lpt+wp0LjZPs2DJ37BfqvY
	AYZ5gB4Xf4HBqrKAlE/5n5/0UemfJUmCmxFEcSdSxqqBC1d/KwNBRmcuNDgSrpFPNsi1mftrYXF
	nvAU050NjqOLISJpm/3TwUoys18JD8vcVbTKIentuAgRt5otjrUBiAWPOqNoTXgC2pSc4nYv8f6
	AIIs4yq2ndasDUd1zA==
X-Received: by 2002:a05:6a20:748a:b0:398:6ec6:b06d with SMTP id
 adf61e73a8af0-39fc9631183mr10166114637.34.1775863749388; Fri, 10 Apr 2026
 16:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9a2a59bd8d9548fb5dab128f4859fa3d@paul-moore.com>
In-Reply-To: <9a2a59bd8d9548fb5dab128f4859fa3d@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Apr 2026 19:28:57 -0400
X-Gm-Features: AQROBzBmV8Ri9IK63vbQ9iWzNWu301jVDFLZnmKlibSJujvhRYj_Y-qZ3nlilgo
Message-ID: <CAHC9VhQxO1pKuJ4XanS5cZ7v9qFeizUsR0ZgTNFi8Sr_JHwQWg@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20260410
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 7:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> - Fix problems with the mmap() and mprotect() LSM hooks on overlayfs

I forgot to add that you may see a minor merge conflict with the VFS
tree, but based on what was seen in linux-next it was trivial and
easily resolved.  I know you prefer to resolve those yourself, but if
you need a rebased branch/pull-request let me know.

--=20
paul-moore.com
