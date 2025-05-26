Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200727713
	for <linux-security-module@vger.kernel.org>; Mon, 26 May 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748281584; cv=none; b=BJszxZmMbeJ/nw/U9LJueZHl7Iy7LVxX/FRrrwYTJMQ+LnuePXuJR4yH/yn+OvF92TprOs+4yexeXz8zSUV8HYG5WTyVJGYFkSXEXlUqFficaZmiGew3hHima2d0uCBVm2YLyaMvKpPdr1wog+DaGkWmruF6VpJdyGqe0anoRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748281584; c=relaxed/simple;
	bh=+Vo4cjMbX5sLgdnKiDK+bF17vg0v3Mz9GcrahwIa1+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al0UcWGqyxVvODfxOPdaJGaMf1nBW2y902cVN2OcdOk0s5xT80Qa61Lr+PhQ7P6iK+KmG/t8PDa9Tfq0btozZrQq2tMY2q3siOPsbNRX1a5buG6xFGSSQA9pIbSXyNKGtvdc3vy+AGEaB16VOGarpIn8GilVp5QN2MHVWspvwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v1kBC2eZ; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v1kBC2eZ"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b5jqS21YSzxNR;
	Mon, 26 May 2025 19:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748281572;
	bh=4Q9mO3aHOjbpSobzxHGdMXrInPPRvU2hbxIfHCQiKPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v1kBC2eZp9JObY622FJRNm9MA+A7rvt3j0ju9bgs9D5YuVt+M3nVOB6cdIgZH+CRQ
	 2ihCCw/cljn0RVSSFQyLezVVzWlLhdw9XsnfUTzNjI45WCoKlDAK6BrluE4j4P0axG
	 rWPiaWkxIHcVNFyQGlg0PZwe/EzgdnMH5oFltJFc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b5jqR0Jsszkg9;
	Mon, 26 May 2025 19:46:10 +0200 (CEST)
Date: Mon, 26 May 2025 19:46:09 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Tingmao Wang <m@maowtm.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Ryan Sullivan <rysulliv@redhat.com>, Shervin Oloumi <enlightened@google.com>, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/5] tracing: Add __print_untrusted_str()
Message-ID: <20250526.zaedahcoo2Th@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
 <20250523165741.693976-4-mic@digikod.net>
 <20250523142242.1be10abb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523142242.1be10abb@gandalf.local.home>
X-Infomaniak-Routing: alpha

On Fri, May 23, 2025 at 02:22:42PM -0400, Steven Rostedt wrote:
> On Fri, 23 May 2025 18:57:39 +0200
> Mickaël Salaün <mic@digikod.net> wrote:
> 
> > Add a new __print_untrusted_str() helper to safely print strings after escaping
> > all special characters, including common separators (space, equal sign),
> > quotes, and backslashes.  This transforms a string from an untrusted source
> > (e.g. user space) to make it:
> > - safe to parse,
> > - easy to read (for simple strings),
> > - easy to get back the original.
> 
> Hmm, so this can be an issue if this is printed out via seq_file()?
> 
> I'm curious to what exactly can be "unsafe" about a string being printed
> via "%s"?

There is no issue for the kernel, only for users and user space. :)

> 
> I'm not against this change, I just want to understand more about what the
> issue is.

The issue is about a malicious process triggering a trace event with an
arbitrary string.  If such string is printed to the root's terminal, it
can print escape sequences and do nasty things.  For instance, the
terminal can beep, the window's title can be updated, a path name can be
"hidden" with specific colors, the screen can be completely cleared and
rewritten to trick peoples, and other "original" terminal features can
be triggered by custom escape sequences.

This is definitely not something new but still relevant.  There are a
lot of articles about this kind of issues:
https://phrack.org/issues/25/5
https://marc.info/?l=bugtraq&m=104612710031920
https://www.cyberark.com/resources/threat-research-blog/dont-trust-this-title-abusing-terminal-emulators-with-ansi-escape-characters
https://blog.trailofbits.com/2025/04/29/deceiving-users-with-ansi-terminal-codes-in-mcp/

In a less malicious environment, this helper would also be useful to
just sanitize arbitrary text.  For instance, because '=' and ' ' are
escaped, it's easy to write a key=value parser in shell (without bug),
or to say it another way, it's more difficult for a parser to fail. ;)

