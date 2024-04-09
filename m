Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE5158879
	for <linux-security-module@vger.kernel.org>; Tue,  9 Apr 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705690; cv=none; b=I5w1PyOr4SP+1fMDYdHJveBdXTZyqh0sgWNKg6lVvShgmZMNOD8JSz0Zr7AVKmN/MeUzZRRHUqI0RnfEwgCXOoIxogIUTmFosQIkFZAsVSbuPnAwCBL7LYDOBZDCUOVaW+qKhlWC+NYfzwuvgvk1hWa5tP70KHH5VvOICqdw6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705690; c=relaxed/simple;
	bh=Z3Apmj5x+nFQ46PDTILFXFE/2EuIsfP/RdSYI0sqdLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnWNMPwXFjk75jlwW1n0xyRc3UGSQCJQk0hkMcwnQCdmmYzgkBf3xyQwSS8mymibvbZ3moMIpTihVBnCvEvIQX6qaRI8v8SE01fRivkfeuhmwMvn37sR1i+sp8Qtr4BSiIn7RP1fL1TmSvn0BwOnNARv2QSdl4VgHX3t1idHGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sPWCRfQS; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sPWCRfQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712705681; bh=H4C/CyCpGyK0dHeXTHoS7Ur6mQx2nFBMHHs92nCpp5k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sPWCRfQS6W7Q5GPtzQkpU04iwKxVAwNACT5JlBgv53yaWDaVkXTorTjgLRV4JBEKYAfUVo1hmxXVngsLWFgFALctqx2DnXbOLCEC9fqUod/pKbymUQyHxAB+19V7TN/3aaVI6zFONEj5Q/bTX9oNSyhFcL1MoPWTE0DYB/yno26OvHDnzgHoftFCUvbqsJb48Bdectz8WiRrhZRioBkaWRB/MzFZRq+Ib1UTqEOyH4pCA1quX9HFMOKwDOfOADo3fKvjOfKTLk2mu5Bntz74vHlQDtoI1XjzVWZjMogLU/zznAlGDESRl9f2MPPk3+w+aPS0fAVTsAMjJWfC+ZLVBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712705681; bh=2F+qh+Uey62mW795foXJlUkAcvIaWAN/G3Iu5hiLeEW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lfUO/cFrs9kVUCtdm4JiuwvkcGYBvMV69j3ppQeUxsaY0/V81JN/QyukWb3U6ZBuXuL916NcMlAhbnje9NesZYXS60WBz6F98Lgr3aIg2VSsabxbqCdGu+BCBqxJFFmB4lhTPI5DeCBnz/p14fT9UZS9S7mfXE80AS2iRPTnIygpEfwEFnpzeTGUfClZVF8fz9tUvBcsiA8ZH2VE0xR14NdNIoDmm6i9WvC/HoBWHCzq/WCynFSNMwQcWhvKRk8HM1c0JvsaYkxWZc9yEacGY1jeCI3vskLewTUlKCfqMdXC3hFFSpa8VBZaq/fOOeZ0qtTMz3ic8ObWmdbPDG4o2w==
