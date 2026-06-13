Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE9370ACA
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334796; cv=none; b=FO02bXkzFc1rN1Ho2xqZDUJEkevPCD7LNVLmb8+BIzwNi4vaiX0O7zdug10FBvBh8/7BQ4WIi3AuaybuNfuROzyhqF7VdNWPlxC3F16OREOvbnzm0q/or80jrpaadh0crlJg6GJgqgsr7i3ve01iwf8h7xJS0ZMyJQX4VnALmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334796; c=relaxed/simple;
	bh=WCr9OO/1p459hxYJsgQFhaP+PWlj+JvLVnNJGjSgRBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItmoHIwCiMFCjklSLUo/btzR0nz6+lJML3pX+yySYspJX0CkNTQdDjz9ct9arMxvKoljhtwhEaPHLrgj7XytB/4kjXRnPjNnNvuAugIh1kdhXCoh6wyuEcq4e6pg64ZSWLf9gi21r2g9V3wu7LdTuTz40qPCudRg+b/dZulIW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Yjap1WA7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Yjap1WA7"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 41B9E3F867
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 07:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781334792;
	bh=n9wC9N11IWejja/NrlLdSDt9GWEelDFusP9beswEFvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Yjap1WA7Jhi3yoCld8cUGERVx8LIwDOcRH/FaKWfXGBKbfeXbG7TH+Jcpc+kVcy3h
	 u4WdBtwo6SHAg+zZgA1xukCnJT3FLw/czw3WJbtFhIsKZk/4fwZBbEbRo+pcwGzI5S
	 D5CF8bs0x+Ww254LWTAdAc27bXrZflQdNRJor8rUigdA8V9uC4xox+ceRMIShYH8Lc
	 Ew0DCESNTGAOJVnw8PE100vVKvHmfA64v83pH5H3PyU1OWXjpVm2pOGlD4atD3MsQQ
	 KzBcN6JR1y0ceN2cnTJVdkyOkWRrOsu9zsm3jeqpv7h5+ppfQc0lncSFij6n9Mhh0m
	 jOh8rGh0VB2uhTxu199jHR8ZS6WqbOSagOPSe4ICw6S8wUntqUCR9Yi5titajIBdwG
	 CGbYv2LM8GOIr9AM3fdF9wAXJ4N25t4scNvG7FE8XB5FXeMAOy8HpzvR6zdC3/Z7OG
	 oDizW0Lnm1U9Lr9Sz5PraGmyEtN533nOeFHbFeiOXAQ+rnbcABuwZ0QpRqoGYlcJVW
	 DyjO16Bw2wE0dc8dEh29BHWNmRsYl13q+xUV7Z7P22/EC8hV9wuj/Bqd0sCxzio3+I
	 21N3c8QTxE+B5WQU5rbEB//Vz6m0RLp9++173vekwTIKHUsIvEkM43prtxpmSlZKha
	 jnwHu3v3sV3LSbj4utkfPE/g=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bbcd40642so1283779a91.0
        for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 00:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334790; x=1781939590;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9wC9N11IWejja/NrlLdSDt9GWEelDFusP9beswEFvw=;
        b=fJA1CLLggcBcOR3nhUD0BHRa6cP1/we7wrODhV+v7JaSCvyaSnE0M7c3IirLJQsTzI
         N71EjusAZ6Z4PnMMD0ZSMYLL2EpCHNzNIyyJRl593TnTur2hcs50yZlWld6UQGiH4rkK
         Z9CdH36nKY8+VV6lXpyPaGJYI0qCR3dJuZgB0faMOI4v0fjYORRIzqPv0sjfhfi5Xrbb
         5+9sMKpF/b4o6JpYlvxapUWwVL8RX/Mgb+s0NSXakd6C9MrbBRYDXZQ6rAKTGFMmMOs3
         u2S+rk9qjsDev69ig/hJJ7gWNZvh5Gw9WkphQ//ty04HmEMuAcfwqKAsy6OHmswKP792
         VxUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Yz/bpD+VKwBD7x/nGlTat6FecK7P98btBRf0rtbzxRLP5Ef2LNBVRM5W7NxETZxDBvx8OdM57mmjiuvqsAYMzW4PFIbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZaW+VkLo3M+hgvZi8RtXBtTIvLXjtUD1HX26KZN7+sf0xwU0
	3rRo5mz53dnFixube4u1V034Txtbj14Oz4ZER9QfLRv5fZ7ljDPW6xCsuGbILwo1MY1KEpteqFP
	dXyz8fhyVNrEgnRfVqIr5xldfDjoQ8ye4wHwfjlWeromm25uHh4Fh1HVSqot0UEFrbKUFHJl7ZX
	ndoO8d7Y080i/8kWf6hA==
X-Gm-Gg: Acq92OE7HLbBWrv9aosduPEbO5mqpYLAmYek61TUlFZl4KQC0log5DgoSs90crMIewv
	nMkj38u/5M4vfjiLaHlc9NeRqPtgm2aup8Lc1VZzNzPx0gKVyBvtIAfvxWimpIEJnGjv0dhhY8u
	4ikC+eMfn3xi6PT0meicZ2gp/ArErU0l+pSMkQ4Ta7F+grUNVhmq2e2Ix6hU2WAYu0IPbBPA+RK
	rxB/tjrAL42Wt6OPpJMarbySc+B/HnIkO+CotFSAp2NW4PBwpWH0EwonAAY6P07mtOPCLa0HKwm
	/GFxtY8XmcEMYKfagZ7jRknWIhMk0JzX+KGCdxAviAge5L322Oh/Tlh+b5x1AvreKUNzT7iNGfx
	2EfbarFd0j+iljS2Pa0i4euA+V+7QlHOUW+ZJ
X-Received: by 2002:a17:90b:4fd0:b0:36d:9ea4:d0b with SMTP id 98e67ed59e1d1-37a041a878cmr6964869a91.24.1781334790374;
        Sat, 13 Jun 2026 00:13:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd0:b0:36d:9ea4:d0b with SMTP id 98e67ed59e1d1-37a041a878cmr6964848a91.24.1781334790048;
        Sat, 13 Jun 2026 00:13:10 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f176e92sm5215838a91.7.2026.06.13.00.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:13:09 -0700 (PDT)
Message-ID: <8d7701ab-52a4-4c86-9519-959c806ecf04@canonical.com>
Date: Sat, 13 Jun 2026 00:13:08 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] apparmor: Fix return in ns_mkdir_op
To: Hongling Zeng <zenghongling@kylinos.cn>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, neil@brown.name, brauner@kernel.org,
 jlayton@kernel.org, jack@suse.cz
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhongling0719@126.com
References: <20260503041243.200895-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260503041243.200895-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 21:12, Hongling Zeng wrote:
> Return NULL instead of passing to ERR_PTR while error is zero.
>    Fixes smatch warning:
>      - security/apparmor/apparmorfs.c:1846 ns_mkdir_op() warn:
>        passing zero to 'ERR_PTR'
> 
> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Acked-by: John Johansen <john.johansen@canonical.com>

this has been pulled in to my tree

> ---
>   security/apparmor/apparmorfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index ededaf46f3ca..1d7b1c70f22a 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1922,7 +1922,7 @@ static struct dentry *ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
>   	mutex_unlock(&parent->lock);
>   	aa_put_ns(parent);
>   
> -	return ERR_PTR(error);
> +	return error ? ERR_PTR(error) : NULL;
>   }
>   
>   static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)

