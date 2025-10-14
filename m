Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFF30DD35
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483580; cv=none; b=obHZ/E0uoNPiKpEci8p204mEhR43gN/mYs2SD6dopU3fDrykwfwyH/0g1STouN+1bDAaa3l+wPLBa9X+fm7un0BcHBDqnyxI0YHAm8+zh2BldO59a6IL7K5E6t2RsU4s3MaZG+42GHqEY9G1SfeLXTAZsaT9PXQcjYj2DIHwc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483580; c=relaxed/simple;
	bh=foCmb5W6RClH11/V4qgET2I1gpQvWp/PxyJHOlaDdN0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=W7za+VjzEjBaIBNvl4E9CvuZpCCf2L+Cn0a9U26y/WlkwXYQRrdbDtI32esKIVIAu8ejaLOqAt4Ms6Klr/5Mcw/7NpzoH2C4Mfju1OrabbGUaZgTpgnODwgadsXS6ZTFd0tWxFokj1SSZFsSV2TqHAZiGWGZ5CrxiE8AE1RDAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JcC2BVJW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JcC2BVJW"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so102452676d6.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483577; x=1761088377; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCQPp9bQbyUFc7xAWYe06+PCP6ZWoD05DYNG/yuCCoo=;
        b=JcC2BVJWB+k4XJtYAQ3oxVa7LBs3f26l0KvoTmYXnPDALttk+EAEPRYVYECeZWpwhA
         EdZFYSfs1n9bWXaBkOohlzSBXQajTzI8iO9g1iGUyfKyfBSX1LWBtSSNBiCSEzz5HCzJ
         ws6/77urM6Qds3IBoseQX7jzma8Gw6o2BXt9DG1WbaGqJnfwnIlJFA0HLzO8Lz+jWTrD
         wzJRMCCNbBIeLzOizK15UVaIIxc4/UGZtaZRyCS6LZHjaKmMxf5Xi0JhreKxeEnOdiIs
         GL058QVAfIqM3ZuYNOeYJ7zMe/TxudAjQ1ZcyUAbfcYHw1WL40/7GYnoj6eu16eOIoMj
         La+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483577; x=1761088377;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UCQPp9bQbyUFc7xAWYe06+PCP6ZWoD05DYNG/yuCCoo=;
        b=H9R6SPNc6fMefYCYeG8tm7mVs93K7BFa2+STSS8GmuCfn4XhT5L5u1k2vUQbxlRcB4
         f3PO2DBIJwM9s1dNilLxUNVpWZcv4m/saA4Zj6af4NErf0UY8m5RpMxHFcHPL3yRQtf4
         5jyS9Z7dvpe7IlLi9zbYLJEcIQ5y1WfETvGIcZzu3qD9tO++MrZ23AgY3NH03bSvvi5G
         +EDCLyjkH4iCNf6VTM5xTEL0rXRgKbOAYwS0AJuQSElrx3DlO4wTXHRy8vbxaPiNFupm
         Owalt8W+5PvCe/KW2GDrnFYfVSEaDBG1oqG2kQYps2TKox0t5u/JL43e5HVIcYjdsZW0
         bKIA==
X-Forwarded-Encrypted: i=1; AJvYcCUnyzqzDB+xhxFToxkHiu/VP3GN8+0+zcRgBtEwrUBY/IPNN0ARJ5ngrD2S2MgQRRQcv4bSJSXNorA6GfguV25B/u65djo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRr9WECSouZYDY0i6rwTtC3PD4GGRIde2SiPpuGULM0S+XUuRT
	vFrkkDCKzl4wrxFksjx1EygYNKandPYoIUSKqf5/TyPRYvYh6XTYKqKHGja/dMvGdw==
X-Gm-Gg: ASbGncsgroqoyOyf1pLdpHOXDwAam+9/cTPtcIJaUGjNOIf8s15DYhrG0Ig9mWHoxAM
	NSDy9nJPrR9RfmTpTFE0eYhP6WYR3dJwYJ5KTXKc6XbS7sDGW0FeIZDzvFEjAP1p8t/KnFMxMkT
	hRuRe2qTdvV7ZUYQzFd44INvwsjPK7cDoEpCYlUoe5nWXM/+Aujc8lfUTrwjn4oXqDaxY7HWrP8
	xKBSEvQm37WEiBM3BVN7zXdAepvXec0ixFosIhRBqqtMpbZuPgoxu2fGcNAPKy1KILqh2Mf0pFT
	+dbGs3XPgUrxUh81tuUAkgBxVP3bTOarVR9nYylJ1j6CFBhvM4pTVymRfVOExnHrzPIgyTEvXhM
	FJkrlmlcU6O2VXekvUUtlR4HbxciLWukmUBpgzOF6qjt3U9ENcYofwNPMKenye3qGXohRB/IEVC
	tyK6KHXw6yMdMtB9/tXYOVoQ==
X-Google-Smtp-Source: AGHT+IGUK4+OZlOwx7+K3DolpHpg4wxF5PDVeFNt2hgjjeQNdw27tz2rjbFhf9h3RN6vn6hAUsmJqQ==
X-Received: by 2002:a05:6214:1bcf:b0:80e:9291:c47f with SMTP id 6a1803df08f44-87b2e768f91mr379237516d6.44.1760483576981;
        Tue, 14 Oct 2025 16:12:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a2c6dsm7233906d6.46.2025.10.14.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:55 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:55 -0400
Message-ID: <3aa966ae48394feec053a63c8868ca0a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 10/15] LSM: allocate mnt_opts blobs instead of module  specific data
References: <20250621171851.5869-11-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-11-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace allocations of LSM specific mount data with the
> shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  security/security.c        | 12 ++++++++++++
>  security/selinux/hooks.c   | 10 +++++++---
>  security/smack/smack_lsm.c |  4 ++--
>  4 files changed, 22 insertions(+), 5 deletions(-)

We discussed the concepts in this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com
