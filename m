Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CB2FF642
	for <linux-security-module@vger.kernel.org>; Wed, 10 Dec 2025 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398540; cv=none; b=Y/+HX0r3V/0I2QrIu0D274rs+GP9PvbjvUR2zsqDe02Dqyw97Hc4OTBX9TZZT2jzjPli4yt0hIS65DYcdGU4rPnw4cf4PPEpUXT8f8+87NHHYesP6B/he3kfWvx8+aRLCwn2bhGHOkHZ9Tc9OA+Tvc/T6U6Q6Y3bzy9iiXlE3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398540; c=relaxed/simple;
	bh=NpYiT7uhshOsTvvzD3/mZYfaE/33b+Pb6cU2fRpvY+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gD831KfpV7xh9YAmzuWlJRoShcJaNi8gIZti6xtCHgMyQ0K7Qti2IpI+EzeYZdoQMoZt27SQugLaLtaSELPn+9EXoXYlSVlxgbRskmqjXDHXldZiBtkbNawtSklm2IMTpU0K99OBHEL2isnoFZ93ATm1VIyD6CxWkQTix989cXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pptDAuvw; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pptDAuvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765398531; bh=9zpRXtvakyc9qIaEQtxWLTemOQrHXHdTWzDPqVofNIM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pptDAuvwUpDXIWiR8MjmSc9lwWCKyFRB6h4bFUdndb1dIvKJX+TGWaZT+PEB9rELRgJrs6dr4xqaYnZtqn4aVli/HobGbQaYCR9GeiZJ0iwi/mUdAIB8004/VDUx3nHTKsHjBNX1+DEnEHiFzRFIrWlJaly3wbkklscdwOprE6nyzovmeAkvcon4QN8+Z2Z8mxh5YA9Sc9w9rIg+1r6yKbgURTYpfeubQhxPV01Y/zZuofp9pHyxnWJx+GGsfAUPSZElWpGU71+nTA2Sc/p0VJIHj9ehc07Q3Hac+6lIiFixPOJt+VoUmM4cGwmEu0BOWYxjDfCTYImTjLAAALkXEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765398531; bh=yhTx7Y5Lg9mVHX+1vYvjoTLHJoAN4fcSO6sQ5vp2b7e=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=C0ffnP5uZudR+YP08icnZP4RiP1yVb1q2zACoya4eLnxxL80ccd9wC46yRx+kyzzOBGKCsytvuwKF1tdpzNsJxkdqukkROUpUDbCukUXiIHtL6CcGzdp94KBEaBWMt1wHmILVrTgjmWrA0SaDWt9B+ja1hPC2p8lLJlOhDXhHT5aiRkJtO6rJkzm4le+bOM6lORfNUANOdvm9Fd5BtpYbMX3BHPoIeCeLMvb958+MXXiaTk1GL/1OuYyte5vgqVBbUkBy2eqsP1qCdOz9xVu7+qjdWjGfIn3gwifXRekEFrJ/6VwRStj/1FpJs4bMyVMl2ntOySK0aOaycC1tYDRdw==
