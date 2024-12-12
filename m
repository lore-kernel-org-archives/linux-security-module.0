Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236E1DB54B;
	Thu, 12 Dec 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029749; cv=none; b=oZjis0c0R6YWRN0UvQtCjT2e57Oz2168GoifTEaI5W8lRaWcuqLqLQkQs7fCqjvuQeujsCoAMkAA6x5S5i9T/WgahkWTGD5kWDDE+e0o0/cLTiIucNt7NRviXxzXzvMiP3eCX8VQuf+G8D66eiBQPdTiAUH/kbNsuuCclNQdzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029749; c=relaxed/simple;
	bh=+8dg1DpKpz7coVGd7KWdU+TKjZSKn/R9z9bAFzW4Rz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud9PkW0z6C+fFbMlL/2OCRssrH2lFdw7ZLIrRvCw8rZL86yf/iSGbftX/rDmnSwog9DfxmmFAAXWb61XEd9mzAiAQI8wq6rIiaWf1GBeNL1rWUF6F4PmuKF6mAtCh4xoy9RKhppn2iyxSS6EAICdnNbQ+vFtAZIbXDs521XfrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMp8nsiF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMp8nsiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ABCC4CECE;
	Thu, 12 Dec 2024 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029748;
	bh=+8dg1DpKpz7coVGd7KWdU+TKjZSKn/R9z9bAFzW4Rz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMp8nsiFlUdmebzUbRoaXthrTMZuGtHwoE+99hshDDSnDeLwI/bSHbEhRmLHE6cGO
	 N9jRHgvLnfRtec9+qCay8M+0V1p1Qs9PFmnrFTZImfNZu+f5hnlwmpPjXomQ0REp0j
	 kQeY/0gAtdQ9uygLziLh7zNJk8ajhWC6BfVopPMVZ4k1BAvnXVUnrP18Jz1VUziGzf
	 eaOSagjMdUNIXFslAxicCe8hPIPqXBsYywmOxK2nzIz5vmX2NeNwGCAc2PvDLNEU/c
	 XGEDeoCGRZXF7Pt6py8UUnohcCx/bP4Z+x3fWKxlcWYFoUuMnIx4Ra9pJd6mmsVOBH
	 dJWCWa6UDDxjw==
Date: Thu, 12 Dec 2024 15:55:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] perf test: remove duplicate word
Message-ID: <Z1sxsU3mBsDDLuZS@x1>
References: <20241120043503.80530-1-RuffaloLavoisier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120043503.80530-1-RuffaloLavoisier@gmail.com>

On Wed, Nov 20, 2024 at 01:35:02PM +0900, Ruffalo Lavoisier wrote:
> - Remove duplicate word, 'the'.
> ---
>  tools/perf/tests/workloads/landlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to perf-tools-next,

- Arnaldo
 
> diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
> index e2b5ef647c09..1f285b7b6236 100644
> --- a/tools/perf/tests/workloads/landlock.c
> +++ b/tools/perf/tests/workloads/landlock.c
> @@ -10,7 +10,7 @@
>   * 'perf test' workload) we just add the required types and defines here instead
>   * of including linux/landlock, that isn't available in older systems.
>   *
> - * We are not interested in the the result of the syscall, just in intercepting
> + * We are not interested in the result of the syscall, just in intercepting
>   * its arguments.
>   */
>  
> -- 
> 2.46.1
