Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A1770E0
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291806; cv=none; b=bB90VH6VXw7XvP/R9V5huD6YIaw3ukqS99Q3eHRQqQWHRYbcx6NjFer1+CkRT467bKtlqbIQZSk7qImWZ/Ty1d1uEvYDtPk+W1G3cPFWDRJfthNht9SUqhTpszRsrXb6pV6ggGWYSXkGxMpTduDqKNtINe9RIHvyN0Y3ts+fV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291806; c=relaxed/simple;
	bh=rdVM/YIfSPSNxLizWmV18wYVVeSmFkt3mfv0QU43eXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTzNewv5Fj1MSSG+dGVIQmLAFjUADUw4Qld/t/SiWcrOC6xZbVheLogRZTO5oZ0/Bu0KKA6moSSeQMi2eK9ikaSr3qwtkkUQGXh9W8exFxACJVpvqIsQ1DRGvdDbWFuMRUjSbzYtgGgJe7ZiKm2Dq3fPpiA5vMk8T+RXV+kxkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 449LtvFn081120;
	Fri, 10 May 2024 06:55:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 10 May 2024 06:55:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 449Ltuvb081117
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 May 2024 06:55:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <431b2707-1384-40cf-9226-b2ad90730225@I-love.SAKURA.ne.jp>
Date: Fri, 10 May 2024 06:55:55 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
To: KP Singh <kpsingh@kernel.org>
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
        andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
        renauld@google.com, revest@chromium.org, song@kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
References: <20240509201421.905965-1-kpsingh@kernel.org>
 <20240509201421.905965-6-kpsingh@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240509201421.905965-6-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/10 5:14, KP Singh wrote:
> +int security_toggle_hook(void *hook_addr, bool state)
> +{
> +	struct lsm_static_call *scalls = ((void *)&static_calls_table);
> +	unsigned long num_entries =
> +		(sizeof(static_calls_table) / sizeof(struct lsm_static_call));
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++) {
> +		if (!scalls[i].hl->toggleable)
> +			continue;
> +
> +		if (!scalls[i].hl)
> +			continue;

If scalls[i].hl can be NULL, checking scalls[i].hl->toggleable
before scalls[i].hl is not safe.

> +
> +		if (scalls[i].hl->hook.lsm_func_addr != hook_addr)
> +			continue;
> +
> +		if (state)
> +			static_branch_enable(scalls[i].active);
> +		else
> +			static_branch_disable(scalls[i].active);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}

