Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D063A9002;
	Tue, 18 Aug 2026 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024889; cv=none; b=r+WUTfz1jCDNsIXjzRerNsZjlud+ZmEzEzi4WoKbl9NQl60ZjT5fvG8JGaemIYicGWYRUG4vXFl2jAdIveqFPovO/Fyt59EnPRBSQahN770RTgU06/hDTtar3AusHlXd5/prK286uD0iM/D08MbhXwTUs4QOMENM9KrFWIDi61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024889; c=relaxed/simple;
	bh=yixyTo1971oLIY7w5vtlHVoeZwVu+PtOIG8SWb2Y4DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jztMqUcQh9+szWw0oCo+olyrELnvXvFsv0touvyZgPCg+OaPotO0zqcGlgjb6Abq8Vjr2BQArpbWNu/fPO7ZMy8TIkzf1NDuKZYlkO8qo5hdVgT6ZaWuPga/G3LAOAOyRwybvm/DDWIti4XVgoc64pRitZOQPqYfnWjPs1y6GiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hPFyk2YGJzYQtLf;
	Tue, 18 Aug 2026 11:47:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0981F4058D;
	Tue, 18 Aug 2026 11:47:57 +0800 (CST)
Received: from [10.34.206.8] (unknown [10.34.206.8])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgC38UDr1YNqZA3mCg--.52763S2;
	Tue, 18 Aug 2026 11:47:56 +0800 (CST)
Message-ID: <6ab57477-69f8-4c60-852e-58ce7ef25023@huaweicloud.com>
Date: Tue, 18 Aug 2026 11:47:55 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Justin Suess <utilityemal77@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiujianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
From: Xiujianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <20260815112041.1248855-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC38UDr1YNqZA3mCg--.52763S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4fKFy3JFWfWFyruw1Dtrb_yoWrXFWUpa
	1vgF1akr9rZF1xuF17JF47Wr1Sq395Cry7CF1fG3yUAan8XF1xZr1IkFyYka1agrZ5Xr4F
	vFyI9a9xCa4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

+cc Nicolas

On 8/15/2026 7:20 PM, Justin Suess wrote:
> Howdy,
> 
> BPF programs can attach to the locked_down LSM hook and contribute a
> verdict, but they have never been able to ask the locked_down question
> themselves: there is no way for a program to invoke the hook and learn
> whether a given operation is locked down. (i.e be a caller of
> security_locked_down rather than a consumer).
> 
> Today the state has to be fed in out of band, for example userspace
> reading /sys/kernel/security/lockdown and writing the result into a
> map. That is a time-of-check/time-of-use race: a security_locked_down
> verdict can be raised at runtime, so the cached answer can be stale
> by the time the program acts on it.

Adding the bpf_security_locked_down() kfunc does not actually solve the
TOCTOU issue you mentioned. Even after bpf_security_locked_down() is
called, userspace can still change the lockdown state via /sys/kernel/
security/lockdown.

I fail to see the necessity for a BPF program to know whether a specific
operation is locked down. The test case provided in patch 2 does not
clearly demonstrate a scenario where this is required. In my view, the
verdict should happen exactly where security_locked_down() is currently 
invoked.

Furthermore, based on the current implementation of Lockdown, integrity
is the prerequisite for confidentiality. It is designed to be coarse-
grained and does not support per-operation lockdown. The fact that LSM
BPF can already hook into locked_down seems to violate this foundational
model, this is is analogous to the bitmap implementation [1], I’m
considering whether we should restrict BPF from attaching to the
locked_down hook. Nicolas, what are your thoughts on this?

[1] 
https://lore.kernel.org/all/20250728111517.134116-1-nik.borisov@suse.com/

> 
> Add a bpf_security_locked_down() kfunc that calls
> security_locked_down() and returns its verdict, letting LSM and
> syscall programs query locked_down state at decision time. Out-of-range
> reasons are rejected with -EINVAL before dispatching the hook, and the
> kfunc is refused to programs attached to the locked_down hook itself,
> which would recurse into the dispatch. (how the obvious recursion issue
> is addressed).
> 
> As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
> to host it.
> 
> This kfunc has no reliance on / relation to the Lockdown LSM, despite the
> similar naming. It is an LSM-agnostic caller of security_locked_down, and
> Lockdown just happens to be the only in-tree subscriber to this hook at the
> moment.
> 
> In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
> all, and uses a BPF implementation of security_locked_down.
> 
> This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
> enabled due to this line in security/lockdown/lockdown.c:
> 
>    pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> 				                 current->comm, lockdown_reasons[what]);
> 
> Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
> applies cleanly to the lsm tree.
> 
> Justin
> 
> Justin Suess (2):
>    lsm: add bpf_security_locked_down() kfunc
>    selftests/bpf: Test bpf_security_locked_down kfunc
> 
>   security/Makefile                             |  1 +
>   security/lsm_kfuncs.c                         | 84 +++++++++++++++++++
>   .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 28 +++++++
>   .../testing/selftests/bpf/progs/lsm_kfuncs.c  | 34 ++++++++
>   .../selftests/bpf/progs/lsm_kfuncs_fail.c     | 26 ++++++
>   5 files changed, 173 insertions(+)
>   create mode 100644 security/lsm_kfuncs.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c
> 
> 
> base-commit: d82ebfc685c91e7f5623a8be949da1ddb767420b

