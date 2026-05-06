Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4D4B8DE9;
	Wed,  6 May 2026 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088691; cv=none; b=H7c3lil3JM5KXKioSSZNXo3OKT4iJwHr4XkoSSZgZkKejb7toa5xX/vR2w1pwS8BwK6Mq49X6LCws8VcmzyYUbEHRscHwUs0AWcsguikdnMdrT2oaiYwcJGTZpzK6Y2xyeZOBkORhbNxV/C5XhFqJczg1EBYJXhscAG8R+KhMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088691; c=relaxed/simple;
	bh=09gOH9z89fiGikL7sFb1HYcEIaMz4M52kOWacbyxoZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFekIQvQ0J/dBT177RJVXLExAzfOUGc0lhvbm5yTmZ6dg0Y8XYF0T7rdn2m7RdLovLNtGwuGuX0wnsJIt4sooash0LPx7AmL8GDI977R5Wv0EeVqOMfw1GkWxKng+TKYC1nb9LTZgzeBsyPSEjyEcVpxtD9bz4dj4cUhtVyIpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kUiHFHXK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kUiHFHXK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=76vttDvg4y9AZKkRp0beXp2t/fQ+E1/znFnFmENOgVc=; b=kUiHFHXKSlqIAsgv3Kb5ciVeD1
	uElhnQBj1eOeqT/aU71QAiWY9EmDgq+mbod86oP6lPczCz58GBUyHi5CxRPwuefvnvj9PblcAQKqA
	ccr9wEyghNynBhFKROY+CKkV5fPZa//NwqyV5cv5O+d0kulK7+ZYCqtCiO7KEhtOsa8meGsEEc2Qo
	9ZG7KRtjl10Oi9AGNP2qCfHrZG8GcaDCYOkKNpEgyvzLPGg5frMNBJMDAi1319Cnf0ziAk2ECyf7K
	OG00XZc65LhE/prr9EFdsAIViEEiCZBaUEn2cDQPYubpeK6v5rDhgpjYc0spsROtSgsirSG/KApKe
	7PS0k6UQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKg5h-00000001fK9-2wTI;
	Wed, 06 May 2026 17:31:21 +0000
Message-ID: <14dd9b3a-63ad-4749-ac03-e48be5491dc1@infradead.org>
Date: Wed, 6 May 2026 10:31:21 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: fix typo and formattting in
 security/credentials.rst
To: Mayank Gite <drapl0n@protonmail.com>, Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260506054914.162806-1-drapl0n@protonmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260506054914.162806-1-drapl0n@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 5/5/26 10:49 PM, Mayank Gite wrote:
> - Fixes a typo in "Keys and keyrings" section. Replaces "keying" with
>   "keyring".
> - Updates formatting of keyring types.
> 
> Signed-off-by: Mayank Gite <drapl0n@protonmail.com>

Something (protonmail?) split some lines of your patch so that it
cannot be applied:

patch: **** malformed patch at line 24: tials:

See https://lore.kernel.org/linux-doc/20260506054914.162806-1-drapl0n@protonmail.com/raw

You can see if Documentation/process/email-clients.rst can help you any,
or just do an web search for using Proton mail to send plain text patches,
but using Proton might be difficult (IDK).

> ---
>  Documentation/security/credentials.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> index d0191c8b8060..4996838491b1 100644
> --- a/Documentation/security/credentials.rst
> +++ b/Documentation/security/credentials.rst
> @@ -189,9 +189,9 @@ The Linux kernel supports the following types of credentials:
>       be searched for the desired key.  Each process may subscribe to a number
>       of keyrings:
>  
> -	Per-thread keying
> -	Per-process keyring
> -	Per-session keyring
> +	- Per-thread keyring
> +	- Per-process keyring
> +	- Per-session keyring
>  
>       When a process accesses a key, if not already present, it will normally be
>       cached on one of these keyrings for future accesses to find.

The change itself looks good - if you can find a good way to email it.

thanks.
-- 
~Randy