X-YMail-OSG: bTGHL8kVM1kmu.b79EDjZShFF31nQRFrnrsPnTxe4dmRCJxpiY4tbozvpigGwvo
 cAGtkR2EGKr2of6Ige7P1bCaPhDSSBD8YF0sV6XtOVifBscp2wvySWI2rhKBWCW0gPuQtm566ME3
 n5eHCQFmUukDIFoPNWEtPGJ47oLBFiCt.k_wKKPoHpiO38AOgqCPKBxBup62WT6JghV626CoAeoJ
 AdRT1Pe2Y_XDlBvLllIw.4c56rGvOTiibOsCFUnKhvnz_4zyWFcL9Zgdy712USe3v_RXOFPutCYI
 aOy533ADURuLcOgpEaDyt1oFzkHmoj5Mr8eLRlshys69B39KEd5jI85SFy1OyZCXrl8z6wAYCtOZ
 V2gqTQ8KKUj6brRP4Ryy9Rri.XoJ2HUoYaJjP_B7hw6VBXXgQ.srcq5QYJcJmL8hzE2cxDw3Jtbb
 Hdng1s7aPKc5ul5b6hbbImXyoTeb0R0yBppwhLmVN0vsVA39LtyfgKgK8ouxAuITX2JTI_dd.E0r
 U5YHfVY.KphMEvrdodDl6Rzh9vlPWyCB2nGJ6dKGNoMxVJWFBkvzm4YeDsq5NO3GUwsdt3LE0krm
 INqpuOkO5sbfoe2S8azcvfy6PVFEcFePM2d1YqRgLL1S52L4_0mJ7p8Ttz_tN3WvxK8zRfbE7qQ7
 wc.rCmgokXNB.P4uYJK3aHl4JPX4BYuThr4b5uv.OLU6sP64RIvONg_GY083Ds8xWZdwQKTAzy0H
 pPzYPpzyDv67HDYu3dP5YZ.8g1t9euyeIybCVhB4Qv5kUCj0JDm3Dj0MzM2kVe05eAusg4iS4BWK
 ImG5SV7SL4_mtlHpw74DHh2CGc_NgB6DzjQ3gwlQvZgg36z3Z14W9nMGvdrxI6JLnr4kod5h0WW1
 Qb6eBATTQuQ0L3Qkl7X6vQP756lOwE27W_2wKItYS7vZQBWBVYj7cGXdVQDWykI6eEpLjQk47W.c
 SY5c0rlPvD_hZAqyQ3yInyugu3dYqoVyVi.8DC3OqAsbofDYZyXCiofh6P5Df0uaAkfMneTgHqUD
 AlgQ7A7CO02CBcLWicDvmAW9k_9Hn6GamLjGBGcxcR_zj0Ox1Gdeiw2WLbV2glMoeRdFw5QImjLB
 Y8gqP.hAYWRDIRN0iSW9tB8nCpVJv8yYkND8kZqiy2yuFW3j7YEUCVabTztA3yTv.uDdNrPP.KEM
 EbTP9.cgGq5g.Oy6bqijgNhpfF1GOxePROnwELY1p9ES3ukTgJhDz66xObX8qz_8gl832nkEZjKV
 u39ghZEt4dvUIL1DUNWwJhjAS4Euprpe3wChSAK.SoicEv0yYt1CxtMoNyOOExaIGswNcAYMKjSv
 eeMOzxdGmCSeLXh4iFhGdEBMso1_qf2Og2gbfrOY2pEQUBjOKv0uaSk15QtMPE8.xZV8zZSsgqFG
 19ga.5wdn8AKwNhYHQxAIS2gohLDh_bpLvlEDiZLw9avhkHBkcTIRGEq5hqLnNS4WBcHZIcFmtLq
 jnvtguzE93zPhjH_QhCuc0hlFGrOLakHj3lL3MAxZncLZO6X80_aZvr9sMsgX2AFTu1iTy2zr2He
 bS9UbuSH3Exf97ZZDAZoGPVvf5Hxx4rIm4iSusvdDsexIIVWbJaUsAX.y8izRZQkbf2T.nlSvFOb
 iBn82iRRaIqNPyycHFV1N2kfO0IxPfp5t7YrFkGzrPjWYGyTJf5iDzjQBKsTBV6J9taw.E9luski
 jxBC.JrS7oh9Ghw1BzJpzzVTg5fVZ79z3O17sCE455psqLhKrBHz0esIZf4d1KsUqrwFYSFbmJWE
 zuFQhSIvTRXpRnYFZNMWYrw2lfuiY0aeMcIr5UflvWY6Y_7qqtILPuzBcxzbE4qPrlJXUsR0sET1
 2MNVPr0Z5FC8k.UmTXkw4VXuPsVsS2uFDMFtT4r4kmsMhW0BGgU7M9.FwF24oTznwv9broNn309v
 TAV3E70R.18CURt94wWFYDB7vrEizOXnPxf8T.e.5fzf_AQ5pDG8C9igXpmrvBdNfk5OKUda8Rnl
 NEAMMQUUifiDWKtCYIlqFWxpjPynOmt7PZ69aZSur96LK4w1hg8nJMYoAVPhSdLSrjCJGneU3YSb
 P2cNNElhesNncIwU3FogXrAv4u81Ehpk2U6IWnRxWqyzzn5xR.d53vaS62VQqdOi8H6Y85sd8Scd
 NAMpftLs9X444zL4wExalCjuDtT1_iw7b5M6GQRsNLu.CNVw22vtrY6icPHGEjcf6TYbaFSSeMso
 FL1kMVt5WkwVOkzr0GKTMhdFl8pWjHWNUTpTn9cOG64.4BYj09t3CVPWDHEBbqNeLNORs22Hn
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 651828a9-550a-4235-b499-62b9572e3e3d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2024 23:34:41 +0000
Received: by hermes--production-gq1-5c57879fdf-nxlqc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9846cbc1f7581b0baab90511d642ff9c;
          Tue, 09 Apr 2024 23:34:38 +0000 (UTC)
