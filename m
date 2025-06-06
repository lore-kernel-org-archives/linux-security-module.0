Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71211F4C94
	for <linux-security-module@vger.kernel.org>; Fri,  6 Jun 2025 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749242544; cv=none; b=jKv06cw9Ttjjw8mqCR86bl396ISC41qK2Dc/N5RU52N6kQe+/pGy9+ZaPWP+y2hHc/CJcKuZr6cRD28x3q7VJR4qQ062xQVJ+HC63TGJG7R+2T/sJlqjX7AmC/954bCMjgArQmJT9BVYXq+52j9e+bm2D+lzAt/UimQansfnCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749242544; c=relaxed/simple;
	bh=FAn2BrAFFDWanh6ZIqsWC9r0B5q7vxp0IMIl/zDLKEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0ugmyd6TmnlXKIPa86Wha4VR4yEGzK6nBCVzAspewvG+08UQYCN7CCorMZ08eIPSyTrdGAfXz36pK+gZ60RK7P5jlRwSPOVkKqyRNfkkqQ2OFF0uGU9s0bj0VoTZCH1EgO8SDuLMqAm+WSKzB/ON4KUSQ/6cahuQapLOvrSZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dkP3EuEy; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dkP3EuEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749242541; bh=wSidtG73uAlD1RqtC4IqvQFWkCdn9P9Zuuxi5KO3FKE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dkP3EuEyejSUZEk4lxTdUO31h4QtAYVul9EDdlhi/qp5+xf5yGPWj7AtkNIPWT0+FJrjmX3QsFp0cFZFP+wv9Nu7jfHFQ3G+kIR2HdKSkAmlrCuBwH16qNiWOdGJ4a/WcS7X5L4gdK1Dr7NsBaDogFbOA9GizRVRU2K9meltkvCi5cNYwl9yrvNmWehbyxbHyFDN2xKBFEfEZ8OD1Sj1JdRWm6u3PJQS6SVp2BNWpuNNkFv+3EuQbdAe/xeFBk55wcPPpNUf/PpnB3j1E2l17Jk8QfqHFivXhSULeloCMsjels91X5+rCapu9n082z+LgLwGi2r3zelSXTqaWQTAFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749242541; bh=swA2TNZpLfQvbUlSDtUejs+xGJcL+c3oUGoQukbP0+E=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hVJ9RtK4KsYvH2isFaRfaF2z6hBBINM24VfnZrrTI15BDnyhoSBXeXkxe3bTQtONogQ+lvg1INdG/RtzbDQR5zywYOiNg3zVAa8E5NsnDcGtFnqg19TohXiAgLJg2pkEs06LQ85HM4Cmj3fuKwsEs8E8pIRoWH5AOkvZC9awTlHR5ucnlc15hTpT7/9YKRjapiYq25z9+rvDh9r9u5dKqAoz3gcV1AjxSnRrw/E+lYin/zn3fxImTq5HvaLHn7j8mcWv5YfbZsjh4axUwx32HfsJfsy1tZE866P40mA74wHUqLhH3qO+FBkZ4JbH6y4tgehXVtx7EpyM8FgumU0fjA==
