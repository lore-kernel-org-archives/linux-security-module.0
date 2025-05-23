Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF0298CAA;
	Fri, 23 May 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024517; cv=none; b=aWal3V3cSGdLzmTDhzDJaXT4Zv8rPeIx+42/pFfX1s9EnWrsQLdTJTrbiKc1zQ58vE9AJOwaEsik7eAeG49TeCy18NBc6mQ/sWw0uSIuehylWw98HhwSks6Fg8+6z9O3+inLz9VDQFkM4YgtmLFO5QnF+8+NML6IL8eK0UaV+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024517; c=relaxed/simple;
	bh=nDe+eGSii8vpLzWz3C4x8Jl8wqRIMxtnUqMOb4hhn50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9Fx/x1WuWE8S1uLh9AA67lSKnRM5Bxt9kRkEcbLhSzgHlud+QxZw1VubIIsqzTPApVNioPq/bI4PLksA1mi3cnT1VDhbQ68PLAzQ1Q5CancdwVi7q4Nu8caixVyajbohC+GDDfbo1Idyu4XHfO7H3cuP0uAiyCn9TJ1c/YCY80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27148C4CEEF;
	Fri, 23 May 2025 18:21:54 +0000 (UTC)
Date: Fri, 23 May 2025 14:22:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>, Tingmao Wang
 <m@maowtm.org>, Daniel Burgener <dburgener@linux.microsoft.com>, Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook
 <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet
 <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Ryan Sullivan <rysulliv@redhat.com>, Shervin Oloumi
 <enlightened@google.com>, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/5] tracing: Add __print_untrusted_str()
Message-ID: <20250523142242.1be10abb@gandalf.local.home>
In-Reply-To: <20250523165741.693976-4-mic@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
	<20250523165741.693976-4-mic@digikod.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 May 2025 18:57:39 +0200
Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> Add a new __print_untrusted_str() helper to safely print strings after es=
caping
> all special characters, including common separators (space, equal sign),
> quotes, and backslashes.  This transforms a string from an untrusted sour=
ce
> (e.g. user space) to make it:
> - safe to parse,
> - easy to read (for simple strings),
> - easy to get back the original.

Hmm, so this can be an issue if this is printed out via seq_file()?

I'm curious to what exactly can be "unsafe" about a string being printed
via "%s"?

I'm not against this change, I just want to understand more about what the
issue is.

>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  include/linux/trace_events.h               |  3 ++
>  include/trace/stages/stage3_trace_output.h |  4 +++
>  include/trace/stages/stage7_class_define.h |  1 +
>  kernel/trace/trace_output.c                | 40 ++++++++++++++++++++++
>  4 files changed, 48 insertions(+)
>=20
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index fa9cf4292dff..78f543bb7558 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -54,6 +54,9 @@ trace_print_hex_dump_seq(struct trace_seq *p, const cha=
r *prefix_str,
>  			 int prefix_type, int rowsize, int groupsize,
>  			 const void *buf, size_t len, bool ascii);
> =20
> +const char *trace_print_untrusted_str_seq(struct trace_seq *s, const cha=
r *str);
> +
> +
>  struct trace_iterator;
>  struct trace_event;
> =20
> diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/s=
tages/stage3_trace_output.h
> index 1e7b0bef95f5..36947ca2abcb 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -133,6 +133,10 @@
>  	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
>  				 rowsize, groupsize, buf, len, ascii)
> =20
> +#undef __print_untrusted_str
> +#define __print_untrusted_str(str)							\
> +		trace_print_untrusted_str_seq(p, __get_str(str))
> +
>  #undef __print_ns_to_secs
>  #define __print_ns_to_secs(value)			\
>  	({						\
> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/s=
tages/stage7_class_define.h
> index fcd564a590f4..bc10b69b755d 100644
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -24,6 +24,7 @@
>  #undef __print_array
>  #undef __print_dynamic_array
>  #undef __print_hex_dump
> +#undef __print_untrusted_string
>  #undef __get_buf
> =20
>  /*
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index b9ab06c99543..17d576941147 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -16,6 +16,7 @@
>  #include <linux/btf.h>
>  #include <linux/bpf.h>
>  #include <linux/hashtable.h>
> +#include <linux/string_helpers.h>
> =20
>  #include "trace_output.h"
>  #include "trace_btf.h"
> @@ -297,6 +298,45 @@ trace_print_hex_dump_seq(struct trace_seq *p, const =
char *prefix_str,
>  }
>  EXPORT_SYMBOL(trace_print_hex_dump_seq);
> =20
> +/**
> + * trace_print_untrusted_str_seq - print a string after escaping charact=
ers
> + * @s: trace seq struct to write to
> + * @src: The string to print
> + *
> + * Prints a string to a trace seq after escaping all special characters,
> + * including common separators (space, equal sign), quotes, and backslas=
hes.
> + * This transforms a string from an untrusted source (e.g. user space) t=
o make
> + * it:
> + * - safe to parse,
> + * - easy to read (for simple strings),
> + * - easy to get back the original.
> + */
> +const char *trace_print_untrusted_str_seq(struct trace_seq *s,
> +                                          const char *src)
> +{
> +	int escaped_size;
> +	char *buf;
> +	size_t buf_size =3D seq_buf_get_buf(&s->seq, &buf);
> +	const char *ret =3D trace_seq_buffer_ptr(s);
> +
> +	if (!src || WARN_ON(buf_size =3D=3D 0))

		    WARN_ON_ONCE() please.

-- Steve

> +		return NULL;
> +
> +	escaped_size =3D string_escape_mem(src, strlen(src), buf, buf_size,
> +		ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP | ESCAPE_APPEND |
> +		ESCAPE_OCTAL, " =3D'\"\\");
> +	if (unlikely(escaped_size >=3D buf_size)) {
> +		/* We need some room for the final '\0'. */
> +		seq_buf_set_overflow(&s->seq);
> +		s->full =3D 1;
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

