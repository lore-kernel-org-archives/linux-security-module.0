Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0613E02A;
	Thu,  7 May 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114219; cv=none; b=Y7mkeBZqFtL2XsgKcG2pWHpLc9xDQt6OSYAi9H2IebCsLTZEF3JVGT7X+XboQeMM7lDieQztM6AxAKaDYg03MMoVRomIdhQgGqUIYc29aBse5QAqhPWfUx735ID2BSQu1+dym+MbiX4NtKMOkWKpf3dDoXWDXbbskRqLBPM1by4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114219; c=relaxed/simple;
	bh=2mf3CcnBl18LTaPH8e70yP+/ny9Qrcdmfd8nqvoT8dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOuUj3l0f+iFDdG68urzf0kyfJWzX3r5Gg0MT9Z+B05HAmq5HyOLNbfnfvF4B0wDAgIobQPM1lpmEaaBAkrJshxFi5D/f5kNaxSYFLG1+Lmq+CWjM5NnVcPwPHECXB0bpgdKfxqACBd17+0Dd2org87QAxApsT/GRsGy4ieCrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fy8Z5Gf5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fy8Z5Gf5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+HLDzwqgSW3GcJGGHTImbu5kzAPpLvoPFv1J1HDRrKA=; b=Fy8Z5Gf5iLUiwx3k4zsjGO/2zL
	DmjdJdeEv+JTUY7HAHDM/1TOaWRcy+hVqk/3N1RTWdP3SVBYiZwQxkBWhw7wYX5Dwlll7HwZCWxAs
	mSRF03J6nDsGUZ1YhKK/ghcGD8GXCHNUL0FdtdnysDhhVpfTtrxP1g/3OwMErIbhAavXkFmLFAZwc
	o+5pwsBsi+E9puhzuK3gW+d+vD2joPxa3iooZhUWe6hIanA8/tnFb/oRacRI5GTocVV/ozbZcmGy1
	6ZmdudgKe91eFek1/AuK+4cprjPOLRwRA4Hpwbp0PVxPuuUKD9YViGPMFkZDqdQHpQV2jWZByxvsp
	d6Dx4GQg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKmjW-00000002MXy-0XLd;
	Thu, 07 May 2026 00:36:54 +0000
Message-ID: <cbe6e145-9d2f-47bb-8d22-1599cfd1a9d4@infradead.org>
Date: Wed, 6 May 2026 17:36:53 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: fix typo and formattting in
 security/credentials.rst
To: Mayank Gite <drapl0n.kernel@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260506225925.271163-1-drapl0n.kernel@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260506225925.271163-1-drapl0n.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/6/26 3:59 PM, Mayank Gite wrote:
> - Fixes a typo in "Keys and keyrings" section. Replaces "keying" with
>   "keyring".
> - Updates formatting of keyring types.
> 
> Signed-off-by: Mayank Gite <drapl0n.kernel@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
In the future, right here, after that "---" line, it should say
something like

v2: use 'git send-email' so that that patch isn't corrupted

and in the Subject: it should say
[PATCH v2] ...

Thanks.

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

-- 
~Randy
