Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4097153573
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085271; cv=none; b=nBn4nfsJfj1/r7AXaGwvddhkwNkkkDt64d1h8mkd9yqmXTaTuJajLqVuc6ry2rL0HkqzU2uamek/ISqN7Sbva/WsMzOKVE3Xkn5VTe17j6N3ExSFccyve89jBP8WbZTryf6Rg5Lb7soRBnZ/+VHhJYia0KIyddYLuoRzMnLjKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085271; c=relaxed/simple;
	bh=iujaYdwllFg3cG+JJcJMnKE3iL+dAomyKsil3KRn56k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mu3bOrxk3ePUhb0NyPPhDlnsLx68yxgINm71dk0YhGoWW+E+75JX8Py+ZtdAf8f2KobHBeBgO5YVcAAWxLHkOpbuWUkKXGg1bscly3Qvk2oR3NB5R27IyBYzS8/BmSXSEqPHhUQR99Q8LNc8/Wt1Q6Uz3Yqik5k9eon8kbJxRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 494Nf620052680;
	Sat, 5 Oct 2024 08:41:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 494Nf65x052667
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 5 Oct 2024 08:41:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
Date: Sat, 5 Oct 2024 08:41:06 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202410041305.544EA7E4E@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

On 2024/10/05 5:54, Kees Cook wrote:
> - tomoyo_register_hooks() becomes an exploitation gadget that could be
>   used to bypass the LSM as a whole.

tomoyo_register_hooks() is enabled only if "CONFIG_SECURITY_TOMOYO_LKM is
included while building the kernel" && "security=tomoyo is specified or
tomoyo is included in the lsm= kernel command line options".

Therefore, those who are building kernels with CONFIG_SECURITY_TOMOYO_LKM=n are
not affected.

Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, callbacks
registered by tomoyo_register_hooks() won't be called unless "security=tomoyo
is specified or tomoyo is included in the lsm= kernel command line options", for
the proxy callbacks that use static call tables are not registered.

Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, and "security=tomoyo
is specified or tomoyo is included in the lsm= kernel command line options",
tomoyo_register_hooks() can be called only once. And tomoyo.ko is loaded by the
time /sbin/init (nowadays /usr/lib/systemd/systemd) starts. That is, by the time
an attacker can login from console or can start attacking via network,
tomoyo_register_hooks() is no longer callable.

If an attacker can control boot behavior before /sbin/init (nowadays
/usr/lib/systemd/systemd) starts (e.g. by editing kernel boot command line, or
loading malicious kernel module from initramfs before tomoyo.ko is loaded), that
system was already compromised and is a different problem. (If kernel command line
options were modified to enable only capability (i.e. "lsm=capability"), how can
selinux/apparmor etc. can protect that system?)

Therefore, the only problem with tomoyo.ko approach is that the static call tables
for tomoyo_register_hooks() are currently not marked as __ro_after_init. But it will
be possible to make the static call tables read-only if the static call tables
are aligned in a page boundary and an architecture-dependent kernel API that changes
given page's attribute to read-only is called. (This is why __ro_after_init can work,
isn't it?)

As a whole, I don't think tomoyo.ko approach is unacceptably dangerous.

