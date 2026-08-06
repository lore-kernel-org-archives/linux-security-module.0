Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4264373BF2
	for <linux-security-module@vger.kernel.org>; Thu,  6 Aug 2026 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036930; cv=none; b=eLedFgWMIaJxTuXvdqbT5cpKu6VO6GYSHLB4L59wTdJOVy/2msiRzofPibcQkcKZEPrluCIQ/4rVmgk2ZvH2jKLMzEk195yGeFwlAENyBFxT9t8IafdxpYmjxcSOZ8+DF7o6dSDQvgAzpfzEXVqqHTXFT9P7TcolrUTpxuP8YRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036930; c=relaxed/simple;
	bh=bAZ3xWT17LiPCPPqrLMqDHOrLaErqGkWnw2RshU26LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjMl+sYzsume4jY6dH1LxZ8c3RrORQZj4qjDuFs+EvrAcbOXDEBW4rJdnAmN2i++NmdOtZnucZO8SocIu2weWqgGKFkj1f97bklhL2sg+eNa14ISn4ng1AvX9qNEwBklCESssMMNfLb/18m2qNx4Z886PTc41JeNdYeLA6leZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1twUNUkZ; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1twUNUkZ"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGDbp6blczV8R;
	Thu,  6 Aug 2026 19:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786036918;
	bh=GIXZ74wxKXTVoiR32tjBTjv2nPYH2Pa11xY8e7a+dzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1twUNUkZJehJ3rm7ZCbd4pSsH8jOT4LTxFZr3+VDlyAxi4D48YBQAbAMsfte00Dv/
	 92CMj3pccP0E9VK7rfFokizC066V0cFw3q8YbhAF95aHIUk1Or/JpKFx0vepSp1Qct
	 QneEn9Zgt9UUJzQvlkzYDZMrzfqI3q4id8I/TzvE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hGDbn3SR0znHm;
	Thu,  6 Aug 2026 19:21:56 +0200 (CEST)
Date: Thu, 6 Aug 2026 19:21:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/20] tracing: Add __print_untrusted_str()
Message-ID: <20260806.ooMo8dungahj@digikod.net>
References: <20260722171159.2776765-1-mic@digikod.net>
 <20260722171159.2776765-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722171159.2776765-8-mic@digikod.net>
X-Infomaniak-Routing: alpha

Hi Steven,

I addressed your previous review for this helper, is this patch ok with
you now?

I also addressed your other review about the tracepoints.  They are well
tested, including with a dedicated tool I wrote (not public yet).  Could
you get a quick look for me to push this series to -next before the
merge window?

Thanks

On Wed, Jul 22, 2026 at 07:11:39PM +0200, Mickaël Salaün wrote:
> Landlock tracepoints expose filesystem paths and process names that may
> contain spaces, equal signs, or other characters that break ftrace field
> parsing.
> 
> Add a __print_untrusted_str() TP_printk helper that escapes separators
> (space, equal sign), quotes, backslashes, and non-printable bytes via
> string_escape_mem(), so an untrusted string cannot inject field
> separators or control characters into the ftrace output and can be
> unambiguously recovered.
> 
> This guarantee applies to the in-kernel ftrace text output (trace,
> trace_pipe).  Userspace libtraceevent (perf, trace-cmd) does not yet
> parse this helper, so a companion libtraceevent change is needed for
> those consumers to pretty-print the field.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v2:
> https://patch.msgid.link/20260406143717.1815792-6-mic@digikod.net
> - Add a Return: kdoc for trace_print_untrusted_str_seq() and rename its
>   declaration parameter to src.
> 
> Changes since v1:
> https://patch.msgid.link/20250523165741.693976-4-mic@digikod.net
> - Remove WARN_ON() (pointed out by Steven Rostedt).
> ---
>  include/linux/trace_events.h               |  2 +
>  include/trace/stages/stage3_trace_output.h |  4 ++
>  include/trace/stages/stage7_class_define.h |  1 +
>  kernel/trace/trace_output.c                | 44 ++++++++++++++++++++++
>  4 files changed, 51 insertions(+)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 308c76b57d13..4ece9b8d9d6b 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -60,6 +60,8 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
>  			 int prefix_type, int rowsize, int groupsize,
>  			 const void *buf, size_t len, bool ascii);
>  
> +const char *trace_print_untrusted_str_seq(struct trace_seq *s, const char *src);
> +
>  int trace_raw_output_prep(struct trace_iterator *iter,
>  			  struct trace_event *event);
>  extern __printf(2, 3)
> diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
> index 181b81335781..0235dbd11b52 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -133,6 +133,10 @@
>  	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
>  				 rowsize, groupsize, buf, len, ascii)
>  
> +#undef __print_untrusted_str
> +#define __print_untrusted_str(str)					\
> +		trace_print_untrusted_str_seq(p, __get_str(str))
> +
>  #undef __print_ns_to_secs
>  #define __print_ns_to_secs(value)			\
>  	({						\
> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
> index 47008897a795..f29a82e7a4c4 100644
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -24,6 +24,7 @@
>  #undef __print_array
>  #undef __print_dynamic_array
>  #undef __print_hex_dump
> +#undef __print_untrusted_str
>  #undef __get_buf
>  
>  #undef __event_in_hardirq
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index a5ad76175d10..f0a9b29b3e36 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -16,6 +16,7 @@
>  #include <linux/btf.h>
>  #include <linux/bpf.h>
>  #include <linux/hashtable.h>
> +#include <linux/string_helpers.h>
>  
>  #include "trace_output.h"
>  #include "trace_btf.h"
> @@ -325,6 +326,49 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
>  }
>  EXPORT_SYMBOL(trace_print_hex_dump_seq);
>  
> +/**
> + * trace_print_untrusted_str_seq - print a string after escaping characters
> + * @s: trace seq struct to write to
> + * @src: The string to print
> + *
> + * Prints a string to a trace seq after escaping all special characters,
> + * including common separators (space, equal sign), quotes, and backslashes.
> + * This transforms a string from an untrusted source (e.g. user space) to make
> + * it:
> + * - safe to parse,
> + * - easy to read (for simple strings),
> + * - easy to get back the original.
> + *
> + * Return: A pointer to the escaped string within the trace seq buffer, or
> + * %NULL if @src is %NULL or the buffer is exhausted.
> + */
> +const char *trace_print_untrusted_str_seq(struct trace_seq *s,
> +					   const char *src)
> +{
> +	int escaped_size;
> +	char *buf;
> +	size_t buf_size = seq_buf_get_buf(&s->seq, &buf);
> +	const char *ret = trace_seq_buffer_ptr(s);
> +
> +	/* Buffer exhaustion is normal when the trace buffer is full. */
> +	if (!src || buf_size == 0)
> +		return NULL;
> +
> +	escaped_size = string_escape_mem(src, strlen(src), buf, buf_size,
> +		ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP | ESCAPE_APPEND |
> +		ESCAPE_OCTAL, " ='\"\\");
> +	if (unlikely(escaped_size >= buf_size)) {
> +		/* We need some room for the final '\0'. */
> +		seq_buf_set_overflow(&s->seq);
> +		s->full = 1;
> +		return NULL;
> +	}
> +	seq_buf_commit(&s->seq, escaped_size);
> +	trace_seq_putc(s, 0);
> +	return ret;
> +}
> +EXPORT_SYMBOL(trace_print_untrusted_str_seq);
> +
>  int trace_raw_output_prep(struct trace_iterator *iter,
>  			  struct trace_event *trace_event)
>  {
> -- 
> 2.54.0
> 
> 
