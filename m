Return-Path: <SRS0=UvE5=P4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF080C26667
	for <linux-security-module@archiver.kernel.org>; Sun, 20 Jan 2019 18:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD06F20861
	for <linux-security-module@archiver.kernel.org>; Sun, 20 Jan 2019 18:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BLWB6Zvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfATS4n (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:56:43 -0500
Received: from sonic304-55.consmr.mail.gq1.yahoo.com ([98.137.68.237]:42293
        "EHLO sonic304-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbfATS4m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 20 Jan 2019 13:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1548010601; bh=D9wNj/GPuY6bT9EMRCSjGIjB0X14TBM2LuAfBBfFkxI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BLWB6ZvqN+0AIp0Z3LjKT4zlt9GOHG72sO2PG399bvgqlYFil8AElNqhEMWyHuskpMRXeLMFCpzwNSTO3V4yTMRY85gGGtUmhvrVJ18mTzZY5sancF78sW5xHC1xsvGQbZ3BFCVbKKy/S2vdxq8vO0mt727ksr07voTihPhSAq+RYbCTDSHJZEimAOn+2SjKyiY+vgjq0T07oYItY+lIOkLDKHC2nNyAYAyHCrxGR73+4UGyMJi4em1idhk78aH77vJK1TZJ6CvTEqtHW7vd/a8eKspNvNDCrztG6MP49PWmHLxs+16jC40k1hOHg+/audTKQKECdNRUy+SIZ+zIuw==
X-YMail-OSG: fxol4EsVM1ls2w7CH0iCQmtvXCDpSGJa4dSsZkYhAluU4ysIWCt2dU47FogaI2s
 r751DIIQR6eDDN266CWRXWLArvMSQR.f.r9sD5SQniz6s62FnGXFALYLytXZrB8GRnwi2uoR5LcB
 __IdUV7.KoWR8qJASBRwLqa4GrGICNuIlJsEa5u35SG0f28Uzo8XDK7vi.YSCnoLeGDhEYKKc1kM
 EBfEgNuRfvO8_SJM4d.Nw5XCN_5_HvlT4xsEjc.LrMPUjcEQCzw.juux8Ds.VrF6byj1kULlk365
 QMpknJex5u76cyliKTMiVwBh5OE4R4EySGNDx3fCsmXjoZqK1B3emF5s0Fj45OOIF9YdB0EyiR_Y
 eaqfiGVf32A702s8eYNCjbedZ9kT9Otn_DK.IlBhQmvJz6Sa7HBkYEq7l_QAVe3WPe8EbBfq93J0
 rgbLqG2CK7wHS6Rj8x7FtlUgrpz00d8iNSCIRnSOkv6hBXzHzgx90guk00tN25IEZ44jC0ncMaz5
 yw.dH_.LBnAChfjstXSEcdu5wowxW78x4vVoFvzDNPfwcH.N.g18EzR2aoKEG8YLHVVG4FbnioHV
 nWntB_S2Dfy8zvCy0riVUocUKCUtdYcsrJMWf5cM2m43xMk7DK.TbK7ADRNC6QQcx3Mehz0M_ZgO
 hgxVLuhqY7bRpKTHeNqNJqr5dDJyhXZOSjPSBQQ3EA16L7xQqqU4KpN337omRVYdjsxtZPugfYlS
 zXwHOiYmv3q9RcVgZkWFxKcdk_xivFhRY_ESkdY_rxacs1jWEJbwreEOKdiPaJJ9WpB3Pfm47nM0
 k3O6cMCJ9QYxAswGYP33.tzBmU8lL1hEz0omlWohx8eASrAYDNs138lbVNo8.E_q1ri8pLRNOrij
 R5.VT5EWl8OKEkv35PhyvtODMYWW96vvtr0tGG3seDXQjRLgvcILG8anSf141k8ysVM8f41GcdOF
 mviSuWji3642uHCvaN6.gWnASrH2FMFfUod8kPvkJwe6TK73x.u8Vl75.B3JWkpirxLU2mX88n5M
 ejxxfekTHpFkgD_r4oaDz1fI9Gyc8dnc_8_YgvWUEkEs6ei.JK2Z76wep1YYrEkY.LcR6bZ7n8L1
 Ri5dYm7dMpDcoobVvZRR.VqvxBy8iCMeubxkxEf0XiYAHGCss
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 20 Jan 2019 18:56:41 +0000
Received: from 118-92-255-155.dsl.dyn.ihug.co.nz (EHLO [192.168.1.152]) ([118.92.255.155])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 187a983805853565a354274ab5e4a5d8;
          Sun, 20 Jan 2019 18:54:41 +0000 (UTC)
Subject: Re: evm_inode_init_security and module stacking
To:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     LSM <linux-security-module@vger.kernel.org>
References: <f1a86814-716a-d02d-42ce-8ef64d680feb@schaufler-ca.com>
 <1547778689.3982.20.camel@linux.ibm.com>
 <9e142269-fd2e-b62e-f3fc-687d400aefd1@schaufler-ca.com>
 <1548002531.3982.202.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f9b450c1-740f-3b77-510c-7e0404986035@schaufler-ca.com>
Date:   Sun, 20 Jan 2019 10:54:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548002531.3982.202.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/20/2019 8:42 AM, Mimi Zohar wrote:
> On Fri, 2019-01-18 at 10:49 -0800, Casey Schaufler wrote:
>> On 1/17/2019 6:31 PM, Mimi Zohar wrote:
>>> On Thu, 2019-01-17 at 16:47 -0800, Casey Schaufler wrote:
>>>> security_inode_init_security() currently calls at most one
>>>> of selinux_inode_init_security() and smack_inode_init_security().
>>>> It then sends the result to evm_inode_init_security to create
>>>> the security.evm attribute. This isn't going to work on a system
>>>> that has both SELinux and Smack.
>>> Calculating security.evm based on multiple xattrs sounded really
>>> familiar.  Looking back at the git log, 9d8f13ba3f48 ("security: new
>>> security_inode_init_security API adds function callback") addressed
>>> filesystems wanting to be able to write all the xattrs at the same
>>> time and prepared for multiple LSM xattr support.
>> Right. That provides for security.selinux, security.SMACK64
>> and security.evm at the same time. What it doesn't help with
>> is what goes into security.evm.
>>
>>>> I see two options:
>>>> 	- create security.evm with the information from all
>>>> 	  security modules that provide inode_init_security hooks
>>>> 	- create a separate attribute for each module,
>>>> 	  security.evm-selinux and security.evm-smack in the
>>>> 	  current case.
>>>>
>>>> How would you like to have it work? I am agnostic, although the
>>>> separate attributes would be easier for the infrastructure.
>>> Having separate attributes for each LSM module would require re-
>>> calculating the hmac for each one, any time any of the other file
>>> metadata changed.  That doesn't sound like a good idea.
>> OK. So it sounds like I need to gather up data from all of the
>> LSMs (e.g. security.selinux, security.SMACK64) and pass the combination
>> to evm_inode_init_security(). Will that work? Will that provide the
>> integrity sub-system what it needs?
> Casey, as far as I'm aware only real root, currently, is allowed to
> write the security xattr domain.  If we assume real root is labeling
> the filesystem with both LSM xattrs, there shouldn't be a problem.

evm_inode_init_security() will get passed the concatenation of
security.selinux and security.SMACK64 then. That's easy enough.

>  I'm not sure how this is going to work from a namespacing/container
> perspective, which I assume is the impetus for LSM module stacking.

It's one of the use cases. New LSMs that want to use blobs, including
Landlock and SARA, are also important. I even know someone who wants
to use Smack and AppArmor in a complimentary fashon.

> I haven't been following Smack.  Have you added Smack xattr support or
> thought about it in the context of "containers"?  Are you planning on
> appending the info to the existing security.SMACK64 label or having
> separate xattrs for each "container"?

Samsung had a pretty complete implementation for Smack
"namespaces", but they decided on a different technical
approach to their problem. No one has picked it back up.
It used a label aliasing mechanism, very much like what
user namespaces do for UIDs. All attributes saved to disk
are native. The mapping only exists for the life of the
namespace.

>
> Mimi
>
>
