Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAAE457E43;
	Mon, 21 Sep 2026 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987159; cv=none; b=uANr0953/3fEhD1eciz3PjEyZKThiQgG7lynLxWumrq/yJYOQoeq0E9UPm2WBBEW+rBonM/rDLMiLa3OLGEmuCS8sh5iXjVed1MnHR8sBFK0nMXhuaSpt8g1v7InM2GMUEm4G52D+qqDOnwo4BCOUO5elGUrazDKbpygWCYQtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987159; c=relaxed/simple;
	bh=qBP3FHSpE2eyqbhsAm0I3ZeM4fCDqi5syDOsIUN4ujw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q74bcX2tf7eJ9zgIGOjeCh9J94ypSFCaQAoqUHUbTkvv5gWooSuAQVGM+aJKAL1GU4mAKVMVBfuauKtD4Pp0ufM1hGeeo1tOQcXdAtOFps9JTLKBuKS1UXfgGINLG7i5tC7K+JL9Pr11stKOf3+f0EjaEIb8y0TN1hj7X2Dz6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyd7lfOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyd7lfOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92411F000FF;
	Mon, 21 Sep 2026 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987155;
	bh=tUT07PoqMhyFda+phwcBfTPUcwne4TMjaTdgdBAux9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyd7lfOnBRHV7gib0XY73MBzQuywKjHCGHfN8zgunhAT5zWCNszemogAo3VormRyR
	 6OosXfmTGDsXovGVjxU9TgaJRnSwij9RHRyt+jOH4Fst/GKRMh3CtvntITUXgv8PSA
	 fEyHFvKvrGJ7PVyBcVKJaEgRSs++UreKXqdjPSWzxau0OKfsTJX1gUeoSWHCAJSBAz
	 1o5/xFVetVf1w/RVNrcGNCg4aVkIOd/42PvfxKO6Lez6ALtHMVjN0FQxtOHb/HMM5x
	 fwCdq2WdnZKxyQorSubDg2T4ckQiMuS2oziBd1NAD7OEHRtdTNFQ8mVXLmhx/X6Foo
	 kwPeYnoT3RTRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/15] fs: convert process/thread iterators to
 for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260921092101.89285-14-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-14-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:39:14 +0000
Message-Id: <20260921103914.C92411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] fs: mixing goto and scoped_guard in __set_oom_adj violates cleanup =
rules
--

commit da2e9c3ae4d6602d37bc777bfafc43d2f081d385
Author: Ye Liu <liuye@kylinos.cn>

fs: convert process/thread iterators to for_each_*_rculock
   =20
Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
with for_each_process() and for_each_process_thread() loops in fs/
with the for_each_*_rculock() macros, which scope the RCU read lock
to the loop body via scoped_guard(rcu).

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 58be389424605..2c47d838a1c76 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1161,8 +1161,7 @@ static int __set_oom_adj(struct file *file, int oom=
_adj, bool legacy)
>  	if (mm) {
>  		struct task_struct *p;
> =20
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rculock(p) {

[Severity: Low]
Does introducing for_each_process_rculock() here violate the rule against
mixing scope-based cleanup and goto error handling in the same function?

This macro expands to scoped_guard(rcu), introducing scope-based cleanup in=
to
__set_oom_adj(). However, this function already uses manual goto-based error
handling:

fs/proc/base.c:__set_oom_adj() {
    ...
		if (oom_adj < task->signal->oom_score_adj &&
				!capable(CAP_SYS_RESOURCE)) {
			err =3D -EACCES;
			goto err_unlock;
		}
    ...
err_unlock:
	mutex_unlock(&oom_adj_mutex);
	put_task_struct(task);
	return err;
}

The subsystem guidelines require converting all resources in a function to
scope-based cleanup, or none at all, explicitly prohibiting mixing both in =
the
same function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D13
