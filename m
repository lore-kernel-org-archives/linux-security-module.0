Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0332694C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255618; cv=none; b=Gw1Ic5tj5rpT2IvxAKDk+gKy/yJbRLfkYYzmwLcWP9DzYNRLtm/ecsB1oNFjPjLHjcyLcVirERZdHeMb1FXCmQyEwnzds0wqw8mUSrmXEINCcuIYmQZMp/5zZeGLo936muk6ZwdsKZ1H4JJd8Qf7mqACBqmYN0oNpBzr2Y2tkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255618; c=relaxed/simple;
	bh=PHUZ0CnPFukmdKLr8C1Nq2dFO/uAJ8EbagLeGB+zURk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONTJMHEIN5ssXK53caF+KupArPbbYoh2jLTaH1U1K35wHxc2ILKG2Eo3YvBtKL1V4A6oX3fQ5lH3wRuT5xs7A9t1l69v6DZ+rDibxtboADBdVUkLJMpHbVXZvufOFVVg3n+urRhOKU6Mr9LttmN+fyRUgfbvO6d7LVEaqLEQuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPg3ON6s; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPg3ON6s"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8fa79b9fcdso551129466b.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771255616; x=1771860416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J7y6qD202tS9ZJwEULP0hfr9PzyjZeypcJCVZCRQP+4=;
        b=aPg3ON6sGmypk5snp7CUWg07IgBBkU4lqybWEv3bDTneMFM6R06OP5QuoB8yfzQUVn
         lXW7TnZCcrk/z4sfYP1NgLz9edzUPjhrKlO6HpB2f9SoX5vrduyzrXYYfUNWU8HJwmr4
         duG5qoPsZVLHLMuboV+lQwNAX+SiedD1NWOnC2ANDCTNMUzZY+M+MpEwPWoZY+6JK5OZ
         LmqbKBGsqUfXbjUlMGBnyTJjHNoU6l/V4KFHWhmgPK3bpUtzllNC0KyplUpqFUvdE6HA
         D7wIVHZSGwbNYQNTAq3kRfHHMBA5h4cXJfvkdIgDDYSAJbBoAHaguxaXzWKZL1vS7S65
         uIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255616; x=1771860416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7y6qD202tS9ZJwEULP0hfr9PzyjZeypcJCVZCRQP+4=;
        b=KZIDCPeB2t1/VljF77rmfp5gAX7S8KUUYpC+kTIUjqiTthv4CkDQ72dcbiHk9xCDXc
         ByUxZO/k5zjE876mMdCiI68QMKPdG7gep20qozC7bcb4OSsfywNAcQav3fwqEw3oZpH4
         FdhqhQU7nvjManefsBR3DVWsvLRHQ/5iVaWimvJ23oZ43lf4IrWWQC9Y8MBsmNDHPPjD
         n6NL4Fv1Lvnul1RLWyTkrkdBVzIfjqCcV7MI05bQcCxz292tNdVNZatoENhZSOQgwFeo
         4j/6ab00y4uLaAVFr6jRS2By0BsCCcIJLLJZECszYkqhYF35E1nvFkufpdFOZDeICZ9P
         5TAg==
X-Gm-Message-State: AOJu0YwQFC0fFE+WAz7OabsmCsRX3wajbLbffVKdybf8oVPpO1/3PW93
	h4dZfm0ujJwt8NPraLOSJ0XquC6gOPh9Sv2oxnS+ppSZPSGFPgMPs4s6099sS5QycOfz126nj3r
	hOsvW4w==
