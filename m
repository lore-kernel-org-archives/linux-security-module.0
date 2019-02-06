Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3D6C169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4552073D
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EHo1ti8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfBFRoU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:44:20 -0500
Received: from sonic315-14.consmr.mail.gq1.yahoo.com ([98.137.65.38]:37681
        "EHLO sonic315-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbfBFRoU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 12:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549475059; bh=uzy8tvfW+foo4DGc2j4PSJCAItRuAAUVP/aGl4nwYbg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=EHo1ti8qRV7eryW/MhaT4KYT4LfTHwGC+pXlLoiUOUtvvD4whJT9PXr60wM5tOkCYL9LM9tS8nf9qCI68n2xMM0C9dewwYLdMx2olB81imJZgePMRZS42pyOky23PhDNcpAFaUlsPFo9qIA0vEaJTD4HKo9bdL85BaE030IQD1Cdptf/gRoyjAjdNUmoPaXgT/UVqcSm6GmAQUZZTgqgT6/eDOezKRUJRfVz/DfLPhnhcVKiISvRh4zLdvhCU/4M9GX8p19iCG/0Hy9C+fOWqE5Hkjc5rdozPDfZ1lcDEB7yVbFU7MBSNQRYJO/bnr0SQAVeP++NoN3mlqMspdle/g==
X-YMail-OSG: EwWu8REVM1mI.ebl9aoQgAJ5i9LqCkA_YPfailsEqzrcGYYuE7jajZQ_bho0FBf
 XBZSGRzBsyGDS6ChoSao1LGS1UD8gzYe43Hel5U0YEfvSt87bx9Ywv_qq9phPcqSdnWHNFwKyHGY
 2Yri2ioAza4yTehEmPuLlMBbw_FmGL2z6NYTca11aSVjOZfHWf628k6vhPiWb7r.vtKYI9AQLjTS
 aTxG02I7CvAr9xPlwb3jfAz_.811dteAC1EVrytZD9eMsbRne7u_RxFxHz1Ru1nc7oCEWgvdJsTs
 5Inw8WVEoO_hpB9xRtpkgGeIN55y03VJjXBRFYCS1xGC7n2dc0nLurrt2zBWYHGI8_udAatDGExe
 rNku2lG1fJ6I94sLBRnu5xIttuwoyUiDjWBAsleJdbWWBECKclipvy6QX.qYSe1GfcRpkJITFmzu
 YqZd8iFLsDM0WG8VA4fcdauJmP_cLo4XcmE.B5iKfJL1mu5kb82fHPKB2x3ODTfxYx95tqzCLInt
 .gF7yIXh9NIjkNJO.aVbzqPvk1hu6Bk4VxKmiUkWnuKKnKdAAIJlKsMXLUDqhdPzI_ZzVFuXRL6t
 3tfD8epJ5n6Z.9NP9ZM._T736V3ny6Vgj4mLaDbebjjkdQW1.mD5wMjfGL2Iw5N11c5S6qjpmuIU
 K7s6pc687lKJjOImK3H_A13MwXqcoMsuSC4hw_2_FMbTMn0chtDwD0bNJ31XB1BUbE25cgqW4OQa
 Q3qRYd2CW1y.x4NtEwcTTj1ye8QGEdgu0h8cWwSBat0h0mxyFVmo2PkICTOot38Bh0CsySH0zT5N
 1lM8gQA7Bud7RS4P4TKkfl3bAMfpFGlrB5qJkY3Ps2h0ZNJh3ubuanvaLqc3Jy51g9GBSKTC3qWn
 wfv6dyz7UpFMZilNSJ2_ASoqvCJ02Z6XdBRHu7s0gBahwGx1_bMlmoaeUJ.R8wInVRGVYCi6jLW2
 O8epGp8bB3BaoI0iOgEvLGaWhXFy_i7KUon9uWNSo4ArYhEYwe35Ttt0A9LOw7TAoDoykSSby2qk
 1voYb2LSG54sOKHfhEAKsJXT9zpoooqX99BJQYR6L9zuWh.J78tD53Rc20VIC4ixOapHNNSJQQz4
 HYincQoaaxrhn2Bsd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Wed, 6 Feb 2019 17:44:19 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ac92487ab4a76eab3afbdc179678d637;
          Wed, 06 Feb 2019 17:44:15 +0000 (UTC)
Subject: Re: New LSM hooks
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com>
 <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
 <CAHC9VhQ6p=LoEN6Rqze48FrVDsX0mfXHY4BvEaxU97w1azP4YQ@mail.gmail.com>
 <alpine.LRH.2.21.1902061207010.19811@namei.org>
 <e1492ac6-d1b2-ce2b-c0df-1f30601747ad@schaufler-ca.com>
 <6598f48a-f50f-1976-f766-126c0a43f7d9@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7e13bda3-9ef2-d382-19d8-f96203c81395@schaufler-ca.com>
Date:   Wed, 6 Feb 2019 09:44:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6598f48a-f50f-1976-f766-126c0a43f7d9@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/6/2019 9:06 AM, Stephen Smalley wrote:
> On 2/6/19 11:30 AM, Casey Schaufler wrote:
>> On 2/5/2019 5:11 PM, James Morris wrote:
>>> On Tue, 5 Feb 2019, Paul Moore wrote:
>>>
>>>> I believe that will always be a problem, no matter what we do.  The
>>>> point I was trying to make was that everyone, especially the
>>>> maintainers, need to watch for this when patches are posted and make
>>>> sure the patch author posts to the LSM list in addition to any of the
>>>> relevant LSM specific lists.
>>> Right, and there is no way a new LSM hook should ever be added to the
>>> kernel without review and ack/signoffs from folks on the LSM list
>>> (especially those who are maintainers of in-tree LSMs).
>>>
>>> Casey, do you have any examples of this happening?
>>
>> overlayfs (according to my records - which may be flawed)
>> is a prime example. Inifiniband hooks were reviewed/acked
>> for SELinux, but there was never an attempt made to work
>> with other security module maintainers. Yes, they were posted
>> to LSM, but under the title "SELinux support for Infiniband".
>
> overlayfs hooks were also posted to and discussed on lsm list, including comments from you.  Admittedly the cover patch said Overlayfs SELinux Support but the individual patches for the hooks were "security, overlayfs: provide copy up security hook for unioned files" and "security,overlayfs: Provide security hook for copy up of xattrs for overlay file".

OK, apologies all around. My records are still better
than my memory, but neither is perfect.

>
> In either case, did you request a change that was ignored?

Smack support was definitely not included. I started
getting complaints almost immediately when overlayfs
hit upstream. 

