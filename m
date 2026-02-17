Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFF3382DB
	for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332080; cv=none; b=tbZXvtpJM+iHcj3U1UEFfQo5FxQybT0ryK0T3VI7VOvNGGz+WwF0T7hyaED/F9v5vrMWXuqPCFqewGe/FPGBZ5+Io/zvTMPAgZsEde5lrqrwy7QmgomwTmwnWwN02rsT2nz9pOiAnI/h1y/WAj2Mvi3LDbY2by8M0AiV1B1ez7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332080; c=relaxed/simple;
	bh=MYd+Ro1Iy8+sEWendOL+JIkVT/lvp7HC384i6g3/cuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMvfP9qxKb+ou9sjq3bnm9Hq98TL6k7OvKGeZ3CyPI9KLeT56Cud9sSuL8RElA4pl+eQ1vV+a+4Aogm79E6DeyKV4Q+0xYgZ+IwzqzVgvL/xH03FT1XxEZ6KyVxDu8nSlSvwoh0mKwBqxpIlppGKnwBQXq4EGPU6yjTh+w6xN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OqsyZELl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqsyZELl"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359108fd24so2885786f8f.2
        for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 04:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771332077; x=1771936877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0z8GdOkxoKQRadJ2XXmSHB3cWGSE2IGKaOcGrHdCOs=;
        b=OqsyZELl9RY3yp62ZJ1AiGfULZoBhoel1LHeMPHCAL8DYW/E/ypGt3E2ay/Thlt/8a
         7u7CnuLnghhZT0D0wUy29MnMDIDH39q+isIgjYY8Ws3paY0cSY6Tqgnd08Xl4uYzFZMg
         nG6nIY3+XQZ8w3FlOLyql0IuZnBEvUpd+AsrPIXLV6NZb3fsdrQzgPzWqLQsLFkQhvzk
         WJovQ1W7wPhcEQTEfP6DIXaxV9LaWdAn+PaVz+3pzRgIOm0rHZ+x+IFCESXg2R4ywIsV
         4gMPVLd4+TMfagc1Jtb2byPzzvlnNl206BXGB7LWuQSgp5GpBPXG/lbYTKX31uVI4Mhv
         RYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771332077; x=1771936877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0z8GdOkxoKQRadJ2XXmSHB3cWGSE2IGKaOcGrHdCOs=;
        b=JTRiH2lIQF9kUTqR+fUftuyWMLoAHPXB2ifOE7sDWFJzCCOoPPhB9OeVUvGQ3cwV3n
         XMLV8x8A48nXw227Ah0QwSVR4ogLtZgGNenaH0v72bJXZQDKOU/YWo0HrueieUZu8ihR
         yAmAptQ8QDy9I6IDxEbZsY7RQPIx53bp2aVuUtbc0EIKLbTM5Qx4fNR8s1G7eEtXYHXm
         1GHhrIPPtY8e8vk2ofYZpNkR7fARD6iZ4gB+qnluVZ4YSGn8ut+4slIOmyrsZDoWJ8j7
         LNepdQG+Dq+f1WXjHFT6hhRyNVx0g1h9wk/SqA5xGjcsTenr0HyWBVMXA+BSNbrnhG8n
         4bgw==
X-Gm-Message-State: AOJu0YzhT6Wf1CmM5xcBHllMsj4lkYcLGHraVbgKJIXyhYjoOFQPrZ25
	NZyOZmzvnL5pjBrymGcivMhNlId5m4TOG7V2+QxJCce5HLkPTNE29m1mqsNp7Rg39A==
X-Gm-Gg: AZuq6aKyWZCB2ZxPPyDvnNFv0TZA8krnaSY8+gZ2J6la65LOeRZymcCzXFfXhiBB9FI
	7cSDl578EgxWzkWpyfTk3blX69vQsOxfjAkeynQLTS6oTQKokI//gi6hLjZXIjKhTmElA7gSWe9
	OHNntmxdif24tWlqAULc/PGXHnKvZsK6ADOapwVU3Y7dhww+HmCnEU/1VIFuELzNBTeaFPsDreE
	BmK4uJDl0XFjIq72tWbrdYv5uLlCczB10w6SRWRTrLrtL/tgndYBz0aAnPM3bMGvbawAi0nGmxS
	qnnz6/75H2XFOABvwrJ4gj7IlWhOqsA5HE8emZ5xNSJI/cOqjiTiWdGKrgiL6k0lIQbXjllJxkA
	Lz0Q3jC05JG3Ra8aRyFAkfvvOiSgl01TJu79fb1UN2VjnYZhw5zXEJg1qOUU7N5fOx4b7c3iSIY
	+d6z6dXMlq8J7KgIpqHCRYj8+Eoy2B3aaI1DtEL1PoSaXw9Em1BeHfXg==
