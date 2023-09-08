Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42832EE801C
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Sep 2023 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjIHQDP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbjIHQDO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Sep 2023 12:03:14 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4201FC6
        for <linux-security-module@vger.kernel.org>; Fri,  8 Sep 2023 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694188984; bh=+cHipo+2vJm/wQcBQGeUuqbAT9124XW0Ru69T9AST+I=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=Lk/PH+J2TN6jbKlCQgMQYsZPxsR5FS1sG+bprqKLxIibgnvjR9RED+8qd8em2rRILDQPVIhVJoeDbcxS91tecMKq5Sa6p7C8/BFbJ+phJTarVLnTYU8n7syer9Bhm+0KCg7QEQgOtm3iS1B0OVYzbafhgtdW6gb9Yt2X8+T7Q+55qxrr7jHaHGhpfoviBqowmF0Xjqk/50ivY1sJKyIzhOrRutlLKKo4LIqlSj6Pl17/NUWc8Vt/kMgKqDm3BUnxCE1BODV0zx8hJ0JLs4vQPV37fU6amvxDAxK7Mvldh8Btuh3yektpxBJMImLOLZnIZh7hGUExrkY6s/ny5BMmkw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694188984; bh=q/vw7cbxgJuadAvtlsUGmy1QXus3q2ILyu9blXKbIac=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=avG8bQz77dYA10koqKgGI5WBwocJx/Y7OqrsSKUFcrV80iX8pSe9T4HAMbrHRb7xiIhcicZU9M0yAB3mqTo6Fest8y8fIfdqdh3SWUpDoqx4iokvMeLF4j/jJbvOlEyDfcxLwttFE9UWi7vET9HYGvSgGvF0QQr/tvOTiEFDQ1Q7rZt6Vq6aK6/BEOCteWvHeP8W563/gzkVrxLidmq9E5gOYGd2CbF7ouKVVxSGr45SrFBY8LXw6fzWl3b6ckjjXqEh3cCXpkadp7cLTxcitW9EQq/ZI4pdFuMCmTzYjidjLW7IVydEIDl9wrAcjGYI0mI22CsjOBR7psaw4lQixw==
X-YMail-OSG: fDFmBNMVM1nW8nMyWiWQ8JD0gDLlmwqDa4HV5ijonDCrS7Q7.rwFQwjGDJCPJ4D
 x5boh2_9KyFJuqJ.PFSDncpYXAwNpVEzvX7cLJYZpH4TT_uwkUiOEsl8_cawUMLHUC3TqBfOiMhF
 etujEbPsqMn2Dpp3EqtVbSZp77L0yQ17EaJC5tITMpHwJ656Z3IfW5khQa_H6Q0zKRLsC_mpO6SC
 pwyheKkq4tmWbpsUATCdNyCOp4QL8loJSXqSh0_MwfutTnd7XC9yRyRmfBEln_kueMJeaXL4iETF
 bz7MOZBc_PMGOrIflAYrVUlHwqN4p5Q3.SJNJ8E1zr7eczcgVaaT5DJMQ1utKXNg04ReAp7IWpRY
 nfD3ZyOEMI7KSy0z0yQV2MBT5sp0uLK0WoXXPjnaE9DtnTnZqt_ypBPDgOXSW8LX2KV4Zvsl9V3I
 QxAPEownAPhtF5W8NjI0bXW5mBb7P6FjL05xnH1J2_tTXdfoHfxDle6MQ5wfraCq_J8uSbOT0kdF
 tjsqVCnqyNZ.hkhBLBVqqKeq6YJQ4YroVC6RcBEHjIXROkgng2uUgELNwIp0sA4ss5LQDcpBsM1W
 jVTp8WJuTVTFoffDVkbKz3HUyYmqRfWIbzWh3hh5S15XuPr_VusVeUur5U0UKNebrMTmg376aPRm
 0jJd9mTMqLUOoP1_LH0rrJCIBZlDqcO4cnlFRa5iXMMk.ZyFCdcKXL1AZ_b.fJyhIwGgUCapJP9i
 ibWdDrbM4pVwEGc66Bo2rcFHqyaMYN2scXiXZGWtX1RZkLyHz9tvp22XUciz3T7z_Eyew4XQUi0M
 ZYDTPB_QKbRV4gtLnigWvop5fB4702QALmlt28cpyFGa_HEmrzc0JxFgNKKPfEjptqiqpWLBzwrp
 Tpcq298ImFVbpnDlkMGsKENZn9JdgTG6XqVdE4r1rGMiGrRpbPJlYvRz0keM7O_80Cg1xoXG8gt4
 8yQ6OeOpGeDRMAb6.go03eEp_iFb.KsV0pSgBRY.D5LVIp.rN9PvFydiVT_8nn1f7CrKVAiLRs.y
 34ZSxmwRC51AmL0LlHUKuRGyHRzTbzd0xD7PTQoVonogoYXRHiDwSMHmvok.PSqvhI_nWNzLCBOL
 tigCUEJ.5QT7LSw5Ht9dEVeZw1WqX3ji8D6n7qrsIO9taBE1oqxecvEp0pCqw7xoibmrr8PEff3N
 PIP5W0moq7wvUgZqaAPU83yEMCxggnxVe.WfBqUNvYxwg8vHEY8l.qecdxHR8CaGkQpusSeBzfaL
 PzB9IaXcSz8cS9JK82wHe6aOcqi0_pxtAR4h5AYwbjFSafd5SQplJpzkCJne4KLXPN9inq0j2EmX
 yonCQCuVp.WOv5QqHw8QpY8FLHTpRxOI_Vko4kwxuiIwTRX6_ZN6HK7AHjakFWvHJLaEKjIza92s
 7FJRIpS6dn3H4gG6mtrrChnUr6o7DTVT83E8pduhZp4pfG7eCKQSDYcIpGWVrNsRXQP0dhdnV31_
 fxNlu3Cuwf4.O0Bw03j5HafzTeGCLcMsSYng70Phg1J1nf2VhZsMxJawftsHDh69yYY_7X4_rPHD
 jIfQbEroLhgYhoZp6SeUtDco5A65Te62DaGXAPNRewkAG4y1wP6RmNAYt89cy5Pu.jfJ8XOgpfhB
 A7IHnEmFbeOAFRSg7RVYOFJMJP7MrUxWQUkHAHqhcnjcFRUaBmxNG5pX3_yykILvy.tdJr_joz_y
 Fz1t1Lnvy9u73jPLHCh9yWAgMhwwtO_KTCKg98TLBqQbyAhCV_w.67qaSDb4gcrZr7AFK1_buGiz
 I82gX43grkxCxPdJANwCwDU5oy3A6HJMtnGKkbfaTeOBrpRerybktxqPhJ7AP98Anw_vcG0oDp3p
 2V.L59w8jjiHAbZWJv3MlTiDBtcrdhkCaiS_yGDYTqlx1LKN65.gaHtiEW0gIa9n5nxVNsnPAD58
 TKvI0ntYU__9cYDcurrkPHgmw3R6Lpru6zK8MW0wx1GIi9mbqh3EXBEshUQ8MxnGTjsEAWbzCoPR
 mZK6_wIA2yK3cHmo8M0Bm96t42ApU3aYcVxAk9iPH3dMk_E8m.FGPyTCbpxzgZvpD_bxzXnTCUyv
 FD9tOaY6Kc1heZP3K20bdpRjYTmTxlfgltImwhy2Rh6ls1QrnARyqwgp6IYP0ezp0BZhivRJCclp
 4uuYY56A9bVEO0kjzQCAZC1uJfUvAWEE5vMM_byAX6ulgmmXlBTLJCkCQn7zyMAnPLo4PP8hj28G
 kjL9VmnRTU.19JeEDEyJbiAlu70woW5wApppFSzBC9UPfvWllqVBzXBP7KPRF_t5p.L7uXC9E.MR
 aZVY8EXE_k4lo
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b401cd89-b916-4834-8b26-cf041b0d8e9a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Sep 2023 16:03:04 +0000
Received: by hermes--production-bf1-865889d799-k5x9p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6a2cd508d5d8484554489f32e83872e6;
          Fri, 08 Sep 2023 16:03:01 +0000 (UTC)
