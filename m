Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB463E6399
	for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100016; cv=none; b=C8OhGzqIwTGlVqpUmHxWzp4ZhLrnwxRJQxmDAAoenM4T9z/SoOTE84Qg05QMKJn8w+FdlkfU99jgS/9S9F7v2kAhZ+A0JYFRlfdFAkX/Q3jEToYcBsCtD2VKR4dCRNPCUqAPSKp9T0PxNLe0pGlCFdZONtl2fjPblEdn282DJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100016; c=relaxed/simple;
	bh=X9AZk6ouA560VchecOEmVZBrcgzrfZoBE0QGMf0Aezc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox7F6I4AxVVlhEonQJoYvuG8Rj+krLtKzkyVIykRQt0mcJRyGwrA0ZqM8Wf7/vsu+M+7DnUxr5h9VqDiIQELZg1xdufETAmpCQtWXM+XPJ7VLXfWEP2YjVilcfT6cuHvQt/do9e2XxWvQcQcSbvXb9ejJ7lwsfZVGXYLP7x8Tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rFN0Zqxk; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rFN0Zqxk"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gJv9Z6t4GzGRt;
	Mon, 18 May 2026 12:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779100002;
	bh=DqZGfXeHDKO3ofh3dXhJEMakdrjyJnKc8lUuhZhQRpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFN0ZqxkORmS6NBKTiy6Bep834N1w5tA1lY7HuC5xXh8t1BsuHpYLHnbl37ooS22d
	 b3AzbkPdBWYZSUwNHitCTHusZQoQcoD7HlrLQxDRdtIZHdM2DbZbzIjdklpSy7FQDK
	 pJSoBKc5f9lkJn3yOsTKWOjhP0pk+bGfBF/Oqo64=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gJv9Y34wgzMmR;
	Mon, 18 May 2026 12:26:38 +0200 (CEST)
Date: Mon, 18 May 2026 12:26:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 05/17] tracing: Add __print_untrusted_str()
Message-ID: <20260518.eZ8gaiyoh3re@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406143717.1815792-6-mic@digikod.net>
X-Infomaniak-Routing: alpha

Steve, Masami, Mathieu, are you ok with this new helper?

On Mon, Apr 06, 2026 at 04:37:03PM +0200, Mickaël Salaün wrote:
> Landlock tracepoints expose filesystem paths and process names
> that may contain spaces, equal signs, or other characters that
> break ftrace field parsing.
> 
> Add a new __print_untrusted_str() helper to safely print strings after
> escaping all special characters, including common separators (space,
> equal sign), quotes, and backslashes.  This transforms a string from an
> untrusted source (e.g. user space) to make it:
> - safe to parse,
> - easy to read (for simple strings),
> - easy to get back the original.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20250523165741.693976-4-mic@digikod.net
> - Remove WARN_ON() (pointed out by Steven Rostedt).
> ---
>  include/linux/trace_events.h               |  2 ++
>  include/trace/stages/stage3_trace_output.h |  4 +++
>  include/trace/stages/stage7_class_define.h |  1 +
>  kernel/trace/trace_output.c                | 41 ++++++++++++++++++++++
>  4 files changed, 48 insertions(+)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 37eb2f0f3dd8..7f4325d327ee 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -57,6 +57,8 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
>  			 int prefix_type, int rowsize, int groupsize,
>  			 const void *buf, size_t len, bool ascii);
>  
> +const char *trace_print_untrusted_str_seq(struct trace_seq *s, const char *str);
> +
>  int trace_raw_output_prep(struct trace_iterator *iter,
>  			  struct trace_event *event);
>  extern __printf(2, 3)
> diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
> index fce85ea2df1c..62e98babb969 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -133,6 +133,10 @@
>  	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
>  				 rowsize, groupsize, buf, len, ascii)
>  
> +#undef __print_untrusted_str
> +#define __print_untrusted_str(str)							\
> +		trace_print_untrusted_str_seq(p, __get_str(str))
> +
>  #undef __print_ns_to_secs
>  #define __print_ns_to_secs(value)			\
>  	({						\
> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
> index fcd564a590f4..1164aacd550f 100644
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -24,6 +24,7 @@
>  #undef __print_array
>  #undef __print_dynamic_array
>  #undef __print_hex_dump
> +#undef __print_untrusted_str
>  #undef __get_buf
>  
>  /*
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 1996d7aba038..9d14c7cc654d 100644
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
> @@ -321,6 +322,46 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
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
> 2.53.0
> 
> 
