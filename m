Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4C31326B
	for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045645; cv=none; b=tJICwjLSonxlKkQtJNBcav8jepV7fW9xyhp4AQd0X8dYHuvAw9HIwTgSenD4A2VtCT6Zi5MN4yna+MoiU9E8PknIZrq+MW9hyjZ0X6qp3Tz4eQ1dskhrSA0g2TGCH4e7yNMLdLjPfoG7WnBHytkIy6pFot3U2EU+tNIBIYp0e9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045645; c=relaxed/simple;
	bh=IYfNgJtBQ6RbPAHveRA9XcmzjH3CHVpWjJuPVOZDjb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hykbgnh8XN5yolhlyY7yXI56MO3jYO11xB5zm/XU2pducNO85Q/YeADjDqAojPHSC5qwpnGCfdSdSQ3/QBfR9SaSH0i5uZyntkjlBnrm+TGt6CqRAS3r6TDw/vwTE1vCnxjpVLmnVT2XfUqLAXDi1otmULr9o/kA1P6ISa1nmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM3F5sqB; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM3F5sqB"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso780225e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 10:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045641; x=1772650441; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m0v9eecdrDlKKkRsI8AJc9LWKKGXVn/oxr4SUBFzAKY=;
        b=XM3F5sqBj50+0X5mw+JusqQTCwHKXeJFBn/xTlz+o+F+mAmprSAJxoIlo/fMqYMEml
         wcL/r/crRzJnH0E5V4tZAXWpODV9KCTTJ3BxM4wmyfrE3BvJb42EHuyhSh7Ho4DnFTkW
         xJocbFNoRvhYuzGMGWQob5jokv8Muue1XhROJjPYPh3OkGyGzxjNHb1V2g8cDlulspVS
         YWJ1trXhV9TAlCZXtdhE6RkHXXUkzTJqw9B/8XBH7pwbq2JeEh5S9oXJjbjzu+qCHfgS
         s9hTaVIrRHLM4NhQOKnJ7T6vOUxmOayegXMZdEpGxK0/lUWwBN1VIpfDznNTwG3HR5Sr
         UVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045641; x=1772650441;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0v9eecdrDlKKkRsI8AJc9LWKKGXVn/oxr4SUBFzAKY=;
        b=sH9ZMEO/jmA/NSwAoM92A3h+Qkm1guV7j5hFuMlgjyrk5u3fs93fiW7bPYC9MCPiy+
         xGVqtJ3PvghpK/8HqJoR3pSzUik2F/VYZfwSxjlrDYSzTau2VYfQRLQhR5bkcc30HYH5
         Ov+kB5hLyenB1x+b3M1qmEg4LFUEdqe8dUKSCpacOz6gzbjqSJqB5H1MF+oIFMlW52Qu
         Ukx189sQkAF1FfbnK1ikeGRchVqEjMfUsIFi5K7w8Oz43x3hS04D8t1N5bLjp4et/it3
         psE9Zq3GSjBrwCtrjkFTZ8rBqy+/yROf5eoos/DmBpVEVbT4tDxYKE92gxi1vzK1tH5M
         QXTA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0uhg5N8pSmWx1CN/EMKmfgYCWTc26YMykWrWVnPSnZpowyjaRL2aKW2Jkch4wsz7jSY5MewEzXhhI6jSYAWVL/Gfoxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/oCOQ2+tFDtJLGJYrd58JNxy8M00b+nQSWWu/oA0zgPQaU82
	RsIXPuet/0NkkvRdQnAKmfKKqYZjnByLKgNuNgx+zTNagRK/s/2jg8Qh
X-Gm-Gg: ATEYQzwJd9qJ90P3rVjtBdBrt2+cnmLm7HhtxbESrDd/TKLpmtlFI4VNHqyMVFix5xq
	mEFGGPHQHH9lJ3woczXYdikorN0nWVBzZ26RGogRh5DDgGdS3zlpP57ufkEXKSRPa7/WMnwlLwg
	p4QEYTHF+tCHcAnGf/y4EX/KHdkWRMyb7F194tiHa5DVImuGDWqdyRi/8BvSQ91/adFGXFMxtR/
	Uf4dy4dFicF5Su0cgLA8A3+1K8FOO99B+/e5jD4/B1QKhGSAgxUCHE84Uw2Es8N1xt2hhPcXTAU
	DOmZ4aB4pinTOgQS5wuprWTmJlkq6k+pudioTqEUAsG3cZdaRu3XYUsEQt3qYPLXgaA5AfCRnaM
	X8D+z8C5ZfQJQvTA0X6NOzhiEYW5d9XNc4+yaqX+Kll/ZQyUg8zbvRxcDJStSKyU8LK9fDVjqJ9
	fCDX/UuXjXKlR5YvalvSwiP8vx7bpHkG1hFVmH58QW/fya9nyc
X-Received: by 2002:a05:600c:c4a5:b0:483:7783:5382 with SMTP id 5b1f17b1804b1-483a95e6b64mr263650605e9.27.1772045640610;
        Wed, 25 Feb 2026 10:54:00 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd702e7bsm99932735e9.5.2026.02.25.10.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:54:00 -0800 (PST)
Date: Wed, 25 Feb 2026 19:53:52 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Expand restrict flags example for ABI
 version 8
Message-ID: <20260225.617b52a2bef0@gnoack.org>
References: <20260221-landlock-docs-add-tsync-example-v2-1-60990986bba5@n0toose.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221-landlock-docs-add-tsync-example-v2-1-60990986bba5@n0toose.net>

On Sat, Feb 21, 2026 at 11:12:25PM +0100, Panagiotis "Ivory" Vasilopoulos wrote:
> Add LANDLOCK_RESTRICT_SELF_TSYNC to the backwards compatibility example
> for restrict flags. This introduces completeness, similar to that of
> the ruleset attributes example.
> 
> Additionally, I modified the two comments of the example to make them
> more consistent with the ruleset attributes example's.
> 
> Signed-off-by: Panagiotis 'Ivory' Vasilopoulos <git@n0toose.net>
> ---
> Changes in v2:
> - Fix formatting error.
> - Link to v1: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v1-1-f89383809eb4@n0toose.net
> ---
>  Documentation/userspace-api/landlock.rst | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 13134bccdd39d78ddce3daf454f32dda162ce91b..0affe1c953d61a4b32aca700cd262c49cee6304a 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -197,12 +197,18 @@ similar backwards compatibility check is needed for the restrict flags
>  
>  .. code-block:: c
>  
> -    __u32 restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> -    if (abi < 7) {
> -        /* Clear logging flags unsupported before ABI 7. */
> +    __u32 restrict_flags =
> +        LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +        LANDLOCK_RESTRICT_SELF_TSYNC;
> +    switch (abi) {
> +    case 1 ... 6:
> +        /* Clear logging flags unsupported for ABI < 7 */
>          restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
>                              LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
>                              LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> +    case 7:
> +        /* Removes multithread flag unsupported for ABI < 8 */
> +        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
>      }

Thanks Panagiotis, this makes sense.  We overlooked this.

I'm slightly worried that people will copy-paste this example blindly
if it does not have a big warning in it.  Unlike the other "backwards
compatibility" example code that we have, this one actually changes
how the enforcement works.  (The other flags change logging, but audit
logging makes no difference to the process that sandboxes itself.)

Could you please add wording to the comment to state more explicitly
that below ABI v8, the enforced Landlock policy only applies to the
current thread?

Thanks,
–Günther
