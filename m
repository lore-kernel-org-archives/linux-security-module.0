Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA028A702
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635085; cv=none; b=WrfwHQp1OMmQ8GbRXVzkuDbdeegKedVwufCUCPAD6V+hmRWd7IOzTOfdETaGDP38V29b8UQjmcvsBr3+dyRrIIWqGUPk1ZW/rqq5Y+E2CB2y8VwYWNUDIIGf3HXIYgtxDMWNlDeO97JhaB5I41/D3P9Jau0gATUYba9c0rXUvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635085; c=relaxed/simple;
	bh=5Lsigs+Yxul/cGMbXyyD3AwvuR1nhOpZkLYWWhXKRP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pT0p68UgmMNhmu/6z8OKg6mLrtPLAa6izu/wc0nENKWG8/AsLlPUr3nlIHKk23GvcwEzgutRXL8eFv2iP/JEcAhLjzxE9X7pm5EuLYZaV+nWq0qWkDozCAVHN2wnRT3ndpvh23ipSbTtyimZQa3U5rayF0rxTBQLnM7TfQbks5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SRBycfxL; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SRBycfxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746635074; bh=YwR2zTcCrOx9+ca74S9+pcvO6uuFrkzft1zm7AcdSkU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SRBycfxLf+nSFePa1i3AghIzJw2SwIlgDZbbPylzP3bjSsEDZ2FKqDjCPZYAXRHsfe4BCxFukVUDfSbTB1uhRjTpcx8lPQinvgYirNqRCkPSg+j8t+9HslKlFJNXClHAwZ2XK9DqcgODvWQIXuMXEHbCI/u9zlAXOmFTH18PnKhXs0slnblcPrwFmYGfR4r9jJrA/apFyh0aGC8NCsGgeJSFEvUVNUS10lPXWAszpMxaaLKLnVCpbxPzP2UDXzCDD/9uc35nGg9xfzsP5V6pxVnv9EiKFW/1Lx5/pZAwrd5AdOQ3K20swekL5kzrnpe5cJvHhvD0X1o8PCqqLsLTWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746635074; bh=/Y0pnNJQWKWKgbENQEqYz1T0wbRNmbZEcEn2gRmd1M+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=M8HJhYqNoafXGg8XNXaqFJfw2ib4Iae0HttTjQvbBeEEX7iKB6Pw1CyAcaRnJbo+SO2JFf0xpJXME95HMSL6Z9jaewDLuFPD7xPoSO3jZsydwA6NuuDo1RW8haP/L/G8kyzZwqEiATtzIRg5gSOJs7Mxxyxt8FbfqaSOh3zFsbO4yd0nxujIYpWxnqHSlGSkuctuorHGXuZwCtAjA0R31c8BNyDJkFAW8wAdpv/tKfbM1vFPBMmfMxaJ/iPdnTpNtTOtIJGekN1qfm38gdm97UFBuYCpm2cm/1VUO3QXTmwtWyXXS76ZS7WHPfYIP1cH2Hura4oXvs+JPq8oiHcnww==
