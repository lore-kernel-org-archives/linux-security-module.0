Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B973322B8F
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821305; cv=none; b=lp0Hzxd6g/lRJOQsbSziemXgrsLi3z172ToniFJUgXv4FKKNzRwQsnb2g8KEROmmal4gGeT1hFo7kpWDM6O4AHnN2cOhcvBt0qoVwWZoadZDJ4RZgOGyOn8OUZmDZJp9gZukX+FBdYm1OYkcIRCbV5q9eZ0YKHEQLvjojOZtjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821305; c=relaxed/simple;
	bh=rwwp1VUZT+vawFd4KpFBqiBkY5J2v5L9dvzSpW2W4no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1DeQnL/m6BauoW4p05Ouq92m6Zw7m974/qJAIb9uFO+VaPeJ7UX611BDnlcibj/dwREOHbB3SvtgD4m9FnXLNEz1ijpNVAGJPtavVQ8AFwIx1FUlYuloeZFFZds5hq7Eq6MNaXjrnuu0iJ+QJHE5nOPV82O+YdQwlZqTrwSkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cB7fvNlV; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cB7fvNlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765821300; bh=/ymUV8GA5Ky8RGJPy2v5lkVFzajWccp9EcJbhcHuJUI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cB7fvNlVTPoFnB6y0dLym1EwKuXUQ23MobeNZdgJZ1hNAt1dzipdtLXrZ/XTZFoIxXwG4lS41CR64qwQxNtTQGm69gPwmQ4GgE7Z93GgIq4DRFHl2ZjZzEu1VWevdgjh4M61sd68jaig/5V4looIgNejuFY8UI42pfi/5jvEONe5XeSLcTplemcpoDOlkbsuzCHTzRDCu3J0C1VnmJ5/zDWc1iEVXiZ6YL4Ky2i4eaUyyK3CFx7d1+8XyD+iC7jhyaaWN2WCmVIuLy8+4H5b5JFhFhREkZ9Huj3EDq9SLuOp1sn7o6WLUqhEO+/dIS6v9Fgg9uq2Av95E4nsyNgiBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765821300; bh=+OLok3AKyOE4/mBJZZWu2six48p3OHGCbmtJVkD0s4+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AxBhBufKNaysBsZQZGF0ct0YsErr0GyiTBXSumwzvzesD4icQ+RlMZHnnMsk7Z+N1ENvDVmj2cZvE/y5gRI/Ni/NKwz3jUrDH5YjFgEFK3DFj/gzarJS5huJDX8IbHhy7VAFOWs/Ik2lpKbHObntNMYIkZenhygVYCdjebFZk2kR/zmIbQavbMb0jMUA9KWE2e8DM/GfR29hIJQW+x1EG22xuMNaShHDVySS+WkNV6qopJOyfplDxv1Jxpj3bl12n/t03bUOnqmxqsfbzOHof9MPUnIXEBvRCyG9noMxUkEaxatuO7lXC0oGTHrij+Y9s6R/3t1C2ekKzSPJPDDEGg==
