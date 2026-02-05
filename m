Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB63348445
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277950; cv=none; b=P31jKOlHNNqdg9+BEzHe9Q+32ASM/fQ5q0h2RNIqONK1aXKOfFpRM+KfmX0CNCx5QDsUFjpyGYReTtJaUWjxr1t+FYNJ/UJqS1eeG3lSQGjtay7QBqiXZN/Z4dwXzfJBX6XKL/CIrGiMsWJY7OloXVTyQcmavJqYazjGvk+INoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277950; c=relaxed/simple;
	bh=4pSKhJ+3eJctAUwYfJpqArHj2F5XgMq78rnXTgHvJ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ti4Sv/jiSLNH/mQBCHUuYbqWsUCv1tk3nR3VTDVuPMvbTp+ucxZhkn6bERy5qMyd8SE/L3s8HiEOJTb0guowh98VsnEDvEJTrv0LiWXWwXIll1Qa/do6+4ZXzLJO8wDvLp5rKegBnE01QwhvDfcW73B2ErAqAUvy31CRsbUBDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=JPd13e7v; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="JPd13e7v"
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1752A3FE1C
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 07:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1770277948;
	bh=8XVw416Or0rmn+GcjrsK44eO0KMyp4QJc/ScUi5E7kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=JPd13e7vfWx/TUd+zmfI2FXfOA8XtG+/KvDI7q/B03SkOuMzQ6Edpc+3nxqJWlZff
	 uMemR9niDeEYD16S/XSHBgAVTp+Wg4u55qrIzDjekXd0gm5YVSEFWtQYO6RpYhkPsA
	 DRpkBntus+KisFrtS6siN9Cxv4wrTmxiTDG0iWc/b95xoMJXa0GaJKsgNQTWLSWJvG
	 sBjC7S9S7Tx78MGb3E5AE/953GcIhtxv+VI56xzJtupXFG6r13/c2bPgbzcwSlMkRC
	 aXHC97opzmlO+qasxTORpIU5Te5g4sih/2SaNCNoFGi1d5qOsPEXcgFurAA72d0AG2
	 0AXfyLJTrw4CgofZyDw2M3p+pr8yjp+V8V+V60prbMffXY4KyvnTvSJSU0oEA1Hlzz
	 78ptJOAgicbc8V3Kn+4EovpLOwvPjUxNJH0JXVMB9R8saPFdz2Xv6GKcyG7PHiu0Hn
	 ucJ7uDZEh1HJXCbaXCInLYv7atrvaagpKs5jEAnp12XCG5hN8yjAQKv5MZshvlcuLL
	 7tPsSqHGl2rzMIpyTYdqjONjmf//tknmS3PHA34VShOOBOO4oO2Fz4/uskYSv01LMM
	 nWsvamr61hSyja2BVj2RoFLZPYrAliYL+iHxQYkxzwmMugFOj6ZFIt8kqebIiAApbG
	 641QP8iZnVeC3Ap+TKcAsx1k=
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f39ad0d82so1345344b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Feb 2026 23:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277946; x=1770882746;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XVw416Or0rmn+GcjrsK44eO0KMyp4QJc/ScUi5E7kw=;
        b=Kx2W5KvMMnXn6RH5eNl3HTz2kz0RgKZHf3mCiiVZ4UtjmHw+xHl2ZCwdgcjCaDdIjL
         UjSXTroAuCDihhQt5KfaCWZXOYGOl89meyQwG0JGrYW0nCr71J3ABWfmBMWXJYH7jC7w
         ncyZax7K4v+GTN1xXF7z0E8EhsJhk3A+8lrEBkMVnB42/5KdU4uCCkgjCIx0/93g+zSb
         EnnS+qUETjFoyGCvI7KQPe8B+UcPoPgm3fDgnwE16fV9pfSE5RopxuisXzD6NJ5J0hkw
         8WW4oRNIY0lc4b29MgO5dvzsKYoUJHTKDdzbN24l82Tr3kgWNlSYJUl66EvKEWCjxZel
         NMWA==
