Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFED2E8B7A
	for <linux-security-module@vger.kernel.org>; Thu,  6 Nov 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440864; cv=none; b=Qmvo2w4FFZKeIatZqJyHrCI5wdmY2cZXcVpiCIY+03kd6/h+Obqz+54suuVmEKLSmNjUF/oIm1MuxURAD2Z12kkb2AoHYTqmd4iU1d6TeBjlQ4ohVDq778h4FuFmE64lA6ogyLz4VyrbBGdPSdYPzX7MQXBZHEjX/+RmfOoWJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440864; c=relaxed/simple;
	bh=ozOcgMxD/NRKJQrmMTIroO6F4bQ2Qn4kHa/gDXh91fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xlvf7nVAB/lBN3WGX06VVVP8DnQijHcuQyUVCszCsLEpK3npORXPCdRTGmbFP4ObTYlFQmwnHv1xY0ql/sJMV/2r3Tx2frWvMLindatv1RGpsZi7r3j1sbCoXKLiZItVbpXPkb7PKAXQJKZES+wTXGRT6Ug5q2OCXU5AkB15q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZTfUjg83; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZTfUjg83"
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7A25A3F91E
	for <linux-security-module@vger.kernel.org>; Thu,  6 Nov 2025 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1762440854;
	bh=AeJV8PctFSZqeTwM/Nu1W1BbU7+ROG2OVp5zv88vYO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ZTfUjg83/DWLDKivva1BNDL1hm5G4IWJi4/+w4wH9HwJW0yJqd6QNg8H9KvU1EQnB
	 4UinSWiJY54YP62RmKC7ItcoOSu6wpfv30YA7F/qHOiwiDv/KhxL9HEuXaKh4gZV1u
	 MJhH5b9OJxMvXHQsdI5n/1EPPBJ7yT1xm6eJwYyrA964bM76hQEUAXGoP7dJ3tdv8f
	 yuzklWGXJel4rJY59dtK0lRuVIrP8EIzTrsUW/5/c2sbIrZaz7uttXsw3NQAUYAEWf
	 kgATJVCg4QagclMmxP3YMwCgD4/zi2QZ0fQrGebRTRmT9SDZ5uE1r+M1LXd7GKbBXS
	 c5pEkA4wjo+Os6Y+9MiLTFvp637OkwcAy7Z3+Ubem1jM5N93nMsmTHc8UnvOZT1DM5
	 v4K1v0v116ttI/9XVSgAL8RIvxz5CPfyxVoG8/1bCPdPtTRmaJuSE7RYhGq5zSqIAc
	 Ud4lX3AP00RgNsJ6KO9DsAXD4I6aSHONDAsScGlCcj9Lhex4ehuK7VoVvo2SvPzAn+
	 1rmxzXYfiwTp7wtgJzvSyl/ruz9tqpzQH1kQfo9b9u0/coe65tBOg5nZWhvmpE+9ci
	 dh4yx/yw8WFw9vkZs1wfBjcrkqG7ZEsrk9W0gM1Sj34lRawp20NAIdZQKCKKN88joq
	 +/sJksID9gZgiyRX5QllqJEs=
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5942a78fbccso679429e87.2
        for <linux-security-module@vger.kernel.org>; Thu, 06 Nov 2025 06:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440853; x=1763045653;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJV8PctFSZqeTwM/Nu1W1BbU7+ROG2OVp5zv88vYO8=;
        b=oiZvoJ3AJgxYnr5nWLZ0pT8aJFkW7VP0NpQajYcBotDK1Ef6RsqL/fgfofvaGwH/Lk
         pU2pYvZl/sD+5efNdMh7h7gyyhDZQmjjbIgAq+wjzX55qfr7j8aiDNjPk7MHgS/xsL6M
         Kwd+dVJM4J2ssgc8upI74WuGUfsUxrvGmlFbDx387aiUAqzrTid0eLOsrQZUJZu0CtL0
         w6ZUcHDERkeGgEWRCYoaQJWaGndKO+SXxRVesmsFM8bEkgsb3PjIn+W0T2Z7eYC63c74
         k8n2lYtPL+oD96sjoObWmTQ0wEK6IIMan3JoHOMBi2dB3+rC/BWqc7aBLRDPgZbvJgrx
         2Mtg==
