Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690F18DB35
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867612; cv=none; b=VNv/z2B9h7TrS2yKBu4NhUnxoQ14P6n9tM+LLOowMFv6MVxkwFiFEyNwLkqc56BESzXnl193YLBSww6m7kD9dY9+EalrkFuwNVWvBcGau1L6RzfpojcybaenjJkElDuLNRoVtLMxTXM6UvR3hDsGJCgKdzymDCH+cx5w9XbYFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867612; c=relaxed/simple;
	bh=xaMuOUD7Oe1WjblQo1WWb8yHBo+R++sb1DGZGvCmlkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDrgSSyZ04Ny0WCcQnoMfC6JeOjV0C64nlsyNfF+O5pdAm+wLzZWdaGxaENVE8veyzuTPamSNh9/SwWGTbqQMUfoboAU3y3IAf8qhJ8VKY2Msjpvstam2/eH62DR2tWA/IKLJwTat7emXqBcsKBAN5Bo0x7EfYdo4MHuGeuNzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtPxNu0E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtPxNu0E"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44a74032ff8so36740f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778867609; x=1779472409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWijgKtCoQzrNVvu+pDOsKCgb2aaaazL5BE6EC0MORA=;
        b=QtPxNu0EFMSR9pk4rND/am2Bw9MJF1Ra2a/Vr5ddGJ5aAY5NmiJlKusg6q1rfuTCPV
         FsGqIP++jHD2JDh1T2UVhRVyr2cis1soAOuLAUmvY522MfHusScxldlDpdWlB762Vh/K
         hDZ1MA7m/7NnryTN1aPzdM3rreHR9JzI8Ks70/PhqsUbbWdfJJ3yPsh8x5/AQu1K/PWB
         qpXyHvWU/ov1K4dEMXs8/2/7XuWxCXKOz+5tBF1mHdhUrhO6uY3Vhcli8S0RalGTXG1B
         O6L6XOqeXe1+Gi9Tk/ihNnsRO/aSof0EYjXgRrsomv/JCL7m1XUNuQG+0NP7GCWnZz7n
         17xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778867609; x=1779472409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWijgKtCoQzrNVvu+pDOsKCgb2aaaazL5BE6EC0MORA=;
        b=JxypGRQboJNZPwexSU/kmusdOGVXcbtxUx1ap3ougdnTDiV2l8bHbUrgy0Zx2OjoIE
         1wzlTVPMA1OoocvOExVYAq1czYa1Pgh8s1Ez95XJVJLDSncDcud6lYBIZ9q8jVPp913V
         ZTh8vMid1tql6BGw1BQ3zEPShpIU+TxfBugj4GOFuM7fq4SloCHe8gmKevmxZR5PqHzc
         lgZ0byHBpQhWtk8xNDDlyQMGM4kgTYScw12uwOAAix21jeLfUQQwFl/Rzbim0Xyc+cbL
         esUuxMbk+86eB+3iVXH3B0ux5kTMp0Oqi1nt7U8eNSAZPySt4W4nzasktnZchib3BmMK
         Recg==
X-Forwarded-Encrypted: i=1; AFNElJ+ulUFUxaUT1GGwy8dhIow10gWKRuOhmECkOlrSDfccwjc+b8fij4lDuqO0erWyIw8dSZv2Fyk03fJ/SGMN6mzszeoX8Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcL5kIwbpLAMa28kxSFLwxeFLn+HXIp8UgBri7QBgYsAEKk71B
	zyf3p90O/B+fGxyJV0cuYoBvym0Vp+/Qawct0DStCQPJeytNfssGajdF
X-Gm-Gg: Acq92OGBXnnFlehzpQ0bFkJt8tQbHAJoJ6Yn5hXkl+4WUWR6z8qivJQkwPG/C3xWqEU
	YByPzYpoSdS2g1tKHUg4XhQmgmR6WO5g5PqD2Xhhje1J5imcddu10NxVZl7tcBJLu0SvmzGIR3I
	uN8y70HGJ8FT6yNMlA2URXLLDn5ZtNlxLQ09WP5aJfk2PuAKlvku+rb9QA6zcM6dNw2I6BUE2HK
	YkFwtP3sqzDocUfK8Mw34luI8uLR+6TTG8YYKWKau6S90FVF+T64T85Oz7m1m1b3/zUintne3vX
	3hKbrMCuGomNiOGsRCL3HPFeIm+yBTPt86FAwt9Oe2+k2V/hYCTxKi4eiNnWPOIE6YAh7QB9Yp+
	uQDVqJNRwwEfTFeQB7jfE7wLQqIOXKuxiLVswrMINjYJw0exH0vIVXaKHzVwfGKqg3DTkvBv0bF
	Wwp+v61n/crJNY1bwMqa3sTIdKrs32WUIeUsDM9aecmLVxGDM2T3ctGpwN2R8=
