Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1714AD38
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943069; cv=none; b=dj6iTiDgGTf+be5AutiT9Ou7nzZeSDdplpiw/M1fvROfrelxaLx5dufKrshRLWcxA08JT0xwERlyuNu7kVEpGZ1JxOKVgLpvlj1944TnZ/K84X16S79KvEWejLzd+I+mjChFXo5zOBVuawRntwv4vCggwjYvjg0H2XLya5TDRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943069; c=relaxed/simple;
	bh=SHLLMD0d2Kc9hNDAalQSfWyUhGZBGvxlxqBJbxncQUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q26lBCmLxyYGeERjjfulo1Y8FnkmWOWKnN3nl39ZtxT+V904rAFKXkmKUREL34uuEyC6dI25OZfmMYorRuQWyGrkfSCOOPOJsPDyJjbD1lmI/xMh+65eJ5PsVoR2rDK5HctZ34jUcdVGusTsZEv3Zc8NdhV8sERQM6j4C+Mr6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AFM2el4a; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AFM2el4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728943066; bh=NIhk5zxmPqsUqVGrXuHqmRSr0bOlHR4b1snNWPz6cxk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AFM2el4aDCuy6VcInPQFScSo5BiNePLT4feKzMOQ8EDEXXHMjfl3fRaG6gkU1QrFkzU5TjYUFDu4vsh2WjnL5U+zB1GqvH5YSFzTr96hxOzjkL/CWGYfg5cnYAacpfm1neZds3KTS67TaBX5N0GUt3bWac+kz9jx7vjIUifYRlIPRylMEfHSlWUQ2a0FjdyFHwUk1YkOCEfqFRSR1Mj9BHjnW+Ea7tArShggU0He1FO3csnx7AUFwOJcW0gSBVERkipT2L3FHyFJazb2vQwY2zxUEyElfnzffyE9jBvI0Glegl2a3Zh/1NRTrS7bIu0OieisIz6HKVAP2NPMP9H2Yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728943066; bh=Mh15AMV3zLHsDFBwZLnBE4xBY4ZJDLB1gQI1p/akihw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DMeSiNf5nEWGT8hMG/74yboHyvCouuZnL9TBMO4/LEW5AfkpThWW7Kaoc+TTIt4VLloOUHcnXx6074B4QCpjrQ9jF5DZWczWWCohZQpEy614e1kYmYIfHSsHIEj57ouATjVMMechq7PaJhNIjM9iAdWibtU//UJaC3HrW4c1gn/91d+JgXeNAcx194L/qtZtZ5DxZd/yziPOYoICLFR7sjCZRE3bb2rLk/U1jfk5f9vxXgAxWKzK6Qrj8+20YSqHaTr9LANscROddxpiXjZuOEI5scq/XC639RTJ7mjFK6WJmIc7NRIPhWMzf8I/n279pUn9sHIeKpGYsCxS1OHovQ==
