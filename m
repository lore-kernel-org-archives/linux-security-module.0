Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0447CA84;
	Mon, 28 Sep 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601246; cv=none; b=UkKX71lKlg66er6t+m/Z/QzgMM4P++gxP/ZG61rzttGtL3iGwCaFTHBwjofF8GSEenXqwT6AiMi3tH6v5W5lPv1caZsk4shGrGHLDxEvigseMKVfEvG6fC6LtEzpU9Q9eCGcwfsZcxwscLJvfj13NAc1qEq1FjON7KwxFLFnXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601246; c=relaxed/simple;
	bh=GocJgfuPT72cKEg3bm4osv0OZxD7cy1wWgciX0EOcvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doEpeXrfaa3LN5RsW7rquIbWhK4DjCjsWRvzo6OkZDAOy3pfDSADWA7LadTZhT3dL/tQ5s9EXoe/b/jkxAysHRLd9iyJXIVgc0a3+WJLBzyiClq7Xllx/pxJuX/07otLSxw4lSEMyJcgvjqikrbcem9oooe0Al+pxD+DhIt5W7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=ExWJaAtM; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="ExWJaAtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1790601235; bh=GocJgfuPT72cKEg3bm4osv0OZxD7cy1wWgciX0EOcvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExWJaAtM1Fy5UfZ4xwuGWHuQ4QMLxL/2jmOGmxO5CEOQkhqxAhJjvpyBKpiWMbAG3
	 wMvUBAJVwLSYA5dzkeucvIjO8vnur3Z6rDbKXTrtXHW+7DojcKm3hJ7K+YBr09Q/PC
	 ZOcneFc/Y8Egw9thUymlIRNrpo0m/mhDF3HNv9FnJkztInSjC9FjpBhEzcDUXtERPJ
	 YAIApugXnSvBvKe10y4UmIalohDLU+FK7KheIDrVpaz3AKWh73Za5Pn8vomsP5XGzu
	 +1dhRpF/sJ+qfmxzyyfPEJ0C3RQfi8EFfcMkQv9NrGYIhZNoJlj5/+r9gwEqWfPHt+
	 6Y1QPbhP99/Ng==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 291DFA57; Mon, 28 Sep 2026 08:13:55 -0500 (CDT)
Date: Mon, 28 Sep 2026 08:13:55 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: "Andrew G. Morgan" <morgan@kernel.org>, paul@paul-moore.com,
	jmorris@namei.org, pjw@kernel.org, tglx@kernel.org,
	peterz@infradead.org, debug@rivosinc.com, broonie@kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
Message-ID: <arpoE6UN7xuv87qR@hallyn.com>
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
 <arK0cT7CGb3Khy69@hallyn.com>
 <CACmP8UK5wGZmBTRVBOm2_ZGhpFG-jWpihvUNxrcrgXr5K2GYEw@mail.gmail.com>
 <araGY/FhiKu61l5v@hallyn.com>
 <26ec4edf-8eb4-4153-8e17-7f67376f13a8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26ec4edf-8eb4-4153-8e17-7f67376f13a8@huawei.com>

On Mon, Sep 28, 2026 at 11:10:14AM +0800, Jinjie Ruan wrote:
> 
> 
> 在 2026/9/25 22:34, Serge E. Hallyn 写道:
> > Jinjie, could you reproduce your timing experiments against the
> > SetProc code?
> 
> Hi Serge, the test result is as below:

Thanks!

> |   method      |   Description                                       |
> | ------------- | --------------------------------------------------- |
> | baseline	| Per-cap syscall.AllThreadsSyscall6(PR_CAPBSET_DROP),|
> |               |   the original gVisor implementation                |
> | dropbound	| libcap cap.DropBound() (library API, per-thread)    |
> | SetProc	| cap.IABGetProc() + SetVector(Bound) + SetProc()     |
> | SetProc-min	| Minimal IAB with the read overhead removed: NewIAB()|
> |               |  + SetVector(Bound) + SetProc()                     |
> | mask	        | prctl(PR_CAPBSET_DROP_MASK, lo, hi)                 |
> 
> All variants uniformly drop all 41 caps (cap_last_cap = 40), and both
> the success rate and dropped are verified.
> 
> Sampling scale:
> - Patched guest, 8 vCPU: 2 boots × 21 runs = 42 runs/point, 1050 samples
> total;
> - Patched guest, 32 vCPU: 21 runs per point, 525 samples total.
> 
> Mean in µs bucketed by actual thread count (sample count in parentheses)
> 
> ## 8 vCPU (42 samples per point)
> 
> method	     8–15	16–31	      32–63	   64–95
> baseline    3258.9(41)	6955.9(43)   10303.9(84)   14394.3(42)
> dropbound   3356.3(41)	5048.1(43)   9914.3(84)	   16837.1(42)
> SetProc	    3365.4(41)	6255.4(43)   10179.4(84)   16799.8(42)
> SetProc-min 3485.0(41)	5603.9(43)   10533.2(84)   15146.8(42)
> mask	    68.2(42)	92.3(42)     224.2(84)	   433.7(42)
> 
> ## 32 vCPU (21 samples per point)
> 
> method	      8–15	 16–31	       32–63	      64–95
> baseline     8422.4(20)	 8491.8(22)   17814.2(42)    21612.6(21)
> dropbound    5235.5(21)	 7568.9(21)   17350.8(42)    21205.5(21)
> SetProc	     5540.8(21)	 8159.2(21)   17920.5(42)    22168.3(21)
> SetProc-min  5582.8(20)	 7907.7(22)   15136.0(42)    22334.5(21)
> mask	     114.6(21)	 181.8(21)    428.5(42)      684.7(21)
> 
> So IAB.SetProc is not an optimization. Like the gVisor baseline, it

Oh, I could be wrong, but I didn't think Andrew meant that it was
an optimization.  Rather, it was correct, and possibly complicated
or fragile enough that it belongs more in userspace than kernel.

Looking forward to seeing the updated design.

> issues one PR_CAPBSET_DROP per capability on every thread
> (syscall.AllThreadsSyscall); averaged over multiple repeated groups, it
> is on the same order of magnitude as the baseline, or even slower.
> 
> > 
> > On Tue, Sep 22, 2026 at 07:10:11PM -0700, Andrew G. Morgan wrote:
> >> The https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/cap#IAB.SetProc
> >> already handles this for the whole process. It can be run from main()
> >> if you need it to happen early, and it will track down all of the
> >> threads in the runtime.
> >>
> >> To Serge's point, I am also curious what benefit there is from doing
> >> it more quickly. After all, this is pretty much a one-time function
> >> request for any executable.
> >>
> >> FYI The "sendmail capabilities bug" reference is written up here:
> >> https://sites.google.com/site/fullycapable/thesendmailcapabilitiesissue
> >>
> >> Cheers
> >>
> >> Andrew

thanks,
-serge
