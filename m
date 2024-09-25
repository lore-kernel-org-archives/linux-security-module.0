Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E31A2642
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268606; cv=none; b=Zngd8rNlIREcSy86zQCZb7Z4YOgoH2ic1XbAOj8WLvOnIi5ONzmjfA/P9fEz1iiP9rsZ81eJ3aqbVelQ/GdjHfZw1BIlfETksfSyrUYCXyPzbJmhFG5BbHw8tCvjnVeKbK1f/KMFIpO0ClLXO6xQ/PQelijt32R/rxlaHvfBVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268606; c=relaxed/simple;
	bh=UP8TlT4fnM/2M3rlEe0iwTUhg/gmzJkxqaQwggSPGkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQNQA/qTzvBMBS13fY/Y+5JDsrn8e3ucbG8E9ds0pGZcnJpo3rN5aDo5T5OSLm/8UO8U3OyVJntDH5sZ+1g2MSOoJPaL6rJiXp5ptlNOOt/IFhVZcy/ngRLKJgw+SsmS3f5FMKUOfnp6AryC0Vr/DeZgWdUanv3s945FZq18494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLlvq9Qi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLlvq9Qi"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365392cfafso6975109e87.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727268603; x=1727873403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyexOjK4t4+icAZ3KrLZwvDy8q8cKnhN5qL20Xf6xns=;
        b=VLlvq9Qit2ovL+t3SsxnJlOgPjrw5Hvho4ZzuDhGo0GptMD3+EGSMj8N7nT9UiSa87
         qdXG7zslVkv1V0zIAEg1q6lrxnjad/qt+6zE1zrnJro5t4aTqmtvSo3XVgbBrFLCgoni
         /1UkYKEx+O8xcbIdlB5Jjmk7kiXth7Dp3kvQepuyJly6ftsrOzFC7+X/qSkO8H8K0VIu
         89hp2V+xPf2bpk4OTDDnqvXXPhZCnAXDHrBQ3kHwIVvj6IsL02Ldyvki212gdpNhDIeN
         CZtu9YxOXck5IVBklzqiFucwDVEMGvaYqX7oPVW8/1tGDj+CZFYDPdFNmSbh2n/b/9VU
         8aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268603; x=1727873403;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyexOjK4t4+icAZ3KrLZwvDy8q8cKnhN5qL20Xf6xns=;
        b=slEZM0QYXIYvYZ8jx+gjSMXbnCc0oNZ4s2hyWJrcCSb1bc5SLGIfxIq2y9/2ND5TYv
         gUqXDnPUxAi/Mg+sMS2g8a27juV7h7Mr7hzPz2HhU2qdmGrcI/h44BSY9uVr7tL+ZKcP
         WweSq3GuJSrXShM8HKRQWLZaWNQfLRSrcmCkR/pOPa4tLR4oh+56iZ7YobdO/mDqc2VW
         o62eAUlz+yrmO7lzKMHwyeGRt7Kd28nWa9bQbw7jnsXNqAsKTSOoHR2Tfi3ZMUfSzvTI
         0MnTAFVf0kxXx6kZoJHxlZ3xyuPha/krY2rHl5VVQtd/C2Z5F61OJVvd/cku3ei2rGxw
         RbQw==
X-Forwarded-Encrypted: i=1; AJvYcCUGFWdEVpBAYaK8x3EYhZKNjUvCNoJlDZu2jnZdSImnf5n+0lTGOKXSf8io/lR5fcl/Hp0PIzoMWxTLIOpHT3JvHgNS6Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+3a2G2KlXRCbOMAlLchOBZUMUEZF0H8BXR9ZV3As5ja7pGLt
	7yrMiht7fU/+EvDVFvCQf312Q7cZuDQ9vl5fxA2aaLsSOwc858AL
X-Google-Smtp-Source: AGHT+IHS7UPocv1EVodImnUwDtxi2YESqToqKqHe3Puffex/s4KHj67GPKK2OwjO9I7fnZP1Mr6hOg==
X-Received: by 2002:a05:6512:12cf:b0:52e:be50:9c66 with SMTP id 2adb3069b0e04-53877566158mr1456798e87.53.1727268602287;
        Wed, 25 Sep 2024 05:50:02 -0700 (PDT)
