Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7873BCD10
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046159; cv=none; b=AwCFkIbmW/FTcKNzA3ti5l55aYVBdOVLBVQKplxHeBwSXn4zhqxxUKyWaNCNsWgr436Y0OGod1uC+y/6X1q3gA/T2xQZSDGZrSaEuZSi2Z0QqwOsXozfF0yg+5cXhB5hsnFKWO9vVFLfPjMsp54inePPVvXTFK24+OolYvifKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046159; c=relaxed/simple;
	bh=CAb72qiPny0PvaNCxNGnctOEEFn6/mEhCO2bGL68Rc0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YIzSK8GWkXbfrB9uD7MbfIXiVTT/vrPohMwbVlCq7wN8hIBojv+SW5/dIaPSTF+2OSjF42gEjfi/2hceQR2qPhAkIWGvb0WhXIoqR+GFQUQixCD1A3FeM/o7Eh0pmuVYKIlLnHfN5lzrh18g98kS+zJBjW+A7HXr/KhMOx8QB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwHTJw0s; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwHTJw0s"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso9475195e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787046156; x=1787650956; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4Ql8DayXDknHcRJNarA/M05HCBsQ3VGg+smqXrhUYPQ=;
        b=OwHTJw0s1BTdkVyFLT6Bx0gPBH8JsQ6j4LvEHL6Wm8iInaV0rtUVXF2VJZ6bAO4m3z
         iW/mD2bXmKt9ACbNdU4GOyMrLP7QHeAwmmuTHiVDjKT+260yIkfnpzBPBnqFmCoFOhJ4
         hvy7Sms2FeDdMq05VH7UjLoGTjQVzOMZ0jpIP1vc3x+Nnyu5AEtqvoaepM3Bua+8V9Ta
         twQ+p9FITkT6eQckcD8Z6m6MSs3TyoOMzJX3Kaq+shQhyWEKViKbcAjJLsNoZ4XoHLQu
         MLNvH6v/CtL8Lk3hDIsnA9RRAv6yFyFcY64XQGCqxx9gEU4IEWrsHxQlbEfzrUtMslh3
         2pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046156; x=1787650956;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Ql8DayXDknHcRJNarA/M05HCBsQ3VGg+smqXrhUYPQ=;
        b=NyqE2kFIFYQ8KsIsGui+o1vwSLpALjKA1JSvWkpwozzjUm0Oqg2VZ/HgyvyRnD6gTQ
         vikzrzDlnf2oQLNNybQDD890A8lPBKHZDhWuEy5tEvdQoDVNM/AhP+SH7JFOPVNP3Q4D
         jrU2cgrSy1e3oJ+Y9XD5xwftt8fQGs7ecClPplT3ganPEwTxjzJocz8ZiWvZT5+su1d3
         2KFufViqk/X9MMKM+VWt9iSSWn2OwhuUYJJcXUnycKT2+n/JgNu43pJ4HBMWbbTOu+55
         OqTSurUlypz6Xl270fXr3i0DAg1r/3sLi2T1cicdoeMOBYLk1WS1eO1HWjDEkombInVR
         98iA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7vhGd1/iqyOTtLTNQ10Zt57KXz1PBqLwjR/yrVziyp0qMHkIYUG5yU+7Cwu9rm/SKS2LxQvW/xTNKUCJ5oXQgNuOvIPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrdjcdLY+qi8zUQU1ovZCyEPyFpzce/KJ+mN6QggDK3211nxS
	2Y6eTDTAgKAgCVE4sVkTKNHrq7/nBaW8JcTKmwzg2BJuC74IA8uSadfMGVOB5M/y
X-Gm-Gg: AR+sD13TdtNWWa0bxigSpOOu0R19/3jvKHpvtRm/YO8WCGONx5J6EiDBriMDYAku/pk
	SfC0ffPJG0dLcK309B0pT+4b46+8MGkF4UyoaxgxG283qXaL49L+jnpf552Zja6J5fwFl3BrWrq
	2Vl2qPz8pJmvSMmdVqm5rVoOiJ2zO6Ax2JVLt0XwAdn/rCONduT8sADPbIG7utGlSS8vaoyB8VC
	zYp4F+PYsnDNsqxtjCYPXNoS9mJPJo+fkHYCYBD5KJQ1tSnuMW4l8vfMuatLA1OnToz5EYlnId2
	Ot5A2VmPYXXMNXpH8nmmyOWrqMShHTHWF45wE/HCkUp8/mFaxAR38ESHCAOHYZZM5nC9mbdgZuu
	sM0/na4CQaXuNlaE/jXtlsBdsWfFq/kTzdfWhiG6Uwg0niaoHu7geWaqTAW8ENTGxJT4grIy+ej
	vG4Fvn/C+20uJ1XeQ+O0e7zNaxzXSW94trYLjpk5YCbR8uUmTNXiRYD8RAXxVhijX3NJuut2FEr
	UaQN5SgEd5jbgX2NpchgLzoaPfCKHs5ZT5qKMDZMQCgu9vDg20TzPD5eDlGnddMScL/B8zsuKQU
	RbTwdMgZYJbm0q9ep45B+Glk8pI=
X-Received: by 2002:a05:600c:8b6f:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-4999faf519cmr127092225e9.6.1787046155704;
        Tue, 18 Aug 2026 02:42:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998777a4bdsm249127735e9.0.2026.08.18.02.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 02:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 11:42:34 +0200
Message-Id: <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Xiu Jianfeng"
 <xiujianfeng@huawei.com>
X-Mailer: aerc 0.21.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
In-Reply-To: <20260815112041.1248855-1-utilityemal77@gmail.com>

On Sat Aug 15, 2026 at 1:20 PM CEST, Justin Suess wrote:
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
>
> Add a bpf_security_locked_down() kfunc that calls
> security_locked_down() and returns its verdict, letting LSM and
> syscall programs query locked_down state at decision time. Out-of-range
> reasons are rejected with -EINVAL before dispatching the hook, and the
> kfunc is refused to programs attached to the locked_down hook itself,
> which would recurse into the dispatch. (how the obvious recursion issue
> is addressed).
>
> As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfu=
ncs.c
> to host it.
>
> This kfunc has no reliance on / relation to the Lockdown LSM, despite the
> similar naming. It is an LSM-agnostic caller of security_locked_down, and
> Lockdown just happens to be the only in-tree subscriber to this hook at t=
he
> moment.
>
> In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN a=
t
> all, and uses a BPF implementation of security_locked_down.
>
> This kfunc can cause notices to be printed with kmsg if the Lockdown LSM =
is
> enabled due to this line in security/lockdown/lockdown.c:
>
>   pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_l=
ockdown.7\n",
> 				                 current->comm, lockdown_reasons[what]);
>
> Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/=
master, but
> applies cleanly to the lsm tree.
>

I don't think there is good enough justification to add this in the discuss=
ion.
The reason you gave (dynamically disabling hibernation) also doesn't inspir=
e
confidence. I think figuring out some other way to achieve that is better.

If you care about knowing the state of lockdown LSM, doing
bpf_probe_read_kernel() etc. should allow reading that state from the progr=
am.
If you have a BPF LSM supplying a dynamic verdict in your environment, I do=
n't
see why you cannot use the decision procedure from the same implementation =
in
other places of the LSM. I doubt you have the scenario where BPF LSM is shi=
pped
by someone else and your program needs access to its decisions instead.

Lastly, given the difficulties we've faced from the LSM maintainers, I'm no=
t
inclined to waste more time in explaining again why this cannot go under
security/.

pw-bot: cr

> [...]
