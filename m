Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE93A1689;
	Fri, 15 May 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854257; cv=none; b=IpFAk4PrtPr63lRlt8P+VQxcyak5eCsXwevKKUUNzXfPXhtmRHNHFNweMSWjrgBWUdJeQj3c0pG6OMHhsmnB/WGyhyAQZ0x5L+rxO2A3BOPnhefwwC2NmcAVgEEXgwE1QjjzSc10gL50mMhi7MiNZ/rKmTGYeRqCDBWVLC7Jf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854257; c=relaxed/simple;
	bh=EQLmR9lH/s6dARjpwZGuJLeUc9GM540ebrSZ+TD6hcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lIGzwnXLul+ri18opPrXaVNC25nHbt9VRSjgjCphSlatJpVfO4VV55cLEhtfAZjeX2NoklxPr+C1oL4Aa3WcZn/xgoIErxm1eelgulJju0eZMVVYY6KtA2G2U6uj1oQuDqLoXIhH52/SYnuUdOo4MtsGZoLVFLRmCJnBEZel1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=K4oHDP2G; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="K4oHDP2G"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 48917410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1778854255; bh=bVqun54WR3LQmTHYOXAJ0pTNA8u/mahb9rRj+Rlq01I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K4oHDP2GkNYOve9VADr6tn/QlJ9CYkddH2YxDOhDpBbadOkR8KNWxjYU3k6s024JZ
	 0uDXbGyn/qihVQNslAw0R5oGQmYyR9BBNn/VoUX6qPlvaoJbyIax8cATQQBJN7/v8m
	 Vlfd8X/DI6M6kknKn4yCN9qJxTP/ttReGyo9Bgudz2jmKU6F7W4RIkE3N18oLKlv1k
	 rDFXHTSALctePschHXz01BTgr9ERIuTG1GsGz81VOeRMwT0EbOkDaxl4lI/3tYyer+
	 oz69/l+7r877RLbmEimgB6beBAMHd96jC/xrpRZc4u0E5yS+VV9rFY+vpttADSFdQF
	 aipQj0c/c2vbA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 48917410B5;
	Fri, 15 May 2026 14:10:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mayank Gite <drapl0n.kernel@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: Mayank Gite <drapl0n.kernel@gmail.com>, Serge Hallyn
 <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typo and formattting in
 security/credentials.rst
In-Reply-To: <20260506225925.271163-1-drapl0n.kernel@gmail.com>
References: <20260506225925.271163-1-drapl0n.kernel@gmail.com>
Date: Fri, 15 May 2026 08:10:54 -0600
Message-ID: <87v7corcep.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mayank Gite <drapl0n.kernel@gmail.com> writes:

> - Fixes a typo in "Keys and keyrings" section. Replaces "keying" with
>   "keyring".
> - Updates formatting of keyring types.
>
> Signed-off-by: Mayank Gite <drapl0n.kernel@gmail.com>
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
Applied, thanks.

jon