X-YMail-OSG: SWLTVVwVM1kkvRSmBYzp85OpjbbheAYA.kkl9G2nu7fnSDNGdNq6ZHDHOMt4gES
 qXE9lF0qv3PYCLid9FkZpNEzpS3ahsCo0lzlS91QP7vkF4CNWWQ1Is12fyZ6Le_XcKWHjWe3rALO
 CM6GJSIhlfLRyQ6Tl5gMV3sbxJzTHz_3wWX1NdEkqQUcfTONzYl6t3JKYUy6ErmKYZ.ZxAHv9VOH
 Dm0OKq5B1OpLKOl0aRwptsSP0GAzSgJy.0X6nvBy3FKVWl7VBkCX0gsIKhhxeRnwzSfXwBwPJUg3
 oxbN2jQeUebffbVPT39ybG2Ie2pgX57wLlSoU3I7OxbnElYf9esCvOHqAOwK3ZLYF.YcYC.khqrA
 oTs31dpx0UvHWQZmGvYjD7sKhbNta1oPCGe0cLF0_XDAiZaU1Lu44EVyHYPyE1j8GSdC77VhLlSy
 qQSDYnzW_AZdLa2VrEotasx1glb4WsjU8_WsLw6IvKzWHw2QCPJdAt.SZVWK1d1bF7A7b0m9eUtG
 N2WwwHiuyJzJBZhPdY83LfIusVS7AeovEz2w1gNVVb6ybKLjFsH_hWqJ34Tcy86UWa.10_LbvB5N
 BLFEmDC1NmkJaxVEWZnYWSZEfkRxlm_eSB0VC7JO8uQRVFRNFISIMLgVxZ_jc4uMGNqMp7UFmYWE
 rRHS5D48CZORl6c2j7aM4Mm18.BW4JNCpyqVbBAi1EU8lf2ttBKjIPhYb026JowJMRrHPB4OtEPc
 QMFiQ9fJDSzEidiiEJDY29xU8T5QmN.6n7RNw4GlRq6cgfBmUQAlZ1kf4Biva6eNDso2ldgcTyoC
 0MYQgywTyav53YI7yQHiFV6U3hiAwHmDKzpYZ7sf20dJH74bqxFvx6P8bBROb6gxEvOu340S9npl
 RihwMqXa3.jcL53OSos5HFVf4CyIRATrGbDCyxDDdv6bTfAg9zFF7ZZnEaUEOlejkk.OaADWo1yR
 AOiQkgFDG6FDz1TlIAJk2Wkps_985FyNAD.c3eSnE23wfZqDR5bnTxNM_Iv_H58CBz_Sn_q76wJH
 g.toh9IuV6Ah9cQih7KlnvnszuvhbEZJz9SHGwrXjCBWjludT73wMmd1v1qwRbhaXALp6z07Y0wI
 ATKMhM3RNamg.KnPmOQ_B0TIA0aX3znvXJwbcphtF3mviCAZppSX6gV2noUnXSf6skHObUrDePgz
 l2nx9tI66HYuwcWKqr5pEmg_fPnjwchwtejpwG._FlnfEMvjdwYnWz1BAllTAbQiNkjGuI6lsOsu
 ZEKBrNze1DjUVjtO6L7qAc3T.C_RSYT6jiM5WKjtVTUt3eyTEN3g7I3xTYxNw2NH9LerL6EOLq5A
 klX_a0_0ir4TtVlxd6zUW8g855ke5iH56lItsXz6bPkDqJdgVmNno30RBgSLfbxeV4N4Tg9Bsvhd
 PSaBEy3QpS5VLww3k1lk6fR996Tkj2whTy_ABhQXa0pBvNIc2siYft8jcqtichRB9GS_xpXQQhXZ
 p.drue45GypUKs7QTn3op9IaFLfpcVVZ1JVwftgXIcvVQGpHRdgN5SEvrafdmSBnQxLzF4tp9x3w
 ajTTAbs6nKrHtHRwjlUjQDWLrctoBwGTx3sJuo7wESn3mjk_HWRWun1gWCsxpwTScm4jmI6ZfB_6
 Dl3pxWAqzdz0Q7fTLFRsXacNFEECgcPvxME7JUoyyDD2iN9dTYowpxmw.ikA7LJp8FeMjp.4uWcF
 t5LdKEjRcH_szxlDFKsp7PquBYbvY_lV4m9FCsvk7kNbV12AGJybA_SlFDSA6O7t0_PaRGFDVX7Z
 KI.iDg_YSO_GP4vjdoyxaU2j3fKe2Izdn.5HL1j6lCtUVHqvXMw74eIPh8gzqNYsGsWxyOwHaGwL
 AZPvHhNGo7VRLmoxAOYddBvVieDNhpww.3Hl1uw.gaaH1KSA_kw5idRCVz6.qXMBgWeYpUghNYR9
 WWzoYvYdkXgeM6rL39KMlY1aG_a3mHzRDYY77yw.TUJTHkLyS_.mdiMZV1XBhRoSMprdEnL0wh8p
 8r0ZB0uSt.ggJpC3ROqv3InKB92RGLHBG_jcl2mmZU2SHS27Rkso3QE0bX3ep_s0ltJNHJw9ugq1
 hwGerKLfabE6ItI1pfm.GT755UcDsEazl2_EYEptPfFEN0IGUq_JA99eJib.nd_yDUvaevs3iaUa
 Zcplafxbcx3W5Mt4DlIxuiXxzMX0OSc9T15j4pV0h6vlXL016I3aNNyhdXbO8sDaIOX592tCvTVh
 5tX95eXiPaQ3xl6EuiuZ7dd132KEaOHkPb6kPpAeISD4hOOB.GJl2grxTxFRQ7nBpNVGq0SHwkGM
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1d2a3e02-982a-4fb8-89bb-99201a06fb02
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Dec 2025 17:55:00 +0000
Received: by hermes--production-gq1-54bf57fc64-7k4gx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b4dee8fbcbf5bd416f5b7b08f931448c;
          Mon, 15 Dec 2025 17:44:51 +0000 (UTC)