Received: from [192.168.1.100] (h-98-128-166-54.NA.cust.bahnhof.se. [98.128.166.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8648e87sm518313e87.203.2024.09.25.05.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 05:50:00 -0700 (PDT)
Message-ID: <9ec5667e-6c3f-4f0f-b0a5-2047c3345a9b@gmail.com>
Date: Wed, 25 Sep 2024 14:49:59 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: fallback to realpath if symlink's pathname does
 not exist
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 tomoyo-users-en@lists.osdn.me, David Drysdale <drysdale@google.com>,
 linux-security-module <linux-security-module@vger.kernel.org>
References: <d26b117d-1e13-42d1-9580-6dd6ce034c21@gmail.com>
 <ca37ee54-574b-44ba-b967-ef6f8f2780f9@I-love.SAKURA.ne.jp>
From: Alfred Agrell <blubban@gmail.com>
In-Reply-To: <ca37ee54-574b-44ba-b967-ef6f8f2780f9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The environment in which I discovered this issue is a homemade 
sandboxing solution that chroots to an empty directory, and uses 
seccomp-bpf SIGSYS to forward filesystem operations to the sandbox 
manager process. The exec target is a statically linked binary 
specifically designed for said sandbox.

I don't expect that exec of arbitrary programs will work (most of them 
have .interp = /lib64/ld-linux-x86-64.so.2, which doesn't exist either), 
but I do expect that this specific program works.

I don't know enough about the kernel to say anything about that patch; 
if you say it works, I'll trust that. Thanks.

-- Alfred Agrell

On 2024-09-25 13:01, Tetsuo Handa wrote:
> Alfred Agrell found that TOMOYO cannot handle execveat(AT_EMPTY_PATH)
> inside chroot environment where /dev and /proc are not mounted, for
> commit 51f39a1f0cea ("syscalls: implement execveat() system call") missed
> that TOMOYO tries to canonicalize argv[0] when the filename fed to the
> executed program as argv[0] is supplied using potentially nonexistent
> pathname.
> 
> Since "/dev/fd/<fd>" already lost symlink information used for obtaining
> that <fd>, it is too late to reconstruct symlink's pathname. Although
> <filename> part of "/dev/fd/<fd>/<filename>" might not be canonicalized,
> TOMOYO cannot use tomoyo_realpath_nofollow() when /dev is not mounted.
> 
> Therefore, fallback to tomoyo_realpath_from_path() when
> tomoyo_realpath_nofollow() failed. This change makes TOMOYO unable to
> utilize argv[0] for controlling domain transitions for multi-call binaries
> (e.g. busybox), but this change would be better than failing to handle
> execveat(AT_EMPTY_PATH) inside chroot environment.
> 
> Reported-by: Alfred Agrell <blubban@gmail.com>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1082001
> Fixes: 51f39a1f0cea ("syscalls: implement execveat() system call")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Alfred, what do you think? That commit mentioned
> 
>    This does however mean that execution of a script in a /proc-less
>    environment won't work
> 
> . Are you expecting that execution of non-scripts in a /dev-less and
> /proc-less environment work? I guess that majority of programs depend
> on /dev and /proc being mounted even inside chroot environment. But
> if you have programs intended to be executed in a /dev-less and
> /proc-less chroot environment, this patch should fix this problem...
> 
>   security/tomoyo/domain.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index 90b53500a236..272e8474d15f 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -723,10 +723,14 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>   	ee->r.obj = &ee->obj;
>   	ee->obj.path1 = bprm->file->f_path;
>   	/* Get symlink's pathname of program. */
> -	retval = -ENOENT;
>   	exename.name = tomoyo_realpath_nofollow(original_name);
> -	if (!exename.name)
> -		goto out;
> +	if (!exename.name) {
> +		/* Fallback to realpath if symlink's pathname does not exist. */
> +		retval = -ENOMEM;
> +		exename.name = tomoyo_realpath_from_path(&bprm->file->f_path);
> +		if (!exename.name)
> +			goto out;
> +	}
>   	tomoyo_fill_path_info(&exename);
>   retry:
>   	/* Check 'aggregator' directive. */
