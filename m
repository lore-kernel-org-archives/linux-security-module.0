Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CD221D92
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095765; cv=none; b=KZa3pelwXTG7ZgT0sUD8CoqUiPG2iv+yg+qgzGE2+mFJfU6F28svhDo5xDtLWi8VsuidOAJP83LIM7wQgFs4COzvy3C/0SO9q+Qyr8cysXxvQUvMeQwthfD5Sx6evgA7hbddUxsyZd98MipQraLV0K4JEModBV71+e/pCP5DxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095765; c=relaxed/simple;
	bh=ypwWDR752Brl/yP1GVT7O+pBYSXpSCA6k5ypA26i6FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNmKjNVvB9ZLOSJKwm3lsjdvsjpAZ/9I152udxuikM0+wKxke7nzjrPJx6/s9Uj2ZFyoF0oDRjxbnpU9v/SM/fsDbwM1UhlQrslNE27fPjii5XsN+t91MRw6Z8ax+U7IRM9BYHQFjFuQ5i6WKSZSyBtbYH5cjjIwXrVkDnI+7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ESEo59HI; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ESEo59HI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750095762; bh=ypwWDR752Brl/yP1GVT7O+pBYSXpSCA6k5ypA26i6FE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ESEo59HIKswgH98C+N03D9Yfoa3B7iDbLOgHhaJ23m2AyNamPIqd00mEZafmL0wXNgHDfablV0IT51HudqkuVHmS4BCiaNxiREQKqtJf+WEkQsixU9pfU14YNW8PP3j/27sZhhxLztwX2v3OFucvatLg/PzgpzR4cJ1joKLLUVUxiiZkjg3myRNpJ/o/PSxSlz8/8BD7odRPaIWmvOndP6nK5+t1HcNlzC/J9L05CGXnCzJ14NYuiMn5cI3NhhIniMVlYcmsHgSYldOhOGKhUgG1c3REZTZb/hpsd5s8OrZ8bqsRSKufY/kxAqOd3mRXuxlz1nwyPYo5QAm7/pEJEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750095762; bh=HEUwDrCU2Cw8FmpnWmc7jAe3IKOpOKn/uxS6vdOra2Y=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=s/ah04ndvaVRdmZP0MHTt8dj/xM4feGK7Sf8aGnXRVji6TSIpw5D0EntlWteftJ7O1gZPEDfc3BZhxbSGU25Q1SHwJwC8SM8/m13ygv0NrpeMrRyQnpcb+aFRPMfgc7mDlVuxSUE40hHA8yZBRSLNfgRJ9hdPp+pT6L7e9JkcpiYtUgVMf40apme0ad7gQZxj/wUHRH2nVHYDciSWAtk8/GLpXcKwosY0UixfQOUt9Gk086zyZ0TfEOtwMqSgqpt9FN4JwvIIMpczB0Suck7XW/jkqBnJP/5tqZoN5+yG8C4ZQfc6b16CsayWqsmd3gplbTN3ybMv7i+c1tUJtlwIQ==
