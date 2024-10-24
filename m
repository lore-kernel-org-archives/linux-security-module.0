Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D891D220E;
	Thu, 24 Oct 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775950; cv=none; b=Iv3/s2R6pF0p27uYfY4RI8STTaHLLBvW7zawDuIH0akchEC89loUwDsBeLsTuyXNWFRFC+jYUnrCNM3Ehe5www9AS+s7i+PFfp3T4abtAHKW+PgfRA/uZKa7W8vMuccdoKC+AQRhMQY8t1BmTqlCTQBhgEdJyZEgbl9O5R3zqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775950; c=relaxed/simple;
	bh=tF6sf3zE022/Q3IqJ2xwiBdw3R53WbnMjuCQ4HirIWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee+jWGB8CUqpHNPgVp2jf3lhX1qodKyjRLErHkKXp0epk3vSQwmZo/6mtigvj/spZq6b2OWytO4H3sbnBywOplTwI0SM9M0ckOKR2NAIwn9RhBe/ogd2H+MpCoy3iOFec57ti28avo51wMXunzOCCveRQs7ArLU8rtukYJohskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF7BC4CEC7;
	Thu, 24 Oct 2024 13:19:08 +0000 (UTC)
Date: Thu, 24 Oct 2024 09:19:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, Yonghong
 Song <yonghong.song@linux.dev>
Subject: Re: [v1] security: add trace event for cap_capable
Message-ID: <20241024091904.2650d758@rorschach.local.home>
In-Reply-To: <20241024104012.1815022-1-linux@jordanrome.com>
References: <20241024104012.1815022-1-linux@jordanrome.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 03:40:12 -0700
Jordan Rome <linux@jordanrome.com> wrote:

> +TRACE_EVENT(capable,
> +
> +	TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> +		struct user_namespace *capable_ns, int cap, unsigned int opts, int ret),
> +
> +	TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct cred *, cred)
> +		__field(struct user_namespace *, targ_ns)
> +		__field(struct user_namespace *, capable_ns)
> +		__field(int, cap)
> +		__field(unsigned int, opts)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cred       = cred;
> +		__entry->targ_ns    = targ_ns;
> +		__entry->capable_ns = capable_ns;
> +		__entry->cap        = cap;
> +		__entry->opts       = opts;
> +		__entry->ret        = ret;
> +	),
> +
> +	TP_printk("cap %d, opts %u, ret %d",
> +		__entry->cap, __entry->opts, __entry->ret)
> +);
> +

You record cred, targ_ns and capable_ns but don't use it in TP_printk?

It's fine to print pointers there. Is there a reason you do not?

-- Steve
