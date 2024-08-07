Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6B1D4141;
	Wed,  7 Aug 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032051; cv=none; b=dDhTj92zMfVHbT8bBj7hjwWgkCUTx/Pn5JxKOet/UtqFANoCU+Zw5Vv9pTEEmg2VPN4OlE/9x4UZcbypltiUd3tTG62Z7GO3VWDjsrB3r60BgpdbVopiBl3Na42Ai9eGxtVo2hwiQjbqBgD+1zhAjwp7PIyH6BzmXxAluSG5XIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032051; c=relaxed/simple;
	bh=p21/cAWglAJpXxD0R88qELV4sHF1fr0kWpyfApXgfNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlO8wbwsUa2EzULcH6At8lbJDtx9/nvV7e2W+ht0AhWWcnIO0/bapKn73ocPSjtZ4lb03kaShkge0pgn87xM91/eIAVDTBHhosxkEbSzpHQnP4hc83znk1Pbh2sfCq4XkEBqKcqCavbBkz53Nk/hpayv+NwRlGidi1qhyojoYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kKaUa4HV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kKaUa4HV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n/W/nSgbzNrLM+cmNRa4NEKX2FGNkLkKMNvXJShIpdo=; b=kKaUa4HV2uDb/PdIYG2IIt265H
	M2TXa4Hsti7rgORq8OzPACuosfzx403yaxl2kI5nhBYv+9n1FOFDHYaevXkDchvJKRgDGFyK4capC
	LSAWrAemIOX985VrKY6zhK6dLKcBuLtlcUKqAMN7O5s72kDrqlxZ2hVePZFj3ekAfTuVgd8X4DDhg
	JsQ974iqa8C7CgyAh9J0oK3owXUbooXoScp30LmKhCUzLvdqpcZdb5v7n9m4pRYK/YxbfEwQSo9pD
	tcYw7+kxGUEA01JSX6AWN17G7vPJoHRm2u6kIyHD2HXMja4kz8U9uS29X8K/Q++iy0JNxArZRbX7F
	JJQH/RGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfLM-00000007GB9-1qEC;
	Wed, 07 Aug 2024 12:00:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F281930033D; Wed,  7 Aug 2024 14:00:39 +0200 (CEST)
Date: Wed, 7 Aug 2024 14:00:39 +0200
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
Message-ID: <20240807120039.GD37996@noisy.programming.kicks-ass.net>
References: <20240807105441.2156738-1-james.clark@linaro.org>
 <20240807111520.GC37996@noisy.programming.kicks-ass.net>
 <bfe18512-03fc-4e17-b945-d8e3480a32e3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe18512-03fc-4e17-b945-d8e3480a32e3@linaro.org>

On Wed, Aug 07, 2024 at 12:20:13PM +0100, James Clark wrote:
> 
> 
> On 07/08/2024 12:15 pm, Peter Zijlstra wrote:
> > On Wed, Aug 07, 2024 at 11:54:41AM +0100, James Clark wrote:
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index aa3450bdc227..4a69583e329a 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -417,6 +417,7 @@ static struct kmem_cache *perf_event_cache;
> > >    *   2 - disallow kernel profiling for unpriv
> > >    */
> > >   int sysctl_perf_event_paranoid __read_mostly = 2;
> > > +EXPORT_SYMBOL_GPL(sysctl_perf_event_paranoid);
> > 
> > I'm never a fan of exporting variables. Perhaps create a helper function
> > that returns the value and use that where required?
> > 
> > That avoids modules getting the idea it would be okay to change this
> > valie themselves.
> 
> I could also remove the inline from perf_allow_kernel() and export that
> instead. I don't think it really needs to be inlined but I gave it the
> benefit of the doubt because it was added that way.

Yes, that works, none of that is a fast path anyway.
