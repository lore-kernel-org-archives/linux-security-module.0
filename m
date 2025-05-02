Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31DBA50
	for <linux-security-module@vger.kernel.org>; Fri,  2 May 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746218666; cv=none; b=OA3FUoUMYnW+liYU3Bjk5dq3yWbZyhPGLIYe8Kq0OGdSPV0EHGuk2XnlLhU4ZXWYztV0OIgsomgl5+p8oZLunT3bjM0ZLCEL2SqzHV5UE+ApZbBaB+8ZEbtadll+RqwhOTtv5Vp8OfkJ9MrJ0xbyihw1l6R48EHSctciKU1eKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746218666; c=relaxed/simple;
	bh=/zrZPeF6T1D5IrSFkMRo+Brdb8me5N1Jm4NMYJIqC4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTs1uVP8tgQ0Vb/rhowHfksq+hRICc2KwkeiPaGK04MC85tn/kJyMSWd2zzUJJtoyGftbMcUzY2rar/W9+o13iVum06OOaFsd5YYpWRFGHbxL9CeQFdWMEngOtFPrSOv5B7C+9EZK+cDnwp61S5D8IAN7FH0Qiqc6BmXyLuxsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VInTB3+o; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VInTB3+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746218656; bh=rRvMYub94aad+X2lXuXg33X0inGAuKkW1PnnoXgigO4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VInTB3+oMUVublikHP4YnYFPgnpqft43tvnYLEZlwmossF3yb7zl1nkpT4sifswwY0vOJVDyg5dujt6FrVfFj0oFbfDcQAmDRX+93JpwCV95Sh+tJ5Jgm/Ww5LnwlPddG0C2yUlv67tENNYnSFrKhCv5nfn4EY7bcKCC6Qtqqmq7bn162HqWnEtdTcqAZ88uE5Cmt0C/i5trajq8zsB+1Hk5JlTni4a1KiHhZvEqX3ZXhZS0UtXmlNQEyT30qv2cO2y2+Q0Z/5CNofkCceLlHTay63ieH3FNff9+m/GVY2Cd3R39BtW6orkcmcp6mLEECa7h0euuN77qL3yNjFWuug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746218656; bh=gQOiQmuTjOAvBSDW2lEyQnKMxu7fo12CEQV8GhI+i1H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LeCv0J+TIsZyaG5/nB+jysVOT845NEZtPd2RqBkBiajI9uva48iuc7MkZ6LK7A3FYGVeG8q1/yQEo8xr1j1hkSLM3I3pMu6ZYNej7Wx4Cm1BpcfjQIhC8fuHfd/yOEBm7KCe6zhrw290LY844oQnmhaWnkC9hLEq/0qfRtryzc+pRoot5t/Na8KEwFI+Ef0P+qqwvZZfQ/B/yZOf45W2pm7h+ZGE0fl3DhwzsNGWdGmAtyHgb4FxfSWIT1SZgfI9GMZYD7Pxfla5QeSYOuRMX0i+rmyuuRaNVSqzFhWOrZldn4MhQ4GSZy+fJq+DiiEwKXDmVKm01PNkJo8pUDq+XQ==
