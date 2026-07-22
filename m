Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A0284693
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724221; cv=none; b=g6VaAnP7FgVzuMz1C8viKVsUOYSuoHJYbfoOQfmP40f+Xnl2Nr81QDvfVo1pi/kS2m8dzLWoUAaP9F8g00TB93qWWuXEnovgDhCrksWVhsEg1s9AZMuqrGl8SevXQlnEvdWRfhBpWEb3+CC+9dyHVUAkFUIu7T34fgxRqD0jRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724221; c=relaxed/simple;
	bh=rOf3yOeoPaV8GbB0UMhEnSZ3ceLJXttM7TqE80KO8Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeGjwJ+cFossHtkp90a6kL0UKdud5x/X7s1xjciwW0IkKeY9eqPtl9pzZ60u398xVIsUYN3qKQzvKtbq/N92zQrw8zmfd2TwOepazkOJdNR9uc5DWwGH2n+gURu1HYN6Ho+lrjQowDLOoKHvTVkUuCWZ41uTf1KzTmOS0oWuUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JiuPUqfy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiuPUqfy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f633e6058so4947979f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784724218; x=1785329018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnYnNtKTZhp3m/Ur7bxY+P2OLpfTbrGdAo3NRWVmIRE=;
        b=JiuPUqfyug/esm7RPvM5Pxvj55g3XEMQR4lJr4lvOeEnnyPJk5EOIKpKJKqaos1By4
         WgWyjB2cxZMX8g88ZFQqzGx6vFBUfnyRwpt7t75QPhzTL1ZA/ktvK1RnEbwB76g/qn13
         zpaBzHeMl/QsoEAFxivSYqUe6+uFESyso3cMl5aAPCMJXGdWSxmw5a00K/AIMgSg+zlO
         /bd3e6hQ+Bv+FA0MVH0TcdVK2kp9CQksqwJZVezvlkpHCWE7h/pOHDd48+pk5NIdJ9/V
         ctpjLsk8UuAt7sZXfzDV7o4HAIC7jKeomojjkBObkBGJbEfjNbEDHY9tnuFaOe0tBXmY
         3p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784724218; x=1785329018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BnYnNtKTZhp3m/Ur7bxY+P2OLpfTbrGdAo3NRWVmIRE=;
        b=dM9ehua2UyZ+tqN7HyCeUB6fWJeJnlSiO/Ni2/fP1VOjVwwr1XdOC/VdOiyW2//sK1
         Qzn2v3NCZ+IMVFgdBdoMW0TbMhU6hFQVYN3i+BId8XxFEtgP/Sfw034pc8HD2bhGEKiC
         SkWdJRwwxU/fzOXfa9HvLQupExoZ/sQS14byQ7XHlHF94RlVLm/AoLvHagEC+MDorF3n
         0cPlkSO8g9+cQ9Qh7HlSdUPC4BY8IphXqn+9j+0rwjiLz49VMArO01lLnNIgRYNghBrt
         PPxvh6xmVnKw1sA6ksSC0sGonHdersY1Clw3hGJnWXUJE6seO/p8vuyrAwcNFQ2dOb4i
         F8zg==
X-Forwarded-Encrypted: i=1; AHgh+RqV/r8GeqIVBxFdbSS6W+GcdP5mv+61C8MVW820csdkigek6q54ZZ/WMsKRiYJ/EwSkvvW1mYIXElAPUdJLW1dPVu5qGq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW2XJlVwZLnhsycb6MI4dpXQ3OxPsxZeAJo0ECLnkGNDjkoDON
	doUaOVNO3XY7PimDzWji+8jevfQVlfDo+zmDgOJ6ss8kdkqM9N3NXILNvvpoVLxb+g==
