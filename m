Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E383C7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173FA2064B
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 17:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Qc6P+tMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbfGPRaF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:30:05 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:36434
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728124AbfGPRaF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 13:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563298203; bh=6UzBpl5Oiz34Y20W6zry02s4o6QUbCi3SDcmzZo28As=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Qc6P+tMCJEmgGcig5sSChfkd02dhimS8DHxnCsf3EAmOlfhRqGU+4YcRUHc/sDBAcodJByksq+gO1tJQVfDYZ3Sg9ac8BlCrOkOed0YSL9m9TVGwt7JMxoI34WQZnubz6L+yh1bV1mvmngg35wLEmgr4znzExCYUZNqeD+0aWigAhpRr2nQgeb2U+S3TcqIurb6+i1I0ryy203MuAnvYiXYa58wmjAWTADIekGX+h7mxLpcGj3Oq7JqfLSLhwglwdv3DIdqYKN5BurOP6XSOYnmh0UK5AIKYFMo9fBntAgDaPDwx3U9wVPEt0STeWGh92M4niojCSVmCnZXawizobQ==
X-YMail-OSG: Hwt91g8VM1n4bhzhPwqgxPD9ItMuceQAEo9vjFGeTNJ.qiDEFJUoqx8umdNa7ts
 u2lLqYgnohxPPCijg5IeYCy6tRYWI9bJUsqBPaMAs4LcFqvLmTLCQVXbrvlOKEswPzeRlD0g8H5s
 B9JDCqYm7i37QlHsDqSq9oWZKEKmk7RpeFNoO4OAnm4pQgTvyZoFFINx.s45GpSX9rNCraUWDTlq
 Gn87f.39tEGFrsApKnJr5ZMQQMdLZBgNyajWmx.JsJ1iBFnqYDcPAA_2fQRE23CjzQMzgQ2jd5mV
 dQXTKtmr28iyqJKtvHQIED_cVuWhm3TIz0dAxM5Brl1PcB3wNaD1MqGGwRvhNDsdE3RyMXaG8i8w
 zhPgLrgcD4MxOX9DeBBPwqI8A9MzdntEO_i7p3wTnlRiYkFxIHwVtHJ7Ces7lJDEpr6PVArtVPNn
 u5sBAPrlN_GcbQwIvaSPMWgW3A.tlDi6CHekE3sVLPeQfrQLJRrvufFew5RPlDxF8bMPHUMLL06r
 ZDHmQ3M58tWFKCEMAClhpPo16Yn8TqbvTh2TkNCAaC07oklLxDP85h.23NckzfXm71.fARECS4j7
 EKBsKxyHs1EGi80z7jlnSNli3QHI_izLmcZOAiC8Aa5jb9.ZuTOb8Al7Nh8GJGsf7wg5M7E7ISyF
 7F1lVTutpMtR5fPkT7EBL.cSNTkMql.Dzgmd7nBOBhZaKQ4ESzfSTzMYLgD1LZIMJfigESlVa3Vv
 551dm9IahQY45LHc2AqHGZr4S7nGiJhvVxuxHYwyomN.MxyQj.J3YCY0cPpEYUAXaYY5dEm9KIPW
 HTryt2eFaWXJMBtV7ysOu6HsiQcMhtKfyfzpuMV1MQmpakyy_zXQwadAjtQeGDYPXIJsMBI53FVw
 k9RiUB1BmGkVLYGeJDKC7F.1NJFnc08BdE1SfpNFPVI4t4Pfib_lGhiqQg6NqZ6w39ttqlQ4SRra
 ySENYg.5bzlckBS3Afw2H8ZdQx9T3zodoJmkkZ5_ru.5uoX60Pq2QwJoHai59Al_Z9vMu8eYo_nn
 .xXQbA2pv4BiKsAFsYCuuyVt3kUaqawMD8YbFEcPDGLhfxEiZCeQVChQcuVWNb9PxIVau.CnRdjH
 hrXlzrkv97NpqEEBPsvr0g5PsnbXI3hXNfTHXQLYGcAAdUgokBvsuFzux0e0N_AcQTOD3gBkyZmH
 a3YkuZyisKlXr8zjrZGFbBrAPhtoAqKztF6rQUdHE2XDlCttkvQ8HIvKH10ITzbEMQHxQU7cuGKQ
 t7MvJrkbl73x0Dw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jul 2019 17:30:03 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 401141501cbcdce833d5f43827a2e28b;
          Tue, 16 Jul 2019 17:29:58 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <c46932ec-e38e-ba15-7ceb-70e0fe0ef5dc@schaufler-ca.com>
 <CAHC9VhQ08LKUmYS8ho_0-uDUFakPPq1bvR6JwWiLUrnwaRV6Aw@mail.gmail.com>
 <1979804.kRvuSoDnao@x2>
 <CAHC9VhSELVZN8feH56zsANqoHu16mPMD04Ww60W=r6tWs+8WnQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c993f63a-7c2d-c6c8-cfa6-3cfba410770d@schaufler-ca.com>
