Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72217EEBA
	for <linux-security-module@vger.kernel.org>; Fri,  6 Mar 2026 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780438; cv=none; b=QiZ17TEslXR01cKFJkE1HOqoujC28s+8sGraTze5Bjfp0IruVSlHUV7D9NEi30q2b1gn4nWdI7yWwzGRxkqi1JgbwbdTdeW58msxMbdoAveoBKaUCpVyqbNNMGzL+tnR5Nq5fqyUEvsGQlFrAoc6KrR3LJy2OH/apvbXYN8zwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780438; c=relaxed/simple;
	bh=OANOmkkwIIwZoqirYjmQ8DjYFXzdlXyGCpWngT//PWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JomCchmt0JIZkNZQOLVVjs46wwfjoiAV8vjE1snuizjMJ8KJOoWIxYCPqz+/VUbEfYjZy0DtdO9QjvicS1pB8Y8ghuP6eGrcAsu11WQcHhIlrfBebx9sCUmXCxfTopSuilGSANw1TgpWXffNOt4hQPUgsIUdzBFfawXxfqLNz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JevC2UgG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JevC2UgG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4807068eacbso74181455e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2026 23:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772780434; x=1773385234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WdH+t5mm2ZbA7SrWqlNOGQimILmI30bY69V811HChRs=;
        b=JevC2UgGHQ0gQoMEoZ8ycDIs1fKcO0OJpU72Lz7CEfq3Jxy8/thcUAcDp0c/Drk44M
         p8ovvjruP2qpUQAb/fGmNs5DSuw27++VNNoRev89iGmdJXO3J4ZELPJeXhru3t5aZxPN
         bCXjMfM9k7w8sMDT2NAgm0dbWXLwbZQk89oPCgBpX9uS2qdasTZSEVYbZ9wKiuee5zUI
         lzHPFFKf+D7jF+vB3JXHAjvHdk+aXS8DJUG+xN3z3swSHaizNOd8uHjyZCN0fTIGeLl3
         PZLufxaIFQ7/dbFAzardqL+KpG+YFY0lovtBCWPeo0QJ0gKC0QRzesx44tSBRX59zwjs
         k0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772780434; x=1773385234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdH+t5mm2ZbA7SrWqlNOGQimILmI30bY69V811HChRs=;
        b=GNnGYlB/nVpUuWB70mEeVnN8Fji0AC3VrfRdQ1nJWvEXmbS0tyeG61L39eW1l98YQv
         0Tp3gFoD2b4WnrZ/Rm53QPjPRHWX/0r4hnDT7Z6W+4kl4KRb+gOvjVoDSaFN2d+tJueo
         HqwN+ghYFrnwF0rXi+1wcn94ZC8oAVTJqf3navEEN+BMH7j0mUDgFDHLEarwsKuaPp42
         Nzwq2aT/RS76+lTMDp3XAl39uAOW6kBVk3PyiDjbh9/XwZ/SEjrpCCnEj8aAkO8ipEw9
         f1iPRvHZA44Cd8rk9En08FfLolzNP6hOI0xO3giTU+lJ6P6FMp78k5YgIJE6Qx4OqZT+
         LcwA==
X-Forwarded-Encrypted: i=1; AJvYcCWXgHgc6amy57heC2EJUdruC7f5KYWQXJNeoZYKgw03dF7zR1Zoog3OshEYZ3CqoWywoD5+Ww+VMt8N/7+q54asoDN8OsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/ZLqYD2NXXrr0hAMkHo29aSv/xYBrzpp65zAsR6qw693FQC6
	PHeDFYZNfYJ+XHN6qETe/OoYogW7oJBmvgy+BDkLgxWGABdir+kYt6eN
X-Gm-Gg: ATEYQzzEDZ0WPR8n8tL2UuV9+jfTu+1QqcVkEhcTF+otcFHxDLfpSCbpkuI3e6zxeHt
	HZ9FmyX1j17gDRSxoUuGsSnUQiZc6EcL295cacGRpnnz7ReC9h7bw1Y+pJzaUOJ5okXHuoi4IdC
	HseDTtiTK2DRSLQ5g5Wulw/rzgLszPp7+sskjziXNCWX3N6PXZtrtnDE1VP0LampzA4cp3ORFa3
	k5T74dFhnDEcIfbGIgeic2L5EPfpum+GrEr0ygt6bjFcGpWgTQ5G+ZyTkhFc7zQw3MA3wjvqF3+
	cvMPQ7Mh+YhRJ4IesPzcq5h3NNRWF+bTzrCIzPbhlxViLLTDLT0D1m/tDMbHmdVHmWhrUzYAIBf
	fJ7FSPDeZVJp2nPm4FFQqiQx5G2dQ4rgNrbBNVZrddMkTILJlF3UQ3KsFXL0qFvSsKslhKrITL8
	5iG/LixEs+/m70vfy8TA/dnp3Is8erYSpof4CuDKFEwzzYS0Wk
X-Received: by 2002:a05:600c:620b:b0:483:6a8d:b2fc with SMTP id 5b1f17b1804b1-4852691c73dmr13672225e9.8.1772780433434;
        Thu, 05 Mar 2026 23:00:33 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm33720145e9.4.2026.03.05.23.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:00:32 -0800 (PST)
Date: Fri, 6 Mar 2026 08:00:31 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: jannh@google.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	mic@digikod.net, paul@paul-moore.com,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	utilityemal77@gmail.com
Subject: Re: [PATCH v5 2/2] landlock: Clean up interrupted thread logic in
 TSYNC
Message-ID: <20260306.4fc6e59bb3d7@gnoack.org>
References: <20260306021651.744723-1-dingyihan@uniontech.com>
 <20260306021651.744723-3-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306021651.744723-3-dingyihan@uniontech.com>

On Fri, Mar 06, 2026 at 10:16:51AM +0800, Yihan Ding wrote:
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
> Changes in v3, v4, v5:
> - No changes.
> 
> Changes in v2:
> - Replaced wait_for_completion(&shared_ctx.all_prepared) with a break
>   statement based on the realization that the bottom wait for 'all_finished'
>   already guards against UAF.
> - Updated comments for clarity.
> ---
>  security/landlock/tsync.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 1f460b9ec833..d52583ee1d93 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -536,24 +536,27 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  					   -ERESTARTNOINTR);
>  
>  				/*
> -				 * Cancel task works for tasks that did not start running yet,
> -				 * and decrement all_prepared and num_unfinished accordingly.
> +				 * Opportunistic improvement: try to cancel task works for
> +				 * tasks that did not start running yet. We do not have a
> +				 * guarantee that it cancels any of the enqueued task works
> +				 * because task_work_run() might already have dequeued them.
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
> +	 * We now have either (a) all sibling threads blocking and in "prepared"
> +	 * state in the task work, or (b) the preparation error is set. Ask all
> +	 * threads to commit (or abort).
>  	 */
>  	complete_all(&shared_ctx.ready_to_commit);
>  
> -- 
> 2.20.1
> 

Thank you!

Tested-by: Günther Noack <gnoack3000@gmail.com>
Reviewed-by: Günther Noack <gnoack3000@gmail.com>

