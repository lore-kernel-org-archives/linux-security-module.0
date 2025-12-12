Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1130E0CB
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765583005; cv=none; b=ghNLfXjTC17zivfLz0S7OVC8ld8iWtRBYOMH1NRO9UM4DGFgNmgay+EhMQ7HNs5Uw426+RZz/WTMdvI+EB6ffXhb4OUj9NOvU/C3K7d1cbX40WEnTH7R6ndsQICQpJnbYtyssPHk3yf8TGSXe6JfiknbM1+NFndvwSdjdd9tPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765583005; c=relaxed/simple;
	bh=YVlNVYce8ivaSnlZ53aibc+/4Dyxkk/jh3yPxJCOeVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTsAHdH4dN7EZgh60YLEIAOS4nS/wgaEBv6T2l4OsjxL4uVprdkZZESFUogpDFb9FPzmOSTSgUgqQf00qbnyTW1YFKvWWTFl+YyqRxRpCip1PVK2Nfn4ECepAM9u61r5TUUzm8s6zfTLxXfiSQDtQvDdM/3b/R9WArkiPV9teR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Iaj63wuE; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Iaj63wuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765582995; bh=JnpvvirOSE/zstAZ+j/3clV16UCyBzsttGrHbkpwHK8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Iaj63wuEBvIYBLJ7A+PePrBH0dkDQDR+oQnq1jp6z++BOz1CQ4/xpMk+smes4CqXy0bhY1ldA6HjGtS4ROgvlTJ2lvZ26p0a6gXOgjoIrur6phywEzQrzMi/MX1kFSWURj/pghPx5/k3yxDHdCHnlXHbj99XJq1uBm4dVotBmd0lzs1LVUrb322ypGH+dnaw3yTlggZESpjfvwrcRdHrMzs5ECSxhYFlikQZfC5CN0HiHGv6RSEE2V7gfnR0LS8ublYwTNQzMpWawc4UGJrOjcdeExTT/4DTMnbgfHzG8F2Qugvm0mRUwkK6diecn8hdjQO6k/NJaFLT71DXzDVIyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765582995; bh=cR72xUR9LeRQw674bvDLxFQY6tfAfW0XZBwKkiFEgZd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SfybudGdAcm9h1WFy7hna4tFyUBfflxTARWnQIHvSolVKoxQBsNFqAH9lZ/Bw1nL9+AS9zyXyxCiZ50FqeRW/bsJFQOpqRDH//8MUSIKVQbp8OAw4pmgXPraNMTMgnf1tPD3qG4gjKS89h15wiXy8Xeon1XhTEGVZgXaSPzXWpmmEDyPI7r7wm9kk1rOe9meMCwnZPYPf7qEIQPMHJdBn4SIMO+LXxL+Qyyv0GcF3AMXV8VfY8RWOQG5i5/36fg1fPLy2LF40DJjCmHT3e8ivDq+iLRHrTo8p1KLvpEgiSTLjEKJxlgs33D8ORhcZfgqZ+MpVqZZaFxg4hr4eyVStQ==
