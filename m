Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619783CB0
	for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537246; cv=none; b=DLNDpp8eP5ZaxEQY/ox/+zu9bJwD+S4rTinKQXmvvORFXhBANBeNnd50qZBfXMFyOYKSX6gx2MdVaI2xHPAKGFalRw8zw9NQ3Hg2f+wCn0KIMhX+Bq5fuWf6FVBT4/Lxquy1X4WTSqyAO2BoXjgEWqyzNpE2mTX+cQj8q9AuCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537246; c=relaxed/simple;
	bh=41Dzm4ure1ovtFSClC4fzEn7Te5wsZV83Nh0sX4POBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG5Zaewqhl8gYLWHXjWci0okB2fJITqOd0STpj5tuCH/9tVBS/VIVFPLPxBbhtHWcMVLoqZW5eUje4zvJ4SWbKax+1lWTz7CX1CX6JTKRYVoj72wIUnrxb6d31Zsy7uPBnh+d4b1RK79gxs95VSjnYDUJ1ydtiC6tJLmV67bvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IwvTFMbR; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IwvTFMbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1708537242; bh=2He/rikUMLJD8Chw2vUhaJAvnMzl/6kCA35rYv8BpQQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IwvTFMbR86y25CIb0xU/G8gPtVKjHtESmwg0URIk+kSAh9O6pAgpKsNK31LlkVl+i6sRcjEaHa3YHON/TgW5IK/A0VQmMSx1QYicPsegexPjm8FUF1aLYbKqgWjpJ3voDQ2so60vEqyHFXaWObHx6h/q9BfhpG3e1dbg5qalVy9SHEoGPmr4l1wrfNDKJKhlFSVPzFGLulInqQGDlJFSdlf8O7m9Rup6GTXTZNpLijdjPA18fr8wQbb9Q5WlqGK4u++3WBwcL7cf5lzJ9e2Xlk6K8B4tvgqsvm1lT+ioVQrZ5guBvLw9fuERbgJ9SNCE7SArBduc+ippXByWDVf3Eg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1708537242; bh=vXX+DB9FqfkwcfYOJd+bkFuMlP3chILaoBebZx9kRuA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LoGRwIq9Luh+ruNxbXM7v5MS0yC6K5wj9rvurd/xS5VtpQR7rlUlX87Qi9aHsvkqyzBx5FPSQfyplp2X1VCFJzz8rb3yAUq5+qaUJziFiMwsYEQUPRHalv4FwYml+KzYrzEfqykZhXx6qV4tvM4MQezeGKcY4oYyRT8xUGXtNtOWHp7QraCuWbpjSYkzDZyPEY9cAD2R+dHt7Z7+OMkHRLNIPACSSmM1s69tlqMaAl0eYhUZRZb16EtCL8aSAq6BljsaBeSJDcTwpnrz9vJQm8T1UG0Z9l0TZueb7XuTkuE25o2Hjq69kfSS6d8h6WWUddTm/hZ5DskbQXpNpTcrpg==