Anyway, this sanitization should not be visible in most cases.

> 
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  include/linux/trace_events.h               |  3 ++
> >  include/trace/stages/stage3_trace_output.h |  4 +++
> >  include/trace/stages/stage7_class_define.h |  1 +
> >  kernel/trace/trace_output.c                | 40 ++++++++++++++++++++++
> >  4 files changed, 48 insertions(+)
> > 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index fa9cf4292dff..78f543bb7558 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -54,6 +54,9 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
> >  			 int prefix_type, int rowsize, int groupsize,
> >  			 const void *buf, size_t len, bool ascii);
> >  
> > +const char *trace_print_untrusted_str_seq(struct trace_seq *s, const char *str);
> > +
> > +
> >  struct trace_iterator;
> >  struct trace_event;
> >  
> > diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
> > index 1e7b0bef95f5..36947ca2abcb 100644
> > --- a/include/trace/stages/stage3_trace_output.h
> > +++ b/include/trace/stages/stage3_trace_output.h
> > @@ -133,6 +133,10 @@
> >  	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
> >  				 rowsize, groupsize, buf, len, ascii)
> >  
> > +#undef __print_untrusted_str
> > +#define __print_untrusted_str(str)							\
> > +		trace_print_untrusted_str_seq(p, __get_str(str))
> > +
> >  #undef __print_ns_to_secs
> >  #define __print_ns_to_secs(value)			\
> >  	({						\
> > diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
> > index fcd564a590f4..bc10b69b755d 100644
> > --- a/include/trace/stages/stage7_class_define.h
> > +++ b/include/trace/stages/stage7_class_define.h
> > @@ -24,6 +24,7 @@
> >  #undef __print_array
> >  #undef __print_dynamic_array
> >  #undef __print_hex_dump
> > +#undef __print_untrusted_string
> >  #undef __get_buf
> >  
> >  /*
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index b9ab06c99543..17d576941147 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/btf.h>
> >  #include <linux/bpf.h>
> >  #include <linux/hashtable.h>
> > +#include <linux/string_helpers.h>
> >  
> >  #include "trace_output.h"
> >  #include "trace_btf.h"
> > @@ -297,6 +298,45 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
> >  }
> >  EXPORT_SYMBOL(trace_print_hex_dump_seq);
> >  
> > +/**
> > + * trace_print_untrusted_str_seq - print a string after escaping characters
> > + * @s: trace seq struct to write to
> > + * @src: The string to print
> > + *
> > + * Prints a string to a trace seq after escaping all special characters,
> > + * including common separators (space, equal sign), quotes, and backslashes.
> > + * This transforms a string from an untrusted source (e.g. user space) to make
> > + * it:
> > + * - safe to parse,
> > + * - easy to read (for simple strings),
> > + * - easy to get back the original.
> > + */
> > +const char *trace_print_untrusted_str_seq(struct trace_seq *s,
> > +                                          const char *src)
> > +{
> > +	int escaped_size;
> > +	char *buf;
> > +	size_t buf_size = seq_buf_get_buf(&s->seq, &buf);
> > +	const char *ret = trace_seq_buffer_ptr(s);
> > +
> > +	if (!src || WARN_ON(buf_size == 0))
> 
> 		    WARN_ON_ONCE() please.

I mimicked nearby code but WARN_ON_ONCE() is indeed better.

Thanks.

> 
> -- Steve
> 
> > +		return NULL;
> > +
> > +	escaped_size = string_escape_mem(src, strlen(src), buf, buf_size,
> > +		ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP | ESCAPE_APPEND |
> > +		ESCAPE_OCTAL, " ='\"\\");
> > +	if (unlikely(escaped_size >= buf_size)) {
> > +		/* We need some room for the final '\0'. */
> > +		seq_buf_set_overflow(&s->seq);
> > +		s->full = 1;
> > +		return NULL;
> > +	}
> > +	seq_buf_commit(&s->seq, escaped_size);
> > +	trace_seq_putc(s, 0);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(trace_print_untrusted_str_seq);
> > +
> >  int trace_raw_output_prep(struct trace_iterator *iter,
> >  			  struct trace_event *trace_event)
> >  {
> 
> 
