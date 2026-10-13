Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9355370ADA;
	Tue, 13 Oct 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900558; cv=none; b=A07iVOSjs9pNL43r0Zx+oB5l42cwbVvvn+5VNyHf+Iuc1+jm+RonG+7CjeQjnh3xJA4IrhyqwCVvFS2Y/GCOEyNeFq2CbGTWDG3Hc+Mi3fZh3AbER4g+FiSRBqg0gwJF25Tm5Ys3QuU+CNdFZB0sWpa2JeZh3m64wKUG1xEZlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900558; c=relaxed/simple;
	bh=Suo0YfCYPtCoLBJ8iZXRfc+dw40jvIHLkG13JRnjZUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBhfoX/PxLWKD3CamJYY8SUFS7v796gXmZuA7p7WY/dsQHAiTFzzCcntDSp7OD9YeECQrTphJx5lwmcSi+TGysqSWP5mAVhs0AUZC8oco7ucy1IsxYwzpCpwJ7HzT5qESobCaFddKAFDcqM+OLcaQZemvF6CHyOhDAIWw2QuMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=kL9ibrJg; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="kL9ibrJg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1791900547; bh=Suo0YfCYPtCoLBJ8iZXRfc+dw40jvIHLkG13JRnjZUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kL9ibrJga4YY3RAquWvtOegRsAK6JNwI4zXpQH4mv6j2Vsk9CY8qfIhLg/GbWf10M
	 DeXquRyTooElnL5wcZ6eBAgd3kldWf1/1DVrk/QnE7SSW6X/eN/0nBES3D+BgjTlUU
	 C/Rx2MZe3C0Slal4i45wXX+ZGEjf9NEkolx65kLPAJurAwcIqT7Fgf9sZxk/YpgtAy
	 XDKHXmjY/8nxliaKEOZl8gn/L8ISgxycaCqcVMdYGSSfKRj3VaBKUpf5cLXmVPw2xG
	 o/e7XKeKzb8AwNvzLFiFE90IPPcFzQuMfwogAUoL6N27g/9+hdqYmLbjfnu+6mI3om
	 KyZ826JuJNe2w==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 2638A6FA; Tue, 13 Oct 2026 09:09:07 -0500 (CDT)
Date: Tue, 13 Oct 2026 09:09:07 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kees@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, paul@paul-moore.com,
	jmorris@namei.org, shuah@kernel.org, oleg@redhat.com,
	brauner@kernel.org, alexjlzheng@tencent.com, jannh@google.com,
	jaime.saguillo@gmail.com, elver@google.com, blbllhy@gmail.com,
	bvanassche@acm.org, pjw@kernel.org, broonie@kernel.org,
	debug@rivosinc.com, tglx@kernel.org, aleksey.oladko@virtuozzo.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, morgan@kernel.org
Subject: Re: [RFC PATCH v2 0/3] security: Add PR_CAPBSET_DROP_MASK
Message-ID: <as47g9Ofa7hgDDLp@hallyn.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929130200.1638343-1-ruanjinjie@huawei.com>

On Tue, Sep 29, 2026 at 09:01:57PM +0800, Jinjie Ruan wrote:
> PR_CAPBSET_DROP only affects the calling thread, so dropping capabilities
> for a whole process means one call per capability per thread.  For a
> long-lived, multi-threaded process such as gVisor's sentry this is
> stop-the-world signal delivery and costs milliseconds per sandbox on a
> many-core host.
> 
> This series adds PR_CAPBSET_DROP_MASK, which removes a 64-bit mask of
> capabilities from the whole thread group in a single call.  The drop is
> recorded per thread group and folded into the bounding set wherever it
> gates gaining a capability, so already-running, concurrently-created and
> later-created threads -- as well as children forked by a sibling -- all
> observe it.
> 
> Trimming 41 capabilities in an arm64 KVM guest goes from ~8.5-23.6ms with
> the per-thread loop to ~11-14us, independent of the thread count.
> 
> Changes in RFC v2:
> - Solve concurrently clone and concurrently drop mask problem.
> - Solove sashiko problems in [1].
> - Link to RFC v1: https://lore.kernel.org/all/20260922095816.1191799-1-ruanjinjie@huawei.com/
> [1] https://sashiko.dev/#/patchset/20260922095816.1191799-1-ruanjinjie%40huawei.com

Sorry, somehow I didn't notice this version until today.  I will take
a close look later this week.  Thanks.

> Jinjie Ruan (3):
>   capability: Move mk_kernel_cap() to header
>   security: Add PR_CAPBSET_DROP_MASK for process-wide bounding-set drops
>   selftests: prctl: add process-wide bounding-set drop tests
> 
>  fs/proc/array.c                               |   3 +-
>  include/linux/capability.h                    |  10 +
>  include/linux/sched/signal.h                  |   8 +
>  include/uapi/linux/prctl.h                    |   1 +
>  kernel/capability.c                           |   5 -
>  kernel/fork.c                                 |   1 +
>  security/commoncap.c                          |  91 ++-
>  tools/testing/selftests/prctl/Makefile        |  12 +-
>  .../selftests/prctl/cap-bset-drop-test.c      | 641 ++++++++++++++++++
>  9 files changed, 759 insertions(+), 13 deletions(-)
>  create mode 100644 tools/testing/selftests/prctl/cap-bset-drop-test.c
> 
> -- 
> 2.34.1
