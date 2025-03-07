Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4B241667
	for <linux-security-module@vger.kernel.org>; Fri,  7 Mar 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369248; cv=none; b=lBrymLqmRUG94YH3u9vgLeB44Ng1FullZOd4Vd6hTEWpFEB2Z3Bsu/cihKinCiGzU2wY/OUqMWAxCfQBBG1cbsgaqIpZ9DFHw6dPZm4SvQsUtRWoLT5H0SICO3yDas5Q7PAqZISilHH0ISqbwcWlisy5nY3+FnIe1axn2ZMQc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369248; c=relaxed/simple;
	bh=Mg4E1/o5wra27s6ybfNIs0rCwK5CwHSxgpI4abYYXT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/CP0j6UQdyEhzZ2Ch6mc9sVlTzBg/XZoCjWRM1h6J963me1ubtR04BPvo4HRVzvMMUCVFaRto3DwK/Gd03WgkXDF4z5Zo1I6UByjyAYO5oB/PNeQupvOWT3jpcizqqLx2ptmrZDzHcPBEXjO96h2E6YdGUQih3Pk8UbzKEfiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QwuHw/Og; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QwuHw/Og"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741369239; bh=mzHM9hxFz5zMfqkRxlpsX3m1hAfbWWypMce/7frwR7Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QwuHw/OgPm5ZdxB+Nj3j1E4m4zjCBgn9DnrIcu1AMt6UEbu9XIzsFQ7LwbfGJJATGXCKR7Z4QJeGJY3Prsplxpi/g3US1GlRJjTOLdy0tW3Mt/V3G6rylOW7H9JOmy89zsYyH2FmCOZiw1SLH4jv6JwdxvSXhhXfaeuOY2qyQUUtv5onMtQG3XIIPbAZy40+a8ptY8CoW5y6P8WzjqlSxHoSzcQvbDJYMXiZsOCZKSn7aiEQdbLqDBNImGoALHtxRFX9dKDE71mB1+pYzIFv2C7v0icpQZTgwG1GqNBIZTA4IzYYAw3yuHnysvXcKUjNZbPdL6kk96G+lCFqBHhmcg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741369239; bh=AmtE3coXoF+2WpfAgaAJibxsY1jgUag7ekh6uFckm1b=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=r3y7/vEbbD4GqQoZ1ogCOEjPCGtpI+IpjpaIdSCMDgCJS7rINRygLfQzjd+Cc8JcJLLWAXO6oZh5nAe9ZrOqd0A0VLrIqIsDelGJX7wjxn0wtqgNxAIW27xyaFNMkM0jTAzXiRyHRyzCCn0Mizq1iV6FYw1G/Bw8P6XIlmUIpmV0CFfnCS3ZAw/Coj9uFejdScjy+IAltGMCeReZdE6UZ3kAKPe+N+oNryPPTPsamHmqK5XD2Ys8A+g3SFgKFAffGBx0ul/bW2aIZF9GuUYVsFqg6cvugagNmNW5HnCdHHaj+qy6J61h+EoqVj265kBNe6I8QM/FmH1rInL9MfAeug==