X-YMail-OSG: QBeIFMQVM1lIxtUb2PD0vD9LdREGqW_e2kQ3bCm9Irf9s_9fHftV6cmPDtOV7Tu
 rNTo.DUnZJ6j7h7VrnMybKZnviPuU.OJ.wAGKNifAJ2VztaAcrFXByD8l6Q8p5tRyZdkmGkb5NBZ
 m.AdN1jbE4_jl2Hmzs2_OPX4XZ2u_1rr8zRvzmIGpVDvnlIgySEY0yVso9dnFXdSkvCzFOXV0jjw
 ylVYsWwmTwRL34kF4p8zfaEJbbRzdJhL.A.SO6YZSPX5FL3bZav.gV6ymFdTnEU3G5qCKjuFl94Z
 s2grt8LG._7Ik_jzb3iX4pvaWCo1CCNKSxJgOGe4bcOFtORNB1rmyKEewxozdlQdMkioNqGFPbh9
 3oShwmvRdx.nMUNdiCvtlSm00.fQEebji02Ral2QQ0FALew4bTiNVLYMEgb2otbRSiUiVSNhlzoV
 g3nQGWBChKAAub7tWvjfEdfu_veDq6P7w3moZfL7sjWAcMYYnqj0RfI4EW4WqX.UsE44hgJUKudp
 vbshqb_DKOC8sXEfgxrnllvnhC7Qlp6YeJevSE77tKWsophy_.2CctvOOd5lRINPMR5n_KruCynR
 k7GUuiICgMPt5T0HpybYfUx4DmBseZzAdV82GfdhryffQxOxZX.._3tfsT8.BKqLv4r00avvE85e
 mGCyXYsrr6Rjz.jnzMxFqAXPhuA2rqwHFxp0piy0_Piol4bfaF2spo2eKJElYAcNytZEtxysx9_i
 e4x5I7axg.ZOK3fcXXx6HBxT5zNs0TSVY97e4b3_LiaE26Sh4QqzFLW..HG3510l9ebZ0b1HRyt6
 TM640wrCkD9bN65VjBMJdptjiXoJ7gGKYaBVfQludnffcQ1oLx7DU2BcwpVb_i3dVegH83u0dIYU
 fFWZmDFBkDNCufExqmwhASnTywORNIUiti0AYIEfcW8dueHvYOsBV4Cw6.gsFAh5HTm.mi15ob3l
 PMqbj4oounCUanh4DXrfV2pxNMHuWau_h5GFu2xdBzO03y.JZ4mVLphDj1zgGM56OpOPLA8A35Dp
 3jB0NII0k_2SFagkJdztwHT..WPt_RzjYaZFtCUqBB2XZb0cLjywDBC2nWNWzadb8XyHmHOAwWSn
 KMY_VNezQp.2uRSt37wNgQdt.6w3MMiW6_BAvxfhNTMnSN9HBohBMMFimyfBENoarkxiTDJ6sWAG
 yD2BCGbmd7I_qG1zY.5gTae_EBwYSuFG6WfDJa0mHt.EpN8bL7T.laUw1RWMh0_8cjL_yCsu1DHR
 hOKbngXUJv4p9REeBc32OAJp28dRR5bO1SdUcLbQbYrNP4NCwfPTY92iyb_0AJYn8oPDCEr8ElgN
 vvZOo6OpaVkZ.ECel7J_9j_IZfO7xoPxeWLN0Pn2k09FFljnK0GzRMGhz4iR5XTr6J7b9ZPgPMBy
 I2d9qkorDS5UQNBPsOKc8p8QLDdHaP.8adUrVgpvSHz6d2.1rC80GJjDZZpQvZOyPSfuUqUbjxM4
 wY03wwgUux7DSPRAs.gPfWlaXMlPIcTLCEfIIV7U_WhekPer1hjOOYCanKL.xo0EYEcMcUKA79rd
 iKnq6QvXFgUjXDQNkGpGhY8j13DckH.CG5PdaRXtlXkSxghrjdDsfSBV4t0LFuM5ypH7txdzvXWB
 .oILq9alC8xc7uARHpldo3CnNklF2aTQdJcj.K..zveeH4F9qlIrJfuIQYN9xvmK1lGsvY2Kd7sn
 dgLadWseyOoEqtNgmTiJMxitixu5CdRPsw5k4Vo3ooV19a4H4pD1j2DGE1oBhARN2fezT2mkgzDU
 yw1w3gStVPbFPsUxUZk6Pm743FACukUYGT6vzmy9gG7Sg4O6q4pJx6wJaPdEBaL2VR64jIpQBQYj
 W7pK9TZs4qrifcoS54WdxjFy.qopB3HQl05qHT7dBZ8eu3CxMYETLcfm7CdLuG8QeWMF89j_G85J
 tMjIwPwNOFzVillARTVfzym62Q07kN0qOfJMfLnADxmSrp6qpIBMbxEFXIGI8.4.9vwnstF6G7cK
 Asrjj6TuQXZcth.2WWKMTZssX7NuWmS7EhDKPWKDiNDswm4YhFvO5Wgm46eQa4WW0jBgmZFZRaan
 tVLOTj84di3bwBRJpRyBZJjLxEOx2oPldaUDN8Xzq3VAV9ymXlJiEtt0xVe33QlVes72HIlTm5sX
 QP5Y5Ec0ZdEQdv2scXAxs4E7Y2FmRggDn3TX_CXo81vRu3guZYLrYfgUbToqprTNT6NChMFXNlJD
 QElJyuZnSSEnyos8XPIIR7jlmR3Tif0PlzI5wPDeyxkoARqCDxamePSmsP41NHZusSEed_hGkGfv
 wLga.fexQ8J84
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 31bd11d9-ef1b-4061-be84-cf54a971b57f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Dec 2025 23:43:15 +0000
Received: by hermes--production-gq1-54bf57fc64-dtvpq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1b7f598435f05bace80e2f156eb8a8c;
          Fri, 12 Dec 2025 23:43:09 +0000 (UTC)
