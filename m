Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3719006D;
	Wed,  7 Aug 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029336; cv=none; b=eS4CEClIxHLTy6NGMVeprjsC6sZSvfUOS65qaNKz65/iv0laa8FYU70chlto+24H7F1T2pTajxyOZunEL9fyvfhMgQJLFIkY52P5aRxLJF3TnTaaoYwlX2USncVHKaWxCgXdjcJ/bVep8vpEdpPUy/N/9kxPSriuCx8Rll9CqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029336; c=relaxed/simple;
	bh=/KDjT6PpO7fvydgqtsOxXwtX3zLju3Z5GPtIrzYUU8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTuI73y15QM1lHgaRcWMkvCjoB4LBJxxTCIIJFKBLm2gjbIspwlVapMzhODCNKeOTVPwTfFGZaG/ogRg9P2MViyYcxWeO7RVNgcBjae0fBwT+yCkJc2o2fFda86Ft7NAyZqaj1PoRlCgi6fiPa9qlIP6lWD/hY3Evnf/KA6AB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pNJQ5F0u; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNJQ5F0u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RcsOscq7FlE9juKVWICtqz4JEEQHCeU2rLy1+T4JN7s=; b=pNJQ5F0usSxJDE6W+x8sfaYZNh
	Lprmo2uy0aughBESa3X9d/urQjiNrfv0mIFDUk5InGZmdBtxk7zxZ/x6B9tbooDkqwDRY9HHIELi6
	OuNNDCje7t4Sn74H2QXU1XTPQWlhUDf9ndZSSAU7ODi39ceAeRbj4vJwx4zj/mT9wVjnqv4JMg19r
	fa/r8OYcyby75ggJxf5otJbFHwUPhGu/tl3QAITcqA6HQ+5NimeMUT+s3bapEm27yUIpbq+GPATvi
	MQx1f5BHEevJyKzxiVDIEB66pTanKIHipzthR5DDl2Ii1U6uj6IFkCCt0K/V9RigSfhn8TfPSqXPq
	n057ylvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbedU-00000006byi-3r3f;
	Wed, 07 Aug 2024 11:15:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2FB7B30033D; Wed,  7 Aug 2024 13:15:20 +0200 (CEST)
Date: Wed, 7 Aug 2024 13:15:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Al Grant <al.grant@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: arm_spe: Use perf_allow_kernel() for
 permissions
Message-ID: <20240807111520.GC37996@noisy.programming.kicks-ass.net>
References: <20240807105441.2156738-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807105441.2156738-1-james.clark@linaro.org>

On Wed, Aug 07, 2024 at 11:54:41AM +0100, James Clark wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aa3450bdc227..4a69583e329a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -417,6 +417,7 @@ static struct kmem_cache *perf_event_cache;
>   *   2 - disallow kernel profiling for unpriv
>   */
>  int sysctl_perf_event_paranoid __read_mostly = 2;
> +EXPORT_SYMBOL_GPL(sysctl_perf_event_paranoid);

I'm never a fan of exporting variables. Perhaps create a helper function
that returns the value and use that where required?

That avoids modules getting the idea it would be okay to change this
valie themselves.
