Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BD258EDE
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525290; cv=none; b=NGldH9PxqHus0S/BpArvklGHr9SeHw65MffKh3H/S3DMPALRxhLj0BoWniVlYNRSZXSRGA6SyCjeOoqoWFvuCiSe+oHXAor8+GV6VcuGOZxhMM/ZR/rxpKTza8vYAy9oUN2xQr15DfXy6IZyEtM48KVJJlD1dcwz3TFobNpTLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525290; c=relaxed/simple;
	bh=Zx9nb3ztPP4g9lWyzcy33cFFVp1VcJ513Xbx8dVo0Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9kRaWuTa88RKfB+0eJ99+MjkVTp46fPOyjDQA4+qlo9yuvLTjjRiwMDQqW/5RHrFcl4lcuUCJNKHU3kB+DE8KkHgMMr1C69KOhXpfkYTZRPKwN5cBBkS/D+s1M/l5Jbo4u1SAhjEg4rJzya+NHNCj1MYGvxU1bVXosDCHRi9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCqatpz0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCqatpz0"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso6882734a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 13:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766525284; x=1767130084; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eqeIwvBi5mfFvTXZOb022qfLOewfFt8DYBPEmyMUGgA=;
        b=DCqatpz00qIETVeyzCWJfIc/buosHG9U8/P1y0McMgrKYbC/E5KMEyY+LV4+iM+prW
         P6V4cXIw670QVvHJDl7oX8fU9MVLfE7ZMEBFZ1VCFWNnIgmpoMljDRsjP1VcHOD7O/TL
         mmVzUTmi17+zCE999Wm9/TzbH5BohX1CI0ZPazrpahGmtjR9NbGuY5o/a27DLrR0WMiQ
         aOV3nooH3GvdFsH5eXZFJ6JjAKnYxqQkCLaUiB7iCyXCJTbEHgjZAfKZk3lEcoYrEBls
         nt9agq7FkHncFn2lcjtkdEVkgIqMHTi7JdNKCmCUASd+GW4ngKT9CWxTnyJ2lxUsAl/b
         MiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525284; x=1767130084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqeIwvBi5mfFvTXZOb022qfLOewfFt8DYBPEmyMUGgA=;
        b=A6BGiv7Z/RS0EbNpLSYB3oKMjqRP8uRcp/uhF5SOzog3MdHAdYfdht/gvIJdItfj+E
         GEDQoCjHEjHjIHwtcJq4hkP9xt+EDlA2RAv9cxjVWpdft8lqr3qsSt9XqiCG2z2s8Ssr
         gp+5kuTOuhW1hvmc/IUCQeVMPzX6WlTE8sA063ntIgSMgW0cBZI8Jv/dokrmwCt/gQ9+
         EirxOjvhEuJf7Z69Jr6E0FmCTo5H2E5u2gf4HQ5G107Pf+i6BLTHjLZAUQzkYjG4/gXf
         X7Ke2v0KdA6eOhrfD21o8HPhn4WZ60wRLcMJmRt7iDXn2zqvHC3hx4ntWdWhVyheIymo
         8lfw==
X-Gm-Message-State: AOJu0YwoQrW+ahPIC9N7zAUGsTBWWxAInbYDPykY4jzVM1FW4EFgl8XP
	qlVNlGyx+VrL9hCLPBbR78y7NN2hF+71jrBaMQ5wYRle9i4V19PJ8UiY
X-Gm-Gg: AY/fxX4Hbjm+Zbz+mIJyKga0okfqExJrDYAgiMDBXdR57d+YwjFiXeXAbmmjAIavMXX
	Je1fIw+DpH+gqOLx/ZT8CAIzzpKl4a6gWLYGwGe862P6ei9MVYoJIalyzT/kWQtREZaKAZD5t2c
	Hz9XocLLVxHMjJZQdR5UPA3DGOn0Ikp6Ld3Yhx1M+zoK0x2ApweuXOZcKbpB2Iw/D9urADCRzdU
	73Bmd6RaxoBjEWMdKej7WgALF5hgWL5vDtRRJSC1Oy7Jv6A547A+CP4RzxB6PlaUj0HRZMgGGAZ
	ifXtDK4QVj9bbkeWTiKDwpwohUC6qqJYCwg1LnS2S5wCXnpfAaRWhFvvxs5aEXXr72/mcIK13i5
	U/PundQYnvUtP7d1+nFhdbginwj8Qy+/5Az1p1/z8Y0qBg5GPqECWBjFMJr4DpWFSyLfW460KDi
	BJJuPSqKI3e5k4qiY9cLLIw9lXUPUSRDheStRV
X-Google-Smtp-Source: AGHT+IEp8XHzz3urk0AEbTiRbOwci3ksWVrKeG6VcZDdscrx6T6ZVlSphdaZq1NgfitOXa8wshh9ig==
X-Received: by 2002:a05:6402:2685:b0:649:6577:e694 with SMTP id 4fb4d7f45d1cf-64b8eee5218mr13088174a12.31.1766525284340;
        Tue, 23 Dec 2025 13:28:04 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a4eesm14501136a12.24.2025.12.23.13.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:28:03 -0800 (PST)
Date: Tue, 23 Dec 2025 22:27:46 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v1 1/5] landlock: Remove useless include
Message-ID: <20251223.ebd9978e8df7@gnoack.org>
References: <20251219193855.825889-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219193855.825889-1-mic@digikod.net>

On Fri, Dec 19, 2025 at 08:38:47PM +0100, Mickaël Salaün wrote:
> Remove useless audit.h include.
> 
> Cc: Günther Noack <gnoack@google.com>
> Fixes: 33e65b0d3add ("landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace denials")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/ruleset.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index dfcdc19ea268..0a5b0c76b3f7 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -23,7 +23,6 @@
>  #include <linux/workqueue.h>
>  
>  #include "access.h"
> -#include "audit.h"
>  #include "domain.h"
>  #include "limits.h"
>  #include "object.h"
> -- 
> 2.52.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