Message-ID: <847729f6-99a6-168e-92a6-b1cff1e6b97f@schaufler-ca.com>
Date:   Fri, 8 Sep 2023 09:02:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
 <CAHC9VhQgZ6kRQA7M8BG1H4gW=dPBhPqc5qV72EQqrSt9p0Uhkg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQgZ6kRQA7M8BG1H4gW=dPBhPqc5qV72EQqrSt9p0Uhkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/7/2023 3:12 PM, Paul Moore wrote:
> On Thu, Aug 3, 2023 at 5:38 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Aug 2, 2023 at 6:00 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Tue, Aug 1, 2023 at 6:47 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> I've updated the README.md doc based on the feedback, and copied the
>>>> two new sections below for easier review.  If anyone has any
>>>> additional feedback or concerns, please let me know.
>>> Another update based on feedback received (thanks everyone!).  Just as
>>> before, I welcome any comments or feedback you are able to share.
>> MOAR UPDATES!
>>
>> ## New LSM Hook Guidelines
> ..
>
>> ## New LSM Guidelines
>>
>> Historically we have had few requirements around new LSM additions, with
>> Arjan van de Ven being the first to describe a basic protocol for accepting new
>> LSMs into the Linux kernel[^1].  In an attempt to document Arjan's basic ideas
>> and update them for modern Linux kernel development, here are a list of
>> requirements for new LSM submissions:
>>
>> * The new LSM's author(s) must commit to maintain and support the new LSM for
>> an extended period of time.  While the authors may be currently employed to
>> develop and support the LSM, there is an expectation upstream that support will
>> continue beyond the author's employment with the original company, or the
>> company's backing of the LSM.
> Based on some off-list discussions, I've added some text to the end of
> the paragraph above to allow for a reasonable plan of succession in
> cases where the original LSM authors are not able to commit to long
> term support.  Just as before, comments are always welcome :)
>
> Here is the new paragraph:
>
> "The new LSM's author(s) must commit to maintain and support the new LSM for
> an extended period of time.  While the authors may be currently employed to
> develop and support the LSM, there is an expectation upstream that support will
> continue beyond the authors' employment with the original company, or the
> company's backing of the LSM.  If the authors are not able to commit to
> supporting the LSM for an extended period of time, a reasonable succession plan
> must be submitted along with the LSM."

This makes it sound like LSMs are always developed for corporate use.
While that is generally true, we should acknowledge that the "sponsor"
of an LSM could be a corporation/government, a foundation or a hobbyist.
A large, comprehensive LSM from a billion dollar corporation in support
of a specific product should require more commitment than a small, targeted
LSM of general interest from joe@schlobotnit.org. I trust that we would
have the wisdom to make such a distinction, but I don't think we want to
scare off developers by making it sound like an LSM is something that only
a corporation can provide a support plan for.

