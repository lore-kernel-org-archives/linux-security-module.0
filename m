Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D912367D3;
	Wed,  2 Jul 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457508; cv=none; b=FgzBhtDSKSmaHLi5Tnuo3MHBZQpiWVkOpWpyP/urSY7hR7xcLLAQjToxtmAKjsh4aXXJD8k3CjO0tf2fWTd5EJcFFrgKPmxQvYG3xhLj5yoMVWoaFKUaYuOaQjGdLVFDQUo+RhSpVclQ/FG7R7jlVCJ1j4PSWhNHzQ2Q8MmOwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457508; c=relaxed/simple;
	bh=G7IUTZKcG/MhosKsCw8NlJmZNc3guHub21cjMNrrQOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjkNmJCdhIsACGD3Z/j8Xrn+dwJ2gB4YLZuBP9+EV0ZY4zIBRsq+KbR28GS93foew3dJfEFHi529xX9GRDX7M4ULx3XYf/ivF7ffKBoGzG1InF3BwrlWthvSInwZuSn041Gl0NkkIGjS5Jnap/Ze2uNnuRWfjODYLatJdqGNOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rL/G1vx2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rL/G1vx2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a2F3v23nGGvWezK05/iV6yxFAQUOzEJwGb9ANejg6zA=; b=rL/G1vx2Eqz7cRfP7lsxF2+MOi
	5QhTYbv9rLZhVkGtfooao56tbrof8LE3xjCz05wo82q3Tw5ziNC8plOcYegwUqXUt8+/C7ANTpKzr
	NaI01UMZQRWF697cuk8D72m06Nwjowa524R+C9LR9VktC+Tf6aY2kgFQj0UkWhRlEWahtDUwRT+JF
	Zh6wkjvvmAVswOQBp3EQ9nFC6avYA26mw4Acef3SB+YkeSheQaaHqMpJ0x4fEO8NF9RTHuL7ZNzVh
	ASyKjsiowVRhACZrQxCyhfLL6lSbEdaw41MqLdkT4rkcGV//Vt1CRI+huHALrhUpYMMd9vOPEuDan
	hAkQfZRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWw6Q-00000007Lhc-3HFE;
	Wed, 02 Jul 2025 11:58:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52A29300125; Wed, 02 Jul 2025 13:58:14 +0200 (CEST)
Date: Wed, 2 Jul 2025 13:58:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Serge Hallyn <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-hardening@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	Alexey Budankov <alexey.budankov@linux.intel.com>,
	James Morris <jamorris@linux.microsoft.com>
Subject: Re: uprobes are destructive but exposed by perf under CAP_PERFMON
Message-ID: <20250702115814.GA1099709@noisy.programming.kicks-ass.net>
References: <CAG48ez1n4520sq0XrWYDHKiKxE_+WCfAK+qt9qkY4ZiBGmL-5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1n4520sq0XrWYDHKiKxE_+WCfAK+qt9qkY4ZiBGmL-5g@mail.gmail.com>

On Tue, Jul 01, 2025 at 06:14:51PM +0200, Jann Horn wrote:
> Since commit c9e0924e5c2b ("perf/core: open access to probes for
> CAP_PERFMON privileged process"), it is possible to create uprobes
> through perf_event_open() when the caller has CAP_PERFMON. uprobes can
> have destructive effects, while my understanding is that CAP_PERFMON
> is supposed to only let you _read_ stuff (like registers and stack
> memory) from other processes, but not modify their execution.
> 
> uprobes (at least on x86) can be destructive because they have no
> protection against poking in the middle of an instruction; basically
> as long as the kernel manages to decode the instruction bytes at the
> caller-specified offset as a relocatable instruction, a breakpoint
> instruction can be installed at that offset.
> 
> This means uprobes can be used to alter what happens in another
> process. It would probably be a good idea to go back to requiring
> CAP_SYS_ADMIN for installing uprobes, unless we can get to a point
> where the kernel can prove that the software breakpoint poke cannot
> break the target process. (Which seems harder than doing it for
> kprobe, since kprobe can at least rely on symbols to figure out where
> a function starts...)
> 
> As a small example, in one terminal:

Urrggh... x86 instruction encoding wins again. Awesome find.

Yeah, I suppose I should go queue a revert of that commit.
