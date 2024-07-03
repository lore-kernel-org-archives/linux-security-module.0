Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9B13BAFE
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jul 2024 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720050875; cv=none; b=cx9ue16jPX2Vd11l+4vfc2kyGlgmLOQtKZxJmdWD27IHQBUZ77AEMvjGRZZVc25Djr6KgAzMM5Y0NH08SQRkjBJ78OqnESdF9ozcdvoWuwdVMMvdHpA+G3lOHXVmJLVMY17ZgvxnarIEDd9MJ1Kkdp2PsIcst/2HjKmxHE+du90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720050875; c=relaxed/simple;
	bh=7EV9hTxKiuCKuvZ9hxSVpntYmZ4HiO/iGqzAHq3dpAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suXFDwpdFac+EJpUZg3d4ZkPj1ZuMN2W31KvuYrpSSj7pRRuPokB9Tseoz1PBqBJ0GXdntefXyZ2oyHA034gbG6FSkkgfpY6SKQb1vkWFRTPV9AZPuE9QFAL4yMQwykva457fKEGn2oCFBbtYnA1kvijyUaHEAF5KErj9qdwOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qJte1C53; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qJte1C53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720050873; bh=adDgKntC9DihpZmq3KmFrbq4ei7edcR7ZofWxPcJ37I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qJte1C53kqoJg6zlbkk0KTM1Cdino7JkcJ9Wl8OLtc38MTHINPhcrd+/Op3kfZcVL/gzeAO9ptFaehdV8jx7tDeKCE/iipsNc6ht2js0oWoorJRzS/U3+lLKzMHkYqWv7lHr9szYqW64L43oTTLttZotKC7E6WXmua5Tpouuw1nWIf27ZU6/U3P1Mh5+uYGkRrPXMqNop8ku9G+5Bd6llkvG0ioOgWu90OnUEXTd3Hndf5x8GZ4I5DSFJAft4d1SsZ63fo4ob2pbHFSRWJhoKGnC+i9oTnFlthN7ydRDfzHuVAi3u7jtOi/7mI+QdhawO04ibC01fQLYZXEzU8j2Kw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720050873; bh=BxPwcR1D37q1wuXoOA46SRhAKiGjNQp2FniK+yA9hqk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hCT+j90jBcS4l05zQ1HFIXAl94l7k7kn7/zw8/tY9qlRKlSJRCjhSx0AY6TEKF24LgVXFi2nfP1v+PoqcD1/ue2os4gdhREPR5Cg85Ev3Y8DlOX16I084haDah+hqklD7/AwkCGqUM/AlboTTwq/ISEjrguhNAEp5ZDk8Pso3YEeUZXpMsHGvYVQJS3h66WLLoVgC3AVOdy4iHRkAoMzduLClnzdI5KrkvuzYWs2vqa3HvWgQLvIFN7LxFGn8n3y0IEnH4xb4+SrCBRylPOuR4jDFh/o3F2D7FAU00Ok776eTTE9rrr7UGrt9SnDTM8qB9FOt8JxIPvBAP3R9KDTsg==