Message-ID: <37ee8a6c-ecd1-4669-8e60-df6adeb0eab7@schaufler-ca.com>
Date: Tue, 9 Apr 2024 16:34:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hardcoded security module suggestion - stop the stacking insanity
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 KP Singh <kpsingh@kernel.org>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2024 10:22 AM, Linus Torvalds wrote:
> People, I know there's been LSM work on the whole "multiple layers of
> security modules" for over a decade, and it's been a design decision
> and a target, but I've complained before about the cost of the
> abstraction, and we just had *another* hardware security issue with
> speculated indirect branches go public.
>
> So I say "suggestion" in the subject line, but  really think it needs
> to be more than that: this whole "nested LSM" stuff as a design goal
> just needs to be all rolled back, and the new design target is "one
> LSM, enabled statically at build time, without the need for indirect
> calls".

I'm perfectly good with changing LSMs from using indirect calls to
using some other technology. I'm fine with doing it an compile time,
if that's what's required. I'm OK (can't speak for anyone else) if
we have to break the ability to specify which LSMs are active on the
boot line.

> Because we're now in the situation where the security hooks are
> actually a source of not just horrible performance issues, but also
> actual insecurity. The first indirect branch in the kernel is now
> often the security layer, and the latest

I get it. Indirect branches are bad. Should never have been allowed
in the first place. When I did the implementation it seemed like a
good idea at the time. Looks like I was wrong.

> One current PoC literally uses security_task_prctl() as the attack vector.
>
> Yes, I realize that the "security" in the LSM name is a bad joke, and
> that to a first level approximation the LSM people don't actually care
> about real security, and that the goal is just "policy".

I can sure see where that conclusion comes from. One of my goals with
LSM stacking is to encourage smaller, more directed security facilities.
I am not the believer in fine grained access control that many others
are.

> But dammit, I think we need to put our foot down on this. The
> complexity simply isn't worth it, and the flexibility is of
> questionable actual worth.

Without the flexibility we're stuck with SELinux and its policy based
"security" model forever.

> So here's a challenge to the LSM people: work on walking back all the
> silly nested security layers.
>
> And yes, I'm aware of the random hacks for turning the indirect branch
> into a series of static direct branches by
>
>    https://lore.kernel.org/bpf/20240207124918.3498756-1-kpsingh@kernel.org/#t
>
> but honestly, this series needs to be turned to 11.
>
> Or rather, it needs to be turned *down* from the current maximum of 11
> nested calls to be something sane. This whole "security layer allows
> any policy at all" has been a fundamental design mistake. It
> absolutely needs to stop, and this "you can nest arbitrarily" needs to
> be walked back.
>
> The whole "add cost and insecurity in order to give people random
> policies" must go. When the LSM *becomes* the attack vector, we need
> to just fix things.

Got it. Abandon indirect calls. Reduce complexity.

The question is what would be acceptable? I've been proposing LSM
infrastructure changes for a painfully long time. I'd be
de-f***ing-lighted to hear what would be better than what we have now.
While I can't change the brain dead behavior of 21st century hardware
I am perfectly willing to re-write the entire $%^&*( LSM layer if it
can be done in a way that makes you happy.

>
>                   Linus
>
