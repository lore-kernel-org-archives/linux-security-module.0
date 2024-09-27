Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5693FB9F
	for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454815; cv=none; b=TT7Ckvddg0gBuedSDNPPMESgfqSpCqN3h0JAwAJi1mMTkFtwLdgeC7aw7XCqhOUnHQ2yvLYXogWiGvTHVc8H35wzmTTq+DLJMZg/7qKvwtVQBMAKXLGus8ViOGH7qyC+qAmeb3pbzbHTXrVOvnO2KT8uMWt1KUt3Wh1pRIWR0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454815; c=relaxed/simple;
	bh=SWFLHH/ul+pauNxYwOP1g3lqMYMxjOfCzCkI41JYL3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CavzDxTX++yBhiW849zZt+8X5KbrVgrfeW3cpKzEVNf4J4T0+wcyZ4oM+1fX57NJIX3EO5ihKL4qZlvk3SCYLR+4ImOruzMN57yjOC24DZWVv5awBrBu/9EcPkZB8fY98jgEXN+DEX+oE1G3ROyP0SG6N04NTiY9ZL8EtNX3pPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hSDJo29m; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hSDJo29m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727454806; bh=z2AJDwzAjJtzt7XFEaEnXcCmlx+h8JJPGgIhzn2PUUI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hSDJo29mRqdYuWXH+YI5Z1v/Iz7dve7mPncyolmZ/+6c6thwDSr4hme1BTz6jyzI8QsAZ+i+XZEWW1K8ddoK0W/Ptmb5FTUfFP3mz0XuvVDGGEso5ec7ED7igQUZnwVmaWxCZXF/1HWx32MhyFHlkuiJZ4iaOAgUFuMqkGrDBs3RRdciX2QFYan1RmWnJxV79/8eAor9TejulLUITZGLZU13c6OtqE6WMYfXNJqg+OU68P2n+KVggJ9IMn/JkrOCHo+DkEA2yKhEm1ntio+NJ6MNyQcJDtLMLbw0SCGk/pOrKAGtaBsNG0kaT4ZFI97o6RDAvETOnTZLghbiU+8WSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727454806; bh=Xo8RyCJ8x0WAZdoRI9bPvAzJ69wSWm6VaBraRnD4c8z=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Qby+C3FiTBUuVacpRaqigs9NhKG8HuDqioLeooEunHQq/Q9Wukwkbux1e04+1wu0kTwiHrn30TdUr+ZrxmPw7ql0B+J1E7PK4IAQYQVn4wei/bnDAN71W9WJTMlkheI/zjl+qjmo2YP2V8wMwoMZf3TuYlSLin0HUhECieGxeGsouvmYrO3jkch1DnVYBLTdBP6XxJOeIcMHFq9tOZ5I7/BbsiETNVlNmLQ4nnSMjgN12+93qxqcIrZ165edms9x/39wzZLDHZFdm7fWFv/Wepkz+pY8TQZw0g8G3QV3Jv2b37UjN6zvsPvUzMyBzTZ83cOVRVtvf1rtjc1I8rVl/A==