Message-ID: <932e4d17-5fd5-40d5-8c73-b52bf91104e6@schaufler-ca.com>
Date: Mon, 15 Dec 2025 09:44:49 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: An opinion about Linux security
To: "Dr. Greg" <greg@enjellic.com>
Cc: Timur Chernykh <tim.cherry.co@gmail.com>, torvalds@linux-foundation.org,
 linux-security-module@vger.kernel.org
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <20251212054524.GA23417@wind.enjellic.com>
 <950ac630-c75e-4d4c-ac70-5e4b0e397989@schaufler-ca.com>
 <20251215045524.GA6104@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20251215045524.GA6104@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/14/2025 8:55 PM, Dr. Greg wrote:
> On Fri, Dec 12, 2025 at 03:43:07PM -0800, Casey Schaufler wrote:
>
> Good morning Casey, pleasant as always to hear from you.
>
>> On 12/11/2025 9:45 PM, Dr. Greg wrote:
>>> On Wed, Dec 10, 2025 at 03:15:39AM +0300, Timur Chernykh wrote:
>>>
>>> Good morning Timur, I hope this note finds your week having gone well.
>>>
>>>> Hello Linus,
>>>>
>>>> I'm writing to ask for your opinion. What do you think about Linux's
>>>> current readiness for security-focused commercial products?  I'm
>>>> particularly interested in several areas.
>>> I don't expect you will receive an answer.
>>>
>>> Based on his previous comments and long standing position on this
>>> issue, I believe it can be fairly stated that he looks at the LSM as
>>> an unnecessary evil.
>>>
>>> So in his absence, some 'in loco parentis' reflections on the issues
>>> you raise.
>>>
>>> I've been advised, more than once, that in this day and age, no one is
>>> interested in reading more than a two sentence paragraph, so a short
>>> response to your issues here and a bit more detail for anyone who
>>> wants to read more, at the end.
>>>
>>> There is active art available to address the shortcomings you outline
>>> in your post below.  Our TSEM LSM was designed to service the
>>> realitities of the modern security environment and where it is going.
>>> In a manner that doesn't provide any restrictions on how 'security'
>>> can be implemented.
>>>
>>> We've done four releases over three years and we believe an unbiased
>>> observer would conclude they have received no substantive technical
>>> review that would support interest in upstream integration.
>> Stop. Really, I mean it. I put significant effort into trying to teach
>> you how to submit a patch set that could be reviewed. You ignored it.
>> I can't speak to what an "unbiased observer" would conclude because
>> your behavior has certainly left me with bias. Rather than writing
>> full length novels about why you submitted patches the way you've
>> done it you might consider heeding the advice. Grrr.
> No, we are not going to stop, see immediately below.

Rather than addressing the issues you again explain, in great detail,
why you're right about everything. And I never hit the enter key with my
pinky.

