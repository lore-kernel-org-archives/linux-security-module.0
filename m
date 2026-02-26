Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA338B7C2
	for <linux-security-module@vger.kernel.org>; Thu, 26 Feb 2026 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090635; cv=none; b=QuC6903mBXtOGUT9duKTXh3w9X0amlsuTGHiOELsiU0PXJeDNKTkhmKtktTjUbM2TdpZ5fq1xLuXpkWmEHoPm1Lv0orROO/JO+vYb4Z0FFEbvFLjQcVSanyMnTyYlcRHjVgrDVndT0o1S/jX+wIKa5fWW+O7TnZmhoCMlKGuFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090635; c=relaxed/simple;
	bh=VXn9sFpHwfH0BR15DwxHz5D8lM6BYgFnUK7JmfJBq3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD90/7tIEq+Depde8CJp3BerPwZQuCJuIZoq4LjHAcjz3pgl4j/czquPlV1S04U7V0qHLCivjP5MxB2ip3PQbTxWRUJPhFbb6N+U1bEPa4tdNmmUB2aoOpQ3R36zbhiqtm05ftD7OynPRmaxyNq6SO/mmivw2MWn4Q8/sWGv7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLQ13vK9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLQ13vK9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483a2338616so3501415e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 23:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772090632; x=1772695432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XDBpg16h+HHqzlsU5v34rJbFohd9+zl+xOp/DXEiK2M=;
        b=gLQ13vK9RyCM13w4mSZQArWFDomgjpvg0tHgK41FN5R/RGoC3iMcUuqyG1YpBueUGo
         mgOXtI/f6Exx03yRklekTPeo/gyleCarQs4atOF4iSb5sPYf2n8zMHSIOJw6mAcqH1cQ
         dZSaOB8rzhf7zw27Rx3Z92gmN7LA8TuohrkPFIABXumsHC/pytyJY95eJ2V4cBlRxj3w
         rIKVs4sOvCUhRU31Mn19OJ2t1hA50+8Ry6OEVA0S+h2Upa77irm5zK5zYbs5Uq7Zqxqs
         U4PgMGvPIligt9sqrPP9M3mpwG7E2tuWUTQ2vG/AM7PlDyehTrpNTS50zQNU3vZ5clAP
         h8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772090632; x=1772695432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDBpg16h+HHqzlsU5v34rJbFohd9+zl+xOp/DXEiK2M=;
        b=ip3lGR8RbiDJag9KQxQ7FlDZ0G+dqLvkpAJ+YbHLeEYJWAhN/5itceBbQbBcgTgjOc
         G5S1M14esh2+KZuWq6jTI31N891JHjCMjmzIAkDx7LOEiLONhMfpLFwynwfu9R2shC+q
         yupddJ2G58EDdaIWYzFzbJHrVCqOeojfS8xHMJyvO1WbBHkHzwimhW2DgZWfzRQt7HBs
         F7ETkYPc6+b5ln0h3ZVj7WR1XWkauaDQpfPBv4pXVvxZaUzuJ/bRjUlNCWt90EkEN84w
         Cx6hFAQr0SzLIW/O7oFRFiJ708KzD8Zk5C0khEPVKSXozsxHezuN7mpy8mJUdoP519g1
         nTTA==
X-Forwarded-Encrypted: i=1; AJvYcCXKVvNNkg2tESp+JAQXvmXGGzCCCSPhr2lvK/FXgeKM9SFxDw4AnaKYoCxPg1+obb6JNC7623fyjalqXpE9oD9RMYlBaIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpr47XlNmjzSPPNCqGqxjFWJmaA4A0INM4vMdw6NaklbQlEeu
	HxpL15Iiq8iMdLuyvhOpTyx8lb/FF+iwM/5l2M3pn6TWzOvBcBCSx/OL
