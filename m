Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9B19AA4E
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706885; cv=none; b=dQSj3T9nO8FpKoPSEHMy4cOYBby6onxaiRuIjnzyhivpP6gtNugcki9tJZ0O8XQIj0ZTsYPbN8vgwbt6rfG1QMZBzTfsRT7U60+KloA9heT8plhhjvc4CC9lzQpvcnFvyKo43k2NLrBq2n6Gpwrs7Fq276rWNFVQ8alm6VqJZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706885; c=relaxed/simple;
	bh=yBQ5y+Mb/CKBn/Iu+oeyfy0yTYtT35Q0Pi8FqyJi4Ds=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=C7vNFTS6EqdwUZvaMaTEIa45+fw3TO2CG2PUUJPYsEeznJZ/gIfoyCppQPDq3NL4UVpfE66e6EmFxYebGMRu46bhZwq7nM66XMQNy71gbE8ZfR0UTeH4aQC2k7PzmQgQCfMfVMyyGvYCa7wjZy5X5J6JazoUnA46UHQQTHu+bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FenU7q1Y; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FenU7q1Y"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a2264e907so881693276.2
        for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724706882; x=1725311682; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OfqvTXWrFldpunr+TQo/yeqa5OS+oEjv/nJw1AhDV/M=;
        b=FenU7q1Yw8t+4WiKBZThmfET6KwI2suyOv6R/XgPPEVyJ+nI/oj10zNY7xEzs6EUeI
         bT84tQy/ErWs5VFjmbYc2GMACE7aFy5OjpoBn2PcclkE3gRGoRu9C1qTGGmkcu+UpxyM
         cJZBMAuxH+OTbcKZk3Ind0+fw8+DmvMr5FhBbP43tx6JWPLUS8gtyWh6tyCEnnIYkj17
         3MZ4a6dsyYdCRQF1P8BsCI4zKJm4m9aldAz/p2Dd/gYclfDfKyOj00skTZVP7Xa6CmCb
         SCSBTp8xZgm7kk4uMKyO47TfPwGJgDS3DLBGdS39W/gW3tgq+5l2m2UsrYgh+7p0d78W
         rqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706882; x=1725311682;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfqvTXWrFldpunr+TQo/yeqa5OS+oEjv/nJw1AhDV/M=;
        b=TJnLgLNczdXIkLalwx2DuLBoP5ZJJPlwJ9Iu9CUA/TIwpPDAlMNZnCrHQohaeV46uc
         JdD4vnxHN2jntmhi5UhJnh+BNk+DI+5sVb7kjfyQKD0f8VJsK32ZcH/0tPygdq9aOXis
         0SzkRUHz+bOXu84U7StE1GErWr/XCqPV0U1r7rwdWScepUhZGXWqWGEvHR0y5ZmO5Vd7
         ak3Xc3Ef55wbgacdCq4TSyUuABYWKS3GHKNzt+oZWTPNoBrG6PHM00VEKTMbGaBWkNpU
         EX/+61KbZAtPxrYUhT8Y3iDfojSEhT0a2glAgiYWLkIBBPViWSXGanABIS6kPaps4Y8b
         LCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuj+tM/5hd30EKPasoR/GSPRVaVLaumfQh8EWKiyfPla8jD4gpCHq19LUaDMFFY0xG6bTQlpseHl4DOuTVu3aKLDyOttA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaeapojtFzn0aKxy90AMhnxzHk9M7l3U8PFFg942jg+N7YgxMO
	sn3L4udCOsaLK+k7e/QMU024UYoKjBgnJWnKCr8S8FUfVsn7BawRWQZ4PQRSrw==
X-Google-Smtp-Source: AGHT+IEbYWdr5Hnl4ZVk1T1sAYpHTMGnsK6xf7bfqR4BRfFMeNhZqzWNrEjRK6NPwcMTOvklx7UWzw==
X-Received: by 2002:a05:6902:144e:b0:e11:7a26:29a with SMTP id 3f1490d57ef6-e17a8add737mr13085054276.1.1724706882186;
        Mon, 26 Aug 2024 14:14:42 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd3a4sm49877986d6.113.2024.08.26.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:14:41 -0700 (PDT)
Date: Mon, 26 Aug 2024 17:14:41 -0400
Message-ID: <3447459d08dd7ebb58972129cddf1c44@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-security-module@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 2/2] selinux: move genheaders to security/selinux/
References: <20240809122007.1220219-3-masahiroy@kernel.org>
In-Reply-To: <20240809122007.1220219-3-masahiroy@kernel.org>

On Aug  9, 2024 Masahiro Yamada <masahiroy@kernel.org> wrote:
> 
> This tool is only used in security/selinux/Makefile.
> 
> There is no reason to keep it under scripts/.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  scripts/remove-stale-files                                 | 3 +++
>  scripts/selinux/Makefile                                   | 2 +-
>  scripts/selinux/genheaders/.gitignore                      | 2 --
>  scripts/selinux/genheaders/Makefile                        | 3 ---
>  security/selinux/.gitignore                                | 1 +
>  security/selinux/Makefile                                  | 7 +++++--
>  .../selinux/genheaders => security/selinux}/genheaders.c   | 0
>  7 files changed, 10 insertions(+), 8 deletions(-)
>  delete mode 100644 scripts/selinux/genheaders/.gitignore
>  delete mode 100644 scripts/selinux/genheaders/Makefile
>  rename {scripts/selinux/genheaders => security/selinux}/genheaders.c (100%)

As long as there is no harm in keeping genheaders under scripts/selinux,
and based on your cover letter it would appear that there is no problem
with the current location, I would prefer to keep it where it currently
lives.

--
paul-moore.com