X-Gm-Gg: AR+sD10ich3kcSSH+kiMLiVczPcSaLSMTEaRW9WbFS9NXMj+DIGwKdvQm0i/zyD10le
	vnh6gigm2+zJmZd3qf7at0Uf04kCmiVbAQDqi/zKkIJQSrnyyTAETNgcl0U2LBCIN/cZM+46Jnd
	Fu2lyG9WvVViGaQLfavCxEWQV3nhd8XYXcIAkC/BzeYyWEdUPb1uRHnQQ4mT2gQDmSbjnJqNF0W
	k0u8NC614WqqPYg79MF4MgbCFiU7WffwCEHSJZ9TNJ9BfZZ4Zt8RJ4PtAk2gafJgkY84VI+sltj
	Y+HLJtjnRf1uv7NL0c5R6FyZmOxYqJWmYySLjMCapIaRAfxz/wMk+SCbhB3CnQhHfvKcB2wLg5s
	N4+x0nlJnZYH1bVVAxZF9z3vSFBLqrYppjRReUryTHX7iv+ft0QZ8dM85doKg9zb9zSAyu59fZc
	odjwOKlD63h/h3H6czyA2R+bpYzWNjMADR74kAUif1cg==
X-Received: by 2002:a05:600c:1d25:b0:495:6c44:633f with SMTP id 5b1f17b1804b1-4956c4463c8mr23451755e9.31.1784724217695;
        Wed, 22 Jul 2026 05:43:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:b091:e7a3:a71:4447])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a11sm64818665e9.4.2026.07.22.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:43:37 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:43:32 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Oxana Kharitonova <oxana@cloudflare.com>
Cc: mic@digikod.net, paul@paul-moore.com, jmorris@namei.or,
	serge@hallyn.com, wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev, webprosto@gmail.com
Subject: Re: [PATCH 1/6] ipc: Move mqueue fs magic to uapi magic header
Message-ID: <amC69LnwcgG7xo-5@google.com>
References: <20260722122952.42149-1-oxana@cloudflare.com>
 <20260722122952.42149-2-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722122952.42149-2-oxana@cloudflare.com>

Hello!

On Wed, Jul 22, 2026 at 01:29:37PM +0100, Oxana Kharitonova wrote:
> Move MQUEUE_MAGIC from ipc/mqueue.c to include/uapi/linux/magic.h so
> it can be shared by code outside of ipc/mqueue.c without duplicating
> the constant.
> 
> Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
> ---
>  include/uapi/linux/magic.h | 2 ++
>  ipc/mqueue.c               | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 4f2da935a76c..8e5d33bb1453 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -78,6 +78,8 @@
>  
>  #define V9FS_MAGIC		0x01021997
>  
> +#define MQUEUE_MAGIC		0x19800202
> +
>  #define BDEVFS_MAGIC            0x62646576
>  #define DAXFS_MAGIC             0x64646178
>  #define BINFMTFS_MAGIC          0x42494e4d
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 4798b375972b..9515597d45ce 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -22,6 +22,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/poll.h>
>  #include <linux/mqueue.h>
> +#include <linux/magic.h>
>  #include <linux/msg.h>
>  #include <linux/skbuff.h>
>  #include <linux/vmalloc.h>
> @@ -47,7 +48,6 @@ struct mqueue_fs_context {
>  	bool			 newns;	/* Set if newly created ipc namespace */
>  };
>  
> -#define MQUEUE_MAGIC	0x19800202
>  #define DIRENT_SIZE	20
>  #define FILENT_SIZE	80
>  
> -- 
> 2.50.1 (Apple Git-155)
> 

The only reference to MQUEUE_MAGIC that I find in your patchset is from
Landlock's kernel code -- For a value that gets serialized to disk, like
for the other file systems, I think there is actually a legitimate use
case for userspace to use that value, when dealing with raw images?  But
that's not the case here, I think?

Should this live in include/linux/ipc_namespace.h instead?  Or even be
exposed as a helper function that lets you check whether an inode is
referring to an mqueue?

—Günther