X-Gm-Gg: AZuq6aLInwwduXT+edLmWnsznQx4dsNbinx/juqYHBVPuxlZkZLhJWPAI7/qpxHJAKS
	GbWwNm9M7USmHxJXW/IdkzPtc/8j1ABP8o3FBL1zzIdO9uTJ7yzyA+5SM/MMW3Sh/HYTh6iZN89
	77vQcfAEGv4ye19NQik5avQDmxvGbKQZOcAGMAyo22JStdf0CvV5ZISQRZUJhB0vdz5DZG6ae7v
	+YVbvgKPqOfNWX68RIrCkGF67ouPrj0fArlFfksifuGIQUXtbBxQNg/ttvpjrh6pzTairSJMsK8
	eZJoNabH1HhmVUfjSmzl1crhj/muM3swgccSsLMiAdLceJ/fr+Caxsjqlm8fmJE4sowycI29ZpC
	TQNEJdIIcRA9fiTtOqOOijA+ruLgFCaGrEH+n8/XE6qN4NdcObwE1D79SGJXt3alrU6M5ZuAUew
	Ng7BaF/AAamrQiGqqvxJikH7394eQoDxVwdcPzNICCVvjDayfwarLG1g==
X-Received: by 2002:a17:907:1c8f:b0:b88:5894:6ba1 with SMTP id a640c23a62f3a-b8fc06b953amr557276666b.28.1771255615476;
        Mon, 16 Feb 2026 07:26:55 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:3652:d409:188c:c0b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7663d30sm267043266b.49.2026.02.16.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:26:54 -0800 (PST)
Date: Mon, 16 Feb 2026 16:26:50 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 2/2] landlock: Improve TSYNC types
Message-ID: <aZM3OhhimEFrt62Y@google.com>
References: <20260216142641.2100407-1-mic@digikod.net>
 <20260216142641.2100407-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216142641.2100407-2-mic@digikod.net>

On Mon, Feb 16, 2026 at 03:26:39PM +0100, Mickaël Salaün wrote:
> Constify pointers when it makes sense.
> 
> Consistently use size_t for loops, especially to match works->size type.
> 
> Add new lines to improve readability.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/tsync.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 8e9b8ed7d53c..9a65e3e96186 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -256,13 +256,14 @@ static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
>   * tsync_works_contains - checks for presence of task in s
>   */
>  static bool tsync_works_contains_task(const struct tsync_works *s,
> -				      struct task_struct *task)
> +				      const struct task_struct *task)
>  {
>  	size_t i;
>  
>  	for (i = 0; i < s->size; i++)
>  		if (s->works[i]->task == task)
>  			return true;
> +
>  	return false;
>  }
>  
> @@ -284,6 +285,7 @@ static void tsync_works_release(struct tsync_works *s)
>  
>  	for (i = 0; i < s->capacity; i++)
>  		kfree(s->works[i]);
> +
>  	kfree(s->works);
>  	s->works = NULL;
>  	s->size = 0;
> @@ -295,7 +297,7 @@ static void tsync_works_release(struct tsync_works *s)
>   */
>  static size_t count_additional_threads(const struct tsync_works *works)
>  {
> -	struct task_struct *thread, *caller;
> +	const struct task_struct *caller, *thread;
>  	size_t n = 0;
>  
>  	caller = current;
> @@ -334,7 +336,8 @@ static bool schedule_task_work(struct tsync_works *works,
>  			       struct tsync_shared_context *shared_ctx)
>  {
>  	int err;
> -	struct task_struct *thread, *caller;
> +	const struct task_struct *caller;
> +	struct task_struct *thread;
>  	struct tsync_work *ctx;
>  	bool found_more_threads = false;
>  
> @@ -415,10 +418,10 @@ static bool schedule_task_work(struct tsync_works *works,
>   * shared_ctx->num_preparing and shared_ctx->num_unfished and mark the two
>   * completions if needed, as if the task was never scheduled.
>   */
> -static void cancel_tsync_works(struct tsync_works *works,
> +static void cancel_tsync_works(const struct tsync_works *works,
>  			       struct tsync_shared_context *shared_ctx)
>  {
> -	int i;
> +	size_t i;
>  
>  	for (i = 0; i < works->size; i++) {
>  		if (WARN_ON_ONCE(!works->works[i]->task))
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>
