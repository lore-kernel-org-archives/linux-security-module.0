Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DFF4C7C;
	Thu, 28 Nov 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732758338; cv=none; b=bz2Z2FMNN7XgUc9AZM8rvvJlsjfkQiWMvDZ0cLeReveMg0U+XSVEY5mo9wU1J3Dly8QVEx/1Gn7aASI2Pm6+Pr9ezt1tP4ndjGdJeK7Qryu+Fj3gk+idvHgDOltv0OGd4LVraRabKblwUx5PDFOsPo3iCXdXXmprmw32mu0+/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732758338; c=relaxed/simple;
	bh=yuC/DqKdSJpZMyxKYTTgBUuGxFyWG0qpYNLRxxo2mUU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TZdIglCQJsUS3LcxWo8/DBHuf14a+kBWnVA4Dr7C1O3LkK7/krPWfFj4wyjKDd1PTTRQbbzcW8Y/p4amnilfAHpzaTm9mP7gVKoGq6gbX3TZw/0zwKIM5/uSo9NzwFgJb0zIq49TZkL6zFXeOMKZGYp+NX3+H0LpiC9ruTpEMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uOISfUnd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uOISfUnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2B2C4CECC;
	Thu, 28 Nov 2024 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732758337;
	bh=yuC/DqKdSJpZMyxKYTTgBUuGxFyWG0qpYNLRxxo2mUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uOISfUndAcjBTDGd0M+QePGbr78g096PjKpfjXSTe0gAacr6HPJtmfUyZFkNvGG3d
	 UA7O1AJ/qsBkhTSkgmR5ygBR2g1Xb/7z5TK4LXndWRzBffkOueNQlqFOQ62xWrj7HL
	 SDMixjbPCbPFW55c/128Cv61TVGxMtaMg/JdtNx4=
Date: Wed, 27 Nov 2024 17:45:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: viro@zeniv.linux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
 brauner@kernel.org, zev@bewilderbeest.net, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH] kernel/sys: Optimize do_prlimit lock scope to reduce
 contention
Message-Id: <20241127174536.752def18058e84487ab9ad65@linux-foundation.org>
In-Reply-To: <20241120132156.207250-1-zhen.ni@easystack.cn>
References: <20241120132156.207250-1-zhen.ni@easystack.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 21:21:56 +0800 Zhen Ni <zhen.ni@easystack.cn> wrote:

> Refines the lock scope in the do_prlimit function to reduce
> contention on task_lock(tsk->group_leader). The lock now protects only
> sections that access or modify shared resources (rlim). Permission
> checks (capable) and security validations (security_task_setrlimit)
> are placed outside the lock, as they do not modify rlim and are
> independent of shared data protection.

Let's cc linux-security-module@vger.kernel.org, as we're proposing
altering their locking environment!

> The security_task_setrlimit function is a Linux Security Module (LSM)
> hook that evaluates resource limit changes based on security policies.
> It does not alter the rlim data structure, as confirmed by existing
> LSM implementations (e.g., SELinux and AppArmor). Thus, this function
> does not require locking, ensuring correctness while improving
> concurrency.

Seems sane.

Does any code call do_prlimit() frequently enough for this to matter?

> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1481,18 +1481,20 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
>  
>  	/* Holding a refcount on tsk protects tsk->signal from disappearing. */
>  	rlim = tsk->signal->rlim + resource;
> -	task_lock(tsk->group_leader);
>  	if (new_rlim) {
>  		/*
>  		 * Keep the capable check against init_user_ns until cgroups can
>  		 * contain all limits.
>  		 */
>  		if (new_rlim->rlim_max > rlim->rlim_max &&
> -				!capable(CAP_SYS_RESOURCE))
> -			retval = -EPERM;
> -		if (!retval)
> -			retval = security_task_setrlimit(tsk, resource, new_rlim);
> +		    !capable(CAP_SYS_RESOURCE))
> +			return -EPERM;
> +		retval = security_task_setrlimit(tsk, resource, new_rlim);
> +		if (retval)
> +			return retval;
>  	}
> +
> +	task_lock(tsk->group_leader);
>  	if (!retval) {
>  		if (old_rlim)
>  			*old_rlim = *rlim;