X-Forwarded-Encrypted: i=1; AJvYcCUeLb//tvKt1k7goVVc5l4Y8rsXt3ZPI3hEj8QY+bSJyoC+hZVEmVT42FYWI34Up3D8hkXtD5eRCaDNAo+9DdQOH8fnJqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADrBFbWPUK42JTu0Y1ZKFgXAQTjwbpHt0jmk3SrQ1+GWW1NEX
	Kk437HG24CqwX4Fg/x1sjujdJN46oz62TGEdNj7GPvv5WmUBeZCKboMykqBB6VmZq5yN8dzNx/K
	JJ87JTD8mwacxjdLWylq3245BhcXzHiYAV5p6QCDthrirWPa1H1WHa7eqrFLZ9/t64pADEFyPG3
	3W4B34HAPzZCocCjOfcQ==
X-Gm-Gg: ASbGncvtdlygDETuUz6RiHbLApldHf2iLCNmyWhYvWmV3YT/6EFfG1s0IIJE8jK+rnZ
	EM0qQ2EKQVb9E1d4n81slbfwH80yxFbfr2Lb5vf5TOdHEMDNTw4MUBwLWONEM8PiD5t6C4D9kPW
	cV6H27IAQyRoNTs/h/WuP/a7SrHHmvBOuDTZjIdgWayceQGDCwwr5HjVZhhhcJfHn2kPHg/JtS3
	wzFZZcvs79+eiITszxoZhAiaSXhnJIjYz2pG3iMvJigUiFu88ym5qbie+DLqVd4xuEBjti6jmvn
	Zd4loFA8wwk/sDJZjgVnzSW5ntKQh5jklH8BtWqdV4MCjKFmpXGDfZsrWAIQc/kXTAyiyRoppDX
	Gfh5s++CdLK3KK/kXjMtITxD6l1GjdVvCMQ==
X-Received: by 2002:a05:6512:61a1:b0:563:2efc:dea7 with SMTP id 2adb3069b0e04-5943d7c9126mr2591530e87.34.1762440853565;
        Thu, 06 Nov 2025 06:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkya0pNrMU6ObtM5yVc6w7wtXddBoJJXH84XUOtreiOgT24KGL2kymBLvJ1zbA5T8rX5+9bg==
X-Received: by 2002:a05:6512:61a1:b0:563:2efc:dea7 with SMTP id 2adb3069b0e04-5943d7c9126mr2591517e87.34.1762440853104;
        Thu, 06 Nov 2025 06:54:13 -0800 (PST)
Received: from [10.207.66.60] ([93.94.208.159])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5944a5a0d0asm758572e87.111.2025.11.06.06.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:54:12 -0800 (PST)
Message-ID: <f169ae3a-d50d-4eb3-a977-bb16270527bd@canonical.com>
Date: Thu, 6 Nov 2025 06:54:11 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Replace deprecated strcpy in
 d_namespace_path
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251106145138.2123-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20251106145138.2123-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 06:51, Thorsten Blum wrote:
> strcpy() is deprecated; replace it with a direct '/' assignment. The
> buffer is already NUL-terminated, so there is no need to copy an
> additional NUL terminator as strcpy() did.
> 
> Update the comment and add the local variable 'is_root' for clarity.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

hey Thorsten,

sorry I have just been swamped, and traveling, ...
I will start on the patch backlog tonight

> ---
>   security/apparmor/path.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/path.c b/security/apparmor/path.c
> index d6c74c357ffd..65a0ca5cc1bd 100644
> --- a/security/apparmor/path.c
> +++ b/security/apparmor/path.c
> @@ -164,12 +164,15 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
>   	}
>   
>   out:
> -	/*
> -	 * Append "/" to the pathname.  The root directory is a special
> -	 * case; it already ends in slash.
> +	/* Append "/" to directory paths, except for root "/" which
> +	 * already ends in a slash.
>   	 */
> -	if (!error && isdir && ((*name)[1] != '\0' || (*name)[0] != '/'))
> -		strcpy(&buf[aa_g_path_max - 2], "/");
> +	if (!error && isdir) {
> +		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
> +
> +		if (!is_root)
> +			buf[aa_g_path_max - 2] = '/';
> +	}
>   
>   	return error;
>   }

