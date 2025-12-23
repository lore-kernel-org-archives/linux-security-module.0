Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBF258EDE
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525391; cv=none; b=l3b/p33f74VBHE93b8gyWVValnVvxXYoaskXbGqgJ04KCi0TtPF1JQjVpAmzz5plEmhi5K5/ESmfnKIXMGsP6+8DDvj40aIHaohhpNmaGNZj9668UllzmhKjdy1JhVzQHDEMgh5pWxruOZe7afAod1bw0HYC7upsvtqM/8Vz7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525391; c=relaxed/simple;
	bh=sbt7ycPy86y2/P+Pmmi0u1R43uH3AJIcDIcb/7CO8E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmWPCDkld9EjH7C0gk43461aMpFyRnceYFQIysxpfKGUL80t/XgaA4ylBpQ536NrRLHyogSklT+Mn6OahXmOuM0p/o1DeOSwKESQFs2e/6gEw0cT+9t8sZDGdjGtYs/RlXucZAKnzI2NJYTG3EcK0GJj+cusdtlmEGKIafF0q9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkdhKwd9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkdhKwd9"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8018eba13cso742833866b.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 13:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766525388; x=1767130188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdyhm+xFUc/0hSUiYa6ttG1HNmlqo/wgvBJXk21AYVo=;
        b=dkdhKwd9k4gmQBMnMhvFi4u8jpuWoRpuDiZujMRjHb3rdutKljCl3eNQMWF9rO5MMd
         SrtxPu4Mupgpkx+Fkg091KedOdyb00vWatmT/Xn0NLbQrW/LRz4zjdPvrqx1s/dQzYAG
         8nUrYC+lKzKTq/0/yVNvXI9yS6xDNw7uN4OQ6+5kQcaHlg0Ax3kpfipTsUKB4c7z663H
         Cyn2DYgR4kd4dUHJClpY2LaXfJfFvYAddCnXTDi7ZGEx18IqljddF0DHGe/7D+Zg2mex
         urt1xl1Fx5TonEOWrEOU1zufBrqpSbM/3KgdM4lH2Hbx9eP8dvNTR73r/m/S2aQjH/xD
         okWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525388; x=1767130188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdyhm+xFUc/0hSUiYa6ttG1HNmlqo/wgvBJXk21AYVo=;
        b=XIxOTTq35Tl+gIgyYS/9p8juLdMUasquKfzY24xViEBj3ybtSVDhbHZEHYqcCgY3vt
         w2UaHoDscxReP9fYIaoFK6RW3Eb3ThamaZpUhOEFT2p2N2MB7ldsAYRsEVaS3MKmikG9
         ct5o50NZK1niQ1bp0asIObVHBAJUwd2nRffqAz8jnmy9STNtp4O0r+wZibnEnRa8TuAa
         BfNlThxEsjHCHfnIJf1IvWucRadEPo6otVMWYaWFvRApqVM0nD0IUPD1G+iF93JPUkEr
         KisMXtMk1HHTo26VEvmMWKdKNyOhUrrMjUjYRdIAHhhbg43JIAfspqEefOcM4SDCPrS2
         jYsw==
X-Gm-Message-State: AOJu0YyE+5c8fLzIyHNRfwz31Y+0QEH7abLiiA7EyWFrZJjY/zdFiQeu
	bZRuzW2b/C9smkxf4+zatWf9waUX0/1UnGwncX23NMqHGIWukAnG93q/7ZjjUQ==
X-Gm-Gg: AY/fxX5GtyHOXku5BoDTGNDew01qFUDd0rasgYcEtniXyZTbRCcS4heKridPnFaGabC
	VvXJVIMsYjhaCflBESsMh6kfhgsgfbLllN93zdv3W7iMDtuNkYsbFMLmrEtIPSw/rwCP3wbjl62
	vRk8yrrv5MSoCco+zep1graD9g9caBZXPVTWU28hd3RqDM7v2O4uvzIuuPz6kGufLqhRE7Wxai4
	TFsGw7kl2lFZfQ8jZkVRAimdC6V5nNdeaN/5EkJ7JBP7d6L9w+7D8JQR2DN8F5vZ20E6zvgLbq7
	ku1qILrIi9M/bW12nuGiJRuo23tmQeB22NL8VRGS398JeSqvNXOV7VH3tIfSUUT1FlWDK3XkF81
	b9Zj3+6jvpaMcFVRmLE2IDhvUYFX81Zss3gNnZnCHBNXKk207EAyNwj4juPvIWWnsrLC04SJ4BL
	gn6Nbza7HjeeXaXz79+snoqj/GqtzZcIjOnU+b
X-Google-Smtp-Source: AGHT+IH4+L1pe1wgmIS4x4oeqM+J7owJ65i1trr3qq2n1pRHrqYblXPR2NqqEeqVlKW3yTRtwVHhVQ==
X-Received: by 2002:a17:907:96a9:b0:b70:aa96:6023 with SMTP id a640c23a62f3a-b8036f5ad5amr1561494766b.24.1766525387991;
        Tue, 23 Dec 2025 13:29:47 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f18575sm1489151566b.54.2025.12.23.13.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:29:47 -0800 (PST)
Date: Tue, 23 Dec 2025 22:29:46 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v1 5/5] landlock: Fix formatting
Message-ID: <20251223.c47a212b0e4f@gnoack.org>
References: <20251219193855.825889-1-mic@digikod.net>
 <20251219193855.825889-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219193855.825889-5-mic@digikod.net>

On Fri, Dec 19, 2025 at 08:38:51PM +0100, Mickaël Salaün wrote:
> Format with clang-format -i security/landlock/*.[ch]
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Fixes: b4dbfd8653b3 ("Coccinelle-based conversion to use ->i_state accessors")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index fe794875ad46..e3c3a8a9ac27 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1314,7 +1314,8 @@ static void hook_sb_delete(struct super_block *const sb)
>  		 * second call to iput() for the same Landlock object.  Also
>  		 * checks I_NEW because such inode cannot be tied to an object.
>  		 */
> -		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
> +		if (inode_state_read(inode) &
> +		    (I_FREEING | I_WILL_FREE | I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -- 
> 2.52.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
