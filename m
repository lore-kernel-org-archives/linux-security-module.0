Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506E2FE560
	for <linux-security-module@vger.kernel.org>; Fri, 14 Nov 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112891; cv=none; b=N+sTNtlpmI4Z99dU0Vx6dH33TZcBxUvyjHBvWomHRtDBk7jGg0bQO/io+qr2m0HQH0I9eyBdRAcYteLCtvvTrzy6sv0VO0hhLb1/3QM7DAsulipxgkb9cPB3TvEBXbj3dgMTWKZqVu+jg3ZYbup8npdVonYCuCJJ02KwWrVV37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112891; c=relaxed/simple;
	bh=C8PM7WxuPGZdfL2k/hswcOqc/x9TppYivbKp35Py/N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WImdDGlxxKyl1J2gKVHPpkols8FL2ib/ykzizKK982QPFpRACjeMSjHv3gceLNEUpTazMQqMbyklZzGlh1z6jp5axKvDHJDA72eBP+xULWb1mpWYKV/i/pgs0sp/07Ti9n2rNMGr6WHVG7xs9/pG5CELrkkhGgwInsKy5fmJ+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRVIg1Ih; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRVIg1Ih"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47777000dadso12861465e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 14 Nov 2025 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112888; x=1763717688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIcvV078uJhN54sARrKY1Rqwcca2J3WG/bWTbfWheiQ=;
        b=lRVIg1IhGsjmG62zRqIW0jDcktXfh9q/PpJATyuviAZzYLc8UHQmXvO2YSvaQhWTRl
         noPEUDml0I4cmFggHx4LH9Ygb9LYsmse3lAv2yNe7BHCptZXffV5q54tPu/h4eLqKQ/G
         BBjMRZ377eMLzVyQEPHwOU1a9MkX+qCedmGee7ga2pxB15UCs1SGHcxBiP7aSGdUqcE7
         CIaB1+MzZJtC/XsoPcf6JQcE2E5L/OMX9SAQRR8AgxVjjyyDBOYzwHP5t9ZZ5lPFM5c9
         O3D4oN3c2jsY+XLEQIA2AWaUqwCpWcWJUWr01hLtFFqX7EHi+aNWgpXSkXTLmFh1vFzY
         lRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112888; x=1763717688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIcvV078uJhN54sARrKY1Rqwcca2J3WG/bWTbfWheiQ=;
        b=dd6BfGvJiln+j9zoHllDt7uMoxjtHML/PkLbQL8mJ/Nvlu3Gn2sCebvy1DhB6MRRED
         HIMG9ek0t3VG+ROtaR7uiichpOjOJULEAmdYqFG2HAtf1Zv1QIXIqzcBm95AA/wG4F9e
         awPa8oaEr+1vUjBIR9+AfBgPAqApK2QJTXFYFlWPjh9C6j95U+CA1/3/gnyw13yIv4nc
         gRQTBusJz52bJEwjxFgH4sd7Gar20yYwf5MbhDHX6WslGfiCc2GfTr8B9C7T6+4u4vaO
         qrem6fVVkLq1eI4rCsh2P7MKQvoFw/+pWW383t4dPcvw4EyuVfsxCv6hlIDXm4x/mpeP
         f7hg==
X-Forwarded-Encrypted: i=1; AJvYcCVK7Ch1rg7pV44gaCeLy8LOFh0ptu3F6GMW6OOayQi1TwpnWERAF42mTMNXzel8C8Y0D5X0XKi/09GIwwbqmKs7IdQUtlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxen0NCL63t2DV2D+axL/dYRs+9Ukg2/sj/5CCiK75OXAoL6lya
	0TiKDPvZFYjKM+F3R4rW6tF7AAsAcfPBiNYQgK4AhhG1GG6o7I3PJro7
