Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C3DC004C0
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Oct 2023 15:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjJWPsV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Oct 2023 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjJWPsT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Oct 2023 11:48:19 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7ABC
        for <linux-security-module@vger.kernel.org>; Mon, 23 Oct 2023 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698076096; bh=ybcAG1gNGnfDTF6SVGVOnEJX7eXEoQAJ8pa5ClyFCVw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BGd71k06Jzahg3qsgBNNDw/fimyXXN5lORwp9NCg2xuiRTYLYuhlVkaJmur8ua1cQ8YNP4Svj1Bf46kcfGGm1AIRHfgc9bqkm4mAIWBBeDkoBWdmc8+QmjdOmI0DMxmK5nofgh6cHBNJYGJ6cRAJO80VrJ0c7JncPFCwmjDJk+W8TE+At5LWNfTWxliACOgxtD1cknseEGsJvN2NPDHZb0YphSDxQPHuLlD0c+kICANgh6QiM6aXj83uMQK3irfhI71Fwyrtg9ZS41cufDtyvv8hzjxeYrCzb7D8JYrR9BAOlBj3WhM7qQBm1ybW6q8rB9ly0KpEodevMwcwK2KMCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698076096; bh=kLIouCfRJKOmUZhfqJNWbwVl6ZLjIHy7SbK7xNcrAqS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=J234byhMQerId8qqD8zIjguc+MxGz+S4N4psmZUU29oSsfohuSQTBmNtUG29YU8GTLr1lYV5SyVjD2i73rGGUHbDD5La7hbuJFvYnFZDszBiPfkO+n9OA3W3Xi/VZG2QjAJ+wlhrib1vUolmGLY7tZKVTmFxOw4Rq4zQt42GI+wHyfJPr8Duy5/mvEo2LvQincDyd9Q6kt2Kx3OjxN8J/RvpzS/lqa27EfVpaHJlDGPJhFSAjH1ryz26Wicqx+nKevTkpaUVRkHJWX5XyrXk1qrutZgvCVxp972R2NjIpxBYqLBVIf9CZXT407jMUmrDfrejH0/owAfOSTcASPd49w==
X-YMail-OSG: rRELqCUVM1m2NP0A0O47oMnp7mI0imD66kQPlBxlCYtlGP3wQs1W7t5gtVM5qC1
 9IUj4kRynrBqtzxI0961jvMY31MmcxcI_qBgREk4ZdLpPA7FZ2KRwOjBERoL5.ND8Wxz71Cc0nqw
 bwVKLWCxIe1zKgdBHubcVXX1Qp7V9H1r7K1A7rkuAqnSEoODcItzCexjiayHW6eJg1FYi9dYEguj
 OLjoxE.xqqvA4yPNMWnVbJa3yW_6OpzdJp7xMfmomyXDj4i_KnLA_WYoUKsAeHJPR_RY3gLacPot
 PQSyYZvphtAZwzfTo4dPfNLHJtC.KE97QgY5GIHbH4ZoSaC4.4Hn6Sq6u9IM0gXwkKR0WgzEcfQ9
 tkWvBy2a6pZpkg3FK9Q0RNyz3S265eZgsQF6szYQ3affgjtF6AgI5bNFMGgBXaOxNieYY.N9dYCz
 VM6Ur_UbEotMTUwarTe67y6pa65wF3zmKg28NALcMjCpc5E0EOdBc8_.Qaj.cxo0UoZarfwG32WD
 cOuQJRJM55V_QsyE2PWEcpbziMlapnW4Yqiv_WAuSqmorrP5ZqLoTZkKQGOk8.ePHFkW4vrBYawU
 ZP930PttygrVTWdXbL2gNbWjAP5yY4MP2OH0x7Wie_O.yk76NzQwHAQFzJrZ979WsdcIg9v8pWjJ
 DU790P4251qvS6EV5JrUNvps3umtPXPSkInFG0BPEIlmEpMxEfQvEboycq1xk0._eILNqfoop0LX
 4cHSq2zPBZ07FxGALwe3g9TXsXEK0C1SzzjPKl6nPS9ftxivrL30SwCEnNw0asFESsarFblukuAu
 5ffOR_t20YdclOoX04dTmenlQvnPn4GT7xfQpi3UoqnXFnVD9qw8QcNmdG3KfTO1YBcGahGGHHLD
 5bOC4JnVH6Jgbgc._IWji6M7UODiw0J7tZYSnnHjO5ESto9P3TYXTABeiIQt5e7_JmmNWeY2mD3A
 YSzgju5MkIIWQzbWGk9ALtEAAN4KH8Bnn_JrliXVl3qcpStcjQ6IIYhaoqcHOxjr9VtCoswcvngk
 pFUTsJ2R5Sy1j73cF_yXoCfFmOFaCHwJC.AcUz2bpzYyv26vqKph495cjZUMGaWG5KemR89_9AdE
 2SZaPHPe3pqUStNwLLyrliDQeNCLJy2HgRLHSEAxrDs3kCFDP2Ezo1uUMifGsIjkmjafLC_cJavO
 tuByvUG1feRjuPVG75ce9RRTevp8mbTjZpKil5KQP13oyZCuIKJeakK3kOw9ZEpQ5wIpQVNK65QG
 nOxgSBemfRWAGYGZYfgnPdjysLK6xoko9RY_4dVO9f04i3bwIe7PUcifdeAHDn080FsmiuPSXlJw
 Fng1Ghtuym.nShRglH1a6GYHDw1jD33kplyXjz3CMiEOAmHOHetL09LrAdypWPDkR.5T13RWvjPT
 tIz8isKdn8k.DVNJ_7jV5fYZiJmfDvh.W9UrnTAjnfZr9gN62zViTeuuh6oyznM3xbFIT6SAFHst
 VadhbdweX4cqaNhYKELQR_Y3zPIYyyrbGmC_ndA4s2MCgjvFkIJy25fom8dQuJAlZIfljyQVKZvS
 CixQIFIEwlhUImk9aHmk8Bs2EwzcJaFBykmXkt7LWszW0zd4xxn4nRfpIMawRcyXkiZWQxVX8SBJ
 uudB2PASA10DbAKIKkhx4GLQRO8xDpa5bUpOhUETGXPA0kjt4ocO_805iNaqbUKmiQ.GIsb_rHdV
 nVPj5GeQpJ97Mytfv2yeANu7o7nQ3UavYo4MjmhM3jtVuwfR5tNyKSVNqqzqRGL4HKXdqduorotN
 nqz0gsuEfrEfEmubyQpq8GOQN5UT0R3.mzYGdLDqO2WQECD4D6fm64hQ8a0LPX_tdGIt3bYT4uHz
 fK7AJWopRYwmIlh7XTtrH.a56SSuzHrwo5jRvosW5ncu5cGkbV5a_QUi9uyebKlTCTqG0Cgjeg5j
 i6W_JUKSNyMNznwNMEZMrM566BUaNbDM_lDR7Ihn2CDQVOZG7jyWv7HqyC7zhqfiEj0kZAySPPgy
 pAHmdCqroMRj4E3FUHcQBTCayMkSEi2yASWXEc1vAmJq3q51uqBW4hyjb2RH3gxXdLaUVnIRORwX
 iqCTYjFfPS1HvSKxG.gPD7z3QLQA24Kl9krVUhKz5uZMIdZeJLnWhmlMMZ2MW1UxHjAOi8ZOQCJu
 mwlBAcEvNNoIh6xj7eFm6gDMtXzUxiBgoT2icVr9k4bU036rVzRByUFql6VT48rS.BxcZ475NXm8
 Ejfnpa5VYX1okm1GDeoJg.tRnakaT2x90_vbw2HQ6y4g8YcqxUL097iciiGzzkUou7494cvY7R5j
 BO_a4hCokp17tPw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b6a6788b-b1cb-430d-8404-a3c02adc57c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Oct 2023 15:48:16 +0000
