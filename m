Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D341B0F33;
	Wed, 19 Feb 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993596; cv=none; b=W07hPGzbNwf+v8IXbOKN2+clvcOu8UoN+N6k17Ms1gMS80H8XAE/6HelgpY2e/BKqfZc+2e54SrsIt5heokAL9bpUKNToivstdW9zlALToWHwQrN2xBIU3c9FBVSCHGyawT/Vi1g8CBNDaT6x3Zo2y5mw+c45tdKKFayUvGFuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993596; c=relaxed/simple;
	bh=B/tsrWMqdKAycCUkzWrulcuHm4sff0bSqRXkpZ6/uOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTyDHi2xWdpqgVVCSs89IfeWsoX7JfPE0QkZRshGenptFpHVzk0M2Hxu0w9n32dfOA/sJELtVpQz3qlZYPId56bFU2O+FhnrMbYwgVMtD2ES2+rFFYcbiyGjA0za2JIUrlAL40XcaDHHQyFS/RRZs4sx0iiJ/Y5FzZ44boMOcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shZgsFPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shZgsFPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7079C4CED1;
	Wed, 19 Feb 2025 19:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739993595;
	bh=B/tsrWMqdKAycCUkzWrulcuHm4sff0bSqRXkpZ6/uOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shZgsFPJzX/Rmq7lXoap6nhFc2etFR6yVN3weXpAhdPHANrwtY05A6znl4crRQdtW
	 dJ4yGoG4bawGoi3oy90HWvHUc3GjIZc2IfYzQ6RWpcF1cD/MidmIXwwwqbjJq8O4U2
	 dYmpCeAJ4kwAuQs4ojP8UipQryqEXadW8sOgDyW8hFIzyl0xuvm0OCmV5gOc1Y4QKy
	 bn/r+uwV487M9RnOZjHkBt4GVpPAuODQu19gXQyIYyqPwetjHueWhgsJ1mXl975edD
	 ZN/nD4KCnGNLes7ct5aybqPKnVbjf23kBqP+Q/vcnQA3k5rNCANPEuUEbhfRPoBee9
	 pvE0uwXxGb4tg==
Date: Wed, 19 Feb 2025 11:33:12 -0800
From: Kees Cook <kees@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yama: don't abuse rcu_read_lock/get_task_struct in
 yama_task_prctl()
Message-ID: <202502191125.1A6F07E@keescook>
References: <20250219161417.GA20851@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219161417.GA20851@redhat.com>

On Wed, Feb 19, 2025 at 05:14:17PM +0100, Oleg Nesterov wrote:
> current->group_leader is stable, no need to take rcu_read_lock() and do
> get/put_task_struct().

Can you explain why this is true? In trying to figure this out again,
it seems that the only way current->group_leader can vanish is if
the entire process vanishes (fork or thread exec), in which case the
"current" in this prctl can't be happening; this appears to be locked
behind tsk->sighand->siglock ?

-Kees

> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  security/yama/yama_lsm.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 1971710620c1..3d064dd4e03f 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -222,7 +222,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			   unsigned long arg4, unsigned long arg5)
>  {
>  	int rc = -ENOSYS;
> -	struct task_struct *myself = current;
> +	struct task_struct *myself;
>  
>  	switch (option) {
>  	case PR_SET_PTRACER:
> @@ -232,11 +232,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  		 * leader checking is handled later when walking the ancestry
>  		 * at the time of PTRACE_ATTACH check.
>  		 */
> -		rcu_read_lock();
> -		if (!thread_group_leader(myself))
> -			myself = rcu_dereference(myself->group_leader);
> -		get_task_struct(myself);
> -		rcu_read_unlock();
> +		myself = current->group_leader;
>  
>  		if (arg2 == 0) {
>  			yama_ptracer_del(NULL, myself);
> @@ -255,7 +251,6 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			}
>  		}
>  
> -		put_task_struct(myself);
>  		break;
>  	}
>  
> -- 
> 2.25.1.362.g51ebf55
> 
> 

-- 
Kees Cook