X-Gm-Gg: ATEYQzxZlzIUvRlD4Y6sHOtskq5Dvx6ESzL8YeR639x60HoMAsv9dpPGaukRXVWcRZR
	IrB/X50yO0RLUl6iokQ8C/YxbQ3NxCxe/NxTBKDYDD9oNp5uc4m3SJheVCqKNsskqFn6knlgKRb
	tXRY//1bzfWPF/Gmp3R9Xw6EkRaFgj+Qm2SDGLTKy+vfH/vba/q9kB9qHyuUHAl4C7uEH6xAaAz
	1t9uuh4pCTMYVYEKU45fOJKn3eP/2so4zXjGFW6DtnZ+JuRxYh1etxRiwRgBohAzbWFhEcp+xnS
	JpowS/tmbSFmk9alfEhWHEqS66dilbxcJ1WHqHRqbnv4qvrK3+CnNbRQqOYqnIKEA79HU8ig6t2
	xoe2e8+r9k6sUK7dRWFbQDPdm1ZdAeLD4ONjFhmivFpuruzgsC1bp+Dm53Fo5sAIMSKdYzZtaYv
	W9LoCzPLosYUwHSUdipgy0ul6l96q9nlhdn95QSGbVZRnGEdWM
X-Received: by 2002:a05:600c:46cd:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-483c3dbb412mr16522625e9.8.1772090632089;
        Wed, 25 Feb 2026 23:23:52 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f26d7sm132961235e9.3.2026.02.25.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:23:51 -0800 (PST)
Date: Thu, 26 Feb 2026 08:23:50 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 2/2] landlock: Clean up interrupted thread logic in
 TSYNC
Message-ID: <20260226.08cc999172f9@gnoack.org>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-3-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226015903.3158620-3-dingyihan@uniontech.com>

On Thu, Feb 26, 2026 at 09:59:03AM +0800, Yihan Ding wrote:
> In landlock_restrict_sibling_threads(), when the calling thread is
> interrupted while waiting for sibling threads to prepare, it executes
> a recovery path.
> 
> Previously, this path included a wait_for_completion() call on
> all_prepared to prevent a Use-After-Free of the local shared_ctx.
> However, this wait is redundant. Exiting the main do-while loop
> already leads to a bottom cleanup section that unconditionally waits
> for all_finished. Therefore, replacing the wait with a simple break
> is safe, prevents UAF, and correctly unblocks the remaining task_works.
> 
> Clean up the error path by breaking the loop and updating the
> surrounding comments to accurately reflect the state machine.
> 
> Suggested-by: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
> Change in v3:
> -No change in v3
> 
> Changes in v2:
> - Replaced wait_for_completion(&shared_ctx.all_prepared) with a break
>   statement based on the realization that the bottom wait for 'all_finished'
>   already guards against UAF.
> - Updated comments for clarity.
> ---
>  security/landlock/tsync.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 420fcfc2fe9a..9731ec7f329a 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -534,24 +534,28 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  					   -ERESTARTNOINTR);
>  
>  				/*
> -				 * Cancel task works for tasks that did not start running yet,
> -				 * and decrement all_prepared and num_unfinished accordingly.
> +				 * Opportunistic improvement: try to cancel task works
> +				 * for tasks that did not start running yet. We do not
> +				 * have a guarantee that it cancels any of the enqueued
> +				 * task works (because task_work_run() might already have
> +				 * dequeued them).
>  				 */
>  				cancel_tsync_works(&works, &shared_ctx);
>  
>  				/*
> -				 * The remaining task works have started running, so waiting for
> -				 * their completion will finish.
> +				 * Break the loop with error. The cleanup code after the loop
> +				 * unblocks the remaining task_works.
>  				 */
> -				wait_for_completion(&shared_ctx.all_prepared);
> +				break;
>  			}
>  		}
>  	} while (found_more_threads &&
>  		 !atomic_read(&shared_ctx.preparation_error));
>  
>  	/*
> -	 * We now have all sibling threads blocking and in "prepared" state in the
> -	 * task work. Ask all threads to commit.
> +	 * We now have either (a) all sibling threads blocking and in
> +	 * "prepared" state in the task work, or (b) the preparation error is
> +	 * set. Ask all threads to commit (or abort).
>  	 */
>  	complete_all(&shared_ctx.ready_to_commit);
>  
> -- 
> 2.51.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