X-YMail-OSG: VpV8dEwVM1mBfxS6lg4klHPADX3rq9cKyr_XwyxX0I7o160PYLmc.mucuD0kxQN
 KDFbqlieTwkdOPe2ixfamO_BSnGKR7siRh8t4x0LOvlnHwUiQp4NpAHItAutAJ60sX6fEvVL2krT
 5d39.44VB.p_MsmdZvV6O0dSGHt101E9eGnPfwAvURw2TZicbwDrqXDgjhmY7XhKc_jf4rouGT5N
 QxhPUCwaC1iBdpjiYWqiWQjgngF5YbLOf44nPN4P4dIdjW21tW.sBazmgqgWetRCyKQ1pUMJOFms
 CrlAf2NLwTl06ENH_s56NPOsrZUOCnTW6Ww0L5_119WyQD6Ya_pYIxwYfNotyilJMz8oHVvKEF21
 dpTZqS9YukQ5pVPXhnOSPdGgulrJClsXFhijRb6nFhojbmxdUe1UyaeH1BrDvP8wsPrr8tJQE15u
 DnR6vyq2gXEL29.e5DGUwf2k5ld4j5U5PDlzZL1CSv4AhYhpM4ivnz8h4D3n9CWIeZiil4CZ0h9U
 OAUya3o39q8npZEKRImm1C5rfOVdmupYh3Andyirsi1stLcFuJYuBpV0Odgj9zq_MYk6qqcJPHPP
 qFnuEOiUbdwC.d28QkJLaBg_z5wk2PGc1KlSQVNdq.OWTTn_4WZjCwMhX03FlkCCXTPkR17MKK9H
 WJJgfmrvxfkqhenhgJeHCcpEcalpcC88xUYL4Pqj8OTPrYDCxRCfBfHLLOKnpEDYDNUp0dqnTkcr
 Ax4jRWfOfYOvGcAyGLcqdoY.4XSqVSHEQm0K9AudORdHu0.leyT5M7iFSctKvvhPQglbugwhOwOy
 dE1HvrhoLGeinzoF0b1kxEr71cbnULWlzG8umHDTBrSWGoxcM0EWjahen6crxFiSsJSVIVFsImqi
 FA_9UWoL6Dn8s2ArSZ15dIqZvT7SxLNw_ycrMviBMLiqojkQGfGgt.Th2IJcT2EQIiSZbJxXGqbt
 ZNfK97gjITXBt4.gJmbfGG_kLnpncFrXFwO5sX4WqcxMDM2CWATjmhaFkU15nOhfJAiKsk4_qJdY
 Hnw7pLGqKwjJWl1eqFQoTsylrtsiPLvtf8GML30YaVt2eVMFTpFOUAbZRsuTjOF3033qyLf8.g_1
 0YjlWZW0SPrftAxpvLL6WW6_7n.QcOxIJOVJwWpACaz0k7Bpwnl2JQFifseFELKJs8NufHCVa82t
 5hLlHa8uqO81zxtq.tWTZrQnDcp1JlRQSAlAJv9_LJcys2p_ZZSHeGrhvOu.sCw13DTn3Cd_hoM_
 0us93WDy_KJ1L23uAvQCHEHuOiXwBlI630pcLW7V.6Z3ELm_fJVFkhmtzD9bsl66kAbBI28yH6tQ
 nwJ_Y0atyLtILQ1tGtNK9b22Q3BRhkNq_tN2HFVF5TmIQ_D2tfUqPOtMkKasU2jd_7rhcIGo.1.7
 0TEVPmlPButvqlq73z5F4edevnI7DZ3e3u0E.LnY2SrQKIFQeeBlUM1FX63S2PtRvSeScqYm0BPh
 Ta7AEkMjJ12Xl5YCAI0H61uxJ_PGf6tZTp5zBXOgEXk5OPdYRtcAxeTLG3Oap_TLmPQBByZWhXNN
 nMhb0JQP7p6YDP257QIBg3tn1tQjRvl29YNnwfrW7XGLMuPJRnOXlD2WlLxmCXYqOR9GVQE9oY0.
 WKLCYCqWbZkjioOPems.NxOiK5Dq1mCOPDsqBuhNS_RAa0qTQEpB3YvZ6f7nwTz6izXNfpibaYnF
 4VCF97HopgQ50z5.QPj2m0u3idu81Ru3QXCcchN9S3umx4ZnHvPEALue5SwO59QJp2Z8EZ7Z9blj
 yZhqj68mZ4Iic2A5ZQqjEYWKa_oS9jbWli.NQLQroLldPnreoPyRN3aJkjGcGLR0RCgkLC9fvQDQ
 uQ.0F6fbd3dI41R4iWxgaimj5i5SQ2U0nXIr2KYFtd0Nipkj63K6WuczKrTswN8yfa3OIOr79H82
 irc7In1f9jJXDT5O3.iHpRG1foZQWPd07x_ksEO4WWopGU_TYVPOmxy_CejJCj.bsqntCiY1wUSb
 tz5cQGHmtBrr.BnIDQBUFTko6AskLs10PpwMpdb8nAzY1bVyTRF9seKN8DlSb4w1i8I.2oXe6Hsh
 k47jC46PAwz4OclagAUTAPpPm5NdyapE23Xmy40soSlANcMZe_ulW1lzsCIVvrbSgK.z71Iw5GR4
 eiidHYdvsazJXISWZ5kkaAAZmiBPF_Cve99Q6SkoE8DhBObIdvmv8j_gfN812aPkg1POjN42.KQG
 YnH5eY0Y1uoJXc4YZ39CBFPuEm8Odn9vVoaxWiNjtZuBqjTr71RMa9AAKiesig9I9B1n.JzS5y.U
 aty0HKbMln38Du0cH7Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 53e56017-2cae-4282-abbf-5e887099ad0b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Jun 2025 17:42:42 +0000
Received: by hermes--production-gq1-74d64bb7d7-6nlps (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3e1c64c2a5b3a430392db9f269b02567;
          Mon, 16 Jun 2025 17:22:24 +0000 (UTC)
Message-ID: <225c8775-5213-4a9c-af32-b80e78d98abb@schaufler-ca.com>
Date: Mon, 16 Jun 2025 10:22:23 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] smack: fix two bugs in setting task label
To: Konstantin Andreev <andreev@swemel.ru>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <20250315015723.1357541-1-andreev@swemel.ru>
 <0c8e9341-d044-42ca-9332-2b284a0e3e5f@swemel.ru>
 <c512e831-796b-4a97-9ae2-5eeea7321e62@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c512e831-796b-4a97-9ae2-5eeea7321e62@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24021 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/16/2025 9:58 AM, Casey Schaufler wrote:
> On 6/15/2025 6:52 PM, Konstantin Andreev wrote:
>> Konstantin Andreev, 15/03/2025 в 04:57 по Москве:
>>> These two patches have distinct subjects,
>>> but work on the same object,
>>>    security/smack/smack_lsm.c`do_setattr()
>>> and the second patch partially overwrites first,
>>> so I combine them in a series.
>>> ...
>> Hi, Casey.
>>
>> If you have time and you could have a look, that would be great.
> Looking at it today. Monday rc rituals must be tended to, of course.

I don't have your v2 patches. I have the 0/2, but not the changes.
Can you please resend them?