Date:   Tue, 16 Jul 2019 10:29:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSELVZN8feH56zsANqoHu16mPMD04Ww60W=r6tWs+8WnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/16/2019 10:12 AM, Paul Moore wrote:
> On Mon, Jul 15, 2019 at 6:56 PM Steve Grubb <sgrubb@redhat.com> wrote:
>> On Monday, July 15, 2019 5:28:56 PM EDT Paul Moore wrote:
>>> On Mon, Jul 15, 2019 at 3:37 PM Casey Schaufler <casey@schaufler-ca.com>
>> wrote:
>>>> On 7/15/2019 12:04 PM, Richard Guy Briggs wrote:
>>>>> On 2019-07-13 11:08, Steve Grubb wrote:
> ...
>
>>>>> Steve's answer is the obvious one, ideally allocating a seperate range
>>>>> to each LSM with each message type having its own well defined format.
>>>> It doesn't address the issue of success records, or records
>>>> generated outside the security modules.
>>> Yes, exactly.  The individual LSM will presumably will continue to
>>> generate their own audit records as they do today and I would imagine
>>> that the subject and object fields could remain as they do today for
>>> the LSM specific records.
>>>
>>> The trick is the other records which are not LSM specific but still
>>> want to include subject and/or object information.  Unfortunately we
>>> are stuck with some tough limitations given the current audit record
>>> format and Steve's audit userspace tools;
>> Not really. We just need to approach the problem thinking about how to make
>> it work based on how things currently work.
> I suppose it is all somewhat "subjective" - bad joke fully intended :)
> - with respect to what one considers good/bad/limiting.  My personal
> view is that an ideal solution would allow for multiple independent
> subj/obj labels without having to multiplex on a single subj/obj
> field.  My gut feeling is that this would confuse your tools, yes?
>
>> For example Casey had a list of possible formats. Like this one:
>>
>> Option 3:
>>         lsms=selinux,apparmor subj=x:y:z:s:c subj=a
>>
>> I'd suggest something almost like that. The first field could be a map to
>> decipher the labels. Then we could have a comma separated list of labels.
>>
>> lsms=selinux,apparmor subj=x:y:z:s:c,a
> Some quick comments:
>
> * My usual reminder that new fields for existing audit records must be
> added to the end of the record.
>
> * If we are going to multiplex the labels on a single field (more on
> that below) I might suggest using "subj_lsms" instead of "lsms" so we
> leave ourself some wiggle room in the future.
>
> * Multiplexing on a single "subj" field is going to be difficult
> because picking the label delimiter is going to be a pain.  For
> example, in the example above a comma is used, which at the very least
> is a valid part of a SELinux label and I suspect for Smack as well
> (I'm not sure about the other LSMs).  I suspect the only way to parse
> out the component labels would be to have knowledge of the LSMs in
> use, as well as the policies loaded at the time the audit record was
> generated.
>
> This may be a faulty assumption, but assuming your tools will fall
> over if they see multiple "subj" fields, could we do something like
> the following (something between option #2 and #3):
>
>   subj1_lsm=smack subj1=<smack_label> subj2_lsm=selinux
> subj2=<selinux_label> ...

If it's not a subj= field why use the indirection?

	subj_smack=<smack_label> subj_selinux=<selinux_label>

would be easier. 

