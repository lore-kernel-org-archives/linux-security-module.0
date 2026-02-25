Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23914393DE4
	for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021379; cv=none; b=PhqnLnke0pf1+Gq9KIajXg7kKap9m+Byc+P6wr6yheopd5jwoPyoL9YwmmCyyb14jPA+o6cZ+LGUlhBr65CupxeTQuf41ZbM/8dCRyY9VrdLUpt0/B5le8Kc4R7LKhb7sEsovH/H0Y8LuvQsFnuNRPaK9AN6eVg++oZuruuZEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021379; c=relaxed/simple;
	bh=qFajCPbZ0QIi5lPiftQyrjRCq28wnTwMEvFiSvEXmM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YduPcBPCy6nz6m2tpfU0RCOjnX98lUePTXRlyHrYOg2uJB1aTNp0vulBR6OiC5YyGG5vhGnfG/VCmogeH+w8kElnNup6sF2W1BYOM3JwyNC7dC32kVO637lhP2Hk0WKcVQXTlFbq9xPlYVOZPIJzB6iE28+aXStGJ4GP4W7Fzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGHEsZOB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGHEsZOB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483a233819aso65078535e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 04:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772021376; x=1772626176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJ5P/C1rpIkuLy8IwHUQqCJbrc4Dun+fV8l4FFB9SII=;
        b=QGHEsZOBIZ1X+2t+10fvXO9aZw40CaxjrwFUmmn/M+0cQYMW8H5ouMT5UwP+/aAQe8
         LU1H8zOL+33P+7kfXquLBGKnuYrMtAtI2wy3sQmybZxmrRfj5+wUJS32Jm+Ig6YYGxsn
         zFdNIPqwUJ8ESMui6uB7lSYvaX5UQ5Q9WGTojW8FOdvBgXeSy5/BBzU0GYxyilhsEHOq
         A9g+K8bl46PjW1+RmrNGBRlGr/ca8YU1dmgahWNVVKWPB+8TCuSjCGUAIvTBlY6n4pjI
         cAjHl2QzXbxirFMuGGuA6IDhdwlzCQji2rP33yplHgrSFhRcbTUNbdl+Mz2HtkNWfJ2n
         QmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021376; x=1772626176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ5P/C1rpIkuLy8IwHUQqCJbrc4Dun+fV8l4FFB9SII=;
        b=adsZbZOGtBLVd90fd8/NsDi0QpTPljdzc3UTIgLY6YSiZaSTbqe3iLCZrrcwC32Afy
         pcB5qN4LlILb5BO7KBIppb8aigunCdbTjH3q1QWkVClKokWEtR+bR23VvoPrNNjsK+Kq
         PU+LeK01hAOMOoBvu04G9BcjvqvUW01aRubhFAzGQ6pwp9PWo0qj/VRIWEd+boOgH2KL
         oeYHOrNKSDMCZcZy4gt9yeWSApAj9Uc+jT1+C48RL47kIj7ycLKOvesa55fRjrnw0IhJ
         lOjqC3Sxd9W82Y53o4+LE2P0LNLBHo4sLS9p4i7dp1SYnqboVGpfLSqlNbQ3lLR53wJl
         ER6A==
X-Forwarded-Encrypted: i=1; AJvYcCWkCtCMA4aDgA1zGQYezudmA1A359wvogPBqTSK9RBRANFUjoGRouEPE9YDR1FSZ+P5Eh7egZ0/D82NU4VcfI8ugeHZGbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoNuepUA7KIcWIMsUVCQ8T4BBg4/z09AaKJy+RxX3dYbjuL5I
	oTajRswfgj8WiZtuuYKfOpMq098w6kJhTMIdbMDTQAtX43uTQ/HyXn1WzjQvilEIUQ==
X-Gm-Gg: ATEYQzwlHG+MvyrIC3V91GjDxAQpnS9JSdnNN5j8U5SO0vEF7vnKcqjfB8rYvur0ZgJ
	3MCqHRnY+AM00llVuzWbcR/soQRIS0pUw/kKxkn8WdlYH9yWU+EBYUdxnLkkCduW4/GCWthF5i6
	BRWE/EWk2vydUHZh5hXTYRBoEBi5RjRO0kLC2MlQHSI/h5OrFGOowyVqOGuhSgt9Res5rn7Mr+L
	yuN2Iyh5q7QegFU73QxS82BbLUmhmUTVx8mL7dnuiQdFx03w5TcBjw9e8Pbun479k9nGgB7Aii5
	IzBQr3K3WdKfhRy9eMzMSRB+nIDgLLTDVND1KDdGumKSJ3ZtAm33K2DTXzISpS5RS9ipMXrNUrD
	xCTYTiQwYW/5I54tJgp2ElrJWg9Nm2412A7Jmw8LdQkRg8Tb2OF6TpKDGTUkqJZbAz67wPmISfH
	zRJGL1qjO2KINfj8Wv5MBKhooSKrFkcb8x4qPRRgbIyRUyHitFAOLMfw==
X-Received: by 2002:a05:600c:8b48:b0:483:c12b:fe4a with SMTP id 5b1f17b1804b1-483c12c0071mr13749565e9.11.1772021376047;
        Wed, 25 Feb 2026 04:09:36 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:dd44:5fa0:1b9a:d7c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d95sm32212120f8f.13.2026.02.25.04.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:09:35 -0800 (PST)
Date: Wed, 25 Feb 2026 13:09:30 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] landlock: Clean up interrupted thread logic in
 TSYNC
Message-ID: <aZ7melfSZGsPWvXD@google.com>
References: <20260225024734.3024732-1-dingyihan@uniontech.com>
 <20260225024734.3024732-3-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225024734.3024732-3-dingyihan@uniontech.com>

On Wed, Feb 25, 2026 at 10:47:34AM +0800, Yihan Ding wrote:
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
> 

Thank you!

Reviewed-by: Günther Noack <gnoack@google.com>
