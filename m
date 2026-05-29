Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7031A045
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021464; cv=none; b=I94s8CYaREN5qxw3KFeH7cDocUAQQ5mdgEztPhVTpaie3y9/swjTywzghYDf7rcspiyqqyxpcf0HYjMR5tR3WKgp1x6o4F6k//r51dILPSIejT4COaEJSrbnigKEy2lrcoUJsEWWRfwk4HXmnu90M/jQKoPI3S9unask3I7PtA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021464; c=relaxed/simple;
	bh=dMfkzQ2KMoBqNBkvyQJwU7TU/qUdDuXi2H0CpXvxRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVRVgIZ753XNyMfDEaXhR42zNuPxs61bWv+0BiRJSaZHiGmhZJHI64omZwVlNGuYA7SwB9wRKCqwSps7GZuv429G7xxxc74QI2XvTtND/PLXH0J0Mo4CdI7q8ZSN6uorq0/UY5cuV9LnzPnE8JY4PDmXSirYhvctX4ql3IZQTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX6YAYhX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX6YAYhX"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bde9d73678so141029947b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 19:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780021462; x=1780626262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UELxf6U4hLVPdtFffzjtUVKrvE6uCr2+QAUbCzBBtcE=;
        b=DX6YAYhXUCSHI+aVTyhq2k/ePFbjNcU1zI6x/BMjkoEWJM40uHgStaQboC6V4ZnxXM
         cKvZ+FfTSUtdGCooIuItonn0Si33qqH8fKboJ+iURsMZjQXn0alMiLiz6lx0IrCy7DA5
         4cmSD508xEsw3j7cuEq3apfkFhGKsI0k53H+nV/DbE4Psc2U6hBxRw4YcqdIPSyp/Gp6
         PZRixFACZnHSvYz9OxfNHmnTQsgDJiB/Ff/cXhgg+7a17RRcIKdQs3vYLiTzKkBlaWZy
         lslJMZ9tEwhtPrIX9sXYnLmRPX+F5cGAYSIuIQAGPscE1foZvPzwRbpWDFSgUDZwweto
         StDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780021462; x=1780626262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UELxf6U4hLVPdtFffzjtUVKrvE6uCr2+QAUbCzBBtcE=;
        b=Va0bOg5NFL1Trf00TVSgkml1m7fhzsA3RUHCwrVEWsfxsG+HzPkQ/FpNVJV8JUVn5f
         RowyXzCRp+HDBMieRbBwM2GJdqM5HrFLpZpb6ZXpvU8Pt/eOMSXnIqpJbVCkLZBE9ZQg
         I/lMl1EmA024ACwU/8sGnYLpmFKPkapPPcAsLsqfIFsPdzd2TGD/BDLlDXMEQNoHPX/z
         GJW+HZWSRla/5wZNbrCBbDCWQneZGxzDp4ZWCt9bBsYIBkgRXDO33rcaSYTgfRBNOK6E
         cMmZEIwwYQ5Guru4jgiYCZsKQdusP+GFP0LZ4eYzDAUkayOOnwAmjU8ofHMYa1HpfqKe
         Jw1w==
X-Forwarded-Encrypted: i=1; AFNElJ8dnvR9tEES+KAPI8I8a7ncncyZOrCAkeIUsZqpuZS2gY1bMiQ5FedGuggKLQ4xV2ZxFD+uNn7vK+G+Fjx0wm138U1SbH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRz3hKHES7mKs5GmVrgiNkDZ5yVUtqBz2Cp5hdy/NaqpqGqYHf
	z4AwSP5rMu/kM+kBgEEbO9DkXvbV/OUcm7FAVtrgxw+xxPAYKs5XJaulNfX25Q==
X-Gm-Gg: Acq92OHa+w2HbJnx7LkU8Wo22D0SQJiyHocRAYOm/cTg3MWeE0rj3v51yMb/MdDvrws
	DGFsY9nPlJSQSNiDZ2UTI4sVj2HkedMclY2DiVSpvzVG5ct7BPLpTWYPMmtbZn9Bz5cQwo6eXZt
	deK9OHB+hbsUI3wLpiahU7nXg/Cd7ksUbcJQ43+Kmbo/6IoEzvZDtHq66N33ANZ5xYjb3cgSXl+
	PWWpk41/Wv0k4v0C7wxSC2k4S2KEJUqIu1yuWKQL8vjbysSjEg8S/MoWjuTLFlGaJdVfI5EYLJ3
	MH3IQUD8J+IbwM55KEe3dDgyE2TSgrPdvR2GcD/HN8ObKwXMsP1UPbSvtaKkBo3OJYfxHVhi8Lt
	tmDLL7dboqzq+v9r/8/xnC3kOH72jdfOJUI49+zXpUdl9MzN1JsKRLcRfCz7501zltLFoFIS3Pw
	deqjaNSLFLTW7b6PAMaid0GkofW3DmPIjYqF3mWqRkiUnpWL6fknZd6DnfZoHwv/t7jcq6
X-Received: by 2002:a05:690c:6012:b0:7ba:f3a2:552e with SMTP id 00721157ae682-7de3024bfc6mr7934697b3.10.1780021462603;
        Thu, 28 May 2026 19:24:22 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6757e963sm1602617b3.1.2026.05.28.19.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 19:24:22 -0700 (PDT)
Date: Thu, 28 May 2026 22:24:21 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 03/10] landlock: Use landlock_walk_path_up() in
 collect_domain_accesses()
Message-ID: <ahj3ZBxiQEEX-X7H@zenbox>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
 <20260529015210.500291-4-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529015210.500291-4-utilityemal77@gmail.com>

On Thu, May 28, 2026 at 09:52:02PM -0400, Justin Suess wrote:
> Replace the open-coded loop with landlock_walk_path_up() and change the
> function signature from (mnt_root, dir) to a single struct path.  The
> caller's mount point and starting dentry are now both carried in @path,
> which keeps the traversal logic consistent with
> is_access_to_paths_allowed().
> 
> No functional change intended.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Notes:
>     v7..v8 changes:
>     
>       * Reworded commit message.
>       * Changed collect_domain_accesses() to take a single struct path *
>         instead of separate mnt_root/dir parameters, simplifying the
>         interface and matching is_access_to_paths_allowed().
>       * Tightened the disconnected-directory stop condition to require
>         !d_unhashed(walker_path.dentry) when comparing against the mount
Disregard this note about d_unhashed this note ended up being
an uneccesary leftover from some attempted bugfixes in my draft (now addressed/fixed)
and I forgot to remove bullet this the git notes before sending.

Justin
> [...]