Message-ID: <950ac630-c75e-4d4c-ac70-5e4b0e397989@schaufler-ca.com>
Date: Fri, 12 Dec 2025 15:43:07 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: An opinion about Linux security
To: "Dr. Greg" <greg@enjellic.com>, Timur Chernykh <tim.cherry.co@gmail.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <20251212054524.GA23417@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20251212054524.GA23417@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/11/2025 9:45 PM, Dr. Greg wrote:
> On Wed, Dec 10, 2025 at 03:15:39AM +0300, Timur Chernykh wrote:
>
> Good morning Timur, I hope this note finds your week having gone well.
>
>> Hello Linus,
>>
>> I'm writing to ask for your opinion. What do you think about Linux's
>> current readiness for security-focused commercial products?  I'm
>> particularly interested in several areas.
> I don't expect you will receive an answer.
>
> Based on his previous comments and long standing position on this
> issue, I believe it can be fairly stated that he looks at the LSM as
> an unnecessary evil.
>
> So in his absence, some 'in loco parentis' reflections on the issues
> you raise.
>
> I've been advised, more than once, that in this day and age, no one is
> interested in reading more than a two sentence paragraph, so a short
> response to your issues here and a bit more detail for anyone who
> wants to read more, at the end.
>
> There is active art available to address the shortcomings you outline
> in your post below.  Our TSEM LSM was designed to service the
> realitities of the modern security environment and where it is going.
> In a manner that doesn't provide any restrictions on how 'security'
> can be implemented.
>
> We've done four releases over three years and we believe an unbiased
> observer would conclude they have received no substantive technical
> review that would support interest in upstream integration.

Stop. Really, I mean it. I put significant effort into trying to teach
you how to submit a patch set that could be reviewed. You ignored it.
I can't speak to what an "unbiased observer" would conclude because
your behavior has certainly left me with bias. Rather than writing
full length novels about why you submitted patches the way you've
done it you might consider heeding the advice. Grrr.

> The challenge is that the security gatekeepers view LSM submissions
> through a lens of whether or not the LSM implements security
> consistent with what they believe is security.

While there is some truth to that, we're really quite flexible.
What we need to see is that there is some sort of security model,
and that the proposed code implements it. We also need to be able
to examine the proposed code to see that it implements the model.
You have rejected all suggestions about how to make your proposal
reviewable.

>   Those views are
> inconsistent with the realities of the modern security market,

Oh, stop it. Look at how many LSMs have been added over the past
few years. Sandboxing and application controlled security are
"modern" security concepts that were unheard of when the LSM was
introduced. As I said before, security is a dynamic technology.
If it were not, we'd have a Bell & LaPadula kernel config option
instead of an LSM infrastructure.

>  a
> market that that is now predicated on detection rather than
> enforcement.  A trend that will only accelerate with advancements in
> machine learning and AI.

Without the underlying access controls detection is rather pointless.

> It is worth noting that the history of the technology industry is
> littered with examples of technology incumbents usually missing
> disruptive innovation.

The technology industry is not unique on this. Acme Buggy Whips, inc.

> This restriction on suitability is actually inconsistent with Linus'
> stated position on how Linux sub-systems can be used, as expressed in
> his comment in the following post.
>
> https://lore.kernel.org/lkml/CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com/
>
> So the problem is not technical, it is a political eco-system problem.
>
> So, big picture, that is the challenge facing resolution of your
> concerns.
>
> Apologies to everyone about the paragraph/sentence overflow and any
> afront to sensibilities.
>
> More detail below if anyone is interested.
>
>> First, in today's 3rd-party (out-of-tree) EDR development EDR
>> being the most common commercial class of security products eBPF
>> has effectively become the main option. Yet eBPF is extremely
>> restrictive.  It is not possible to write fully expressive real-time
>> analysis code: the verifier is overly strict, non-deterministic
>> loops are not allowed, and older kernels lack BTF support. These
>> issues create real limitations.
>>
>> Second, the removal of the out-of-tree LSM API in the 4.x kernel
>> series caused significant problems for many AV/EDR vendors. I was
>> unable to find an explanation in the mailing lists that convincingly
>> justified that decision.
>>
>> The next closest mechanism, fanotify, was a genuine improvement.
>> However, it does not allow an AV/EDR vendor to protect the integrity
>> of its own product. Is Linux truly expecting modern AV/EDR solutions
>> to rely on fanotify alone?
>>
>> My main question is: what are the future plans? Linux provides very
>> few APIs for security and dynamic analysis. eBPF is still immature,
>> fanotify is insufficient, and driver workarounds that bypass kernel
>> restrictions are risky they introduce both stability and security
>> problems. At the same time, properly implemented in-tree LSMs are not
>> inherently dangerous and remain the safer, supported path for
>> extending security functionality. Without safe, supported interfaces,
>> however, commercial products struggle to be competitive. At the
>> moment, macOS with its Endpoint Security Framework is significantly
>> ahead.
>>
>> Yes, the kernel includes multiple in-tree LSM modules, but in
>> practice SELinux does not simplify operations it often complicates
>> them, despite its long-standing presence. Many of the other LSMs are
>> rarely used in production. As an EDR developer, I seldom encounter
>> them, and when I do, they usually provide little practical
>> value. Across numerous real-world server intrusions, none of these
>> LSM modules have meaningfully prevented attacks, despite many years
>> of kernel development.
>>
>> Perhaps it is time for Linux to focus on more than a theoretical model
>> of security.
> The heart of the political eco-system challenge is best expressed by a
> quote from Kyle Moffett, in which he stated that security should only
> be developed and implemented by experts.  Unfortunately that view is
> inconsistent with the current state of the technology industry.