X-YMail-OSG: wKCLdUQVM1kG5qrqZA5KvHxv1lCKXEX6pJSBxoRNx91J3xBjMWXSOQGEt3T_rff
 WIn35zR3w0YnfgA.M6w4pvD8LvDK9mJBCdFNbNjuFtKFSstdh4kS032AUOAAzAjqEiNCpmZ.0P0l
 YG1p9lwnUd17EYHJjxPO200sTN1MQYfTM3W.OZShfBl0450xw3SmjgzpKsFU90j.LQTKZbw1LKU_
 ILBmkAhUlLMVNikBWarVSB8vce06AzF6B6YzqLB38uGD1VC3jLIaNrj_Ksy3cN3vLIIz4XUGPOHd
 Ak_cQ0Qgybt8uYlpq7IDbP6YLzFGMk1Hmp.Tif8iPs9TJVM9M_vdaA3q5uHwDlbXJx9CAUKoYBCq
 TcW.keHglWY3EzJ8A25O1bU6ipTProODJlDFSMIP_5o6w3m.p6_4dzsx6Y03sZJ6RMtx_XWZ9i4B
 vosak1VClcVh8y2tAEHpCFANEsE4MC3c_jl.GW6PCQIoQ2eF6DRwghaLGjxlQvRYPnxqaCAOXBvf
 8SMHceEOgPir1rkTYM9RMY1h8n1t_x5Jb7rtFchYIL1EBrIMMhuyZIBI3s3w7R7I4_k8722uBOLD
 xoF79TWPFDUPxPeZN6RNlQm4Gka4S8mljuUgKZp3cuN9WL5INVAInj6EwDZJO.3ml2NazorEoK4F
 NJkoksz680BW3sF48sDXoqinlx6QLGpCoDTK.uJzgknMnW21OKegDY.o83Be2VYZCy24R.Nw2fdG
 CoadiL8M6k4vlsS0bQAsaJWxqPAdZNdcH3c1U2bZdw4l.64_oG_COreLJ5fbChf5O8Rhb9LRbk7K
 Ynx.g2DXv2JmDad8m8izL9jg0TfJeX008h2zlpk.rjgFbPL72IeJAL1eNeefYuMSEnmgSlJdeXPc
 NrVLUrFiGjFmlftvazVnSO1yZH6N3BfBy5n8tcerAHDOtZ6gkvfiVdJ0t55O.Rn5vkvMY3ZVC6IK
 NO7PNZDQIG1NCbwCiZnbOe5Z9koWUHox7RKfbQgLrzvqAYhxayoKDw1KOepfDwX8_bX4_i20Mmav
 i91Z6h7Fckux7tpgLEu6Yg4HsQ9DYLfFUicVfub6mmTTkOqCEY05InveqVa.txXA1CXh.HwyZvzs
 .ZazuXOyRKf6rH.r6eLxsNQ33bllQ5PvNILlBF9tqP9kAHP5XAdloD5AOfr1SMUQ_Q3bSlNbcl.B
 duNnAzIpq0m6Rz1B0EueY.uGSeZqpPXecdK.0MoW5qyhF.DfvNMqJI5D4RP4B_WTujYrzwYBHfeA
 UEeFGdxKfIFTE6RrbNLnOGDzo5iIbMQgq9wguM6qqW1bJKnePWtxrW18mxGmLT5aIln3g7obm7dt
 h1Cpx5fqjssUiLHbpExBIXLS96XN7W0gW5dynG_Tt_QJCmOglW5Be0AYFCJSFEpdvtJXXwEuSfBt
 8jDfW6onyPCeA9jr47raFwgqcPFjrKn6jQVVAp_0iJuRlZkT7tWb3JBI.UONCkJr1G88M08ms_4A
 R8EIYJocyjUwWCz37ED_IK.n89CmCgA7oZr1SUvyQhtXyda9S0CU1UidtfW88K6Mug17DgcpNDjH
 xLLsT0y9Ct9x4m217YFN2UGJrTkSZ8fygziNDNHs1UKZQzE0V9mMPv0fIcsHit0OTIk5NfG2JiPu
 dODV3LA9SQvSVpUSggqTBrKR5mLLjyJ2gRkLDDCC0uTqWXLN6dk8UDxWPYJsB0G6BhtTaPOFloeX
 Jn9ijk0elXt4JthQl5CEV.14oFOgSvl1WJxysPkgyG2XkCzYZtpuSuCcHfnyFGsRAyfwuSheaVG3
 acyuHUs1pzEJEyurCJ0BbLKBrwL0ErbF3Qhi4GJC7eQgCsiyKPswoGMiHPT_UcefTZqtroZQCZDA
 Z28x_9enm7OSgsUEGYExvijXT.K6tbvspHi6QvEfG61eigYvyVasCG5p0ZkA8yqrIwHINqjYlGS9
 UoxAOyHDvhk9cHdn7A2h2ZtINN7OBbVWzwnG8JFFgkaPyXYMYk.lvBGn_Ycc4abYnsS15LOBEint
 oogNiskRqO8LaB02neKgofc06OLTn2SEsYIf6epQzlf8fHIqF0fta5V5F3UmkjrIG_kljCzm9Qsy
 jCjulBJ41i4BhO1pFF1euKtKUxvdf.dofNuyf.Rnp2YqgbfYYrgK_62tvVFyuT5_iKZDRFb9BiuS
 FJ1yQ81oZ0HGXG2daynMDLxoOt2Id32.JCDFwc9VS7ajYqQFlF3DHBSr.bTKAAmwhr7G4iioprsu
 5MNkIjaCuw7m5aeKpdk3gTkbpsboA4a8vZi7wQiIuHWlQDtyOTaZVDLt7Pguxs7K4S0tI87X6KDK
 2ZBqjDX25jQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 775f1cf6-5bbe-4b1f-a91b-899bc560bdd5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 Feb 2024 17:40:42 +0000
Received: by hermes--production-gq1-5c57879fdf-bmngc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 632860db9c774db57b89dd52302a9462;
          Wed, 21 Feb 2024 17:40:41 +0000 (UTC)
