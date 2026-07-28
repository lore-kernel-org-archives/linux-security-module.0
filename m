Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18F39EB5B;
	Tue, 28 Jul 2026 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258858; cv=none; b=NMA33wSsfBIOD+LE2YlAzcdBzDWunZ4GuIO2ehw8jiHUo/If43rvdLg2n0OT8DMVNwdotWAbho4fJvtxjlnzc2yPUO9dzzV7ikdHC1Wy09Rgiw3zEndkM0h6fZl/Toy8NBPTkVHbc3kKyzPYSaalcOVdoNPpWRAUPwTQ+mmuupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258858; c=relaxed/simple;
	bh=WK1vl6rEnpzszq7fUqq3RtyjJ7InvEb1ZSDa/tCBM+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDs3x+ZSNDcYwFYYrCBFAkFGsPV2y200fxoRvn2Mb9FsXHCgvDdnOtRHeAz3D5mJEQatp2iSmM9vVCOLVEAu3lJz2H3uF9O7zVapyOKeszXuWoMIGqfxnmzLhdgKSXj/cqiZ+cvNDkO8uTfCybGUXa1Lssgz4aY/leeONElkp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giL+94dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giL+94dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30B21F000E9;
	Tue, 28 Jul 2026 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258856;
	bh=3FAw8Qsfeb2JdyMijz9P+Iw7lcvz+cg3BtpqyZzooHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=giL+94dpanfDij6Zw8/FphiJBAozmcjQXW4uwJD4X7wkE8/BqT1+mY8uqSQUIf0Y8
	 bOqaYQ8E8lmqa0VwSiNHh9u7GFxbq31n5udnyzi1T2daW+RWXgAbjFIKGBsU0S48g9
	 oE4lanG19xabyt4PcraZyi8EnuKmcDP/X+aGEvl9T3xq+RsqFgRrkHygnizfeFqtul
	 0E+2o5nnmTx4/PZC+csTl1j13crPMLPXT4lIhA9QEb7fMYU+xhpMxvtzItYEBOnqKm
	 tAIFqxgoHCQNmpLXDpVci9fTs1lQFvRE/ceNaWRp1fA/YwfgMK7qw/kpvnr56v3hJE
	 2dlm9TvxSPjmg==
Date: Tue, 28 Jul 2026 17:14:14 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: lujialin4@huawei.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH -next,v3] ima: add cond_resched() in
 ima_calc_file_hash_tfm loop
Message-ID: <20260728171414.GA3355536@google.com>
References: <20260728123350.2751590-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728123350.2751590-1-cuigaosheng1@huawei.com>

On Tue, Jul 28, 2026 at 08:33:50PM +0800, Gaosheng Cui wrote:
> When hashing large files, the while loop in ima_calc_file_hash_tfm
> processes PAGE_SIZE chunks without any scheduling point, which can
> cause soft lockup warnings:
> watchdog: BUG: soft lockup - CPU#0 stuck for 50s!
> Call Trace:
>   _sha256_update+0x12d/0x1a0
>   ima_calc_file_hash_tfm+0xfb/0x150
>   ima_calc_file_hash+0x6e/0x160
>   ima_collect_measurement+0x202/0x340
>   process_measurement+0x3a9/0xb30
>   ima_file_check+0x56/0xa0
>   do_open+0x11b/0x250
>   path_openat+0x10b/0x1d0
>   do_filp_open+0xa9/0x150
>   do_sys_openat2+0x223/0x2a0
>   __x64_sys_openat+0x54/0xa0
>   do_syscall_64+0x59/0x110
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Call cond_resched() every 4MB to yield the CPU when needed, rather
> than at every loop iteration, to reduce overhead.
> 
> Using IS_ALIGNED(offset, SZ_4M) to trigger cond_resched() is fragile
> because integrity_kernel_read() -> __kernel_read() can return fewer
> bytes than requested (short read). Short reads can occur across
> various filesystems — while common on remote (NFS, CIFS) and FUSE
> filesystems, they are also possible in edge cases on local
> filesystems (e.g., reading near EOF). Once a short read occurs,
> the offset becomes permanently misaligned and cond_resched() may
> never be called again for the remainder of the file. Replace the
> alignment check with a cumulative byte counter that tracks the
> actual data hashed since the last reschedule point, which is robust
> regardless of short read behavior.
> 
> Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Which architecture are you seeing this issue on, and which kernel
version?  In current mainline, most architectures (x86, arm64,
loongarch, riscv, s390) offer only lazy preemption and full preemption.
In all these cases, cond_resched() is obsolete and unnecessary.

I understand the concept of cond_resched() as a whole is on its way out.
It is an approach that has never worked well.

Is it possible that you're seeing this issue only on an older kernel
version and not mainline?

- Eric