X-YMail-OSG: douPyNYVM1ngnasO3kGDGu8V4Ao1kh3B2CplPktc9RCCxp3gHGNUJfraUen7Bnt
 0O7nKqO6Q9a6h.EnH34cy_WdxdypgiCkFwExQTReuwOpoSx7I5ZQ9b83mTLpjshMn9SOQy6cZLml
 tST9n.R3SaLd29_pFwBdSBy9Gl1WWhHodleNVyoOYmMwuG7O_f5rS_y0QXiFVD5wl33WvpJcqWxW
 jg74c2iiG_OvFu3jitYlYz0_Ixm5_8Sa1iNTkL20ZfxreDbbF3Jaw1ZsUqekAgobu_V8YQtaBkX6
 Q7kzY7j93qunS0OeIjazahmtZjxvkDYgrpMUvUqpT3yoEZPeclcHoKy0.a0VFfPQkwS187OHZHXZ
 wLYEJfojwjLmxdLl.DvfST5TuUlgmAnMhc3BIRfVBK2KIgEGxnl_uApZXmupiLKZmdRMnJXtqwv_
 AOWIcUnGzEG.5rELnjp60LqgtKjlPTSfNNyMsf2FvzFRlVtCvCw2B.cE8_t95NlDJO0UzlQJYB.F
 lyzlo2tSOu_TJedTEryakLKBgnd7AstbNhyMwaUDt9euKfOW95JYSvLjZnZ4wR0EBX5Fz33S5x0A
 hzPNJvg9Fkp976zI3i8dY2i5M4LNSZIX4H09i2hkl9JpndJ8XHZ.bvdwKP1Mfd4knGwxgFtcsLg7
 q1vuOcmPb6GVVv6VtYnZf4tS9gCxGEQqJpc7bejZ0ytrBz_9FFBW6oym00y5_gwbPJz2e.xzN0sH
 7KQJD1zHyFkUJtDN8mkWRcQbMrf80fpkoIBhVM_dEF2zlSR1OiPGsaglvxI9YLvvwrOPHv66rjE1
 sYYuOsY2K59ooiESsR6H.fP6zMjyHwAJ2UwdfOzPGszBxoBQMOTOgv6S9ThUH32XnC9h8scHwh4z
 w6Cpsc5l6uVukGLmAzSVP5t6fTVL1vUE3EpsUzNk3uMJUz6Qdy3Swinh98T_nYfqj1zOmPCVk9ss
 bY6SI40aXH8AcEd4916qhoGchBFY9pgf2A3Ei4jnJL640N9Tuosi4AkFofnom1TFZ8tm8pNQXBYS
 YGsstXblj8ZX8a8ctDNFBS.sxFZn1a4IIK.wJ6gfi7mUtHwle_QQqFBxwRpxf0DA3BnhY6cZTxpJ
 MBS_HumhlkkUdINLAfZaSsiBFnRr0aQQgGLN.wldGZdBBp0ZXG8W1BZHi1j2ArmXZOst_gEoONLA
 9V_RFHIMCByFINm_twS13mTveVX2wk.giO6y8zRrYYQVogGR8y.Q0.Bxwowtx6MCujnUaC5lvnqn
 IFxLbgepfEFI.R2wnBevsU.omDseYz2MAuq3KndEjEgfl_VpZTAaj68I_g4aocz.qOiigcPijGZF
 k6XpuhJMV7l6mTJt45VusIPjnL4N4FkvCICZbGH99.U8Yva6FK040nC_hjck7jb88B1qSPi.dGxy
 Jyn103cLZlxQal36AiV3Y7yyNIMBOMvNRzuXATUKp1tR8obvjx51NIoHmeZxuRkLTa3xUWKmXBdi
 D5fs4q7io_jkIMCy6Yyonm0zy4qygDXmpyI3mN8K9NBA1sZj71y7Y7IFTcp7LauVxLOP6oqRqoE.
 QwTJoWRbdN8AAP2ly.HBvDWxU40diqTp9Fg3kzlLDYoRA2i40lVqzDfIfzcJpOsr7m_6oESw4oyK
 5hYGIf8ahXTj90wboQWw4w_JEVCTchqdS7lBvTgnD3pabNggP3gwutTF0x6yD5gIoFIR5eL45Qtc
 GRIfDaEizkjv_DNGt31XyN0pAmVXCtoxUbTs.HXSZXdrfDxWYQmTO8jDgaMgwxRE.waZc1m.hWDj
 wKYek_D35HPHbGaRiYW7HGOEsbQDCogoKTkkI_Iy30_JCnqq279b_nUY_6xAKk_PLXd9CnOoF2vP
 d34AV6raWCyJP14Gp99SCgdhKuz9_fJOUnujYXY2n4cXZvxBDotxYRL3uTexrfTis7aVg7gJjlWt
 GYESgH5m4fkzHRoq6iAy5d0NibxPowVM9RnwwGfz.y3m7eA8ee80yVEulrMV21PoOWOjOCiL6vGi
 7fPJchp7ysLMK_3zZUYIj1TOMajfsaRwBn2eZB8jRwC2HnVDDwlwg63rB1yHBcxqD72nGKHaAx4K
 k1Q1Jmj0HROKXgmecWELP6vp9Lvw3B96MYmwtYHR6fzRtTR8JoDJ0zk7dZlz.gfQPe8Y5TstSdc4
 4hMTQ6IONNSIP.zWFvm2OINjlxbnRCFsVSv.KyH7X39Au3s4d6EDjj1WRoud2EBINYjihhvVVZQ_
 cGJgCaLbbTcEhRyh4eD8IqLdBAlsNYAEnAGOqS.Rkv_C_4JO_KLuk7MQl6e2RQuedTOE1rukBoIv
 PU_uxI4Y4xKGM
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b39326eb-6442-4094-a3bf-33dd9d2ca342
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Jun 2025 20:42:21 +0000
Received: by hermes--production-gq1-74d64bb7d7-4ndhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 675906b04282d0cf52b564362a5e5aa4;
          Fri, 06 Jun 2025 20:42:18 +0000 (UTC)
