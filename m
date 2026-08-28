Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB2324B20
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944383; cv=none; b=Od7+gcWZu3XpRbq9H8nsDTlWi920Eu+lM4dr52bDHXmHgoN9mnRUScXxxa7w/iWSLzWQIcxAUrY+qfigAtlmQSX76FPwMZr4w1vPgXTRM0g26Hbq0T9WsIfvWL3EXVHvXi8kjQ0w+iP88nzr71KfE7vjvZyZql3JFywfUcSLtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944383; c=relaxed/simple;
	bh=fde0j7hK2umDyVKS+UAtU9QlH3KMDPeeWTJiyxkR4uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxCgvROY5E2gEXLE6zKaZhGbfvCCQsv0sxt+T5lUPnzC9gaY8SHkj06YmIK/Ek8CJRsc14G9Si0Gt0KC/tjzqG1ElzR/0yp6LoEbMeCk7kpUasQBthxIZa6iuN4OBBgPMuuvdqHceFRBIbKIVNyX5+W9FTOU6LP/yVf05Fc8WFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ed33JlXd; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ed33JlXd"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWp1Y5TN6zQLc;
	Fri, 28 Aug 2026 21:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1787944369;
	bh=1stP9CrmWIAd1U8S7EU/ZVYrCnXTEI0NMFcmQwxv5ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ed33JlXdkZc3ML/XZzaQ2tlEj4x1vV6ni/SFOKBjDyNb3XCJqvk55tjV7PL3T0Bge
	 /gygMQ+rPW+vm6IEQGDgU2DYU3WQGokdCoZymv69xgNmWAgpKu1D0EOsKCfNjRc4nO
	 kcINpeXGBppJcGV/klLxX2y6n9gk+raYgodqd76Q=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hWp1Y1vHbzh31;
	Fri, 28 Aug 2026 21:12:49 +0200 (CEST)
Date: Fri, 28 Aug 2026 21:12:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: poppet lovelace <dmcjisalive@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [Bug] landlock: sun_path length underflow to SIZE_MAX in
 landlock_deny_scope_abstract_unix_socket TP_printk -> unbounded OOB read in
 trace reader
Message-ID: <20260828.da0Eik3eeSh8@digikod.net>
References: <CAL4aGcVcT0VWVFmGi_vLqxxZ9KdOHfGXYZtKjBdvoUyFjbu5=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4aGcVcT0VWVFmGi_vLqxxZ9KdOHfGXYZtKjBdvoUyFjbu5=A@mail.gmail.com>
X-Infomaniak-Routing: alpha

Hi Charles,

This is an impressive report but there is no bug.

There is no underflow because __string_len() reserves one extra byte for
the terminating NUL.  I sent a test patch to prove that:
https://lore.kernel.org/r/20260828190038.71831-1-mic@digikod.net

Dropping the "- 1" would introduce a new bug though.

Bug reports are very welcome but please test the potential issue before.
See https://docs.kernel.org/process/coding-assistants.html#procedure-for-finding-and-fixing-bugs

Regards,
 Mickaël


