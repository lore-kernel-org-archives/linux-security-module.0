Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E3C433F5
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Jan 2022 21:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiABV06 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 2 Jan 2022 16:26:58 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:38260
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbiABV05 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 2 Jan 2022 16:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1641158817; bh=oXZLlxYjLaQU4eS9KxJMpcJujfYISQa6PUMQYlLKugo=; h=Date:From:Subject:To:References:Cc:In-Reply-To:From:Subject:Reply-To; b=nyP0DP9+iiIz3ennOYtBsdNkVL6LEQ7iML+YHn2/xWV9eiWmj1HQySgzj5fFu73LYI3slJGroyPJ+8lxvU3tqLhbZTboIj++0zJ8Tx6HuBEgocc/tQzEpApmAcCHCprrMoa1JtUvV4mVfWrjTV50774N1IUYlClNeEpjF10e/Duvw03g/fvB8H124LZmkGHSRjC3mlwKCj2JWxKy+SjvdWAxO4VLHtjFvPY0ofEf1QoaS3tkFPzbazXYRyCGSEg+rCJ2fjoCX6hqp9lwhBT56CiwJrGi4imLm+MPVUm81D9XzZwl1bF2ZO+lKBW+u3mrPBVUs+YudfMkWddS4juVmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1641158817; bh=XNvfW9UUNfzh7cLOhnSZzUP2X+nG7a7x5p7u+77cylY=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=jp/SP6QwlynDqwU8MykhqqHyot1FnTyByK1vzisxAa0l4gUk5RF2/eO59YWmEt6dDn0g3yMTL9k5ccd+xXG6BLrK5QIklDOl0YurwPPazU/Avodt+GVgx04ylzKFJdjfiM3TsRuq/PhF1/ntEssmGjhwM+BsH16eirtJOddts6cO+TnNR75F7oz7/Cdqs39gicROLI6TjpXZnGOY7DkcCjonDhSzNc4KdniumvZxVnpt74tkiTPsDZ38KSZG9DF8rq2d5umSFbsKEva6FudaRdq3r1G5Y9mEwWNQbSB2SD/q6ra/x2/ZtSrA85APklceSK/jLTsABlpjzo1VIVpHUg==
X-YMail-OSG: GZPEVF8VM1lLESTI6G77XwWdjKlaW.DVoZ4S64mIXkIn2tR0kcCi_4pP60oqwdJ
 jFMvk0vXW8vA90UB6ySJ5UdAj0POEYRWzu_Sn4bB62HkjWrJssaOHuIFSp2q9kkySpIIM7WEV3Gt
 ECYrHUxCCMmgT4Li0oyDRQ4YQEMBR8nJl.dIA1gNU7C52hValgLFwtvyvFJ4Po8dy1h0utZmm_vl
 cvq7P6A6XyIA3SaOy.zu1UYzMS1C2LOCPmrULWReoZDPai.OYG3E0wwSgZ.WJNLsmGk56kIrur.g
 4fEiq9NTgthxVc_TWB_FUCy81ZgRPmbNohN.licLcpybeSwFspxp9.J8SiuPZVxSfADQMh9zXV1m
 i8DJONzyH4bEXD9chp2.u0AnNONFVMcykQOYnIpagJyQzytGuPzHZpHXDQ7fiiwEG2gZRS_ITQg3
 GkYn.rEz64Wj87aVyQohiGUOf28M5BSDrPCTkBS.DCF_Lwr.oFghmj3aclgp0ESEryZl06HAmdLw
 9OqWzHEajFQDvNxDxNI3VGSTXjqMena0lcvX1m2.HZqN2ruL3MJqCS0J8..PC8VV5HUs5eEidzEV
 4pJ5d5UENze79SWSGcMJppG1ZgXK.PRql_WMOQeD_Y__m3Kqcu.M.YacIYcMd2P6jqRVhBRgzSK2
 on8SKg0Nt1JTZAYCReQ_ELUf_F8aaFsJdm4k0oA5QsGYtP1MXPYgRARHqTY__037IeKB6MOZyqnM
 CMs3wQDlmRKtttjifCJMcjwkxYc_4FcviLcu4B3gcUJRQvp2yOQpv6wS_SX57dlIH_c8GOSSNCXY
 WIkxEErL3knywMxL9YtVRhiukTgOKjx6a_6TgnhFrpzrzkWWMkLpCP.USAb8pMTJIlLTHgY0DLuL
 tMpW6Y9M_nvQW9GiC5W9W6Jkh1Vy1yHzsORr36geqscu8OkaLuAFGwRWHubG83m_lrnKFtD0TFBq
 R_yEjTq9aSxsyUuQeH0haBw.i62mJKdBdDQASB7UuVa8keq6kekNwqOvda4Cvw_pUy.6Zmzaq4pT
 G2mIuilVoZBIVWu06RNZ_s.mdkagva6EQ2C87ZVUXRXEaKZpfvt6KtqaPiWlKVoBH9CeZh4iTqcS
 3C5.w_TiJdmx_Yih77cahQucPCVtZY2pbeswxesaWET2_f7glsnOPgBJowtPWGU4iWjRroPZwYLA
 pZwPaKAiJpPY241oPkj2jNQwLovvsBpKBdsbd3yAldHwt4eC1diizvb_rTpcVJW8PlnPxVDh3_r_
 76A.YcKJdAdnZPPvUuQvkWW0b1Ll3prr3m5QxtvmjtqBYfFAjZkbTfRFhi7xl3axbmHwG9iZvpbO
 7aNZacmXkV73eDWNtAQHms_4pe56SEbYgTolz3vqSAEASusYXS47596T.vrr.iFRljjs57FTHzJ3
 CKE3wAohZ.hiO76YRwQBc0jwEa7gqO3L.JqSa5RTWhFmv9LJU9_l37P043OhLZm11mwt6TJQo3vu
 Ks4uVqIVZxcSLSsx1ga.cuZ5LH11HmAsoMDk0Z00WODpLCiYx8Yd78UvfAFlM72sPv9UNodgA_zG
 OAeCW4uZNVBdOr.v.mYqyjhNqgy2LlCL4ip7sbvUilajVdLS4UjGPnF5bKh3OWBAINivK6SVcFhk
 SYP7QuOTpFcoTlCVpA_aKA3V3l9ENNweQZMF3ClTcskWEKh.BWJ4b2D2dO0srm9Myc4LngrXXmNz
 _bPU9ZRIuKtSLslsEqanlSW6dZutae_4l1RYlMl4xD2oKRaDdnoFHmjxM_eCZvrwS6kyecLFDqEI
 jOIU6u5Is3qxwx4sIZRDIcgveCB5r6I5H_t8LJtL41WRQmz4VSJOFtDDTru59.lpIv3DRLXq5sGJ
 ac5CTqf5tK.QzZY0yZHDEZZYJI9QtN_xJh.CdN6OdZealfAEtvbD9saMLf6M4vu.0fnp8kQDGTyf
 8OYXmAvLRVl95snl79KbW_aP.YfD1bbgn7sItknLpqfSFkL7sHVhAUY4frJe3tPlOUEJV6B7uEV6
 OHC_ieRau_u9GBqzd8AxugkJBAd.VGTFZQpF9TthmcO0Aj9V4ED2qd_i7fD7tG8npBzs1QpAFnWY
 bdrAByUJbm0_84YUEES2v6IxxfXv.fcz__n1al7bDVBq4DuoXjlV_7w9cOQxG4oEbRPmcXcnu_YN
 O.2qIDRJbYwNluuUg1fM3XbCgdvc2ZdjpHWQ.iqmUDYRzIDI6Mr2C8czbolBT0foaNvwoDe9.7Aa
 nLXISWA2uzGmU1DvQ.fAhV6Jnu53Zf0AihMjCVCqSE.M71NeaDeh8cixW_aQHjQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jan 2022 21:26:57 +0000
