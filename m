Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2D38E5C4
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637809; cv=none; b=ll2KBul5PBeCNu5NHkwrval2uRCuUOP6PRVtp+i765g7/8icaOF4E91uwUY8HRWqa2iksoiKYc6MNO3bcf/L5XwGBaaM+AKEaMLPjdbEM7JZH4LZCsjlhVykSJvu+2Lup0XGjjgZlBBz6vqQwxA3+APYUpk+m5VadKtPl1luvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637809; c=relaxed/simple;
	bh=EvKavaJ5JoF2KCwfLEt/sTJ6yCZJxBHsL94HMxlrTqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgO5MgSHzrOqHWH614f09iTEd3HBM5Nw6a9T75Q8AGPoGFMvt8KhMKimn+N2TzBPS8996zv/E0XnjBZWIHnnen4cCPrqKl6ACwVtu/0cx824YVvFy1QfRQ7g729emnVQkagl70n75rEv/XcyU9DTz6GEDNsGXKbJAm8GWeE7xdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr2ApqLj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr2ApqLj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso2104769a91.1
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788637802; x=1789242602; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhdZEMdOYP0/8741ysv480wUHo9A3YFdvZfxIu/Dtq4=;
        b=Fr2ApqLjD0dVaS6DcpJdrOhNKvpp/gcl4gLQbVI+ZB8SKKSayLsy78VdeBRYOHGpf3
         n8/Xk86rJkAhdlelD8XWBnqXK2fcWTc1a5RD7ofvAG+w1u4t6C6x1h1DCd14R3X6UvyC
         ePis4n5azRnnK9eHevWNxLaE4vsr9NIU1BhSIar0EyezmDTnftt5e/+q08VCjeIe0cwm
         YJc9K3I25TAOkEPtKgUtihqCFnKm1q+dIqXCxFukbXUGYGygastLZTlsN7pVyvDnchvF
         PqzPWPyky5rpnNuMqhql5qJ7x57VfZQ5PIh7wWDtylcgu+/PgyyXM0W7WQqW4a1cGggG
         vejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788637802; x=1789242602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XhdZEMdOYP0/8741ysv480wUHo9A3YFdvZfxIu/Dtq4=;
        b=ibDin7IGHcmhur8z7/uzi6gxHZHFucKj83i2QtkhnxcefuSH7UaRDr2myhYIjF2rtr
         3HOpHVV73wppUZpXsPpQrGXZxraNOaEHBoBUQfQtQ/A0B9OA8N8dngVnH6nfJnYlabSz
         pN71DvomRv+samtVPJGe6tm8U4C5/hjcA+dnSicxVrY0FyfOynNRiBpaiQ/Tzr9OQNm5
         IBhMqHRAfUVvADIZlm/1gCKJb2MOVG4ncTVDFaEBlrwB4pgScnOGIlgSC3hR3dSsRJ7j
         VusCWR/j5wt8yG02LXgEctU27qcMaheydXHazhLAQxXwv//FCbXpX8p4VfaA/r7oUmQA
         NSIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRFYOIxKbPSdH/tQlWqPkZdeJN+6TA39aG4jtZzmVPKoflFmMqHYIEGXF6OEp/LdqA1C9/lwpYshsIXifueMse2pv4HkM=@vger.kernel.org
X-Gm-Message-State: AFuF++ndG/J5yiuAAWNgYGnzJyPtAEjOblV5c2B68O7JmFn7CDpDaNlI
	RQjEa/O8U3ZEVyNrTL4gVZRaq/MI+Na0h89XK6p0erSZ2jU0Lk1ZPh+q
X-Gm-Gg: AYBFou1liuyWK+UTDzc+slntYFKRYPVsRzsRUdb0oF0D/tOP0u2fTbBN3adEB5BSSdR
	g0VRPtOOdV/dcSjxuU8V6eHGL2N6EtPem6bNvYh24rOQdHvCBEcZBCgCKzvsO9XTv4GdC9f+aRG
	qSBSb6ARcEMokXn90lzRVfxYd1THHf3shvYePWPxMvGrdDbSjAsiZpJS0ef//yI0SmNEBpwkGdb
	tt0+FsO4Wq7+9ZocnLpUWphfQfctQs96hgu94CqDiE+2zGQs5GsuvdoRK65qJIZk5k0WPHArnbo
	XY87ZPOUvzAosgLon6WvzxYt+Lw0ehgFCy6MBKpOgTNHH8Jbhxzi4IF0R6Gpna4fraCUawY8Jtw
	yHXpI/Rrq/merNF5zDLBa0FWUg3uWRDtZLwMhBNTNI7Fwt+w+ihDE2XFODku6qt+KKy8xQIhVj6
	32k7Psop4SzOXDsdfYlE9jsguf/VhOm2s4e6RsPOo0OdRf3vh0LvjBNEwHNvd2n9lk0DIXwFYr6
	h4hAW91DV6HQQ==
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr20535967a91.23.1788637802234;
        Sat, 05 Sep 2026 12:50:02 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b51eb40e6sm1554691a91.16.2026.09.05.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:50:01 -0700 (PDT)