On Tue, Aug 25, 2026 at 09:00:05PM +0800, poppet lovelace wrote:
> Hi Mickaël,
> 
> While auditing the new landlock tracepoints we found a size_t underflow in
> the TP_printk() of landlock_deny_scope_abstract_unix_socket that turns a
> zero-length abstract AF_UNIX address into an effectively unbounded OOB read
> in the context of whoever consumes the trace (typically root reading
> tracefs). The tracepoints are new in the current merge window, so this can
> still be fixed before 7.3.
> 
> Root cause
> ----------
> 
> The event stores the abstract name correctly:
> 
>   include/trace/events/landlock.h:899-932
> 
>     __string_len(sun_path,
>                  unix_sk(peer)->addr->name->sun_path + 1,
>                  unix_sk(peer)->addr->len -
>                      offsetof(struct sockaddr_un, sun_path) - 1)
> 
> For an abstract address bound with addrlen == sizeof(sa_family_t) + 1 (= 3),
> which net/unix/af_unix.c:335-345 (unix_validate_addr) accepts, addr->len is
> 3, so the stored dynamic-array length is 0.
> 
> The printer then subtracts one more:
> 
>   include/trace/events/landlock.h:954-955
> 
>     __trace_print_untrusted_str(p, __get_str(sun_path),
>                                 __get_dynamic_array_len(sun_path) - 1)
> 
> 0u - 1 wraps to SIZE_MAX. __trace_print_untrusted_str()
> (include/trace/events/landlock.h:36-68) forwards that length to
> string_escape_mem(), whose main loop
> 
>   lib/string_helpers.c:586
> 
>     while (isz--) {
>         unsigned char c = *src++;
> 
> reads every input byte regardless of output exhaustion (the escape_*
> helpers stop writing past `end`, but nothing breaks the input walk). With
> isz == SIZE_MAX the read walks forward from the ring-buffer record through
> the rest of the tracing buffer and the kernel direct map until it faults.
> 
> Impact
> ------
> 
> An unprivileged task inside any landlock domain that scopes abstract unix
> sockets can plant such a record deterministically. The OOB read itself
> executes when the trace buffer is consumed (e.g. cat of
> /sys/kernel/tracing/trace or trace_pipe by a privileged monitor -- exactly
> the deployment these tracepoints target):
> 
> * information disclosure: escaped bytes of adjacent kernel memory
>   (ring-buffer contents and beyond, i.e. direct map) are copied into the
>   visible trace text;
> * availability: the walk ends in a page fault / oops in the reader's
>   syscall context; with panic_on_oops this takes the whole machine down.
> 
> Same-call-site audit: the other __trace_print_untrusted_str() users subtract
> 1 as well (pathname :389/:725, comm :829/:878), but their captured lengths
> cannot be 0 (dentry names are non-empty; comm is fixed-size), so only the
> abstract-socket event is currently reachable. The -1 looks like a leftover
> from string lengths that include a terminator; here the capture side already
> excluded the leading abstract-name NUL.
> 
> Reproducer (hand-written, not executed against a live kernel)
> -------------------------------------------------------------
> 
>   int s = socket(AF_UNIX, SOCK_STREAM, 0);
>   struct sockaddr_un a = { .sun_family = AF_UNIX };
>   a.sun_path[0] = '\0';                       /* abstract, zero length */
>   bind(s, (struct sockaddr *)&a, sizeof(a.sun_family) + 1);   /* ok, len 3 */
> 
>   /* task restricted by a domain scoping abstract unix sockets: */
>   connect(cfd, (struct sockaddr *)&a, 3);     /* denied -> event recorded */
> 
>   # echo 1 > /sys/kernel/tracing/events/landlock/\
> landlock_deny_scope_abstract_unix_socket/enable
>   # cat /sys/kernel/tracing/trace             /* OOB read here */
> 
> Self-assessed severity
> ----------------------
> 
> CVSS:3.1 AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:H = 6.7 (Medium).
> 
> If the cross-boundary read is judged Scope:Changed (kernel-memory bytes are
> surfaced into user-visible trace text, and the walk can traverse the whole
> direct map until it faults): AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:N/A:H = 7.3.
> Honest range 5.5-7.3 depending on scope treatment. Preconditions: the
> landlock tracepoints are enabled and consumed by a privileged reader --
> i.e. exactly the monitoring deployment they were added for.
> 
> Suggested fixes (either suffices; both preferred)
> -------------------------------------------------
> 
> 1. Drop the "- 1" at include/trace/events/landlock.h:955 -- the capture-side
>    length already excludes the abstract prefix NUL; the subtraction is a
>    double decrement. Please also re-check :389/:725/:829/:878 against their
>    capture lengths.
> 2. Harden __trace_print_untrusted_str() (or string_escape_mem()) so the
>    input walk cannot exceed the source object: e.g. clamp len, or break the
>    loop when output is exhausted (note this changes string_escape_mem()'s
>    return-size contract for existing callers).
> 
> Found by Charles <dmcjisalive@gmail.com> -- happy to test a fix.
> 
> Thanks,
> Charles
> 
> Reported-by: Charles <dmcjisalive@gmail.com>
> 
