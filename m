Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C431AAE25
	for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587572; cv=none; b=WUq73XKadSIkdcgEZLUNWhshj/lXSuJObVJ6EPcarSVzISbqaNTGrepd7Uj9OO8HDThG8wUC4qwOMAdVCwxu4ZgJ5IXbfJ98t/VmtpLBi6RKo29bHyK6AQHzMg28y3k+zS8qbgj0QWVRJKt3Ym2w2ZCT+Q997wnxY17CSEgjvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587572; c=relaxed/simple;
	bh=nUuj1yFQwQctPZyeaZf8ffYlrw7QeFKprNsInQ+jTuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/15WBLLyCfHQvqLRMEB2FU1+0ra1tFgzP4AdNZlGI6ZTkrYaC/kjIlI7NtsJ7EVHG5F0SHX4NAN8zxo1G9kMrtEQYwWifBXEn1Vc5B83K0Rvy27Oj5h9KocbCDKwA4oaizzh63jQvJgL5xePI1q1evEUNQibA9bkMgxQlUJcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmuOb7JL; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmuOb7JL"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f94ce22f2so226517639f.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723587569; x=1724192369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QN8X+bBf4e4pg8ECVJmLV7aoGPPE4M9h9y5SfDnco4=;
        b=XmuOb7JLvyzRoKVkigT8zV8uE0biCueUrdLC+6pXN5AjqeaxqAFGWT1hU9rPNRvsDZ
         3fU5eBj4VHgEnvMbyOxDo4SlyF1dqm7T4zhNy+oWaV1J6qezOEKZ865/5a5QD6yf2zSE
         zsQq6zZ31fcYemRtrJa5mxHUIsD3W7QlY7Iahg5D168bjobssTF11yaUpsmZBmKP3QY6
         5ld4bJnVvmBPuUbevyZk00bRd5Lb1Yj1wt/HAHV8cdrDd/44dWqWllW0xGH36kY1+DHb
         i0Jm6spuAdClmzuVQhUe8wMeuVMAO2Cv8iEw7Ie6jVlsxGLfspWZBbVehKyGXuViZ+tw
         x0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723587569; x=1724192369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QN8X+bBf4e4pg8ECVJmLV7aoGPPE4M9h9y5SfDnco4=;
        b=GS4W/SYgav//1QlHtE1a6Od9ZTlMaowZC9U9mxQ4aAGPBkUp1vxZ24Lt+r6KpD8Vvx
         cbHsKbLF2Dip76kFW/uyIatfJs1tasy/dKPU00c4TemuW891ooNpn38lFOGCcA9nkGfu
         WbgvaHesLGEcpcQqaVIeajfZ+SghkhFp3FzLDs3zNxOCZsLkse5lFw+GlNGu41IgwJsz
         L3b2urS8dMMeSONGzn6kbCgg8OiGQ3iAxA942fjYeFQovwkuKrblDzX9J62anDYG2KJx
         +Q1qVgnwHW5LXDfZ9xhpAemtht3FUcEywefnti7LC2ZUBuF3LIPb6FBE1dywDfANl9qG
         Rzzg==
X-Forwarded-Encrypted: i=1; AJvYcCU4g5/BnJV1jqDZx/nbIr9riaQvVzB2owMbRgJXad0MuSgVyvGX3TZvmCwDUWGbNCxvHDeCwIySAPFrgSYlUyugcTQhYN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9iX5VbB49z/tf583vIjhhQrj/qcogrdsz/ft5sjNdTQy9i5P
	ocJqYApCBFRWn3FaTX9gYj/ptFuMpbELwMKp45X+2ScvFQyvYBb89Pd4VRQhsQ==
X-Google-Smtp-Source: AGHT+IH+Vc3rvDiFEg5ElrB7bMI7N4hpSdsoFZYx8k23AbxObZpcHIjRmC/uICTdWR81lxtCEKl/zQ==
X-Received: by 2002:a05:6602:27c1:b0:824:d58c:ec9 with SMTP id ca18e2360f4ac-824dad3f48bmr165323439f.10.1723587568538;
        Tue, 13 Aug 2024 15:19:28 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769f9d7dsm2773101173.118.2024.08.13.15.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 15:19:28 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:19:25 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v6 7/9] tracing: Replace strncpy() with strscpy()
Message-ID: <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
 <20240812022933.69850-8-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812022933.69850-8-laoar.shao@gmail.com>

Hi,

On Mon, Aug 12, 2024 at 10:29:31AM GMT, Yafang Shao wrote:
> Using strscpy() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach also
> facilitates future extensions to the task comm.

Thanks for sending patches replacing str{n}cpy's!

I believe there's at least two more instances of strncpy in trace.c as
well as in trace_events_hist.c (for a grand total of 6 instances in the
files you've touched in this specific patch).

It'd be great if you could replace those instances in this patch as well :>)

This would help greatly with [1].

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/trace/trace.c             | 2 +-
>  kernel/trace/trace_events_hist.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 578a49ff5c32..1b2577f9d734 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1907,7 +1907,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  	max_data->critical_start = data->critical_start;
>  	max_data->critical_end = data->critical_end;
>  
> -	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
> +	strscpy(max_data->comm, tsk->comm, TASK_COMM_LEN);

If max_data->comm wants to be NUL-terminated then this is the right
replacement. Without knowing how the trace stack works at all, it's hard
for me to tell if that is the case.

There's a length-supplied format specifier for which this comm field is
used with; Either this is just another safeguard against spilling over
the buffer or this field really doesn't care about NUL-termination.
| seq_printf(m, "#    | task: %.16s-%d "
|       "(uid:%d nice:%ld policy:%ld rt_prio:%ld)\n",
|       data->comm, data->pid,

In the event this field doesn't need to be NUL-terminated then we are
introducing an off-by-one error where we are copying one less useful
byte with strscpy -- Linus pointed out earlier [2] that these things all
just want to be c-strings so this is probably the right change :>)

>  	max_data->pid = tsk->pid;
>  	/*
>  	 * If tsk == current, then use current_uid(), as that does not use
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 6ece1308d36a..4cd24c25ce05 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
>  		return;
>  	}
>  
> -	strncpy(comm, task->comm, TASK_COMM_LEN);
> +	strscpy(comm, task->comm, TASK_COMM_LEN);
>  }
>  
>  static void hist_elt_data_free(struct hist_elt_data *elt_data)
> -- 
> 2.43.5
> 

Link: https://github.com/KSPP/linux/issues/90 [1]
Link: https://lore.kernel.org/all/CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com/ [2]

Thanks
Justin