X-YMail-OSG: MzadX5QVM1n00m0D_mjYbd_p5hqdDrAfhDusHLJvMWA3qTEQkOmudJzgZXuG132
 2AimnmNepSG5ltpeorc1m54kRFzfga3uIYGo30p7r.cvTxKuqHPAUQWn5n79zpDt.dItb3DCJ8Rp
 ppQptmpsPmpGQbTZWnMq79UOkKSBiX9J5szbcA5zg_f8uCk3xF4OWdKVAcNtbsLhmDBR5il_OPT6
 yIaaktnUaoWqcHJJPQkFd8JBQAzo7fYxy5dPRaI9Ekiy8JPFkvR8cMdxjfhEVrOcoIIwN52.QeP_
 X6_GKOK2UGjxfJxxrFllGuu2g7tsgG8osWyzsavuzgp3kW66eQDJv3YA0kAtjzJWLDGrLdsEto8A
 6JXz3VtVf8pSeswXPbrw_vPRICC5ZTz2cbqAJ4kj_NL97XePAjTQjXAccxMxacAA0SGvNnN1RMiU
 CLK_K_p32RI8QlIFqtYPCXONseZTCsxxFkRW74Ah59IBrCGDRnvcrksdk4sc7pr25kUrbdqSavrX
 wR0ndYyuimkvlLIQY_lpAyZfF.WD5EKHI1RpEJxWgz5qXM9xqacnZFAwjp3mN7tSEwWOb8PH3guw
 _vEJ2p.Pt5Iq8gsRdcyVVMLF7_Kzqlws3_E4R.qutq401ebO.nyHKwzPp_wtX_ho7II2KVFXJyPb
 BiWscAdATi9mjbMxa3x9faFsZz.A2YLKmB3._ZnFSZuz91I0JLCFfuVMEIgm0KFjGoN9n2TPmgP7
 B06FF88J2iq6lf4RSbi82bg6eaEEIe9sFxkUiX9HtWJ0_FVcVlXPKr8FeLwq2Vz1x9UcbNOPn49Y
 zYrJiaRxsqLWvl_J600NvG9FBoYFK4O_Db743gl7yC9pRbvB26nKKRVKTl8cqnEBYhgM8bHu_tXn
 Vmy.iPlr9QsmZ9IQBgC6M15DRJi9hyJWlo1hlFpxKG.rkI3WcfXOX5MECnqNmb2ChvMkkiERbguJ
 DWKX9hS1hulAxRyoljiFgGWnACglhYciHXkB7.QPpRsQ6KTs9ZgesNLMwprGP8nEe9F8lyafkg6l
 mNK6u6Iw6l4w6CUfJ4tP8geZzLSTjjr7OD_fi8ZQaE4H8vjnxi1VjdsatW1G57oFpIEZMb1JqxHp
 19WaxD10Dhvakc22xgUNw43rdla3jXE4J0ZWiM.U9Hr6DB0nI89diH0MVSEXml8d5wXx3WgS9sjg
 jISBQj35qGmBKnbpzch0LJf52UvOniuSu5mxK6Yo_i9B8RVBA683aUDR6sr5xpr2YfkDtvq113m4
 lVs06cOcuu0eFPbAZ6nmZLpSUAvaHTMUeKYpIcqBxQ41zNMf2bpQ6cXvN.1sS0CbExj3UHB.eRyB
 LDCzdfIRUEVRS8P1ov6LL3n3dmkd3HkTAp14UErnTeJfTeqIdCKcaGoDY0qc3ElCpSEiVjn4yJtn
 oxEMVWhgjptOUKDg2dKv35FlIqUm.OOKd6itYop6qsAg3LSH_H8e67uw6XkWjcRbrtMMo2klhbK7
 .2wiMA0afWYh13CAoVrTgkRcA60qh3nwTD733Hi_9f6pJdFpuS9xw5RJHPRsW7NuoqqM2KR7F96l
 BUiZhMpP.eoElNzzsCiNB6WwjTg7QLHzn2jS4PguJ_JfqogYoIXpKgMjGlwym4nkj497a2HfZuSy
 DGD2otzXlY7flLUxmpWm0dpM91eQN64_RAe64pz6dnNe3GcUGCWDOVanCGVsdHYR.QhqfzjHCNbp
 .tcdPU5naYp_H1ASrLl0CUk8M.itkab8_LhW3cLn_JMSSrlsQNVvr_CvkJRaOaeHHvvm.dO_6Z8e
 UJAYTgZBC_eMxwFW6ws.RyYO_W8Elud9Wn8HorXy3WVvQxHoLidZM0OKdCN27hGUBfx4sLGnRjmy
 .Gt7FS2zl9U_UJzqSdls3FNdePJRa3OZvD69QeKO5osWqPEOZ7TpnhZ5Y3yCow0Incw8HYpDgWQD
 gZuhTLaz_CQ9GtXJhFTHFy_Yg2bC8c..e.KTkgX1236ritglD3ITeVa1xIaMU_OqRQBg5xa6a0bW
 OPXgr6PmJjKb5JDCITFDSfj3zDPOsrGQ3PbEUMkrzzfwjHhxhvZG5MpPnxaFunFTCj3pnG4MlSMl
 2z0WQRuOlA4CNbH7ts8Ch6B7KjP15FIQa1mXYQ0agDOvj5oPuG7IG7CkR04HS.TpJRFda5GR2dOQ
 .OO2eAR4V0vtxh8v5BCksnj2Z8hxzEZ_J6caVUK_V7GUqJVs0gYqoOIZMaoDKtuFwplviZfP4aMQ
 0k_UmN1UVBJ0P.kcByZa2EJJCdUYzm68UeO3_dtOWFho6T.z92AJ1C3g4.3EdBVc3eb2F2aZoGp8
 7iiZ6xQv4sHuUlb4rso7XbQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1567280a-a099-411c-999f-5a36af2895f2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Dec 2025 20:28:51 +0000