X-YMail-OSG: zk1o8j8VM1niKGsmp0irk7VFig05OElzgvmMAhUzB0vTEuQ4VZVbFBAl2ytPJuE
 1pF8MU0pNMzgnGJJryknWluFXyQjiwj61KmPHDjgECcEng2n4piPLgLxMTtbRt_kLU8pbhorIEp7
 1CeDZjbnSQingEqBfumA_c_NdMQV5aZx_.vtdwFw0AU5WYRfHu9dP8KPG9.FuilX0EXhzCow5i8h
 f.3P.zFKhfIekGFwr9tOaSkB0QfbKWM7E18KmDyuwcZ3nvLCqJzvzNTKQKHyEuqZZViVMKcUEwJp
 BuU9yMZ8duTHft9vRMpP6Rs3dykRtEae5LpdrCGN4NSpS6.3cc6wy75XoxN8qXdElsdcvDh61vS9
 mHwPV48AyIB9F8M0A4S6F.geZdLOtXxCTh1ASo.oE6ZpYvXcCc6lgAR.ImXoa9xSwpFEcl1Ovtz.
 AskrZRqmYHHICxUCEUNwFYzNiDhn3_swFQ_p5U3AEMNATVqywQHyRjK2OpBB9Gl2WSimiVodChf4
 O1DVoYRmBLmIfV4VCwzI4WhaWKv.mJxbk6GiOuCKdw805Xp1mAJjUdVNp5K9d4sNsiWfvchPIIMd
 ilA_UClGG6obJTZyoT6Aop1gND_9Hh5e2NJh4gMc0WsiGrF7tcE8iTU2kvEFuc9Vz0LgZY9iOOJb
 uo7mEFdleaDNsj4Q7y0NXo8vbALPdDTYOJ5IDVVgm0ndXATxuJbIIWrUr2wIf.tSwo8aR9ca2nuQ
 8hL1tXtmH2RD9T5hqQvT6HjihoQhPp0iJ7Ntrmy4YuiaPjINdaUXxxGyun5gONHT.cBqZjXvzSge
 DHO_wetrA7R9m1yyNJIpxtIiw6zrt4m2mJvqOwK7tiB31fhQVLTwPToB9tJsmxQhBGAlgx9QdNiY
 QLxRP9qy2wrbMMs_oS3UAXigg2gG1djb0juIqhJdHMwCz0.PgHnsycryjBHdkcO_wkCi9NA.x0nT
 fs19ZtrjT6zVmGrbede9Iv2lUgFwiKBsqlFfBeE2w1jjDCg2SwH3mgUGyuNvcJskmQhQ7eQu1fyN
 dCmJzdUyDnhExkJWIRi6eakuBpHk5wttYDt3kemz0kagDGsxGPJgMexJDLhQd8PiJ9G2.vs8zZGD
 rwDiZ9mTbl2tHm8_fn2ohTq65osYWPaXRBSfDUS6qyMD3WfgCGI5MRLe7lXpmFGTnA5YpU.OB8Y7
 Y39l90hYUD91Mz5AxpnFFAuW331flEFb5nZ9Fufzi6HEpxBmEQ2LQR4rrGbY7R5J7bwVMS0lkDGx
 rOGeuRYbxJ51wQtRflQZDL6So5YPNuQ2ABiB8QSg9Bt97Y9DkMCUtf8c5mHBGLlIMhCYhOZnMfwz
 SlG9l8UdukZ3Raz93FDNZw4.futLXf2XDcfedAVOxTWwkdhBW.ph.wOsf5vS_frWj2MbZ9okddHL
 dNG62_NCVhZop6hFP.PrF...OAFi0NABtf_zQn3bBm3NdWjWUyPkepjgm8izdPDHfHe_DGl6PwWF
 .uHjSmCn7A9.y0YV3Y5tH_9RzN.aZP6vVuZmIUkgY5U_c_V68Dl5pMVOFpUkJ2pWWhn0VBsJkskO
 vtkAsNrnEmfwFwPwGBvUSiM07QPLBSuLF4ywzbwvth.p09UcTuU4NsGuTpOjI423i1n6goI2GTu1
 AEGfuWZGfvnCna4co3eshf.sCinRb5ZBPgVN2tCpbRDhVCwOGXjmU11qsy1VahehabKYrkAIlIIf
 hls7Vuh7XPvYQ2sO7LKsyiVSZ7ayCn2u7VxSBryFtrJLMeqGOgrQA10xTCMyJnwqpQ1bEs7VC07j
 wS5zv08UXQ8YXiAYsJl8QjV9VSDxi2..MJo3U5SmTrDpZG25LEmyNaYP2CyJ_bDJDvb2KXxbUACm
 jFAoS5E5EXiWCgpA8siH8FHpiipgyk3egOx2suG1bFp0g__J6GBLYzgHTz.6HjT_ks4YB3WL6PPj
 de6LbN2iDIZ2s_8embI2hROyXDWfJjvihyafBqwGiAEGuH1b1wKKxncEdJSwAGIWXHbu7p6cMh1s
 8NGatyRZW0v0PeBLE9a0cI4V90fvG7dYUyJWfiryVWiY_SoJ820kRvi0c1nbc46WlXjp3Guadpt_
 QS8jrGp7pjD7eKbPDSsksvuTq1tH0P9Kk8aP2VOncAGUQDIF5BvpaKtCmMC_x.ipaTz0wapQ9JH6
 SCcCS5FZzvSepUKf01jo4HPeUXaKvRNPI9hg.qVwH0OmQ21AGuMvOzvVa_8RnJcT6bcIXAyeLYEi
 jOBIf_tvB4XLFzeBIv6kyPYMRY7XExQJlZdiK9TGGR6HV.BDhzNkF2trxWNITXT5ZoSd.B3bL8tf
 4KXPQqe8iLbPUhaLiZhzpZA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 109a29c0-f967-48ff-80da-19498694990b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 27 Sep 2024 16:33:26 +0000
