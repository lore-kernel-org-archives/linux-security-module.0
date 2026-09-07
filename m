Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154614503ED
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774909; cv=none; b=DBGvsZ4VtTOLE/90imJ3ipBklxAg7USnihAW/2Q2Qiee3dZIxrUleWy+lIRdk0x4Op6l55GkUa1+HKHduL27xlFGrWESZ+qrL09okmEoZEf6No4NrNYF0pcpJQ27uj+q7XA8AwxDtCfyxIZLkGapH9meLj1Nzws19x6b1uEVQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774909; c=relaxed/simple;
	bh=19coJIylWvxz6gMx5zXstzR5ZZbvm8zgO20K0pyaTfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBH6qAz+q8G3wTXhX6DCGUdK9Af/xLt68hMrcMd7sIVu7Kkm86TS58chr4AgGRVSrE1ew3MLb0xyY6lMI1pSRUvG2yUmtNiNQcKIBQZYZFTBPUWTE1FDzCNi0omZ+Gjpnfboj2IuzbiuyEFYWB9192gke4FeKcGX/LBxHhFroRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PgZAPsFe; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PgZAPsFe"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdj9F3CnXz9PS;
	Mon,  7 Sep 2026 11:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788774897;
	bh=RZ454quDtwdBAAiqCxnXu5jqwnyWsyz8+Os7/oS/vwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgZAPsFegumoigbYo2RzPJ3pDpFl54758utDK2nc+EgH3l6n52pQSDt8D8Y7Dh8ZP
	 VaWbUwzDUGa5bDLFW0VZRu6myBGlwaSm3sJcXdoQQqEwfoPQHMSmWFO2FvTNu97cTu
	 1S/K5quwCNT4rS8Tz05Gq6f4KrJKLS6CT9FqTRTY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hdj9D3KsZzVMq;
	Mon,  7 Sep 2026 11:54:56 +0200 (CEST)
Date: Mon, 7 Sep 2026 11:54:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Norbert Szetei <norbert@doyensec.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] landlock: Fix use-after-free of the source's parent
 directory
Message-ID: <20260907.tuwieD4ohnei@digikod.net>
References: <E9CDD9E6-E960-4DE2-B1AC-5667D52ABB3E@doyensec.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E9CDD9E6-E960-4DE2-B1AC-5667D52ABB3E@doyensec.com>
X-Infomaniak-Routing: alpha

Thanks! I'll fix a few minor comment issues but otherwise the patch
looks good (i.e. no need to send a v2).

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

It's filename_linkat().

> reference on the source dentry but neither locks nor references its
> parent, so a concurrent rename(2) can reparent the source while
> security_path_link() runs, and the former parent can then be removed and
> freed while the hook walks it.
> 
> Any process able to sandbox itself with LANDLOCK_ACCESS_FS_REFER can

In fact it's any FS handling.

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

I'll describe both references cases.

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
