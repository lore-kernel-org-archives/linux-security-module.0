Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112B486BA9
	for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2026 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524470; cv=none; b=HPPcpBq/dCsl8nJQ9UoLIhJ5TbS7aB362XUelz7A6099P2gCa82yh4y4TsgKd5fYiUAe/zW3EQ8PiqBQuECmmP6cI9WlTEwWdTTiZOw3elYtF96oHTMMEsPjdSwyvt7HOLtc7ZbOHI5L65UIrQdztkpZe9ax18JgZy1CAlW8Hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524470; c=relaxed/simple;
	bh=lpkge4L78N1WSwNMWGQNqSrIb/12DZQYNSyP4jQOpeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgc5IFSGVqklPKGSzICCYp6Te7Ha7z6+/ZerNj72y26+YPfpmqHaEroZ5y38QXR1+vSuB95B6dFCL4xzbZep8NreBHzfr4lNnWGyn78yFxj/RQ2RlXQR1y/cqyV/JBj08TKGkIrU9+xMGFwMFQPAYqh/Z+8mJm+orXAj6xuHJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaCbRCs+; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaCbRCs+"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66f8908a887so1024438d50.1
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2026 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524468; x=1789129268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jY4vMQa0HE5PeeFsSdbZPWZR4XiOqxY9qhbCbQ0F2+c=;
        b=LaCbRCs+OX8kudZQBLfIu8P2rFnJPt17pZrL2AEEaL+wivURQkyb78N2j3MhxD/KH4
         DrV1IpvG74DH26xdFp1/4YwDdvS7+u6qPvEnp6TNw6BzAXsZN71nir5ys4CfGuj5PGss
         ujnmRvYVOdkxknJdu9m1Eb9TL/yTdeBBcrnwHD3pnK6QNdWjhXsR60KLs9XLfx6UyaJO
         7961uQr9IIxpJEeglk4VJaoon9ZYiSCu32d3+T8A9M0ZCA4GAWK84HPMAZq7dlF8YnEq
         vV3iiZlCSG+JG9mFKQWA6vfXj3Ibi1M91PJWt6MOafk+Tr8wkYTkrVLXVFzLAyJ+OF+2
         Cjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524468; x=1789129268;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jY4vMQa0HE5PeeFsSdbZPWZR4XiOqxY9qhbCbQ0F2+c=;
        b=ayoUWk+MxeIst7giQFQVU4Pym/De0X7SefpcFSo7o5bgHz+8+5SLnq2RbyttiCFEvd
         3kbiakLKfeO29T27YmMOCFbM7Q5b4tQxJnlY5NyvmNjY66SwigjysW/XHl66X54fVpad
         peVvNYP1Bq1SvHeYunJ+12HH8Uw5SjBOejM83J1jAZqQcBE5WFABYFpAashSVetT3bbB
         nPbhuij5Z1Hsx13qi/Xr1uNDG0gupuEGBIznEwy3oUb9z4jwR1/oCx8kU3yH1f1alvRB
         ukL9fCjx5MecI3NC/5W0i1O1WpEc3a/apkMdYJQfaACYn92zd1BPbvOPG2lwQcua7alp
         2evA==
X-Forwarded-Encrypted: i=1; AKwUvBymo+S/gyImE8y9MbZ7UuGxTIXj8qVgPUma81tQ6FZ31P5I/72CQc6SYBJKnsfYdIZbkr1yb0o+uIVvd3GWL0l/vRihi1E=@vger.kernel.org
X-Gm-Message-State: AFuF++kPVbApWkJ0vLOUkjTo1SSVlEIZ4vYO4bGghXx9G9Wsh8cdpxAK
	d0oy1v0PFjQURUvhfHg2WSdxsoIvPFTDMB2/fzXx5MN9pfQGtH0Xmq/imwVhIMI9
X-Gm-Gg: AYBFou3J1JVMmXc5gxa39AhUhFYJ6NRixatmaqxYisHIBAIEbTn5pwbiSZnqx/BqvH1
	4XQRSCgAq2xKlwYDVzAEYnCUXQqOlJRuOb/1pS3xsVmkpgCfg3lwW3ntIWXqHIGEH5DPspY4iCN
	UYzShjqJiAA2NHmhro63ASiMFdCYPPI7Ho+iqjSkHuWg5pF2GysD+t+XYSI+E/i2jtZ/nZE7alG
	M7pUokmcI3Zn04M0rR9aYG6WVgn2NJ1hYO53D78mEledG/dEdKWLUTtHN4GVnCfEkjKHPYdy4xe
	6B5D/Ngk6xdaiBcMV5ZPnrZk9whGkQcJnCgFukprOkpSUfmG61K/WCOno01P1AF+x5cXRoBPZzN
	hxpjD+YAGWiqvcUuGbYx+W7ccijCBKcgodRK2YHCJJmVCFoWNqsP23i7vqFYZciK3HDGlyD1Fmg
	FB21Z2ReE324JLxWFfHuhwrjE8+2IIW4EKYO5Ze6J1P4RL2ssaGPAxxiAZf0lwsUsxv9eMUluea
	UJ0H/5nVrBF21el3FdpkBK5uVYIrVkKqw==
X-Received: by 2002:a05:690e:4419:b0:66f:c1be:84d5 with SMTP id 956f58d0204a3-66fc1bf50cfmr43984d50.67.1788524468156;
        Fri, 04 Sep 2026 05:21:08 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4695:e8de:7b45:bcfd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb494b79bsm2039103d50.16.2026.09.04.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:21:07 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:21:02 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Ye Liu <liuye@kylinos.cn>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] security/landlock: convert thread iterator to
 for_each_thread_rcu
Message-ID: <apq3BabHp9Zvba-G@zenbox>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-9-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904083001.553587-9-ye.liu@linux.dev>

On Fri, Sep 04, 2026 at 04:30:00PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace guard(rcu)() + for_each_thread() with for_each_thread_rcu(),
> so that the RCU read-side critical section is scoped to the loop body.
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  security/landlock/tsync.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 0b71e158c3f5..f1c08aae179b 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -335,9 +335,7 @@ static size_t count_additional_threads(const struct tsync_works *works)
>  
>  	caller = current;
>  
> -	guard(rcu)();
> -
> -	for_each_thread(caller, thread) {
> +	for_each_thread_rcu(caller, thread) {
>  		/* Skip current, since it is initiating the sync. */
>  		if (thread == caller)
>  			continue;
> @@ -376,9 +374,7 @@ static bool schedule_task_work(struct tsync_works *works,
>  
>  	caller = current;
>  
> -	guard(rcu)();
> -
> -	for_each_thread(caller, thread) {
> +	for_each_thread_rcu(caller, thread) {
>  		/* Skip current, since it is initiating the sync. */
>  		if (thread == caller)
>  			continue;

Reviewed-by: Justin Suess <utilityemal77@gmail.com>
> -- 
> 2.25.1
> 
> 