Glad to hear I'm not an expert! - Not!

> Classical security practititioners will defend complex subject/object
> architectures with: "Google uses SeLinux for Android security".

Yea gads. Subject/Object is about as simple as it gets. Look at Smack.

> Our response to that is that the world doesn't have a security problem
> because Google lacks sufficient resources to implement anything it
> desires to implement, regardless of the development and maintenance
> input costs.
>
> Unfortunately, that luxury is inconsistent with the rest of the
> software development world that doesn't enjoy a 3.8 trillion dollar
> market capitalization.
>
> The world simply lacks enough experts to make the 'security only by
> experts' model work.
>
> Today, the fastest way to a product is to grab Linux and a development
> team and write software for hardware that is now completely
> commoditized.  Everyone knows that security is not one of the
> fundamental project predicates in this model.
>
> Both NIST and DHS/CISA are officially on record as indicating that
> security needs to start with and be baked in through the development
> process.  One of the objectives of TSEM was to provide a framework for
> enabling this concept for the implementation of analysis and mandatory
> behavior controls for software workloads.
>
> A second fundamental problem is that the world has moved, in large
> part, to containerized execution workloads.  The Linux LSM, in its
> current form, doesn't effectively support the application of workload
> specific security policies.
>
> Further complicating this issue is the fact that LSM 'stacking'
> requires reasoning as to what a final security policy will be when
> multiple different security architectures/policies get to decide on
> the outcome of a security event/hook.  The concept of least surprise
> would suggest the need for stacking to have idempotency, in other
> words, the order in which LSM event consumers are called shouldn't
> influence the effective policy, but this is generally acknowledged as
> not being the case with 'stacking'.

Any other approach, and they have been considered, fails miserably
and introduces a host of complications. Not to mention performance
de-optimization.

> So we designed TSEM to provide an alternative, not a replacement, but
> an alternative to how developers and system administrators can develop
> and apply security policy, including integrity controls.
>
> TSEM is an LSM that implements containerized security infrastructure
> rather than security policy.  It is designed around the concept of a
> security orchestrator that can execute security isolated workloads and
> receive the LSM events and their parameters from that workload and
> process them in any manner it wishes.

I shan't repeat the objections that have been raised, but I will
point out that you have done nothing to address them.

> For example: A Docker/Kubernetes container can be run and all of the
> security events by that workload exported up into an OpenSearch or
> ElasticSearch instance for anomaly detection and analysis.
>
> So an EDR implemented on top of this has visibility into all of the
> security events and their characteristics that are deemed security
> relevant by the kernel developers.
>
> One of the pushbacks is that this can lead to asynchronous security
> decisions, but as you note, that is the model that the commercial
> security industry and the consumers of its products has embraced,
> particularly in light of the advancements coming out of the AI
> industry, detection rather than enforcement.
>
> If synchronous enforcement is required TSEM provides that as well,
> including the use of standard kernel modules to implement analysis and
> response to the LSM hooks.  Internally we have implemented other LSM's
> such as Tomoyo and IMA as loadable modules that can support multiple
> and independent workload policies.
>
> If you or other EDR vendors are interested, we would be more than
> happy to engage in conversations as to how to improve the capabilities
> of this type of architecture, as an alternative to what is currently
> available in Linux, which as you note, has significant limitations.
>
>> Everything above reflects only my personal opinion. I would greatly
>> appreciate your response and any criticism you may have.
> As I mentioned at the outset, you are unlikely to hear anything.
>
> For the necessary Linux infrastructure improvements to emerge we
> believe there is the need to develop and engage a community effort
> that independently pursues the advancements that are necessary,
> particularly those that enable Linux to implement first class AI based
> security controls.
>
> We believe that only this will result in sufficient 'market pull' at the
> distribution level to help shape upstreaming decisions.
>
> Absent that, it is likely that Linux will continue to implement what
> has failed to work in the past in the hope that it will somehow work
> in the future.

Wow. calling Linux a failure is a bit of a stretch, don't you think?

> Comments and criticism welcome, we have had plenty of experience with
> the latter.... :-)

We've been over these issues many times. Go back and make some changes to
your approach.

>> Best regards,
>> Timur Chernykh
> Best wishes for the success of your work and a pleasant holiday season.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>