Message-ID: <e6058692-de6f-4206-89cb-af6bb70dd800@schaufler-ca.com>
Date: Fri, 6 Jun 2025 13:42:16 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: adding CAP_RESERVED_# bits
To: Luigi Semenzato <semenzato@google.com>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
 <b1bf0aaf-0290-41a3-8bbc-a61c6c8b2e74@schaufler-ca.com>
 <CAA25o9T3AQJ-zNcb3VuhCwbKQGSFtSBbeN_BRYv0L8M-pQKugA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAA25o9T3AQJ-zNcb3VuhCwbKQGSFtSBbeN_BRYv0L8M-pQKugA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23956 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/6/2025 1:11 PM, Luigi Semenzato wrote:
> On Fri, Jun 6, 2025 at 11:32 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/6/2025 10:57 AM, Luigi Semenzato wrote:
>>> Recently I inquired about the decision process for adding a CAP_DRM
>>> bit to capability.h (to become DRM master).  It occurred to me that
>>> the process for adding ANY bit would be fraught with controversies (to
>>> say the least).
>>>
>>> So I looked into maintaining a patch in our own kernel sources, but
>>> that was surprisingly messy due to the build-time dependencies of
>>> capability.h and the way we maintain and share sources internally for
>>> multiple kernel versions.  This would have been quite simple if there
>>> were a few reserved bits, such as CAP_RESERVED_0, ..,
>>> CAP_RESERVED_<N-1> with, say, N=3.
>>>
>>> Would this also be controversial?
>> Imagine that there was a CAP_RESERVED_0, and that Fedora used it
>> for DRM master control, Ubuntu used it for unsigned module loading,
>> an android used it to control making the battery explode. How could
>> you write applications so that their use of CAP_RESERVED_0 could be
>> considered safe?
> Sorry, I neglected to mention that I am thinking of embedded systems
> where the vendor provides both the OS and the executables, with no
> provision for installing additional executables.  ChromeOS is like that.

I have worked on embedded systems, and don't believe that the problem is
any less serious for them. One aspect of embedded system development is
that kernel versions don't change for years, and then take huge version
updates. That will often require updates to applications and libraries,
which have also evolved over time. We saw this with the introduction of
systemd, where the model for launching privileged services changed radically.
Any assumptions about the use of "reserved" capabilities would be dangerous
when the eventual upgrade occurs. Especially if the vendor of the embedded
system has a different set of developers than they did for the previous
release.

>
> I agree that major general-purpose distributions would not benefit
> from this.  So the question is whether it is worth sacrificing those
> bits for easier security setups on embedded systems (and being
> able to do it at all when eventually all bits are assigned).
>
>>> Thanks!
>>>