Message-ID: <6455c16e-b840-411e-a64e-7b066c2d9ff1@schaufler-ca.com>
Date: Wed, 21 Feb 2024 09:40:39 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
 <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
 <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
 <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
 <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp>
 <6e00373a-a028-4575-b2cf-d4da366c2b6f@schaufler-ca.com>
 <CAHC9VhT730AxsUv=1=dEn22ABeHJPZ1JA-xwZv6DN54+DiiKQg@mail.gmail.com>
 <9a816f3b-452e-4d3a-8c45-da49f5461317@schaufler-ca.com>
 <CAHC9VhRK3L12zgzm4-9eyxdhb8Zp-OrAg0UQxFdc3Qdm2yoTKw@mail.gmail.com>
 <20240216233154.GA1005338@mail.hallyn.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240216233154.GA1005338@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/16/2024 3:31 PM, Serge E. Hallyn wrote:
> On Thu, Feb 15, 2024 at 10:32:59PM -0500, Paul Moore wrote:
>> On Thu, Feb 15, 2024 at 7:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 2/15/2024 3:38 PM, Paul Moore wrote:
>>>> On Wed, Feb 14, 2024 at 7:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 2/14/2024 2:15 PM, Tetsuo Handa wrote:
>>>>>> On 2024/02/15 3:55, Paul Moore wrote:
>>>>>>>> Ah, but it turns out that the only LSM that can fail in _cred_prepare()
>>>>>>>> is Smack. Even if smack_cred_prepare() fails it will have called
>>>>>>>> init_task_smack(), so there isn't *currently* a problem. Should another
>>>>>>>> LSM have the possibility of failing in whatever_cred_prepare() this
>>>>>>>> could be an issue.
>>>>>>> Let's make sure we fix this, even if it isn't a problem with the
>>>>>>> current code, it is very possible it could become a problem at some
>>>>>>> point in the future and I don't want to see us get surprised by this
>>>>>>> then.
>>>>>>>
>>>>>> Anyone can built-in an out-of-tree LSM where whatever_cred_prepare() fails.
>>>>>> An in-tree code that fails if an out-of-tree code (possibly BPF based LSM)
>>>>>> is added should be considered as a problem with the current code.
>>>>> Agreed. By the way, this isn't just a Smack problem.
>>>> I've tried to make this clear on previous issues, but let me say it
>>>> again: I don't care what individual LSMs are affected, a bug is a bug
>>>> and we need to fix it.
>>> Yes, I understand that.
>>>
>>>>> You get what looks
>>>>> like the same failure on an SELinux system if security_prepare_creds() fails
>>>>> using the suggested "fault injection". It appears that any failure in
>>>>> security_prepare_creds() has the potential to be fatal.
>>>> Perhaps I didn't look at the original problem closely enough, but I
>>>> believe this should only be an issue with LSMs that register a
>>>> cred_free hook that assumes a valid LSM specific credential
>>>> initialization.  While SELinux registers a cred_prepare hook, it does
>>>> not register a cred_free hook.  Or am I missing something?
>>> Yes, you're missing something. If security_prepare_creds() fails prepare_creds()
>>> will fail, and the system will lurch to a halt because it can't create a new
>>> cred. The cred_free hook is a red herring.
>> Okay, my apologies, I thought the issue was due to one of the LSMs
>> failing their cred_prepare hook and causing security_cred_free() to be
>> called for LSMs that hadn't successfully cred_prepare()'d the new
>> creds.
>>
>> However, if I'm understanding you correctly, the issue is that a
>> failed security_prepare_creds() call can cause both prepare_creds()
>> and prepare_kernel_cred() to fail, yes?  If that is the case, can
>> someone explain to me why this is a problem?  Both prepare_creds() and
>> prepare_kernel_cred() can fail in ways unrelated to the LSM and thus
>> callers must be prepared to handle a failure in both prepare_cred()
>> functions.
> Sure does look that way...

I am going to argue that what we have here is an excessively aggressive
fault injection. Failing in security_prepare_creds() during system
initialization will prevent any credential transitions, which will
prevent the system from booting. This is true regardless of why the
failure occurs.

To prove this to myself I moved the fault injection into
smack_cred_prepare(), and made it check for a specific Smack label on
the "old" cred. Failure is returned if the old cred has that label.
The error condition is handled correctly in this case, with the calling
process being killed because of -ENOMEM being returned. No other error
is detected.

In smack_cred_prepare():

	init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
+	if (old_tsp->smk_task == &smack_known_hat)
+		return -ENOMEM;

Then execute:

# (echo '^' > /proc/self/attr/smack/current ; date)

to see the failure being correctly handled.

A similar injection in any LSM will demonstrate the behavior.
I hope that we can put this "issue" to bed.

