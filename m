Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE93DDDD0;
	Sat, 15 Aug 2026 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786796384; cv=none; b=MSH3RCML7rOeYfglHB2AR0elZWkC2dtWT2+f0b3Jrh/1ReXBS6RpHPsJW/EgD1felNCNP3Q67RwKcQLFzvLlHHdwz5UOck9dj6AaE+9xeZ/f76Bk2+z3QCJXAw6LPPkER0iyspPKao0POhXyTcBL3QXA6S/BudbHw17CYNxwZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786796384; c=relaxed/simple;
	bh=bNrr/izJnCw/J6FAkdUo5QxSLMdjqW4HbKesVYK9Q74=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xv9kTHRwOj06pQoXOwv1FJjlrNcZwOhpwcgVuGN+6oCnDsq1pUHA1OgPT0Cpb2ecbtBMHxFDFyRs/fh+MNBwUtTb+T+3LVuuMc11PPguqgL05znGadyI6dfe9aoUFPe+m+vKwENtwLnh1ty8k3n5TctoX+gggPlo6ORmN8nuxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXUrDI0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXUrDI0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABAE1F00A3A;
	Sat, 15 Aug 2026 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786796382;
	bh=bNrr/izJnCw/J6FAkdUo5QxSLMdjqW4HbKesVYK9Q74=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XXUrDI0dWNy9BFKwXrX6RP+m2r7xn9SyknaBX3CE4Vc0URkUkZi/vFq4CWALc1jnn
	 4zeSyzmzvLHhKy6YSGx1hTmOIrB+eOhFIZfbf7K+JDBxcf6ukSnw8ZK+s/gQGR+LAi
	 125bry+0c0sZRW4KuNPr/MZ6n/5B74EhLg/ZzNLTXc7ph8dgxFSgDDbztGKK9imDwt
	 1YoNOCsSQodZv2VPY+f2vE1rVLjzjxt2MrAZYXnVe3N0Rx68VQorGFwmQd36lfMI0p
	 mmlatbTrsaSJQz4/VsEAYODu2iRk2NpXsAk78b1V1JmiUJwj9RzhgxL2iYIb8HmJ4J
	 imZXEOAAk8qVA==
Content-Type: multipart/mixed; boundary="===============5072763427968193222=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <099a7d68c7cffa7599e5227605f010906ffe0116fe7c2e6f9fa10804e33bd8ef@mail.kernel.org>
In-Reply-To: <20260815112041.1248855-2-utilityemal77@gmail.com>
References: <20260815112041.1248855-2-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] lsm: add bpf_security_locked_down() kfunc
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,paul@paul-moore.com,xiujianfeng@huawei.com
Cc: linux-kernel@vger.kernel.org,linux-security-module@vger.kernel.org,bpf@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 12:19:42 +0000 (UTC)

--===============5072763427968193222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> lsm: add bpf_security_locked_down() kfunc
>
> Add a new kfunc bpf_security_locked_down, which calls
> security_locked_down and returns the result.
>
> Create a new file security/lsm_kfuncs.c for LSM framework kfuncs.
>
> Reject reasons outside (LOCKDOWN_NONE, LOCKDOWN_CONFIDENTIALITY_MAX)
> with -EINVAL before dispatching the hook. Limit the kfunc to
> BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL programs, and refuse it
> to programs attached to the locked_down hook itself, which would
> recurse into the dispatch.
>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

This isn't a bug, but could the changelog lead with the use case that
motivates exposing security_locked_down() to BPF programs, instead of
restating what each hunk does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31882515336
--===============5072763427968193222==--