X-Forwarded-Encrypted: i=1; AJvYcCX4TREXbF8GTh+5CIedbxHOrA8lNY4JA6mLju/9fSwUFgbYyYi33oZvtL7kRVJDm2dV2x2E3W38kQ16ZSkP5DPnZ2UflrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBreeQWbvTFvIG8efJwRPt/WGcS51TLzIiOEabQkeFqc4WbF1
	GTBOTRXSZ6H6oL62IpTz6nQmpwiiAmukZ48pU0ITQKkDAfdKNzLVjIl1e5kJR5Hqnz8e8lYT6aq
	mm5FKaLw1Ax2XM2Oa9Nzq2sis9lRgV43dmIRPfJ5qoM/PKgrdFV4NKu9Ic/redEfRMOfYc1txHq
	P6zuIsu/Zh27AJJlIVX8uW0rgTwA==
X-Gm-Gg: AZuq6aJPpbfWHrZ28aXEnShxKNQ1O6khdp248dAoFVgKkIjF4gS9OncxZ9hwQql8SuW
	7r+bRjuauK5/ds+pSWCuxbUuZpAW9FwU8hkn2my2ZvVq2AbSGsCR/VaXOms6qFrSa94NdgOblnO
	YfI79gc8+5YjFEs9dQ4Nt3u6+JBOU5bFMyn6ptxS6e6E70X39eF+ZVilzxT2LVzq4yBxRfzKfjJ
	TlxDSaOUpsoidvqrSeq2QCv5NjDqn6pI7qpcypZUF1enC1cS/cQKBKyXqH2NfzkAZ/kCdTiHlIy
	LOmx96ofa56OEJOYU4fpqdtjvi1sMWO4QHYFbmo/mCJEgh63ZlmzTKTzjA9VPk6vrylpO/fNgNx
	zyJV2fLMsaRX4AlZIscpFmHQ4
X-Received: by 2002:a05:6a00:140e:b0:81f:517a:56e7 with SMTP id d2e1a72fcca58-8241c1f5201mr6197896b3a.30.1770277946431;
        Wed, 04 Feb 2026 23:52:26 -0800 (PST)
X-Received: by 2002:a05:6a00:140e:b0:81f:517a:56e7 with SMTP id d2e1a72fcca58-8241c1f5201mr6197877b3a.30.1770277946089;
        Wed, 04 Feb 2026 23:52:26 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8241d4abb49sm4223025b3a.64.2026.02.04.23.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:52:25 -0800 (PST)
Message-ID: <921bdec9-e5bb-4d16-955d-beefc9958d58@canonical.com>
Date: Wed, 4 Feb 2026 23:52:24 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: replace strcpy with strscpy
To: Ryan Foster <foster.ryan.r@gmail.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120145024.261806-1-foster.ryan.r@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260120145024.261806-1-foster.ryan.r@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/26 06:50, Ryan Foster wrote:
> Found by checkpatch. Replace strcpy() with strscpy() for safer
> string handling per KSPP recommendations.
> 
> Two changes:
> - apparmorfs.c: gen_symlink_name() uses tracked buffer size
> - lib.c: aa_policy_init() uses exact allocation size
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>

this collides with two different patches I previously pulled in

1c90ed1f14c98 apparmor: Replace deprecated strcpy with memcpy in gen_symlink_name
b31d3f7385fbb apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init

if you want to refresh this, I will look at pulling it in


> ---
>   security/apparmor/apparmorfs.c | 2 +-
>   security/apparmor/lib.c        | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 907bd2667e28..f38974231df2 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1614,7 +1614,7 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
>   		return ERR_PTR(-ENOMEM);
>   
>   	for (; depth > 0; depth--) {
> -		strcpy(s, "../../");
> +		strscpy(s, "../../", size);
>   		s += 6;
>   		size -= 6;
>   	}
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index 82dbb97ad406..7cb393f91a10 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -487,7 +487,7 @@ bool aa_policy_init(struct aa_policy *policy, const char *prefix,
>   	} else {
>   		hname = aa_str_alloc(strlen(name) + 1, gfp);
>   		if (hname)
> -			strcpy(hname, name);
> +			strscpy(hname, name, strlen(name) + 1);
>   	}
>   	if (!hname)
>   		return false;