Received: by hermes--production-ne1-68668bc7f7-2dfcq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 269dd112dcb123cbfdaedf73b174bc4d;
          Mon, 23 Oct 2023 15:48:15 +0000 (UTC)
Message-ID: <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com>
Date:   Mon, 23 Oct 2023 08:48:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231018215032.348429-2-paul@paul-moore.com>
 <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
 <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com>
 <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/23/2023 8:20 AM, Roberto Sassu wrote:
> On 10/20/2023 11:56 PM, Casey Schaufler wrote:
>> On 10/19/2023 1:08 AM, Roberto Sassu wrote:
>>> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
>>>> When IMA becomes a proper LSM we will reintroduce an appropriate
>>>> LSM ID, but drop it from the userspace API for now in an effort
>>>> to put an end to debates around the naming of the LSM ID macro.
>>>>
>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> This makes sense according to the new goal of making 'ima' and 'evm' as
>>> standalone LSMs.
>>>
>>> Otherwise, if we took existing LSMs, we should have defined
>>> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
>>>
>>> If we proceed with the new direction, I will add the new LSM IDs as
>>> soon as IMA and EVM become LSMs.
>>
>> This seems right to me. Thank You.
>
> Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and keep
> the 'integrity' LSM to reserve space in the security blob without LSM
> ID (as long as it does not register any hook)?

That will work, although it makes me wonder if all the data in the 'integrity' blob
is used by both IMA and EVM. If these are going to be separate LSMs they should probably
have their own security blobs. If there is data in common then an 'integrity' blob can
still makes sense.

>
> Thanks
>
> Roberto
>
>>> Roberto
>>>
>>>> ---
>>>>   include/uapi/linux/lsm.h | 15 +++++++--------
>>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>>>> index eeda59a77c02..f0386880a78e 100644
>>>> --- a/include/uapi/linux/lsm.h
>>>> +++ b/include/uapi/linux/lsm.h
>>>> @@ -54,14 +54,13 @@ struct lsm_ctx {
>>>>   #define LSM_ID_SELINUX        101
>>>>   #define LSM_ID_SMACK        102
>>>>   #define LSM_ID_TOMOYO        103
>>>> -#define LSM_ID_IMA        104
>>>> -#define LSM_ID_APPARMOR        105
>>>> -#define LSM_ID_YAMA        106
>>>> -#define LSM_ID_LOADPIN        107
>>>> -#define LSM_ID_SAFESETID    108
>>>> -#define LSM_ID_LOCKDOWN        109
>>>> -#define LSM_ID_BPF        110
>>>> -#define LSM_ID_LANDLOCK        111
>>>> +#define LSM_ID_APPARMOR        104
>>>> +#define LSM_ID_YAMA        105
>>>> +#define LSM_ID_LOADPIN        106
>>>> +#define LSM_ID_SAFESETID    107
>>>> +#define LSM_ID_LOCKDOWN        108
>>>> +#define LSM_ID_BPF        109
>>>> +#define LSM_ID_LANDLOCK        110
>>>>     /*
>>>>    * LSM_ATTR_XXX definitions identify different LSM attributes
>
