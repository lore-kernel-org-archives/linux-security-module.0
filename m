Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E02980AE;
	Fri, 11 Apr 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360537; cv=none; b=DdlES6tkI1V3eVAlvh4ad94dYITViWpSnWCDOh+zpoMIGs6euzW2Zl/X1JLAm6oRmpseY+dF3IZgqBYFgk6F4DSj1HLwQP2h7gIkh9LlsMnR+ghMiyq5PvvoiMXbsmOO02J+LYHEpjjCFf5aZW0FUzgjlP0KVWx2dDUVxut5f+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360537; c=relaxed/simple;
	bh=IMFF4gsFIW+Xo+Q1Z/FeUWv0CGqiTVKx30ut9GDruI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnVNYpSfGtLLMWZ1uKW0EXiWlTDJEalfi9R9ufCfleeiw72UvnSg94Hp91/NvsCeFscdgFFmSFS/vF/QP9fhO+9j8XlnNHib4rXuJf0nhEsUp7LnQMQ5Zhl4mzd6P5Wbb3r8YQJSmRpqEk09YgQlXWSAy8eWVzVgdRBzJw1AVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLawreZ+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLawreZ+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf848528aso12963395e9.2;
        Fri, 11 Apr 2025 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744360534; x=1744965334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JeZ1VCswI7QX1GjP0qXY6ng0b/NdREuqFUKOgDA2mwM=;
        b=iLawreZ+sB3eD1v4tNQkTu+xZg0PUiuzBhFhDpI5z8v1dSFlWl+cu/KsS09lxqz+7W
         WoLVwJe93HG5NGWRNyxSby4pPf95tGYE4ELrF9pt+0+BNsxT4qollLrIXQpdzWppKYWv
         pAY215D/uXlfGUfXiQB0Rs59Qpq+IeP3GGlPqn2enXDyIcNs8NzAjC33Mcy/yyWDrkWP
         aYDKL8l2E13JJc+k2haSiTVkTP0ZkvRuz1jhosyd4OL8htuRKh03BU+uAjXZtT6fuqRy
         fCUkvFhxu2LZvnTj6McROzHNUtgZdVo5OdjZDyTMPrfp5TdlSqjyVd06iD7jljDBqOfW
         0Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360534; x=1744965334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeZ1VCswI7QX1GjP0qXY6ng0b/NdREuqFUKOgDA2mwM=;
        b=Q8BkO1qEVHEWM4GVGvO2ubVvYxP4F3nSBzouxf/RCr+w04j37a3eROVwaqeuTLOq2e
         AEmQCcEc8coeQW1ctQL6ZL3c6U4elmFzVIzUFegIH/l/rLcO6ZSVFBkRkxmnRglm4sq2
         5oQrFyGS3HPYQKqW7OdC4K4FlvttPCR764OoTFK0sGfbGveOg3Qwya4HrAEKW7rwJr33
         RoQlrrQKYD1rWaGY+TokD6sS8jlHCpO8r+bfvp4TV7inLqBjiI9OIOlnVd3ApLZZSf9b
         Hcfie1RuyfsT33pn+1OcUP2BXhIdqtTFm27W4C8N4eiPG6PHwsGWK2pHcUEFOL8fmSDD
         pcFg==
X-Forwarded-Encrypted: i=1; AJvYcCVN7lIA2t+wU1NXGWZAqHQo39z3d3gQWEwLFuSP+3L2MmuIrrF8PduN87hpxXUDJCDTk4h0ULzBPej/Lnz6VPj5/fKCFYL2@vger.kernel.org, AJvYcCWaUxr+o+TbTJYPL/Ffhc6h9JbRd7sUFYj1CLQ0wApAlpsHuHRd4sGcJJEZdcDGWH68xFqYZhFAlLzX2q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkPLABNhhPzzDeErcO/6OemyYwV92EsUKk1BYOmuwselfhze7
	+LoPWzWhNdrb89ntHZq5Uh5ifebDcGYlwkdz3ewlNE3q5q2thYhS
X-Gm-Gg: ASbGncuozknLy8B3IBAUmJ9M2TADSIRVuyeG5lxZ7KcGF+dM+K7deTLnIq5nGwaUlpi
	ObabxaKHLIWZt21jSjOJZgXF6gXjwQKimEnARvLqnSpx6aoFwT1Sn5d2pk5VBnPBJA3KNvQHYb3
	9/5HRFyXRupiI/zMDRZ4J13r7ghRCzUoZOLIXOncciB8OMA1eByxitI19t93uwwu00y6zw0kcCo
	3VXtyDSpJislSmOg6Zlv9aeZDPdv2v3pNKeXOBhDI/c3CdKZMdOIFFMcV3Jpkxf4ustc/JzumFo
	wjH9kUH0hgFITUrwdncpWnuSp0RU9bD34l9KsXbCZxX86XPHO1NQ3O58+n0zo9rpcVw=
X-Google-Smtp-Source: AGHT+IHZ7/aIl27D+/wmqNZfCbOR61KOSE41AnWgPK7HD6QuxRb4Z5v5AwM0WQcQhNmjp3l0KD6IOA==
X-Received: by 2002:a05:600c:470d:b0:43c:fa24:873e with SMTP id 5b1f17b1804b1-43f3a93d162mr11919975e9.13.1744360533734;
        Fri, 11 Apr 2025 01:35:33 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43f233a2f71sm75974325e9.15.2025.04.11.01.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:35:33 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:35:31 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v1 1/3] landlock: Log the TGID of the domain creator
Message-ID: <20250411.3c94c5c9e6bb@gnoack.org>
References: <20250410171725.1265860-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410171725.1265860-1-mic@digikod.net>

On Thu, Apr 10, 2025 at 07:17:21PM +0200, Mickaël Salaün wrote:
> As for other Audit's "pid" fields, Landlock should use the task's TGID
> instead of its TID.  Fix this issue by keeping a reference to the TGID
> of the domain creator.
> 
> Existing tests already check for the PID but only with the thread group
> leader, so always the TGID.  A following patch adds dedicated tests for
> non-leader thread.
> 
> Remove the current_real_cred() check which does not make sense because
> we only reference a struct pid, whereas a previous version did reference
> a struct cred instead.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index bae2e9909013..a647b68e8d06 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -16,6 +16,7 @@
>  #include <linux/path.h>
>  #include <linux/pid.h>
>  #include <linux/sched.h>
> +#include <linux/signal.h>
>  #include <linux/uidgid.h>
>  
>  #include "access.h"
> @@ -99,8 +100,7 @@ static struct landlock_details *get_current_details(void)
>  		return ERR_PTR(-ENOMEM);
>  
>  	memcpy(details->exe_path, path_str, path_size);
> -	WARN_ON_ONCE(current_cred() != current_real_cred());
> -	details->pid = get_pid(task_pid(current));
> +	details->pid = get_pid(task_tgid(current));
>  	details->uid = from_kuid(&init_user_ns, current_uid());
>  	get_task_comm(details->comm, current);
>  	return details;
> -- 
> 2.49.0
> 

Ah, a classic! Good catch finding this early enough for 6.15!

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
