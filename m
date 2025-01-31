Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FC16D9C2
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312812; cv=none; b=tdhijFCIF6P7l3WSwh+NSv0ImtyN2ua6NGQ6syHll81RC4uYLfve0I1e/QqyGsr6bIxL3m/S/lxpj2H3hrWx9x65B5Tw3JRSVafaaoRL42nV1XcVYOyBRsFaQpfGZx95qajQl+jGK5BtNAQmJVF86fxbGx+xIJCB58jfiKknvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312812; c=relaxed/simple;
	bh=l/POijdq0AKYrlhYqcnG18UNaqfR+4/MYXeh403fXUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIM5DFYZSLuChTHF6wJUJjTi9YOfOQ/vQrvuLUPAW4QKuOaOoWyt8ETcAx0o1F8q4ZZV1zmcC/yICccC1ocoygBRqDVALti3Amyy++kUwZREuzcZZ8x+dJJ5lFvj0hJywOB2kHHcnqpBUVyycJ8jPpVa59jRL+EmhlCXw7/eEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0IQveLG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0IQveLG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab34a170526so280743866b.0
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 00:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738312809; x=1738917609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fWOGICQN9my2rbxgynZ7r3mlpoPZThnbsR+WYwfiZU=;
        b=R0IQveLGwTbh/iT2UWYB8j9iL+scgY3YGcoWuKaEHXyw2R9ePka+6Vqsbi64swEWu6
         9J5T6PWKvaCHT6FteaRJTWhMeYfhq9w+FZcvMklQgWs8EUoPV9E/60z3G/va5O8wHVPq
         StQgfVPyhVKE5Bvj7X1Z0P8X7Gv2tiUbRnZEVnjdWB3xA2sIZW42S4h3tMpJ2MRUkgwK
         TDOrCLN1RQXi5MIWbUBwMRy0HlMhFBongC+kP3COItW8spisnAaLVKUtLrVzrD6AnAlX
         Z1rqbi0pUrEh/Z6Gzd16SsXaWlJx71uXyWO3piG/NQhr95HqBX+mkPWOf7mt6U7dwjE9
         7rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738312809; x=1738917609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fWOGICQN9my2rbxgynZ7r3mlpoPZThnbsR+WYwfiZU=;
        b=gzydyepWoFFo5dipeS3sJgjP9aSNil6I6FH49+aHGVzOjbJLaIjGndG3AQCMNZtygt
         tm6IF+Mf6q4Zp54gyQs26kT/ze18R/zV15r3U7UsodQX04Q7wXyn3PXOlG5Zuq/XAb2a
         EGHsGDG6WsTraCjTcGqHIjvDHisZgV+MQ0cQmF9awhZ8+mLDp2ScCFq7pdcTsEyIeZbs
         61/btR9HtRWSPibp4ZVTTucfkCchIvEKJ6xK/WaVxtuottTspiKcKjPQKmFZjG7KCrYA
         4ht8EmwnmrF50l8ilxQTZBz6boCZeqmuK5UYO0Wxd+AZxW+CXc8Thzw7Ek11NkyTibnX
         6VjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+WAE8pNwMGj4fw/w7iyv0tB6poqedaYsm+h+XMOoRAuulbzStgi/u3VpvfFT9VVNnnjmVpcZXTzTeRXnBg9TxahFlehY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBVoYWsm0HCz15qk3MYkR960ObfN7jo9N7Vzret/g8jfrFgGm
	jTbgRAga79wxnOMlzuNkoDN0MM9QzAvdzMHSIhPPCN4d04VGvTWAMY7BPQIKqQ==
X-Gm-Gg: ASbGnct13aPPbRXJNa+MQ5ns8ro4DPYKzZhCGtfxAfvfHMs0hmkRwkTRfJFT1+K0zzf
	If68WYjPKZb8qSu4bemOy3rc3XE2/zXvzsstgDf/N2QSVCxylUn25P3CEKpdnIwLzpqWRmppHY6
	i7OvSKs9/djvODidIYmC1Jl7GFgGiP7v5oWF2DFup9CUwZbM6wZvEOB1ve7vjqxkj7u2WntoWXr
	FIr3gr3GFU5d/df6uimOaYFcQuFC/bJTig0pWyndJa4WJi4Z+cbS3XWV2kB+7kMiQqX1SZ8xT1w
	8ECQK7dUlmDEWYNr4V2EhyLdKhnxsriAzjKzhyGITwW0DBAf8fd10WTAlA==
X-Google-Smtp-Source: AGHT+IGc66AisMi+T21YVz5kV2+wGdqam815E3zK4evkRVJys/4pQlIeDgu1Bo2DlXU2pQKmlChh2w==
X-Received: by 2002:a17:907:1c16:b0:aab:c78c:a7ed with SMTP id a640c23a62f3a-ab6cfe12c99mr1095675166b.49.1738312809270;
        Fri, 31 Jan 2025 00:40:09 -0800 (PST)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cf924sm257502566b.69.2025.01.31.00.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 00:40:08 -0800 (PST)
Date: Fri, 31 Jan 2025 08:40:04 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, liamwisehart@meta.com, shankaran@meta.com
Subject: Re: [PATCH v12 bpf-next 3/5] bpf: lsm: Add two more sleepable hooks
Message-ID: <Z5yMZEn-BXhJwq5e@google.com>
References: <20250130213549.3353349-1-song@kernel.org>
 <20250130213549.3353349-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130213549.3353349-4-song@kernel.org>

On Thu, Jan 30, 2025 at 01:35:47PM -0800, Song Liu wrote:
> Add bpf_lsm_inode_removexattr and bpf_lsm_inode_post_removexattr to list
> sleepable_lsm_hooks. These two hooks are always called from sleepable
> context.

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/bpf_lsm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 967492b65185..0a59df1c550a 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -316,7 +316,9 @@ BTF_ID(func, bpf_lsm_inode_getxattr)
>  BTF_ID(func, bpf_lsm_inode_mknod)
>  BTF_ID(func, bpf_lsm_inode_need_killpriv)
>  BTF_ID(func, bpf_lsm_inode_post_setxattr)
> +BTF_ID(func, bpf_lsm_inode_post_removexattr)
>  BTF_ID(func, bpf_lsm_inode_readlink)
> +BTF_ID(func, bpf_lsm_inode_removexattr)
>  BTF_ID(func, bpf_lsm_inode_rename)
>  BTF_ID(func, bpf_lsm_inode_rmdir)
>  BTF_ID(func, bpf_lsm_inode_setattr)
> -- 
> 2.43.5
> 
