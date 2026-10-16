Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9949BB61;
	Fri, 16 Oct 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175349; cv=none; b=jtL2kJFx3QPFbAHfDHaxSNKt4ZTRDvJ2t9NItlBd0TRCcW+7BHywDrKAyy0udFjbPZeKVWnqyGiPA5GPhLuPgaaqJ98wmlj5roiyKTSLVwvH/FqGBCEU2QNAAUKMDZRuMgb6OucyO+v7c32Cf2HsBhHrX7O72O9qhLDfWOwvxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175349; c=relaxed/simple;
	bh=sU8Huw5FGvFuFeiFie3QNStejqRmTyfwZt88UfwRTJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8y70wjdWQ3Lm5ewg+Lpx2gcI4ao7t3gz/KgDbNKbogCSZGbok+8O5uSJadp9cpb109+ljS0enEM39JeI9uRJGmcZPT6LvzWrxqYHq0NoYRt9h2GQC3szFvTprqBOsnv7sukQW+0M+H53bkLNOFqJvSUkPoZr05QJBrEVBNpNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=kSupG2xX; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="kSupG2xX"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 85359A0102;
	Fri, 16 Oct 2026 18:29:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 19AF117;
	Fri, 16 Oct 2026 18:29:01 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:28:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, =?UTF-8?B?R8O8bnRoZXI=?= Noack
 <gnoack@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Petr Mladek <pmladek@suse.com>, Shuvam
 Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 02/12] seq_buf: Do not pop from an overflowed seq_buf
Message-ID: <20261016142859.06a43120@gandalf.local.home>
In-Reply-To: <20261005155708.1471260-2-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-2-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: b5nkuwouyhdy4u993jis7grybge175xf
X-Rspamd-Queue-Id: 19AF117
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fj1YGWdwbFm32+9d6zhiqh+led4Jioec=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=nsnHAZht4xXX+NUY+dLaXZLvYlkPS38RZLvaJ/Efn08=; b=kSupG2xX+nSyKoGHdIOevUk2mVcxCRE1bmLaeggcqQdkCUj17Vt4YprEKYZFC3Mh72j06Yc119wIgVM8sqGGgVeBHcUJs1KYVOvbXKp3SX6/TupSQnRywUFLsRCNal8OrJuHxkR9qb6629LhVvGINhpegY933ODevC5KngvenZM=
X-HE-Tag: 1792175340-407831
X-HE-Meta: U2FsdGVkX18lzNMQUpfgWhTfZ2S5QXhKq/p+WHUnR5iO7Un9E9CHipp4Z0C+TZhiJpv7OW61sdClHiB1FnByNoJAJPv6e04xeN5kvFfj7e+Z2ir9uJL/m42Z6kvdZuLttn9l5VMV+hxKaSMaiygUIKrypj62CKZQslnaFljBXuV3R1OVGnoFBChdaKvhW6pLyMI8T8Yj20yTAjw5tHFX9bLhWd8SDG4DNg6fSdLM5aHsvZOJ1k6U210wbRfQQ6EC2kj74XjmDigvgeJZWzYdru0E5t8Vt+ct5vsvxth1inXLWd5A5KgwB5YGmiwQVATbuyKGLFPHqVqTdFKSbf9xm0XidHX6ambNt7HGdNlrZvznmg9e+NyvzRSZE9yRQkaHYG5gWgoZ5w3AqqWlEmsoUHIpTlsHf8xOcokP5JgOre4=

On Mon,  5 Oct 2026 08:56:52 -0700
Kees Cook <kees@kernel.org> wrote:

> When a seq_buf has overflowed, its len is size + 1, so seq_buf_pop()
> decrements len to size and reads buffer[size], one byte past the end of
> the buffer. It also leaves len equal to size, which no longer counts as
> overflowed, so a truncated seq_buf then looks like a complete, full one.
> 
> An overflowed seq_buf logically has no last character to pop: the
> length of what was written has been lost, and the last byte of the
> buffer may be the NUL written by vsnprintf() or bytes that were never
> committed. Return -1 for an overflowed seq_buf, as for an empty one,
> and leave it overflowed, as the rest of the seq_buf API does until
> seq_buf_clear() or seq_buf_init().
> 
> The current callers do not reach this, e.g. trace_syscalls only calls
> trace_seq_pop() when the trace_seq it pops from has not overflowed, and
> kernel/bpf/diagnostics.c sets the length from strnlen() before popping.
> 
> Add tests for the pop corner cases.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.
> 
> Fixes: 32e0f607ac6a2 ("tracing: Add trace_seq_pop() and seq_buf_pop()")
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
