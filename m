Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C25C433DB
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 02:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0124822EBE
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 02:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbhALCMf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:12:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56504 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhALCMf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Jan 2021 21:12:35 -0500
Received: from [192.168.1.2] (unknown [67.183.157.164])
        by linux.microsoft.com (Postfix) with ESMTPSA id 511E820B6C40;
        Mon, 11 Jan 2021 18:11:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 511E820B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610417514;
        bh=Kh0DbWDgX0lL7MHkWJJkrapqmMvyTXMK+VWzFlpqEmc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=U4VRZuYQOs6yIDRE1VBsfDv4mUQjFft07V3HAgKq6xeUHyV+eydu1V5AJzFAR2Zmw
         HkF4tASTgk32ChMDte2RmAvMzpejiI+7Qqtqp2iNodTAfi8GVxTaINPyMOoLg3N5xq
         7RUGeks0zMo+sokSt0IYYFABlvYNBUyIjc29QYU0=
Subject: Re: Question about inode security blob
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <156f6860-73a4-f754-b460-d64de40ff626@linux.microsoft.com>
 <f4f21823-240c-394b-2222-bb8214e4ba7f@schaufler-ca.com>
From:   Fan Wu <wufan@linux.microsoft.com>
Message-ID: <f85cdd1b-1118-026b-c696-18863ad6352e@linux.microsoft.com>
Date:   Mon, 11 Jan 2021 18:11:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f4f21823-240c-394b-2222-bb8214e4ba7f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2021/1/11 17:28, Casey Schaufler wrote:
> On 1/11/2021 4:56 PM, Fan Wu wrote:
>> Hi,
>>
>> I'm trying to learn the security blob infrastructure for my future LSM development.
>>
>> Unlike other blobs, I found inode security blob has a special pattern. I couldn’t find useful information on the web so I think this mail list is the most appropriate place to ask this question.
>>
>> The BPF and SELinux will check whether the inode->i_security is NULL before use
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/bpf_lsm.h#n35
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/selinux/include/objsec.h#n164
> 
> The inode security blob should never be NULL in a situation where
> any of the LSM hooks depend on it. The only ways that could possibly
> happen are if an inode is allocated before the LSM infrastructure is
> initialized or if the system is out of memory when an inode is allocated
> and there are no entries in the cache. As the code says, "unlikely" and
> probably in a system failure state already.
> 
>>
>> But for smack, it doesn't do such a check
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/smack/smack.h#n347
>> Is this because smack_set_mnt_opts() already does the NULL check at
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/smack/smack_lsm.c#n784 ?
> 
> Smack tries to be pedantic about having data set up properly. So is the
> LSM infrastructure management of inode blobs. I have not identified a case
> where you should be able to get to an LSM hook requiring the security blob
> if the blob is NULL. If initializing the inode fails it should be impossible
> to use the inode thereafter.
> 
>>
>> Also, I wonder in which situation will the inode->i_security be NULL?
> 
> The inode->i_security should never be NULL if the inode has been
> initialized. Any LSM hook that finds this to be NULL has probably
> identified a bug elsewhere in the system.
> 

Thanks for the quick reply. If I understand correctly, I should follow 
the first pattern if I want to use the inode blob.
>>
>> Thanks, and I hope I could make my contributions to LSM soon.
> 
> Excellent. Please, tell us more about what you're proposing.
> 

My work will be related to the IPE LSM we proposed before. For the inode 
blob, we want to use it to save some file data like FSVerity signature 
so that the LSM can define policy based on that data.
>>
>> Best,
>> Fan