Date: Sat, 5 Sep 2026 21:49:55 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] landlock: Fix use-after-free of the source's parent
 directory
Message-ID: <20260905.2e30c1b0adfe@gnoack.org>
References: <E9CDD9E6-E960-4DE2-B1AC-5667D52ABB3E@doyensec.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E9CDD9E6-E960-4DE2-B1AC-5667D52ABB3E@doyensec.com>

On Sat, Aug 22, 2026 at 02:29:00PM +0200, Norbert Szetei wrote:
> current_check_refer_path() reads old_dentry->d_parent without holding a
> reference nor a lock on it, and then dereferences it in
> collect_domain_accesses() and in the audit record.
> 
> A reference on a child does not pin its parent: __d_move() reassigns
> dentry->d_parent and drops the reference the child held on its former
> parent.  hook_path_rename() is not affected because the rename path calls
> lock_rename() before the hook, so the source cannot be reparented under
> it.  hook_path_link() has no such protection: do_linkat() holds a
> reference on the source dentry but neither locks nor references its
> parent, so a concurrent rename(2) can reparent the source while
> security_path_link() runs, and the former parent can then be removed and
> freed while the hook walks it.
> 
> Any process able to sandbox itself with LANDLOCK_ACCESS_FS_REFER can
> trigger this with a linkat(2) loop racing rename(2) and rmdir(2):
> 
>   BUG: KASAN: slab-use-after-free in collect_domain_accesses+0x278/0x290
>   Read of size 4 at addr ffff888160bd53f4 by task llrepro2/549
>    collect_domain_accesses+0x278/0x290
>    current_check_refer_path+0x952/0x1120
>    security_path_link+0x1be/0x320
>    filename_linkat+0x342/0x6d0
>    __x64_sys_linkat+0xfa/0x150
>   Freed by task 562:
>    kmem_cache_free+0x139/0x4c0
>    i_callback+0x4b/0x80
>    rcu_core+0x7dc/0x10a0
> 
> Take a reference on the parent with dget_parent(), and release it once
> the hierarchy walk and the audit record are done.
> 
> Cc: stable@vger.kernel.org
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
>  security/landlock/fs.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 30aa6ce13590..200c83372bbe 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1298,11 +1298,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	/*
>  	 * old_dentry may be the root of the common mount point and
>  	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
> -	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
> -	 * we keep a reference to old_dentry.
> +	 * OPEN_TREE_CLONE).  Pins the parent in both cases: a reference on
> +	 * old_dentry does not pin its parent, which may then be freed after a
> +	 * concurrent rename(2).
>  	 */
> -	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
> -						      old_dentry->d_parent;
> +	old_parent = (old_dentry == mnt_dir.dentry) ? dget(old_dentry) :
> +						      dget_parent(old_dentry);
>  
>  	/* new_dir->dentry is equal to new_dentry->d_parent */
>  	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
> @@ -1311,8 +1312,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>  						new_dir->dentry,
>  						&layer_masks_parent2);
> -	if (allow_parent1 && allow_parent2)
> +	if (allow_parent1 && allow_parent2) {
> +		dput(old_parent);
>  		return 0;
> +	}
>  
>  	/*
>  	 * To be able to compare source and destination domain access rights,
> @@ -1324,8 +1327,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  		    subject->domain, &mnt_dir, access_request_parent1,
>  		    &layer_masks_parent1, &request1, old_dentry,
>  		    access_request_parent2, &layer_masks_parent2, &request2,
> -		    exchange ? new_dentry : NULL))
> +		    exchange ? new_dentry : NULL)) {
> +		dput(old_parent);
>  		return 0;
> +	}
>  
>  	if (request1.access) {
>  		request1.audit.u.path.dentry = old_parent;
> @@ -1335,6 +1340,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  		request2.audit.u.path.dentry = new_dir->dentry;
>  		landlock_log_denial(subject, &request2);
>  	}
> +	dput(old_parent);
>  
>  	/*
>  	 * This prioritizes EACCES over EXDEV for all actions, including
> -- 
> 2.55.0

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Tested-by: Günther Noack <gnoack3000@gmail.com>

Thank you for the bug report and patch, Norbert!  Excellent finding!
I can validate the bug and that your patch fixes the problem.

–Günther
