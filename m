Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68240364
	for <linux-security-module@vger.kernel.org>; Wed,  8 May 2024 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126463; cv=none; b=KyjT8MgepsF3YDHy9qYTYZt92hk3D8o6HgRvjqbkkI5B7KQLUQ0OFyIYwNacrZF9Qlud2TOER2hE1Rd6560jCE0kCCUk2oP+3vkEIQZBFvPqwCxvXGaAtPr9kA6UFWkwicetoWDHt/Z0WI4rjWT5ftLjnd+zy6gekFL814WJBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126463; c=relaxed/simple;
	bh=Dd1873tTL8mrfnAaIoCc3BHpnqSCaA0yE/vEawwAGUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC9tYisQTwkNuq+2UDpan8SY8VN/SXEPfdAv3nrxq7RMJNgwbKT6NyRsuangNz1st9nCzH4W4OnixaftDlE4rVN+fAk2UD6Db3TEClmn3VBRfpHdKMrAD+vA9Zrpe5pVx22wU8MpVig8TsXVVWjlrMVg5AjbpgGVvaDHwRnkg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aXgaol+9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aXgaol+9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3ca546d40so29501575ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2024 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715126462; x=1715731262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgufUMFIe5CgvxNbbw6MG+VJiW0+zFKlSCfBrZk9Ldo=;
        b=aXgaol+9gFF9vNwz6plXY6shVat85y+MTP7LJ38cTFzUvP2bmiQICsHx+iq6AuGc6K
         UfQYcRkT9h1hEaKAF+eFuCoTqVHr7pwzx+DPrxUfY0CzSuj2HZ1uBicLLPvggDtaLo96
         1tEbm5/BNEmythxTY+s8x26x67boLLjvlFjMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126462; x=1715731262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgufUMFIe5CgvxNbbw6MG+VJiW0+zFKlSCfBrZk9Ldo=;
        b=iY9D88txlD9XaFLWb0gTpmLu6WH9yiKIpGv2M9GVIRROOLpSrtPmr7SmrjxNlMyrRt
         VYq/fSum++hMREpMuU+9ihnTuWIxterphNdOhDoi5JcY1+pHzIP8+mzfbN0mdHRRXs7C
         hXLpLr0vlsV8Fky1ftQn199RxtpRAYY23K1rLboINPMloVBvzQnZKLC/tyKYaC16rbBa
         RsaW6HU9TxAuXNRtV5DWmRZ6O4onTWLDhIaIsG9hA/0gjkrQKhsZ3jDezFfAgDhpAtrV
         JrCMCgWO/xpM3rViAKZP14Kgd+d0EpnIMPF6bcpNqwlgifcN/Jtnc3i33/N0cZS/r5bk
         xFgg==
X-Gm-Message-State: AOJu0YwtZIbuPKGyNbg2ZA/g3uqlEOoH+XhCA4XnYJhX+TEdQxED6vPE
	w9M+usAvwcpdmnXJ0IRIrEnAphGSgLRsDWXa3N/FK2H9O/Lia3s8JToOyr77Fg==
X-Google-Smtp-Source: AGHT+IEqVNpGRLhqVw8kSUrB4Az3m0syouxfJ3Vc9EaQTLuN0eJuZiZbA1z0yyXDcTk4ZDPLSwmANw==
X-Received: by 2002:a17:903:41d0:b0:1e2:9ddc:f72d with SMTP id d9443c01a7336-1eeb019739bmr12303355ad.26.1715126461737;
        Tue, 07 May 2024 17:01:01 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902b58c00b001e4881fbec8sm10605606pls.36.2024.05.07.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:01:01 -0700 (PDT)
Date: Tue, 7 May 2024 17:01:00 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
	renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
	song@kernel.org, revest@chromium.org
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
Message-ID: <202405071653.2C761D80@keescook>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507221045.551537-6-kpsingh@kernel.org>

On Wed, May 08, 2024 at 12:10:45AM +0200, KP Singh wrote:
> [...]
> +/**
> + * security_toggle_hook - Toggle the state of the LSM hook.
> + * @hook_addr: The address of the hook to be toggled.
> + * @state: Whether to enable for disable the hook.
> + *
> + * Returns 0 on success, -EINVAL if the address is not found.
> + */
> +int security_toggle_hook(void *hook_addr, bool state)
> +{
> +	struct lsm_static_call *scalls = ((void *)&static_calls_table);
> +	unsigned long num_entries =
> +		(sizeof(static_calls_table) / sizeof(struct lsm_static_call));
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++) {
> +		if (!scalls[i].hl)
> +			continue;
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

First of all: patches 1-4 are great. They have a measurable performance
benefit; let's get those in.

But here I come to patch 5 where I will suggest the exact opposite of
what Paul said in v9 for patch 5. :P

I don't want to have a global function that can be used to disable LSMs.
We got an entire distro (RedHat) to change their SELinux configurations
to get rid of CONFIG_SECURITY_SELINUX_DISABLE (and therefore
CONFIG_SECURITY_WRITABLE_HOOKS), via commit f22f9aaf6c3d ("selinux:
remove the runtime disable functionality"). We cannot reintroduce that,
and I'm hoping Paul will agree, given this reminder of LSM history. :)

Run-time hook changing should be BPF_LSM specific, if it exists at all.

-- 
Kees Cook