X-YMail-OSG: cvr3Sp4VM1lcYvXeT3YTpZwAAhQMoLufVjwH6e0fenI.gm51rjevdUv5drGwtRS
 jWo4DQNvXf8XQ7dx6f9lsaA5_G3fdZXGDN_0amxsV7tJV8ppgEMK3okvCW7MKyA3mX3OOZRK_4u5
 AA4VoORW8yuGPCmL7tIXreirCtdeMCg8CdYPoOh.Uz7oG9l7LrdExTtyb1oSFCjcgPmQ2n2MgNl.
 E8y6nWwP3XYjTVnvN5e8e2hwSCwtH41VMYy6SSSDbJuVOFTCtgIk4YDc3PHg4MhXKE5B7M1_yTws
 wcA1A0itsedy7_uBm_n8vI6SoOqvy7AMY3R1EB8.TrIdUsSJhMT0lgUgAIZSfogYUoO6YBm4nOLy
 hAd0OvO_YTym5xhI4dnwVvDB82wuAJ.Umg.aLXW1k5UFh4cmus28dAE.zdHROD1mHPtDsE0JqZNy
 yt.VPpEQO8q6WdeYCiIXju4FTL5h2ayr2TS47LgnPPCc1kKJjK6_c_XvBmsezMl1fsCQ1ZQBtvYF
 Kv0Me6G5eUzP6ndZiWfl3UwGYX4H6ZDmDHzWIAWDtR9w4Y13cXQbFGyAIjpvOz9Kh2y8I2GJ9QJ_
 txffrHMK2dkhCoIjC2IqeIR2WIF3uOZ_8p.7mWDzpdHBh9t1ctKZpdMlq1XJs_gEmQbT57DdFfCW
 tsIeJ6Z__xNjYq30O1os8S6n8_Z6GB9tlFDvhU4CcVUHL16XWhxFf2DJbiPYxwCppdTeAB1dypZr
 Dcxvy.8USt43.Kb3ArV5yLJzMG8Cf5d_B4cPPxr2phX.JWQGxNLijKDsXsccllfiiV0FIX_c9FKJ
 yP1mGL4fk.75QCgiiOmb2FBbj5xM8M8HF_iNUqTK1Tw_sPlFi13h7UckZHnmHqyfR7hzyMmnrtPa
 OoFB6tnbx9Irr1ybn0JP8C31uc9Yc3s12mdwbB16WD_nJOejQnzCZAdthNXtqp4mYslTXqEaPwrS
 aBflrqTIxSecg9isvqarfjrIP3BYX6BI0gcgqDQt7LtMfpqE2bmbVvZWI6ix6ycQQO.T13ir_R2T
 _yMOdIVYGt9w4YDZDw2VDgVYBGYSkArTOZ_hiw6cx2MpUaNblutQwbSimW48WQR9oeR4Xkfz_Rrp
 5_fQEXvFScH8Xm3ZWmpWEsiQ55RwDhhDgSonvsEJjTu5BEsrQVLOnW16q.ETsIaOK_ibzTWS_Hty
 lTkAgCK_eRNCgKbuWc0fPhz2QQKL5Nwkw4Nsn2PeHHoxNv8UVNTv967D9ORiR1m1l1sfY.kn61SH
 BEj8aRoIb9Ki3UNo9bUdfpcQtV0eqOGbRQM1LmdnsEy8kEwXcABFwB2D627Gv21yTtOts1ZtsXng
 dHnEUvpcDCQtr6Ylw8cG3H9DXsUntSZqk1YtDFmOLAtWKp62lqr3B1PGkNHl7MwKGAXlgR0bMm2V
 06SkTE4rNbw0XTX2QvYB8HY.VfycGG9lfwlpoM20K06Pt6Z4mjQAL8KTfWySncay9E8GdqLfn2cZ
 KV7hjQrygEcLzB1.aBko5lcNYY6ttnDXXsfnDBcvZ91.LkD6JAsztyQy_jcn9kcNtkWFaO5t_IEk
 Uf0zQLgG9B9qEd0R4GEhNX_YiKnYpR1tae4r7TH7h.F8Wv8hkI09rZCwv1JM2Hgk393HaWCV3YSk
 LCOcnt3aG2lPFJtO7SR1lveTXcFjOt7.4OomO.kv5sqGu50Oufuj4s0TGcjwwJWD0wVNzk0SFRtA
 IJw2qpMB0Ph3ftW.N.cD436XL1ejhrTY_nQHUvl.sHI04GHGXVMbUT_fTCmT95bIihLD1knLC5Iq
 MXjyrWGIrhEIg4Tjnmt1uSpTvesmsK6Tr55N1wXmidhBVy3hyHJRGr_qHK7QDUZn.rz8vvu3.t5d
 wkkUOxHiVN6CScpWVV5lT7D0yaBoM8W5cQvQqIP6qZiFY15s5l4V5SZrLeV92f88ajg5Qctmp5OK
 IDTYkfUFR_Lts5V5I8DIBJK1yyGk1yGFA3z02C41PW6jCUgqKW8TrHuVLsFBWuNbccnMqeNbR78w
 kK.Tr7lt5LmTzG7r1daPl1i1H0UJA2IHK1OmUrV3WgTFsCjTOTu_rjQHxR5OGu3tfqgiREyJTZvX
 yz6klq.yrfNU4oNwCagTgPrYaWAw9sq5zw7BUKFOsXuUlSz_ZdnpiWPyT7Xdp_r4on.xR2uHPxsQ
 giCzpvbOU.Nf2oavgy_Ouvt0W2phOJ9Dt60AxTeN1389wvkKkOiaqdZzl9FDS5n.azxZpU9BDEZG
 4I8IVr.ypyVv6WQ72FSxCIUdFoOShJqWcXSaTHNSPMK6hpeM0F9_n
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5614bb35-af07-42eb-8e26-25b7795ce2fc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Oct 2024 21:57:46 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b405248f52c8435ef29b2aae932f1528;
          Mon, 14 Oct 2024 21:47:34 +0000 (UTC)
Message-ID: <0e96fbdf-6dba-48a1-8758-0d60f6bad842@schaufler-ca.com>
Date: Mon, 14 Oct 2024 14:47:32 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] LSM: Replace secctx/len pairs with lsm_context
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
 jmorris@namei.org, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241014151450.73674-1-casey.ref@schaufler-ca.com>
 <20241014151450.73674-1-casey@schaufler-ca.com>
 <20241014212937.GA1100381@mail.hallyn.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241014212937.GA1100381@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/14/2024 2:29 PM, Serge E. Hallyn wrote:
> On Mon, Oct 14, 2024 at 08:14:44AM -0700, Casey Schaufler wrote:
>> LSM: Replace secctx/len pairs with lsm_context
>>
>> Several of the Linux Security Module (LSM) interfaces use a pair of
>> pointers for transmitting security context data and data length. The
>> data passed is refered to as a security context.  While all existing
>> modules provide nul terminated strings, there is no requirement that
>> they to so. Hence, the length is necessary.
>>
>> Security contexts are provided by a number of interfaces. The interface
>> security_release_secctx() is used when the caller is finished with the
>> data. Each of the security modules that provide security contexts manages
>> them differently. This was safe in the past, because only one security
>> module that provides security contexts is allowed to be active. To allow
>> multiple active modules that use security contexts it is necessary to
>> identify which security module created a security context. Adding a third
>> pointer to the interfaces for the LSM identification is not appealing.
>>
>> A new structure, lsm_context, is created for use in these interfaces.
>> It includes three members: the data pointer, the data length and
>> the LSM ID of its creator. The interfaces that create contexts and
>> security_release_secctx() now use a pointer to an lsm_context instead
>> of a pointer pair.
>>
>> The changes are mostly mechanical, and some scaffolding is used within
>> the patch set to allow for smaller individual patches.

The next lines in cover letter are:

	This patch set depends on the patch set LSM: Move away from secids:
		https://github.com/cschaufler/lsm-stacking.git#lsmprop-6.12-rc1-v4

	https://github.com/cschaufler/lsm-stacking.git#context-6.12-rc1-v2


> Hey Casey,
>
> so this set is not bisectable.  Applying just patch 1 will no compile, right?
> What is your plan for getting past that?  Squash some or all of them into one?
> Or are you planning a wider reorg of the patches down the line, once the
> basics of the end result are agreed upon?

You shouldn't have any trouble with the lsmprop patches in place.

>
> -serge
>
