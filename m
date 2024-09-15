Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08E193429
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726389639; cv=none; b=KmZ4qv97cMXMnHp+/4ooZQnW+7oiNnIpiB6LJrF5TJMwV94EM2jxJZJtSgwpH87PB6rHC11ReKnzSuqj7HqRBFVorEWvwkf6uEdVuG/rqP0QOMpNWztJKySPaWd8JxEg4yC17g+mrQFF0t2Z3CH2WLupJrMhc0DKQ0E8siR4Dv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726389639; c=relaxed/simple;
	bh=7W4dXzHo6ZsXChruk3vokDJnvUK3D1xdySswkG1oy0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpbiUK7DF2jemecHhauLb9CRv5r2ScsQK2U6DdwdAEAOQyGVFMno+1tI/tbeoMhutvK1qPn8bwj9gCfM0mchreHHPlIHfBjxaaNIzdn6MsTipmHGATjaJlouF7MGbkN4dL+b+c2pyCBRp+fU4vadWqmQY2TdX+Y5uSD13GlY8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ftJOO5Q0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ftJOO5Q0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c413cf5de5so4671586a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726389636; x=1726994436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDDAsPUl2QeVKALO8ENGYLR9AUDsg9hKmMIPotwlIM8=;
        b=ftJOO5Q0g5XUFpmgYfjiwTUL78w2p/C5WD8WObSp1qPrbnizvSFMh5tdqorAuqez2G
         3BeiPYwGZ4xHf0sN5A8PLJOD4scODhyJ97T3yNJqMy/eiZcCNU0U3Bl/CipHlm2eG/sK
         4KHvw7iiYqlvigL+Vn2kY6B3A5+OdOWNeI+Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726389636; x=1726994436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDDAsPUl2QeVKALO8ENGYLR9AUDsg9hKmMIPotwlIM8=;
        b=BkeOTZYGFQMmCtlVb9LT54MWcEMU/Ytt/+nGyu6v4zNmF62cMHSHINdxRD0rmI25Ac
         fbJEsCg7g7KI98szQ5JZr/6JAE9ZHE/Otz1ijQkDYvIK15RW9u78wexFwzfLKoiE2YqX
         +YoPd62BJOvDIL4noxIqBmwmH2bLTwTpscTNHVi06OlpFiPK1vREvHqfx1LnX0QadQbW
         JV2rDp3b0M93DpYqvrcl24eo2AurIGd6xr6Pgl3V8wTNIouBRckjaG1GR7wxLdbrjMWm
         oOlZYieUJZmFGrFJmEMjFa4gM2W1FjSqGRJ3aQT+gLoZLsYTOCKrY1gz16z/Zebuf72L
         A/bg==
X-Forwarded-Encrypted: i=1; AJvYcCVaUKPXui8wB24z2ChvcY7Nm9SfKLPX3KBtdMeRG1ya4XD7hDYAv6G2aK4lTEfUcG+ZWIfCCVbHRKCkieaMFcW7sYH0Whw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGC+QWB5JRhn5HOPDs3nPzJHhCel0BqYhr30V7eDGqHG7OasHU
	RHMnYuSUB7wI4qwB35qC7KfXQcLTI1XDqjpoxKUkjm+OHB2d2IlIfYA29XJc2WopqKo8UQ8N8vq
	cyb0cUQ==
X-Google-Smtp-Source: AGHT+IEVpcbzDZRP9jroBbcgW9iiGxGbahGvl5X1nJi0oV7vxbw6WhsLiqGmrI0NJAnlylpomPprrg==
X-Received: by 2002:a05:6402:5290:b0:5af:30d9:e2b6 with SMTP id 4fb4d7f45d1cf-5c413e4a402mr11075070a12.23.1726389635389;
        Sun, 15 Sep 2024 01:40:35 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb53117sm1458486a12.31.2024.09.15.01.40.32
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 01:40:34 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so4359558a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 01:40:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb/jh1dIixZLxhsgRy4GUrviEiIB96wL0pnCgmoLBZEFKo/puhGRvE5UsS4mkoGfpoD1hUsy0bRVnn418o5kTsfhMx8Rk=@vger.kernel.org
X-Received: by 2002:a50:9b57:0:b0:5c2:58f7:fe95 with SMTP id
 4fb4d7f45d1cf-5c413e5164emr9626495a12.31.1726389632541; Sun, 15 Sep 2024
 01:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com> <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
In-Reply-To: <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Sep 2024 10:40:15 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
Message-ID: <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com, dwmw2@infradead.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 10:08, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> If the aformentioned EFI use-case is bogus, then distro package
> verification is going to be the only application for PGP keys in
> the kernel.

So I haven't actually seen _that_ series, but as mentioned it does
smell pretty conceptually broken to me.

But hey, code talks, bullshit walks. People can most certainly try to
convince me.

                   Linus