X-YMail-OSG: .iF9B8kVM1m_Rw5jyuOn8L6Rl3LUhFOZvIw31wtq4KQ2ngPminb3zalCE1gwi4a
 gvDY1shjcYIjuRqA0.HrGdhP0KQXdrJupvDzQzFork1yT48B7G2arhqBtXBYOeceqCXfFokg_x9m
 aTKhAsJ9orSYL0bp2w0OOqj3pj6RdHmp5K1Iz7scQ9en99hzP0j6qwJsPxIf9ZXddsswWt4Hfn21
 5nl5S3SxrBDIIZhc1bZoPcTL3twe2VPrmYSWb2Mb40cHeU1lzZ3e2FFt2HdSJDMN_nTUTGLBWW2M
 qIU8OG7ZVZE_va0z9A9QQCiHn4LJe8a8zgNp7hCqo4EJ.FZC.jf56wNUI6LW7bv8SFbJfm2fvBda
 j_tgQQqE_ADFFNGLcjA6KwaiP8WVTCZ2dW8RscJ4mBfp2hhHJwM_SqPM__5HMOX.ofxkE52NRGuP
 MPCi5BeOL4ig5Ax1ThPxe2kPKHKOtdkJ54mW1fwcGZwglPaVWWpHvhbh8mJK4H4JeEOrchYg7Np0
 oKqIdlO6KEn9s7yj6ag5g9wDdSmE01YiHn4bXHQtSlVN0cCSYcRsenYRsKOgHmqFXbiS3ZtMcb01
 IABea_SdW.0m8qLFNoqiBajGNRPmhPbARQOJOasJWhJ.cxfVvASZib3XpQtzuXd3UA76b5_oXFyi
 o9aIjnr9ZkAnpz3vuSQfJPfHwLe3B_I6m72E2bG_ffV0JNNDT4sjgbcB5tG.k7Oajg2qzR7EPqoa
 dCr6NjVoosg1lIGzNtssT4IQBN7uM2snf.2g9CjP2u4dhZo7G08lWPV36_SZFFC7BcGZskWyNXch
 7gzPgEKy9GrmsYcThpIATbi2b_7fBVZ7.O0u2BxP.jUQxAIQC3XO9FBPlIGz_tqsBzSWdBJTG_ZA
 GYx8psAXvbQecsIcc2Pg4hM58qVFvz5WBDz2MZfvYSWSzQ86amWdbUv4FgaEMJoWOMffrpr2pa3v
 HLh3Idnmn8Kcd.MCDLgVAe7VLI8uIhlcUampaJEDzmGwroXbeFxWZUu3yFsV0lFCD4ijsND7VxDg
 uZZ9Yg1DPPxC8I.1m7BbSrUhgV3Z4kmeb_bc6ee4.eFLOf68Z5g75i.YAYPYTOTxo3al1mjnKjVA
 9Wkp6dOlrmDbxKhzytyu_tmt5Pfm16gG8RtD5n5oi6dZIewYisgjCQgFpEIiZB9xLw27PwSEVJ7Y
 fSFNMG_Ja5kTsefa9G15aPtM8A7gNvcITl6.xF1vYULIEU8xRK6RNLwfnIdiy6we.EOy2S5ploHJ
 8qNSZBoMGGa4vbVFyeEftj03Ztrz5ZqsOWgG_QQPkuskpl_kCfAxBHIDvmXvqykivCUGgUs_fPKu
 HtKZP0J8LBS89rkoj5Svv4xsLtDZpm6loHL9UeHf2EPCpKpmyFMIfzp1eNQslPCvaZRXguM6pyLf
 YDfbXjUTiqvdGqIhs_vnCwpq_zyV54kb6teLL7gZTKyyL2h20ntzDLw9ueh4m6dEY9Puo5Idsxlo
 9Rbo6cAYMJjxfitPiPIElV6UG4a_D4OAca5K.9zdol_z16o3AA1a64rqrhkYVFsbW0.c8DMsTmTV
 KZb8N7Jp4x1NJ3xfOEeEpSHPzPapN3LOYN_OZ4SIG0xvob9Nx7eJy9WhN8ToIZObScmFRvmWuNQx
 DjulH1koPVSZr6QjmgCPhe9jxBvky7P7tV7WtUnt5avurJlypUBU2ixoVcuHDt0LUDEh7LPkAivb
 rADjBM.EXxSSZBaW8gHgpidzNjymTjdWQ729eAgiIfwm6w3u1TecHCJBl9ol6CBwFucM12SJ2eeq
 eGPE.EjkqcMMcMQvW.WN5NtAlQ_PWKHo2cvdX2NxxRvSirk5CJMa2tgwYFF87MS4l8b7bujvwnrs
 36iS8.CJ4dkltUPjgjmHEJQ5Cl0zIIib5CrAJJrJ14Bba.TQO0Gyx8Pe370E9vV43M5ALdxTFeK1
 1_ekSF_WSfVL4rcAyZ6Gl9DgBIV22tcMNhg2U4u75GAPjISCRSgFf_lYhcsXQ4__GJoVjOeWVkSs
 1ehHLSafMFli1MDXTVijDOpLRHfF.YKoqN1IrtQwLepAm.WDuCLRSK.Nrm04Sksa1VPSo5cVXpoq
 BLkf1s06aLMvmUlVnbNvOUTT30u2d0hR9Jq4dzdS7wMSscFs.FFZ9fYgbAbh_vR7SQwCSR2RzNS9
 rG8KL9JGuV16gWQ1U3kvnziBBeVahcgvOa5V2olKCdjg3GrduyxxNafuH4zecMmY.MmnlE7oeut4
 irkCp2NVzkSBPlx_SPXucts2Hv2tWaWJB0DM90djBAPUMJXjA6FwRFS.RPYyFJ0BUWKwoSpmNn1I
 aH046olV7mN7ZtexN_id1azrPgYg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aeb06a10-172b-47b2-9aaa-9edd2da40a89
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 16:24:34 +0000
Received: by hermes--production-gq1-74d64bb7d7-4ndhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1458115eff23de3fadc617fe2c4888a1;
          Wed, 07 May 2025 16:24:31 +0000 (UTC)
