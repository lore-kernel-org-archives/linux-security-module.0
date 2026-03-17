Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627538F250
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782018; cv=none; b=UII7avGqmmVQoNKVlVRU2rbygTmk9QwGWOmnaumXdFbRXhpKadkGyvttL+JgHMTAdSk/9ltm8rRRXs2kV4w9jWNdH1lpVjz6bg0om6PNqcHQyGZsREJebJ24DV4q/LdJpPj9K/q3nlHAJnISkGv+Ls3owQJHdU2qU0BlbOpsPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782018; c=relaxed/simple;
	bh=mQyZJgiPVqoqo74dJHDzp++wqDuqx+Vv/JhKVG5vb/I=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tO8cWq+mU/7NrJpdj74VjdgKCxJhF3oJpUfSb4qtxrGnAclCf3cr5WbcpUbZWZB6KToepyT5vpZf757LbV69pHAKxOiSiF+UfJpV/OHIf5ckXRdyzIWAYBwLxsbQoH1MkY45F3fMUvqBP+xCaLLs30bzdDDfcZmPc+5KaTYVjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VJVrAh97; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VJVrAh97"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89c4feaaeb4so33483866d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773782016; x=1774386816; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UqvNa0C4Cv/lWYQzzgHjUHv7+/AUn//LeWFFBXrp9M=;
        b=VJVrAh97GFsRA+mM9hX8LOjStfPbw0lkbUwbVVLg9fuEFpSJdJtuLKtH5nATP44dhC
         9NSD6c9ns1xDoOGUtu8R8uItO8i/GWLxSPClYzig+WYcSjifsIrhZP86xP1qDUnvAS/O
         HUADj9wqyyD6WqFTLHG7SLjU9I0n+wBKvC7Eq2mlIWZpGHNM6VGky7gEX2ovwPc6tVbp
         u9utLXar0q/G+eMC2ykddM/qw/qSsBL6P++C46iu98UtlRsmn56Q7ExAZfNjVHREbjtd
         c9CB5VkU94HTL4ln/C2D8dxrRH3E1ZtanJ93VYLnRFcMTy4rU80ZB/ypL+nfC7BIi4nR
         unvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773782016; x=1774386816;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UqvNa0C4Cv/lWYQzzgHjUHv7+/AUn//LeWFFBXrp9M=;
        b=TYlv8TOLx4jEMr29jNUN/sESuEDrOONEN3iAHJwNFVQxK7s6WZK+idPa+qGozFClJK
         xeiOWN2V4bmSGo+zQSWO7zGlCXi7wa41QzZuCNoeOkYpcTffUQLfvirIdv1SCnlbGudJ
         ONTR/dRnKE7EXXIUVDxTHkLqZc7cZc8Nd5hTG48bQzT7b/iSG18ScO1znzjJpwFarMUd
         dS6KkdnpYB9tvfknx0fUAO3XhtBEThIYtoNrbd21uMta7RMhr5OD0oxg0EHicmroVVej
         VAJulJoca5BiVi+U1Fo2i4uUjUlSyUER67m8dbgBq/bDLKTai3X5Km1x1K5o+hCmrdcA
         KunQ==
X-Gm-Message-State: AOJu0YxnxnTzlZQeiYqnMhbPD6XsN89ESZSTkRoRr9stGlzjgbQh+clk
	Cobj6Xuc95QoS0jWWswl5uh5BAtJ9PlWotKeNsW+p5iC84TZFbP1XF7qTg9MPFVuYAaasv5Q2pz
	rZO8=
X-Gm-Gg: ATEYQzwzFoe1qZuGAKgXuC0vTfgTZl6ifb2Xe/cBTt8SWslXlM8w7LXSF6DTGcKIY0F
	Iqr41sHewaoIfnegvvh91nWGRSFZ9Q87Ymb6tFyrXxlsKftuvV8Q8FWYMQnCAZWLnWnYSVVTLhy
	YD9cCzVC1xE+Azkv1iiANulXjm7SbRQe6/6oBVfgjtVt/xSoLuQYKx+96Sa06ldmpOBE3GEj+IB
	DkyYTrlwSRICZfmbkVcL5aXlc0kVrN9aipZM1E3yY9m5/4IGTLAgQUd9YljzPOOgUn3GZ/RvPwA
	GNOJGXHmWP7GIkSe7J2zIsLTQCLEEDoXdAz8sVNsZ7Jj9Rh+waqN7iraA2AMh1zXbzhdSEhBgDM
	uCJ3mCYSn4c+7Sj8btQwlNlR7+Av5fBVqgeg2FA5QvqkzmMp6IPph9Cn6zR374SI17h3QoTo2Bd
	eqSiP7nxx2I77DpnACUhEMVLhYheFQUtVYiBSLYiR8ZxivhYzSAmLEgzPJbQpIeQUSAhF8
X-Received: by 2002:a05:6214:3111:b0:899:e814:825f with SMTP id 6a1803df08f44-89c6b5dc31cmr18515806d6.59.1773782016133;
        Tue, 17 Mar 2026 14:13:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6ba0348fsm5300406d6.47.2026.03.17.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:13:35 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:13:34 -0400
Message-ID: <f2b73b8286491e7355e8355bf1f4d4cf@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260317_1333/pstg-lib:20260317_1127/pstg-pwork:20260317_1333
From: Paul Moore <paul@paul-moore.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] securityfs: use kstrdup_const() to manage symlink targets
References: <20260317141135.133339-1-dmantipov@yandex.ru>
In-Reply-To: <20260317141135.133339-1-dmantipov@yandex.ru>

On Mar 17, 2026 Dmitry Antipov <dmantipov@yandex.ru> wrote:
> 
> Since 'target' argument of 'securityfs_create_symlink()' is (for
> now at least) a compile-time constant, it may be reasonable to
> use 'kstrdup_const()' / 'kree_const()' to manage 'i_link' member
> of the corresponding inode in attempt to reuse .rodata instance
> rather than making a copy.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  security/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Seems reasonable, we can easily back this out if we ever need to support
non-const link target strings.  Merged into lsm/dev, thanks.

--
paul-moore.com