X-YMail-OSG: yaHzr90VM1nwzmAy4VCxS7bTlWpnLGQ8SrW3aHfuoBdBMZudN2LXcn28cp40094
 YoCch66Gx.x4GS5c.I8l9kD699AjbviqbwX13P731YVV.DitcXwU9fNyGz3S1DF4Ckxx.TMTH.i_
 1XxW6uX_kbQP66SyixTLFK7QhmmD_2JHuCXJBjSXkM8ObtiovMJiQuKRbXWrSoNRhrrnstT.w1Xm
 DN1bwBc79gNMG96qquJtUU3yurH6ejce9t9apSxjuc.KWd4c9S1guRCKhZamEMZsn6uzIZEBugEG
 JLCk.E.qjYFzNWCLLmH6PC3IAirkRZavaiGNv618onL3qRhXw6L_NVHsAoxFt.kH.KDUWGH_o4dJ
 kUFg4uNLeBsMEjzYf5ZkEwq6x0C5sjIegTFMq7VVxncIxZQdY3rXsesO1OONO81NbJ1IHxOUGk5x
 aOPTBo5wBekat0WkT2wAAi_tr41iHPx8FnAUJyIHH6AqKU1hDyvKK_N9ouZKb2_4z_ELcP74M_Np
 E7Gb29eHpI73mM4qkb0xWiAoIrs8Pipy4iZH.FNdDr0spySvVw3qVc2UwOuyBCGUKnMg2v6O6dTB
 8dxMrIr2XOtUv1BJFDOQ2_lJJMKVMlFKCnAjQbZlLtcWMu0uVlTQZUF_nFdhRCC2Plm_XNpdXUQz
 ebu53TLT.SSbt3qAaTw9GWL73Y.pJYN.P2PdxEL2OWigatNHksJo82Gf.IBeklPHXhn1DmXZniEZ
 8VWLZmbV6d6PnDjHlyQ8jIlhW1qVpNZKHSj0NjyX0B2V06W8qIPxlxeN3aakxSSEKCAy4VihYYvI
 ZbO6gKJogPG80VHdnIeYfqKOpEDaxoVzaRVT93wWAYlX8UfN47hQMgtrBDkHBERDEuC3wseDYgPs
 XCsSIZoxzMHFjXEZS_hh4IaOWgMULsbJyEB1o7gjUBvd.ZSLh.HtHbLiFSEgPIN1FaWaphltu1Fg
 gC44vbKTkw0rtDptiNP.YqgSYp3khNncOb9bjXf8PqzECiFCqmTnci5zfhRn6lUptXObP6M1SS2b
 iDskVS9zGGeatucHA9x0h51_.mG3joZjh5P4ZRoLXVAF6G3eZgKz7D2k8fptzjZnPfnOJuw1gZmE
 bIdfWAkBMCQPGyDV_jMcilw9PL_3XAyC0_rv9JAFaHpMTaAADJqd9vghLbweC68ojaTsgFm8l3Zw
 _Lik0VTvrQzepo5EXW1K7UNAYJ9Syn2BjssDbkf.siJYhNTKTAxdJrjSHRusdU95VwPnQzj06jH.
 mlAs2X.AcxOzEEiS3NTf3Q_9OaFsIc2p7SusCxe9JVnPeSUy9uGNVBLAwRniyf3.SVLWUOVFdUYG
 o_2qmetzOJHJQvYNx9hYM6wIeVjIzfAoGwkO4yy4WCjuuPJSS0YOWhPZDPcW5IYtyryIB.72ENkr
 nzz4hTBeqDUgV6dHq6SQYWNUFlrnuLBqsIaNhIFcbrcH6PHhFNCrbA.l5KvmCNGRlMVlOYfDamQh
 hKbMy_dyuDrQObEis67Q0EXt6nHr2yYOyGSYR0WT.DdqqeAzXP1tsk497n8w_eeOiu.Aako6fP7r
 P1eS48t6vThAjuH7qkOKKN6OiIe9eR5POnVg8vPuCXOLKqGDyYBxolc_NWTA2XNb2TO1YCqg8Gwi
 jY_GYEN4f_m8z5y4CX0Q1Lihz5885AlbqhA8g20CiTwSU0RIR7oDoPe5roOjvybaltkOsDbxaLg.
 n8_V2kHyvHq4oqNQBtHQOCqiYEqV2834ZBAYlL_2.zuKpckM3DKqFBOro8oy9_8FUB9U6d8pOiM5
 MnNggh6FtZlGNB767KLiC12MSaHFSlsQZSF_rLuX2g5xsUIImG31ueYe6jZKi72mCWHsvv7wLZVj
 EVSs5TXWRt7Y.bTf9wWab6GKKospM15tULJ89slPNeQTm.KSgFLNYFl8PtDXMwCXgAp0HT9TcH2b
 Rl9Hljs1iztxcuR_yY.yKatlD2JBAWta.b3HqSa09l0zszJu06svUlddN4xVtsPOi.61Z.wfvseT
 jQga5_bDxES10nb.sArOeB13__rdv3bdxJJoHNRgmhG6sjfIlOAVDTttW5YxY_HBkZpZ2Y7PRsN.
 ZwQww9gJ4hUO2jG7qvz7uyGbwtMsKF6nZO6rLdl066i4GM_TX2BPPeNy505azAMvwuHtlhT5f6RL
 y7ZRingG.hdrxSBYfuuP8HdNCtS2znqTSkSizT371fQCpw39Pt3z_bgjaBIFyJlNEnZnBk_odMDZ
 CnsA41WZC8wuqkr8JN5mWE7MrVQtCGkjoJI_ZCv9FyNleoOxW6_MbJvaE.YrVxiuYUMpvt.073gZ
 jpMAw3pVFFPZ_tbjhnfLa74ucUw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9c481c09-7ae7-4adb-86f3-b834e3bf5975
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 May 2025 20:44:16 +0000
Received: by hermes--production-gq1-74d64bb7d7-cskn8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c45e6ce16dc12bcb1f7e93a162b13a75;
          Fri, 02 May 2025 20:44:14 +0000 (UTC)