Message-ID: <39ad6f58-db30-4c3c-a3d1-f0af516025e3@schaufler-ca.com>
Date: Wed, 7 May 2025 09:24:30 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] LSM deprecation / removal policies
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
 <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
 <a6d26d37-3475-4f3f-829f-0883dbf8014d@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <a6d26d37-3475-4f3f-829f-0883dbf8014d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/7/2025 4:06 AM, Tetsuo Handa wrote:
> On 2025/05/06 6:53, Song Liu wrote:
>> On Sat, May 3, 2025 at 4:47 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> On 2025/05/03 5:01, Paul Moore wrote:
>>>> ## Removing LSM Hooks
>>>>
>>>> If a LSM hook is no longer used by any in-kernel LSMs, there is no ongoing work
>>>> in progress involving the hook, and no expectation of future work that will use
>>>> the hook, the LSM community may consider removal of the LSM hook.  The decision
>>>> to ultimately remove the LSM hook should balance ongoing maintenance and
>>>> performance concerns with the social challenges of reintroducing the hook if
>>>> it is needed at a later date.
>>> What about BPF-based LSM users? Since BPF-based LSMs cannot be in-kernel LSMs,
>>> it will be difficult for users of BPF-based LSMs to respond (that someone wants
>>> some to-be-removed LSM hook) when removal of an LSM hook is proposed.
>> If a LSM hook is important for an out-of-tree BPF LSM solution, the owner can
>> add a BPF selftest for this specific hook. This does not guarantee the hook will
>> stay, but it can most likely detect unintentional removal of LSM hooks.
>>
> The problem is that the owner out-of-tree BPF LSM solution cannot join the
> discussion about LSM hooks being modified/removed. That is, out-of-tree BPF
> LSMs will be forced to stay as unstable as out-of-tree non-BPF LSMs.

The same issue applies to out-of-tree filesystems and device drivers.
There's no problem that is new or unique to the LSM interface here.

> On 2025/05/06 5:58, Paul Moore wrote:
>> On Sat, May 3, 2025 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> That's dangerously close to suggesting that the LSM hook list is an external API.
>>> It would be really inconvenient if hooks could never change or go away.
>> Unfortunately, this is one of the challenges that out-of-tree LSMs are
>> going to face.  As Casey already mentioned, LSM hooks are not part of
>> the kernel's userspace API and thus not part of the "don't break
>> userspace" edict.
> Due to the difficulty of making non-BPF LSMs in-tree due to the "patent examination"
> ( https://lkml.kernel.org/r/5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp ),
> I don't think it is fair to assert
>
>   LSM hooks are not part of the kernel's userspace API and thus not part of
>   the "don't break userspace" edict
>
> without granting all (I mean, both in-tree and out-of-tree, and both BPF-based
> and non BPF-based) LSM users the right to join the discussion and comment on
> LSM hook changes.

I don't think that anyone with a legitimate concern regarding a change to
the LSM interface is going to be precluded from joining in the discussion.
That doesn't mean that someone protesting that the change breaks out-of-tree
code is going to prevent the change from being made, but if there is a real
issue that affects all users of the interface we'll want to hear about it.
The problem remains: if we can't see why there's an issue we can't respond
to the issue.