X-Received: by 2002:a5d:588c:0:b0:43d:7868:21f0 with SMTP id ffacd0b85a97d-45e5c57d3efmr7332502f8f.9.1778867609310;
        Fri, 15 May 2026 10:53:29 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm16200559f8f.20.2026.05.15.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:53:28 -0700 (PDT)
Date: Fri, 15 May 2026 19:53:27 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v1] landlock: Demonstrate best-effort allowed_access
 filtering
Message-ID: <20260515.3306db78edb3@gnoack.org>
References: <20260513151856.148423-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513151856.148423-1-mic@digikod.net>

On Wed, May 13, 2026 at 05:18:53PM +0200, Mickaël Salaün wrote:
> Landlock provides best-effort sandboxing across ABI versions:
> applications request the rights they need, and on older kernels the
> unsupported rights are silently dropped from handled_access_* by the
> documented compatibility switch.  The recommended pattern for
> landlock_add_rule(2) calls is to mirror this filtering at the rule
> level, which wasn't explicitly described in the exemple.
> 
> Show the pattern explicitly in the filesystem and network rule examples
> by masking each rule's allowed_access against the ruleset's
> handled_access_* and adding the rule only when at least one bit remains
> set.  This makes the recommended best-effort pattern self-documenting.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  Documentation/userspace-api/landlock.rst | 48 +++++++++++++-----------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index fd8b78c31f2f..45861fa75685 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: March 2026
> +:Date: May 2026
>  
>  The goal of Landlock is to enable restriction of ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -155,7 +155,7 @@ this file descriptor.
>  
>  .. code-block:: c
>  
> -    int err;
> +    int err = 0;
>      struct landlock_path_beneath_attr path_beneath = {
>          .allowed_access =
>              LANDLOCK_ACCESS_FS_EXECUTE |
> @@ -163,25 +163,29 @@ this file descriptor.
>              LANDLOCK_ACCESS_FS_READ_DIR,
>      };
>  
> -    path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
> -    if (path_beneath.parent_fd < 0) {
> -        perror("Failed to open file");
> -        close(ruleset_fd);
> -        return 1;
> -    }
> -    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> -                            &path_beneath, 0);
> -    close(path_beneath.parent_fd);
> -    if (err) {
> -        perror("Failed to update ruleset");
> -        close(ruleset_fd);
> -        return 1;
> +    path_beneath.allowed_access &= ruleset_attr.handled_access_fs;
> +    if (path_beneath.allowed_access) {
> +        path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
> +        if (path_beneath.parent_fd < 0) {
> +            perror("Failed to open file");
> +            close(ruleset_fd);
> +            return 1;
> +        }
> +        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +                                &path_beneath, 0);
> +        close(path_beneath.parent_fd);
> +        if (err) {
> +            perror("Failed to update ruleset");
> +            close(ruleset_fd);
> +            return 1;
> +        }
>      }
>  
> -It may also be required to create rules following the same logic as explained
> -for the ruleset creation, by filtering access rights according to the Landlock
> -ABI version.  In this example, this is not required because all of the requested
> -``allowed_access`` rights are already available in ABI 1.
> +As shown above, masking the rule's ``allowed_access`` against the ruleset's
> +``handled_access_*`` is the recommended best-effort pattern: rights the running
> +kernel does not support are dropped (the compatibility switch above already
> +cleared them in ``handled_access_*``), and the rule is skipped if no supported
> +right remains.
>  
>  For network access-control, we can add a set of rules that allow to use a port
>  number for a specific action: HTTPS connections.
> @@ -193,8 +197,10 @@ number for a specific action: HTTPS connections.
>          .port = 443,
>      };
>  
> -    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> -                            &net_port, 0);
> +    net_port.allowed_access &= ruleset_attr.handled_access_net;
> +    if (net_port.allowed_access)
> +        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +                                &net_port, 0);
>  
>  When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
>  similar backwards compatibility check is needed for the restrict flags
> -- 
> 2.54.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thanks for the documentation improvement!
–Günther

P.S.: Please don't forget to also transfer this change to the
landlock(7) man page, where we are using the same code example.  I
believe the overlap is mostly in the code there, and the text is
slightly different.