Message-ID: <f2b76c86-2b2c-49c1-8294-c75e4c758b27@schaufler-ca.com>
Date: Fri, 2 May 2025 13:44:14 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] LSM deprecation / removal policies
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/2/2025 1:01 PM, Paul Moore wrote:
> Hello all,
>
> We've worked in the past to document some of our policies and
> guidelines, the result can be seen at the link below (also listed in
> MAINTAINERS):
>
> - https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>
> However, one of the areas that has been missing from this guidance,
> are policies on deprecating and removing LSM hooks as well as LSMs
> themselves.  In an effort to fix that, I've drafted two additional
> sections (below) and I would appreciate feedback from the LSM
> community as a whole on these sections.  The LSM hook deprecation
> policy follows the undocumented process we've typically followed, and
> while we've never deprecated/removed a LSM, I believe the guidance
> documented here follows existing precedence.
>
> ## Removing LSM Hooks
>
> If a LSM hook is no longer used by any in-kernel LSMs, there is no ongoing work
> in progress involving the hook, and no expectation of future work that will use
> the hook, the LSM community may consider removal of the LSM hook.  The decision
> to ultimately remove the LSM hook should balance ongoing maintenance and
> performance concerns with the social challenges of reintroducing the hook if
> it is needed at a later date.

Should there also be a section

## Changing LSM hook interfaces

The interface for an LSM hook may need to be changed for a number of
reasons. ...

>
> ## Removing LSMs
>
> If a LSM has not been actively maintained for a period of time such that it is
> becoming a maintenance burden for other developers, or there are serious
> concerns about the LSM's ability to deliver on its stated purpose, the LSM
> community may consider deprecating and ultimately removing the LSM from the
> Linux kernel.  However, before considering deprecation, the LSM community
> should make every reasonable effort to find a suitable maintainer for the LSM
> while also surveying the major Linux distributions to better understand the
> impact a deprecation would have on the downstream distro/user experience.  If
> deprecation remains the only viable option, the following process should be
> used as a starting point for deprecating the LSM:
>
> * The LSM's Kconfig description should indicate that the LSM is being
> deprecated and the LSM should not be built into the kernel by default.
>
> * Entries in Documentation/API/obsolete should be created for any user visible
> interfaces associated with the LSM.
>
> * When the LSM is enabled at boot or runtime, it should display a message on
> the console that it is now deprecated and will be removed at some point in the
> future.  While the message should be displayed without delaying the boot at
> first, after one or two kernel releases it may be helpful to add a small,
> e.g. five second, delay after displaying the message to draw attention to the
> deprecation notice.  The delay can be increased in successive kernel releases
> until it reaches a level than any reasonable user wouldn't be able to ignore,
> e.g. 30 seconds.
>
> * Finally, after an additional two to three kernel releases, after any
> deadlines listed in the Documentation/API/obsolete entries, and once the LSM
> community is satisfied that all users running modern kernels have migrated away
> from the LSM, the LSM can be removed from the Linux kernel and any entries in
> Documentation/API/obsolete can be moved to Documentation/API/removed.
>
> It is important to note that the steps above are intended as basic guidance for
> a generic LSM; it is likely that changes, including additional actions, will be
> needed for individual LSMs based on their design, implementation, and
> downstream usage.  The LSM community should take the process above as input,
> but ultimately the process should be tailored to the LSM being deprecated and
> the associated environment.
>
> [SIDE NOTE: I'm trying to close out the outstanding TODO items for
> this document in preparation for moving into the upstream
> Documentation/ directory, there are a few small items remaining, but
> the deprecation/removal guidance is the largest.]
>