Received: by kubenode536.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 55b989d2c8fdd524f46b37b956a0c3be;
          Sun, 02 Jan 2022 21:26:55 +0000 (UTC)
Message-ID: <55459276-2125-2099-9159-4fc07f59d179@schaufler-ca.com>
Date:   Sun, 2 Jan 2022 13:26:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: SMACK: how are smack blobs getting into cred->security and
 inode->i_security?
To:     Denis Obrezkov <denisobrezkov@gmail.com>,
        linux-security-module@vger.kernel.org
References: <470651da-88da-8a9e-7ba1-c5f36066bf72@gmail.com>
 <8cd68537-8ac4-625d-3416-3ce6eba938f1@schaufler-ca.com>
 <eedaa146-c4a6-6761-8e9c-56fd038a8b27@gmail.com>
Content-Language: en-US
Cc:     Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <eedaa146-c4a6-6761-8e9c-56fd038a8b27@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.19551 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/1/2022 1:34 PM, Denis Obrezkov wrote:
>> The LSM infrastructure (security/security.c) allocates cred and inode
>> security blobs. This allows multiple security modules to use them.
>>
>>>    Also, when does it happen? (for a task and for a
>>> file)
>> security_cred_alloc() and security_inode_alloc().
>>
> I mean how is information from SMACK64EXEC and SMACK64 getting into
> those blobs? Do I understand the sequence right:
>
> First, both labels (SMACK64EXEC and SMACK64) are installed in
> smack_inode_post_setxattr. Second, when we launch a program, there is a
> hook smack_bprm_creds_for_exec that installs a security label from the
> program file inode into the corresponding smack task structure. Third,
> when the program tries to access a file, it is caught in the
> smack_inode_permission.

Seems right. Note that few programs use SMACK64EXEC, while
all files will have SMACK64.

> I am also not sure what is happening in security_inode_alloc. Does it
> just copy a pointer to a security structure of a current task?

Smack labels are stored on a list in the kernel. Once a label
is introduced (smk_import_entry()) it never gets forgotten. The
inode contains a pointer into this list.

> I also can't find where security_cred_alloc is used. I found
> security_cred_alloc_blank but it is called only from cred_alloc_blank
> from cred.c (and I can't find from where the latter is called).
>