X-Gm-Gg: ASbGncs2QQB8lfOyjIQ7cidErQXWb3eDBJOhjAv9Zfi8Usx9SDMt8NdW2m7/q6Z+Ehp
	Yt8XIqbrSEoBdPz2ZYu4nF1U//h3QKTeQwrXmZ9YAClcwRa9UidCBAaPyX7c9BRub1cl3C+uQGl
	sgZSDRTlr7oPsdNJd1294DwhLzh4h5fo2IxRAhhqsxijvBuxE92o8sqhGfrCGSBA/OSme+f4Sy+
	nOU5HbI4+y4vxLDBt7tUhQYvdbY+PeLTymV/ZWKrRVsoEyl9UItY1K7xnatMa8hQ64OQCpU4Q4k
	dq8R4dT8tcinRxD/bLbWuNj20nLPLTUoEUffvo0SzHquEYKAL2yGTBtZz1ZCC822zRrZPWaHhz3
	+Kp2UFtgTC6nrcrGqtak02NdH5A0mezazlRAj6RD+6ar5DdJ1dkW4ZI0Wk3epOAFOu3t5cZCwLL
	NcpKHioSuZsLIzcKGxc4keaqasi39JO4/Mt4qGPjxug/N0GYm6vo6L
X-Google-Smtp-Source: AGHT+IHMhMM/WcqOC+40/CZXzxi+sVHMlKI3vfKumXj5CG2qbmIl/AdQzRU5H/oZ2Xbc89Ibz5CWGw==
X-Received: by 2002:a05:600c:a44:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-4778fe69cb3mr22853755e9.10.1763112887580;
        Fri, 14 Nov 2025 01:34:47 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6a1sm131781785e9.11.2025.11.14.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:34:47 -0800 (PST)
Date: Fri, 14 Nov 2025 09:34:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: encrypted: Replace deprecated strcpy and
 improve get_derived_key
Message-ID: <20251114093445.0ec74428@pumpkin>
In-Reply-To: <20251113215546.136145-1-thorsten.blum@linux.dev>
References: <20251113215546.136145-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 22:55:45 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> strcpy() is deprecated; use the safer strscpy() and use its return
> value, the number of bytes copied, instead of calling strlen() on the
> destination buffer again. String truncation can be ignored since
> 'derived_buf' is guaranteed to be large enough.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Revert some changes to include the trailing '\0' even if key_type == 0
>   since this would change the bytes passed to sha256() (Eric Biggers)
> - Use strscpy() and its return value instead
> - Link to v1: https://lore.kernel.org/lkml/20251113135831.98587-1-thorsten.blum@linux.dev/
> ---
>  security/keys/encrypted-keys/encrypted.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 15841466b5d4..94408909f1dd 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/uaccess.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -330,23 +331,17 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
>  			   const u8 *master_key, size_t master_keylen)
>  {
>  	u8 *derived_buf;
> -	unsigned int derived_buf_len;
> -
> -	derived_buf_len = strlen("AUTH_KEY") + 1 + master_keylen;
> -	if (derived_buf_len < HASH_SIZE)
> -		derived_buf_len = HASH_SIZE;
> +	size_t derived_buf_len;
> +	const char *key_name;
> +	ssize_t len;
>  
> +	derived_buf_len = max(strlen("AUTH_KEY") + 1 + master_keylen, HASH_SIZE);
>  	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
>  	if (!derived_buf)
>  		return -ENOMEM;
> -
> -	if (key_type)
> -		strcpy(derived_buf, "AUTH_KEY");
> -	else
> -		strcpy(derived_buf, "ENC_KEY");
> -
> -	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
> -	       master_keylen);
> +	key_name = key_type ? "AUTH_KEY" : "ENC_KEY";
> +	len = strscpy(derived_buf, key_name, derived_buf_len);
> +	memcpy(derived_buf + len + 1, master_key, master_keylen);
>  	sha256(derived_buf, derived_buf_len, derived_key);

I'm not sure this is an improvement, but has this code ever been correct?
The buffer passed to sha256 is either:
	"AUTH_KEY"'\0'master_key
or
	"ENC_KEY"'\0'master_key
For short master_key the buffer is HASH_SIZE bytes and padded with zeros (ok).
However for long master_key the length is calculated using "AUTH_KEY" so
there is an additional trailing '\0' in the "ENC_KEY" case.

	David



>  	kfree_sensitive(derived_buf);
>  	return 0;