X-YMail-OSG: 7GsaUrkVM1mpCQk7f8yppFS.PYaNeNVtg5zm5s.b_HhQYop5Uxdaagtl2FWnlNC
 GRHAjsU5HrDUYbABcTG.tdwtBnSYAEcrYmwJjz5rNcNI1b1NawonBhWzA.11DFm0u_VELem7foNc
 ay7a3JJKJkWWVCbP9oCA4w_XkhT.OjsZ6Gj2YhgEmiCqil3OOf33pLAFuc849camXziJmuEhgxda
 6kO7zZHgC_l_RXXQYfJ45we0AZayjdG1USxdyXz5QdJyEaf46dViJqH3nwEqvshHq1llEQB8MdFj
 jfFqV_2P1ro298byBgf_pjlCpliKaXf9SjZIMaL3GWIf1SNZrUOM1FrTJLw3vXXvp8u7VMh1LAsX
 nRNuFDgEtHVoRdw4UErwUBQj5tfe9vX7XNjJeyjrYwTJEJ9Z2Yi0w8wq0XUFHgV08W3rnGKNOtsL
 Sj6luCMdM50hiHa_LmrdZmdLh9Mq4mUu2x2uurlsCqQTVC8tF.f3fYmBjmXvBJtqALBiDT5y3cQr
 co6JkwVte4HxZZKi6prnIjJAr.YK91OZDDCyNb68GXvZ73yQr0jsgSlknp11g3BCS6rSgBZ5nDyt
 Jxeq079mnOhuUSCIF4pXxdrXHzUNmRSua_MXBHhVyPrgNqMWitqjzUn4l9T8tLDWQK6yja6UHv2e
 JE4ycav6ehyar0Lpq6IO9RUL1IC2.NRwz4Ca8bjrWaZK7aoY6QRxDgLKisBcrRPB0nPZCsEb2CBk
 xNqupHQT1k.NvmRweSCriO3Fut6UciIj13UAJWL4MsvgNNjanCQAYD6kIGWHXfXHpjOhHyHWLehH
 t.dbAT1n57lGTyiyaXnv.Jth52qtmYDnJtRr8CLkmHVZThknFl7Fx9YzOA1r_.zTG3ATvmHTKUM.
 rFUl6GBThQvEgNL1wEY2Cfk4gmeML9.UsX0g0FJXWs1ZglL3kVaMuz7nRzKtw5CFvg7ZutuXJNEM
 bZw8wU.3OKx_oa8KBx6ae90jDjBVmeWmHJ_1.ttEjL_pwmoya3bIhClTrZtHv4ha0giPc5YtlFNg
 Pcse_uvDLzkWHv7vtcpi4sdZPvXqb4zHGVkaTcDhjs8SPndXElGpqdLRyq4YJugwR5COYLsKb6Ud
 GO6Em7SGvnh58ecMaBcDR.1hmiAB3l5.o7JnCa.lG7lck9WT7FO1buNY.kzQyZja3t914Czp3FAi
 2iT8CZFklnLzlKZzx4gi1k_tFVh8ALEkGFVMYkoS5lJfls8K_m_SisBVuYke6nv55Dg3gsedr6GG
 KInfvslZ.zN_8HN4iX3BPc4r7TrZ5DIDJmnb5T9U19pIMkebOf3uYJEGFr4qWh0ppwclRWrjwZvj
 WbN7lrL9X3SfGcTOk4BGSHTGIHEH9nM7Z7yqWURCUR7sHxVhtYTOOLYLLRLFvHs7rsXdRDwDfEGI
 ERi_MecQMwmhudquwzK.f14Xj_HARGu9idpLbvwDOS6vCin__iFl5AOKS6mpYw77jlE8ktG.mrzN
 vXFKPGOd11cJWuCML7tFGWGAl0HOK7_emGEOGlvteG5nqVUANMRgOjhx4WiVTgJ.3_EsV6WfJItM
 oyyQmm.fbOib2.057W2kTFrRTtNEFu5mZe0xDmuwoPBkQgk7Il2q0oMdFhAEqz1Gi2pMTbXPn75Y
 2mjDRjUoF9wYqsov8AY25ZQ_Nada8EvDmDBkuQk8UYC2V54boLetdwbEtaJs47GicpgxHG_PbQOy
 8zDsrQFXfssK63Nl_d1clRHx3bizHYyVLYh_Q_rcVdjSekMUPOwHeaJ99vxskIlIF4P9CnhQx38x
 MNUoClehEP_hRydTQSYmffAIdySLztNNULGWsPeIUGvSCxAuV3CDcAxAFGQKIVvHXFv7fdWh3i4L
 uu55mHvPlD5y15rrBIxyH9A8XAREbFvD..2yZA6RN6hYOkOr7MvGcPieRcXZAN7aQ1XRk_MW3Eg_
 Js0bBA4SOAz20U62WrIaJMjmo2.hE7WJkVtvs7eh_Ae7qAONOX33L8Y4fXmMiy915L1P7bujcvPJ
 ZNyc8g6n3dVsHbbHhgHmhsSqLp1AAENFaptuaDr3ov7xwV5rH8nFVTJwE4PLSH_ataYHNKUjkyHS
 bK2YfnLPVKDkfTfIxD3chgTIIBSsf3ab1H7E_7RPrNwRIgG6n6HZS4989Wyh2ST5R5b_e6UzW401
 r4VKiBuA7nP7nmyT4VTNoOCg.v8UPp0NT4eqb51KszjUBaP0Jn5711OJ57PUY41.A43DMGXA4En8
 phVGyhukn5aJqPS_aD5Me1oLbdGC2elhtupBi.su0PtAL1Nx_tta4.0wY.IbBLr_2v2H98.shJ9s
 1vLKq.rc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8f70d0c4-339d-4121-b452-1c893df58786
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 17:40:39 +0000
Received: by hermes--production-gq1-7d5f4447dd-9hzlp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 44a93f38e4884c588d5eed7a8a9fde5d;
          Fri, 07 Mar 2025 17:40:35 +0000 (UTC)
Message-ID: <0bd0fa8e-1fb8-40e9-bf9f-0a3afb7798eb@schaufler-ca.com>
Date: Fri, 7 Mar 2025 09:40:35 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] smack: fix two bugs in setting task label
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250306224317.416365-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250306224317.416365-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23435 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/6/2025 2:43 PM, Konstantin Andreev wrote:
> These two patches have distinct subjects,
> but work on the same object,
>   security/smack/smack_lsm.c`do_setattr()
> and the second patch partially overwrites first,
> so I combine them in a series.

These changes look sound. I will try them out.

>
> Konstantin Andreev (2):
>   smack: fix bug: unprivileged task can create labels
>   smack: fix bug: setting task label silently ignores input garbage
>
>  security/smack/smack.h        |   3 +
>  security/smack/smack_access.c |  93 +++++++++++++++++++++++-------
>  security/smack/smack_lsm.c    | 104 ++++++++++++++++++++++------------
>  3 files changed, 143 insertions(+), 57 deletions(-)
>