X-Received: by 2002:a5d:5d88:0:b0:435:a83e:88f with SMTP id ffacd0b85a97d-43797850f65mr21118901f8f.0.1771332077025;
        Tue, 17 Feb 2026 04:41:17 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:8d29:f905:4a47:1dbf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad015bsm35340859f8f.38.2026.02.17.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 04:41:16 -0800 (PST)
Date: Tue, 17 Feb 2026 13:41:11 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <aZRh52TIPAmMPJxc@google.com>
References: <20260217122341.2359582-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217122341.2359582-1-mic@digikod.net>

On Tue, Feb 17, 2026 at 01:23:39PM +0100, Mickaël Salaün wrote:
> If task_work_add() failed, ctx->task is put but the tsync_works struct
> is not reset to its previous state.  The first consequence is that the
> kernel allocates memory for dying threads, which could lead to
> user-accounted memory exhaustion (not very useful nor specific to this
> case).  The second consequence is that task_work_cancel(), called by
> cancel_tsync_works(), can dereference a NULL task pointer.
> 
> Fix this issues by keeping a consistent works->size wrt the added task
> work.  This is done in a new tsync_works_trim() helper which also cleans
> up the shared_ctx and work fields.
> 
> As a safeguard, add a pointer check to cancel_tsync_works() and update
> tsync_works_release() accordingly.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/all/20260216142641.2100407-1-mic@digikod.net/
> - Move the return/release logic into a new tsync_works_trim() helper
>   (suggested by Günther).
> - Reset the whole ctx with memset().
> - Add an unlinkely(err).
> ---
>  security/landlock/tsync.c | 47 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 0d2b9c646030..42cc0ef0c704 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -203,6 +203,40 @@ static struct tsync_work *tsync_works_provide(struct tsync_works *s,
>  	return ctx;
>  }
>  
> +/**
> + * tsync_works_trim - Put the last tsync_work element
> + *
> + * @s: TSYNC works to trim.
> + *
> + * Put the last task and decrement the size of @s.
> + *
> + * This helper does not cancel a running task, but just reset the last element
> + * to zero.
> + */
> +static void tsync_works_trim(struct tsync_works *s)
> +{
> +	struct tsync_work *ctx;
> +
> +	if (WARN_ON_ONCE(s->size <= 0))
> +		return;
> +
> +	ctx = s->works[s->size - 1];
> +
> +	/*
> +	 * For consistency, remove the task from ctx so that it does not look like
> +	 * we handed it a task_work.
> +	 */
> +	put_task_struct(ctx->task);
> +	memset(ctx, 0, sizeof(*ctx));

Minor (and highly optional) remark, this is the same as

  *ctx = (struct tsync_work){};

which I find slightly easier to read when resetting a struct value.
Both is fine though.

> +
> +	/*
> +	 * Cancel the tsync_works_provide() change to recycle the reserved memory
> +	 * for the next thread, if any.  This also ensures that cancel_tsync_works()
> +	 * and tsync_works_release() do not see any NULL task pointers.
> +	 */
> +	s->size--;
> +}
> +
>  /*
>   * tsync_works_grow_by - preallocates space for n more contexts in s
>   *
> @@ -276,7 +310,7 @@ static void tsync_works_release(struct tsync_works *s)
>  	size_t i;
>  
>  	for (i = 0; i < s->size; i++) {
> -		if (!s->works[i]->task)
> +		if (WARN_ON_ONCE(!s->works[i]->task))
>  			continue;
>  
>  		put_task_struct(s->works[i]->task);
> @@ -379,16 +413,14 @@ static bool schedule_task_work(struct tsync_works *works,
>  
>  		init_task_work(&ctx->work, restrict_one_thread_callback);
>  		err = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> -		if (err) {
> +		if (unlikely(err)) {
>  			/*
>  			 * task_work_add() only fails if the task is about to exit.  We
>  			 * checked that earlier, but it can happen as a race.  Resume
>  			 * without setting an error, as the task is probably gone in the
> -			 * next loop iteration.  For consistency, remove the task from ctx
> -			 * so that it does not look like we handed it a task_work.
> +			 * next loop iteration.
>  			 */
> -			put_task_struct(ctx->task);
> -			ctx->task = NULL;
> +			tsync_works_trim(works);
>  
>  			atomic_dec(&shared_ctx->num_preparing);
>  			atomic_dec(&shared_ctx->num_unfinished);
> @@ -412,6 +444,9 @@ static void cancel_tsync_works(struct tsync_works *works,
>  	int i;
>  
>  	for (i = 0; i < works->size; i++) {
> +		if (WARN_ON_ONCE(!works->works[i]->task))
> +			continue;
> +
>  		if (!task_work_cancel(works->works[i]->task,
>  				      &works->works[i]->work))
>  			continue;
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Thanks for spotting and fixing this!
—Günther