Received: by hermes--production-gq1-54bf57fc64-fqp47 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 76ead541dfd9cd727a923684f98bc932;
          Wed, 10 Dec 2025 20:08:29 +0000 (UTC)
Message-ID: <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com>
Date: Wed, 10 Dec 2025 12:08:28 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: An opinion about Linux security
To: Timur Chernykh <tim.cherry.co@gmail.com>, torvalds@linux-foundation.org
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/9/2025 4:15 PM, Timur Chernykh wrote:
> Hello Linus,
>
> I’m writing to ask for your opinion. What do you think about Linux’s
> current readiness for security-focused commercial products? I’m
> particularly interested in several areas.
>
> First, in today’s 3rd-party (out-of-tree) EDR development — EDR being
> the most common commercial class of security products — eBPF has
> effectively become the main option. Yet eBPF is extremely restrictive.

eBPF has been accepted because of these restrictions. Without them
an eBPF program could very easily reek havoc on the system's behavior.

> It is not possible to write fully expressive real-time analysis code:
> the verifier is overly strict, 

This is of necessity. It is the only protection against malicious and
badly written eBPF programs.

> non-deterministic loops are not
> allowed,

Without this restriction denial of service attacks become trivial.

>  and older kernels lack BTF support. 

Yes. That's true for many kernel features.

> These issues create real
> limitations.
>
> Second, the removal of the out-of-tree LSM API in the 4.x kernel
> series caused significant problems for many AV/EDR vendors. I was
> unable to find an explanation in the mailing lists that convincingly
> justified that decision.

To the best of my understanding, and I have been working with LSMs
and the infrastructure for quite some time, there has never been an
out-of-tree LSM API. We have been very clear that the LSM interfaces
are fluid. We have also been very clear that supporting out-of-tree
security modules is not a requirement. There are members of the
community who would prefer that they be completely prohibited.


> The next closest mechanism, fanotify, was a genuine improvement.
> However, it does not allow an AV/EDR vendor to protect the integrity
> of its own product. Is Linux truly expecting modern AV/EDR solutions
> to rely on fanotify alone?

You will need to provide more detail about why you believe that the
integrity of an AV/EDR product cannot be protected.

> My main question is: what are the future plans?

Security remains a dynamic technology. There are quite a few plans,
from a variety of sources, with no shortage of security goals. Trying
to keep up with the concern/crisis of the day is more than sufficient
to consume the resources committed to Linux security.

>  Linux provides very
> few APIs for security and dynamic analysis.

What APIs do you want? It's possible that some exist that you haven't
discovered.

>  eBPF is still immature,

And it will be for some time. That is, until it is mature.

> fanotify is insufficient,

Without specifics it is quite difficult to do anything about that.
And, as we like to say, patches are welcome.

>  and driver workarounds that bypass kernel
> restrictions are risky — they introduce both stability and security
> problems.

Yes. Don't do that.

>  At the same time, properly implemented in-tree LSMs are not
> inherently dangerous and remain the safer, supported path for
> extending security functionality. Without safe, supported interfaces,
> however, commercial products struggle to be competitive. At the
> moment, macOS with its Endpoint Security Framework is significantly
> ahead.

Please propose the interfaces you want. An API definition would be
good, and patches even better.

> Yes, the kernel includes multiple in-tree LSM modules, but in practice
> SELinux does not simplify operations — it often complicates them,
> despite its long-standing presence. Many of the other LSMs are rarely
> used in production. As an EDR developer, I seldom encounter them, and
> when I do, they usually provide little practical value. Across
> numerous real-world server intrusions, none of these LSM modules have
> meaningfully prevented attacks, despite many years of kernel
> development.

There are numerous cases where LSMs have mitigated attacks. One case:

https://mihail-milev.medium.com/mitigating-malware-risks-with-selinux-e37cf1db7c56

Your assertion that LSMs don't provide "real" value is not substantiated
in the literature.

> Perhaps it is time for Linux to focus on more than a theoretical model
> of security.

Each of the existing LSMs addresses one or more real world issues. I would
hardly call any of the Linux security mechanisms, from mode bits and setuid
through SELinux, landlock and EVM, "theoretical".

> P.S.
> Everything above reflects only my personal opinion. I would greatly
> appreciate your response and any criticism you may have.

We are always ready to improve the security infrastructure of Linux.
If it does not meet your needs, help us improve it. The best way to
accomplish this is to provide the changes required.

> Best regards,
> Timur Chernykh
>
