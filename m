Received: from sonic313-21.consmr.mail.bf2.yahoo.com (sonic313-21.consmr.mail.bf2.yahoo.com [74.6.133.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B281527B4
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974731; cv=none; b=UJVtq7H0YTewVWjLse8v/eBwX+pMlaJxZXurkMk9s3TjPvnfMFBQeRLMUhZgbKZqUOFcK4tDh14FIKuL4ce6raijnZS00/z8364bU9YmdzFh+hWgpWkGI1phqpmpAslMxEJ1DjqArLWy6yhvhh0xpOMyLHrm1SgKlfBmiA3FAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974731; c=relaxed/simple;
	bh=mpKuP/60fthzMR4AAIO+YgVSeX24wvJ3d4yrNqilXUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P47wABio2nyZwqVWF14Cngis7EuvORFLuUyBpdRgnvg9pXY2JQHbEaIQy2dGJk+Hs5YYrqW6CNAnXaSVPme7Rdi8pVscC27/T9WoiDL+l+IoB/y0HWj3P6djAxpmtOHDxtgBQMn+j5CmISRkwAqHBjy6Bhz6hKVHfyIeifTBHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pe8d3iHT; arc=none smtp.client-ip=74.6.133.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pe8d3iHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727974722; bh=oObGFs0O2OPsH2u7olUXU8gtkhXbOtI3ctSV2KQbF8E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pe8d3iHTID98LaNVKEObKFQye+2LHW6dS+39f3I5MSEHHwaHgJET0sG2tHO2xkKumMLEFwBMTHZbEYJrB3sivfVByDgJpyXDIBhjRUXXAL+Y2LxniyiIwluQBY8W98bHGMd2b2uQ11CLx8PbhmFlinYsH6fOGsa0AkZAYKAcl+ja1VCy3nDcMtNo9f4TM6LGRoDJw1XJnd5sygvcRxRWQbIoF1d3NkazxSojBOQFDmN1jTbz1adx1CqojyGjln3I4OIZej5FXTS9m7d51JUOS600Cn5jF3YkN1BYLsr2Wi3A4O7s/S36IbEy9j86hFRP0z1121i6OiIcEWoY0WxKKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727974722; bh=oo9l2PApHEx3JuHtsDW6eZnJhlb3iBuG7lZIpQ+S08T=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FoEeTPiKsFbaYCX4V0zLlnsT0c/RBd0dFZQQl2htT4NQOQf/w/7+eI/GIzb/LS763whRXf1bZdZABnoim/KqAwka/mje1uEFYG15e7BA6+S1Z04LLax2yWVTxG31CFzcY7WeIt04t5+43pLLbBvulExhBwtbbyXcluvg0Yz4zg1oNRGHyQGw9b6p3i7bFX8wAQnkacJqILC5PpZJKQBw/wQO5axlErnvigBa0ng+Mq58tYPqEegvPnbOkUiNGTqGr7wha/Jsfy++OhvV2Uoa1YbdrFRVjX++y8NCGO4sdwwb6DIuupgJL8MOBTc1DrRWOw/gf6TxCbveXAkoaU7tlQ==
X-YMail-OSG: K0oLnHcVM1mJY8xob1kV2DVzOR3.bpVIqQ_p2yw7KoSLHJm65bRvBNAXcpP1ckY
 4UEPvwSWIG1LBSQi0Xo5g_YVVEyJsulVAC62mDqgJFLF9CGsR_AmLZGaQxAkjzVJaL17zfxjsZ9.
 NF_WrjcqkgULp1i0ZJ9dSyG4cl6nwUDrDuQ4tADCnmK1tUN1kP2pC_YoV8g3Dmcv7Vm69MUv1rIZ
 d1t1DRePZo4u3txujU6ZDTRs2tdAEuVSvwJtlKhx6H1Cr7yE_FtnR1KrBJWoUU4Hxe.vMvKZHbDo
 uAr5dgFv_7mlNlCsoHMkhFZM22xvYY6H3kE9P6RV4mkveq5gQ2xMOUoivzthsuMd7oTjMLybLAmg
 yCnWMe0zr0FPYnDL0jWY2W6grRLRhKGBNzKRv5WcshSuOzFULllGtLgKUmtceCnO98GGRM._m1VF
 YAAZww3.yWg4YsKpXvo3t0CU.2N49ZQAGKDxtFInNMCDkHO5PyisSB.bfI22A7JR0nNBsQuY1iWA
 aJn0XOSIziKO5q2aL.jqs5iBJogfhpGPMoFoBU0e22wNjau.Skta7jDG1hAuqLjfMeUz.6dLgkRI
 8zmWWZh5ifnYPBkK0JaN9np9FmCpuv5r6TPXqtqgJqKAX_rSvA0wTZpDSiPBu.bh2.a6jusZfArd
 mOBmEl2x0dhWhLwDb91U1vnjecfs4ixRLkeVbgh.dbjF1GC8_7HoyYU1otJJSw_luJDDpZlh6PI_
 4n6eArXm6DPpvXkcy6kSHm33hmrjUonyOuaH4HZFVwlyvwo.oa8Z3upj8n0h6Wr8ELLy7WSDujUF
 JIfuCfFhV.V_rQ3BwbGeW.TfVmopVrg3xs3e.d8KBguMCAzw9TWvjltXl0xQRSJ3TxYFEt7SqVvk
 iYkWrCMhdB7iWcQ8GnAOd6Z0anq.o.ltKGRPfcvkwrvWSIEgrg_6hsCkO57xVBjYJXW8qiOqCuK4
 h4_2kxNP7iFlQ_NQKKPuQ4R3vNWfcuZQFF73_2YLkgny6mVeH7Z6W6yMkQdt.9Zt2pJFfoBiKbPq
 SRc8jdG7bVqT7u.rAhFAVH5VwcTWjb9XDCxt_S8obkKJ8LMVyB.Sw9jyRUYOIiPy1ecmvVsuJKNQ
 zMJzmHOL5sz6iMw0bCB4Ql9MPh61IfGZevzAoUffVUv8IILJ7F01Hju8MQJdqQjf81lNGBATYCNo
 e8kLjQ7U19qmLace3SmI2Ks0k1AZ6zVmb0Z89_on4z5A0QFTsnbrwIsrMZfFl8EaLXKrVrhKKwEy
 Pc7H7Z7EzZfdVqflFS5okE6eXU_24P5XrIwVe9MpSj2EGAgHVocARyPnusNtLyIpDyV5SKOVVNyw
 S6msSbzS6hOVD4EnkAqnwKdDp.PZWXLxi1yJNT2PHomByb_xJmQSsRa1j_viRd8LM0phATWO3Orj
 6nO_d6gQLXsK.0NP9sDPFZM.jDgrgIYFL_WINkHwvXp8EjV3b6K7pTShGUHyX8daSJDweA09cn9L
 Bm_ScGv.hrNrY1c19O.MpVdhpjNpPuh_0X7AvNRTBepI5RXw1TUKFyEfyzz9eSZ.Zltx3d7ibbiV
 Z6t5Lvcn_MBsdJBOm71ceUhszuXg6i3a.pggkggwbRpyIf2HR2XwdrFaYfMcaZ6r0u2HmyftnRQW
 W.r_W4hk3IoLTMSdNd7sQAg7I13AvsClHtgeH_ShH3UY6RTpeNdayFt41nyUTrwgtrEorlrg80a9
 khsJk74FjSXr3JXnhc9PrrVWXuKaaL0n.ly.Tc9bRzOfKj9Ea8k6FbJRjD3ZwP40luU3TsTzG0Ab
 yS4Ugj5xZtfUK5k3YAjTbUftrPQ7wbEXM.FXn9Nu6AYp6P5IrtK2sC0hqOf_GAXuDJbFKYsc6lWb
 bDtxLLaUyAlsXxyIXPgEuMrbSMQBs6yluzwwmw7D8oUBnhgvOlLT6jVDb5avAOnQKcpAVifkuVFj
 ysQUIw3tInaGofwuPsYFsfXgQBzfVppCfERMYoR6KK2Cm.cUg2o2aU4ub6_1dESFgNrZz24BvlYN
 4YWptIdqZxiExkW8TGHZofW0ut8XgVilJLxX3JJlJYnwWPb5OrmrvvYGZT1fvsyGHyID6om.8AI8
 FLnGv34fOaa1PpIeo7MYU6PV8PcKyGv_lzljGpnOTzEd26RcmXIBDasoJh9tCRRJO8l2W4LJwde0
 x_th9pmZ8idR83zY8.MwkDXOrWI5ntCuZeKH0npszrVfG_.UP7pKTV760PzhhZwPzSj_RZZnPC8y
 L0JW3fN0fgnyFoyMdHcABg8gfCV2BzxvzuJRzM4MccE_k9upuPK1naeFtapqGwqT8nfmHm4g0b4d
 NkSFVYeTFJFjKUJ1UZD_VAYYhZSg0Z60-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e55ea01c-533a-432b-8040-501a31d9e8bd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Thu, 3 Oct 2024 16:58:42 +0000
Received: by hermes--production-gq1-5d95dc458-kk28l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 534774256477d5bbeca725974e5cc766;
          Thu, 03 Oct 2024 16:58:40 +0000 (UTC)
Message-ID: <bf1620ca-916e-466f-b1b3-f3067b1e4924@schaufler-ca.com>
Date: Thu, 3 Oct 2024 09:58:37 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <f0fc9923-c91a-48b2-ae61-30dd7287ecc2@schaufler-ca.com>
 <20241003164211.GA849107@mail.hallyn.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241003164211.GA849107@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/3/2024 9:42 AM, Serge E. Hallyn wrote:
> On Thu, Oct 03, 2024 at 09:36:00AM -0700, Casey Schaufler wrote:
>> On 10/2/2024 1:12 PM, Paul Moore wrote:
>>> Hi all,
>>>
>>> Hopefully by now you've at least seen the TOMOYO v6.12 pull request
>>> thread; if you haven't read it yet, I suggest you do so before reading
>>> the rest of this mail:
>>>
>>> https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp
>>>
>>> Of the three commits in the pull request, the commit which concerns me
>>> the most is 8b985bbfabbe ("tomoyo: allow building as a loadable LSM
>>> module").  The commit worries me as it brings management of the TOMOYO
>>> LSM callbacks into TOMOYO itself, overriding the LSM framework.
>>> Jonathan raises a similar point, although his issue is more focused on
>>> the symbol export approach itself, rather than conceptual issues
>>> relating to the LSM framework.  I will admit there are some high level
>>> similarities to this approach and the BPF LSM, but I believe we can
>>> say that the BPF LSM exception is necessary due to the nature of BPF,
>>> and not something we want to see duplicated outside of that one
>>> special case.
>> We wrangled with the BPF developers over a number of issues,
>> and in the end gave them something that's a lot more dangerous
>> than I'd like. With that in mind I can argue either of:
>>
>> 	Let's not do that again, revert.
> Just checking - do you mean revert this, but not BPF LSM?  :)

That is correct. Not that I wouldn't relish the notion of reverting
both, mind you.

>> 	We need to trust our LSM developers in their own code, keep it.
>>
>> What Tetsuo has implemented is a scheme that's been bouncing around for
>> some time. It is neither especially novel nor elegant. It is intended to
>> solve a particular issue, which is that Redhat distributions don't include
>> TOMOYO. [I should be corrected if that statement is not true] When we
>> talked about loadable modules in the past it was in the context of a
>> general mechanism, which I have always said I don't want to preclude.
>>
>> I seriously doubt that this change would achieve the goal of getting
>> TOMOYO included in Redhat distributions. It seriously increases the
> Right, I think this is the biggest reason to request the revert, unless
> Redhat or fedora tells us that they would actually enable it.

Just so. 