Received: by hermes--production-gq1-5d95dc458-c8wt4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b665e0308d1077cd74986e7b144609cd;
          Fri, 27 Sep 2024 16:33:21 +0000 (UTC)
Message-ID: <2ea23569-6fb2-4a4e-acc1-e3927dd5615d@schaufler-ca.com>
Date: Fri, 27 Sep 2024 09:33:19 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
 <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
 <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
 <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com>
 <20240927085841.GA3642@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240927085841.GA3642@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/27/2024 1:58 AM, Dr. Greg wrote:
> On Mon, Sep 16, 2024 at 04:08:11AM -0400, Paul Moore wrote:
>
> Good morning, I hope the end of the week is going well for everyone.
>
>> On Sun, Sep 15, 2024 at 8:38???PM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> On 2024/09/14 0:28, Paul Moore wrote:
>>>> I find it somewhat amusing that you are complaining about the LSM
>>>> framework not accepting new LSMs in the same pull request where we are
>>>> adding a new LSM (IPE).  As a reminder, we have documented guidelines
>>>> regarding the addition of new LSMs:
>>>>
>>>> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>>> (...snipped...)
>>>> While I have no intention to negatively impact out-of-tree LSMs,
>>> What I call "patent examination" is "New LSM Guidelines" section within
>>> that link. That section includes "here are a list of requirements for
>>> new LSM submissions:" and "The new LSM must be sufficiently unique", and
>>> out-of-tree LSMs which cannot satisfy it won't be able to become in-tree.
>>> If we apply this requirement to userspace program, this requirement means
>>> you are declaring that "postfix" (or anything except "sendmail") cannot
>>> become in-tree because "sendmail" is already in-tree. This is a clear
>>> intention of negatively impact out-of-tree LSMs. People have the right to
>>> use whatever subsets/alternatives. Even if a new LSM has were completely a
>>> subset of existing in-tree LSMs, people have the right to use such LSM.
>> Comparing userspace applications to kernel code isn't a fair
>> comparison as a userspace application can generally be added without
>> impacting the other applications on the system.
> Tetsuo's comparison may be a bit strained, but it remains relevant.
>
> Linux was founded on a concept of choice, the current LSM architecture
> struggles with the ability to facilitate generalized choice and
> flexibility.
>
>>> While I consider that some of out-of-tree LSMs being unable to
>>> become in-tree is inevitable, the requirement that any LSM has to
>>> be built-in is a barrier for LSMs which cannot be built-in.
>> Anyone is always free to build their own kernel with whatever code
>> changes they like, this is the beauty of the kernel source being
>> available and licensed as Open Source.  You are free to build a
>> kernel with whatever LSM you like included and enabled.  You have
>> been shown examples on how to do this in previous threads.
>>> People have the right to install whatever userspace software /
>>> kernel modules they need.
>> Anyone is free to build their own kernel with whatever LSMs they want,
>> either in-tree or out-of-tree; the static call changes do not prevent
>> that.
> This line of reasoning represents a bit of an indulgence in a false
> binary logic fallacy.
>
> Anyone reading this forum is certainly capable of building a kernel in
> any configuration they want to.  That being said, the general Linux
> technical community now represents a cohort far larger than
> individuals who have the ability to build and platform a kernel of
> their choosing.
>
> From a security perspective, Linux will benefit from providing a
> better means to serve a middle ground where alternate security models
> and architectures can be implemented without building a kernel from
> scratch.

Ye Gads. One can create SELinux policy to support just about any security
model you can think of, although I was the first to decry its complexity.
Smack access rules can be configured to support a wide variety of models,
including Bell & LaPadula, Biba and rings of trust. AppArmor is very useful
for targeted application security model enforcement. And then there's BPF.

It seems to me that the problem isn't with the facilities provided to support
the implementation of new security models, it is with the definition of those
security modules. Or rather, the lack thereof. The ancient Bell & LaPadula
sensitivity model can be implemented using Smack rules because it is
sufficiently well defined. If the end user can define their policy as clearly
as B&P does, its a slam dunk for any of the aforementioned LSMs.