X-YMail-OSG: AfpdCtQVM1m9sexmjJAHL4pFU975qXx1CfHTyfjytVLIk92FDClDaL3PXVjLtKv
 irOjz.8NmHeMssPbYGsS5.nPwiNzK6cXvg1wia_8J3D_omh19c9nSN6LXOIIw7wdBPvY4nAq7caq
 7rHij3ur_5BUd.SV1cWmsyEhbyYkKhyKM9ZlXGZe30XRmX1plBjash6HZMO8p1xqgDBtUIr6zwM1
 JzSFn9nvOvRn3BgQJui0jha5dTJhWtuEQziFIPgGBGZ79crLQ.tqXYSTNBiolT70QtM8BIIxl4Yl
 haPAxHO9WHKjmFadgaPFZplCYwswFKca9xitk6PiYSt1xzdcP7Mc3M6zYglaFHpTgP9UaXdv73Sp
 1AvW5_CBlvje1ERb1Xa7E.xYwNj7h9RMUAWUlj4ymtSUb6toieVIETNxmLE3ZpUY_GpiH7rkWaFe
 wSh3bBYxD.dzacYb_odctKV1tlf4xhQmEcVCEXFiayCnZblwkD8ghhNpbPah.4ZV1lbORY1L1M3S
 ZGzChaPCMhsrjSsmeEbgyLyGT0oyrkJjtXWhAfOp5Hs0Ns6dSKM9r5ZTvvuAGe9ZY0VG.bT3Ttmh
 O7voac3enoVJJAcrPEEwRBAmbWXyKWK3dpsX3UwioSGd4V.5pdk1gNrKtQ9emBfuvK8f4bV1Hd74
 Kt0JOeKx3gHtguflokKa2_F4_QRnRsL0lzYf9RiAuldlBPqu24UVPFAFwzl..iOFIKY8OoIlNCoY
 UUksSg.n1AE4Uxx8c3lcYiO1W2yN3M0QS5gIA1nUCsyGA3erdwqyjw8mHJkSwefvi_WwDODWZkbX
 s1tKzleInooF.0cuKdJ.IHYqb.jDXvrQvQQPl.p13qqcSiqYbIAPvUuwkEvPDaCO79eJGYD2WXtU
 hpCmTfhl7HQBBTbXbwGkniNObi6z6bqBdi6y06buFiP9CjIvlLA4n9EfRc99KIxd3AuQWckgCQuc
 Al140jymN9uHYu31BM8NP6FZBWGThaM2yKV3T0At.fj5t8BvUtYGNPEvVImGDD96d0Q90YQFjoRh
 WAVFoBeUzWvdoS4zfs4c5giD.9PVA3AlQF78KmeyE6fzhU29VxEFK_kgwyCYZwOcS8vAMzHb0Qcj
 uyFObG9MpjZN01L1AmAzKkMJxdLlEs748eaSWrn1iL1kdQhQHKUoyMB7InuGD41qaeJLos0MSETu
 VpUYzCO1om4JhH5pVHzfXh0WC8cWGkbyjtjompOvhUGmfVBfPC51Ctd05giWcHoJEUArcw_ss3Ci
 Ya4DyO6q0_xQ1reJl6132CKGKT6KNoOUwd.SMycMAc9rwy3TWy3zdxT0_8y_OjjstKWwf3zoCg55
 yD70nTexBVEUaQNV71_I8IqJyGe4BsXUz4kWfzjxfN_iSFpR6Dz1djGxyETCVVx5rghj7aETWoWy
 miOjMSQaXOaqJAzW_kUN4c64epZ9evxv_Ni8_YOc02LmwBiPxm.BRt.nZQrk.cKjnVS8QQzpm27i
 S3Z.TzmYeM.jrZlGOrNrBj335F.AT.kueaO_O6yP8ZrEKOHsCimR0rhKtdrxVhrrCc8nd8YpnNVf
 0zTN66HZK1.AOXrg.gRlXuinAogUHYSu8dizK3ze10IQtI2bTvyOTSZUWVv.0qa.P4lpFAX_ihet
 wLxUf1SPepDICK7T_d15izpvKGh2t3HgXdAv6zJZ7gQ5LPv3HsygxZF.vc1ER.dcCWPAVlB4gvY3
 9keLIwY1CnPhQa27141fv3Up.scMaUzMSfjWyBCyLLl2bFThrvIFsCZRta6kD47qVA5wnX7vhFrZ
 2iUWUKzV9cGRjCyHdI4HKSILqlk_yyLWBdlnvBW0dP1VxNY3kOOSLhBPaleDmkg.FCedj707tT.H
 UlBti9oOHbemIlCLAM4XDOb5A6N3kW8YjWCJ3KGts6km8DDmcVNhmBD5BRLvE.Sfk.14akBpoTNn
 _9tnWXwl6IxIjKEyxQQCZogUpT7UJhQ3eQ..3ZsXT99iOdZTfhKidYSntzaKX844Cyx0.tRMdQml
 X5soO6jIrMDd8I3TaQgl_.3mncQ7JYKaRmhRmE.TNHm0qBetuj7EEfCdycMGcMi4XDvaAif.6hsZ
 nf0SMhe2AoAO2XK9oMggqnB1.Sh4ChnH6HCR4u0xUd1w_k.l_uWvEIt87ovp.tPqbI_RG4aC5rpu
 s5aKa73eO6w26a7CSN.U5y4ZMWCXx.qVGMKvqSKaLOj1opdiNZCApIDkL0dUEbouAYpbn30M97xU
 Xv43Re.ntNBswSYBtQcNjn4Lh2MGEWuCYQ9MlmmbhZGyiI7WoDaa5LSKHXDt.Skd4uB0FiJt1qce
 s0gZYhL8VDnIJ.4k-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f84ab1c2-2481-403b-8cdf-071329563286
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jul 2024 23:54:33 +0000
Received: by hermes--production-gq1-5b4c49485c-4f8db (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 997cb928f0c851f28b372b248085efed;
          Wed, 03 Jul 2024 23:44:21 +0000 (UTC)
Message-ID: <90baed2b-b775-4eb7-9024-c15e65d8aee3@schaufler-ca.com>
Date: Wed, 3 Jul 2024 16:44:19 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, keescook@chromium.org,
 daniel@iogearbox.net, renauld@google.com, revest@chromium.org,
 song@kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240629084331.3807368-4-kpsingh@kernel.org>
 <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/3/2024 4:08 PM, KP Singh wrote:
> On Thu, Jul 4, 2024 at 12:52 AM Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Jul 3, 2024 at 6:22 PM KP Singh <kpsingh@kernel.org> wrote:
>>> On Wed, Jul 3, 2024 at 10:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Jul 3, 2024 at 12:55 PM KP Singh <kpsingh@kernel.org> wrote:
>>>>> On Wed, Jul 3, 2024 at 2:07 AM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
>>>>>>> LSM hooks are currently invoked from a linked list as indirect calls
>>>>>>> which are invoked using retpolines as a mitigation for speculative
>>>>>>> attacks (Branch History / Target injection) and add extra overhead which
>>>>>>> is especially bad in kernel hot paths:
>>>>> [...]
>>>>>
>>>>>> should fix the more obvious problems.  I'd like to know if you are
>>>>>> aware of any others?  If not, the text above should be adjusted and
>>>>>> we should reconsider patch 5/5.  If there are other problems I'd
>>>>>> like to better understand them as there may be an independent
>>>>>> solution for those particular problems.
>>>>> We did have problems with some other hooks but I was unable to dig up
>>>>> specific examples though, it's been a while. More broadly speaking, a
>>>>> default decision is still a decision. Whereas the intent from the BPF
>>>>> LSM is not to make a default decision unless a BPF program is loaded.
>>>>> I am quite worried about the holes this leaves open, subtle bugs
>>>>> (security or crashes) we have not caught yet and PATCH 5/5 engineers away
>>>>>  the problem of the "default decision".
>>>> The inode/xattr problem you originally mentioned wasn't really rooted
>>>> in a "bad" default return value, it was really an issue with how the
>>>> LSM hook was structured due to some legacy design assumptions made
>>>> well before the initial stacking patches were merged.  That should be
>>>> fixed now[1] and given that the inode/xattr set/remove hooks were
>>>> unique in this regard (individual LSMs were responsible for performing
>>>> the capabilities checks) I don't expect this to be a general problem.
>>>>
>>>> There were also some issues caused by the fact that we were defining
>>>> the default return value in multiple places and these values had gone
>>>> out of sync in a number of hooks.  We've also fixed this problem by
>>>> only defining the default return value once for each hook, solving all
>>>> of those problems.
>>> I don't see how this solves problems or prevents any future problems
>>> with side-effects. I have always been uncomfortable with an extraneous
>>> function being called with a side effect ever since we merged BPF LSM
>>> with default callback. We have found one bug due to this, not all the
>>> bugs.
>> You've got to give me something more concrete than that.  If you can't
>> provide any concrete examples, start with providing a basic concept
>> with far more detail than just "side-effects".
>>
>>>> I'm not aware of any other existing problems relating to the LSM hook
>>>> default values, if there are any, we need to fix them independent of
>>>> this patchset.  The LSM framework should function properly if the
>>>> "default" values are used.
>>> Patch 5 eliminates the possibilities of errors and subtle bugs all
>>> together. The problem with subtle bugs is, well, they are subtle, if
>>> you and I knew of the bugs, we would fix all of them, but we don't. I
>>> really feel we ought to eliminate the class of issues and not just
>>> whack-a-mole when we see the bugs.
>> Here's the thing, I don't really like patch 5/5.  To be honest, I
>> don't really like a lot of this patchset.  From my perspective, the
>> complexity of the code is likely going to mean more maintenance
>> headaches down the road, but Linus hath spoken so we're doing this
>> (although "this" is still a bit undefined as far as I'm concerned).
>> If you want me to merge patch 5/5 you've got to give me something real
>> and convincing that can't be fixed by any other means.  My current
>> opinion is that you're trying to use a previously fixed bug to scare
>> and/or coerce the merging of some changes I don't really want to
>> merge.  If you want me to take patch 5/5, you've got to give me a
>> reason that is far more compelling that what you've written thus far.
> Paul, I am not scaring you, I am providing a solution that saves us
> from headaches with side-effects and bugs in the future. It's safer by
> design.
>
> You say you have not reviewed it carefully, but you did ask me to move
> the function from the BPF LSM layer to an LSM API, and we had a bunch
> of discussion around naming in the subsequent revisions.
>
> https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore.com/
>
> My reasons are:
>
> 1. It's safer, no side effects, guaranteed to be not buggy. Neither
> you, nor me, can guarantee that a default value will be safe in the
> LSM layer. I request others (Casey, Kees) for their opinion here too.
> 2. Performance, no extra function call.

I want to be very careful about the comments I make on this patch set.
I can't say that I trust any fix for the BPF LSM layer. My natural
inclination is to isolate the fix to the area that has the problem,
that is, BPF. I have a hard time accepting the notion that the implementation
will really fix all possible bugs in the future. The pace at which eBPF
is evolving gives me the heebee geebees when I think of it as a mechanism
for implementing security modules.

My biggest concern is that we may be trying too hard for perfection.
I see a situation where we're not moving forward because there are two
reasonable solutions and rather than running with either we're desperately
looking for a compelling reason to pick one over the other.

>
> If you still don't like it, it's your call, I would still like to keep
> most of the logic local to the BPF LSM as proposed in
> https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore.com/
>
> - KP
>
>> --
>> paul-moore.com
