Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71113C169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401362073D
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="U7lGBhzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfBFRtA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:49:00 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:62831 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfBFRtA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 12:49:00 -0500
X-EEMSG-check-017: 683099568|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="683099568"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2019 17:48:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549475334; x=1581011334;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6O7I3zsbfHCsghpfXOkqGj0sk8tP8jaqkeBMkOX14J8=;
  b=U7lGBhzK/3ioAm8AlE1IfJ7qOR+s/Ly4HmEPcZTEdPwRmMXNT24Vvg8/
   Zh6z19Lo1hxWF41PMjprn05ChmJkjryoxj12E83CMUilMQO2xq6AK0mq8
   Yv4GM+4jBN4bJBRSa8IMyHdtdFLoCFgLcILIKqPg2iRBFUFf3ZbjeMEMy
   e6rMOnUrKWQVVJzg2xhLO3/L1Q0hOfP+nxQjvzqDhE2F5nMnY8E8icYm3
   X2dkjksHg/FmKX7RKnvoeYWMMF+C/7DnJousJGJM8sk++xuMmmoXLeyXO
   FOrkDIlHq8gfRo0o0qYIQ2QwVWSc+TVMQC+UkLgHqbp92EwGAyjtbwk8T
   w==;
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="20269519"
IronPort-PHdr: =?us-ascii?q?9a23=3ArPuxIxbAc0A+OCAM5fZfBTb/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy8ZR7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI/pUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj2LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBetDmaOpNrTs4tTGxkoiY3xqActZ?=
 =?us-ascii?q?KlcyUG1o4rywPZZveaaYaH+AjjW/yUITpggXJlf6+wiAiq/Ei7z+38StG00F?=
 =?us-ascii?q?FXripZitXMtm4C1xjU6sWfVvty5F2h2TeS1wDI8O1EPUA1mrbbK54m2LIwkI?=
 =?us-ascii?q?YcsV/fESPsnUX2jauWel0l+uiu9evnfq3rqoKTOoJ7kA3zMrkiltahDek3LA?=
 =?us-ascii?q?QCRXWX9fy51LL5/E35RLtKjucxkqncqJ3aPtkUprWiDg9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QehnkINkhJeB2Aj4j3I13OOuz3De+jg1Swlzdm3+zJMaf6AprTLnnOi6zhcq?=
 =?us-ascii?q?p960FG1Qozw9Rf6IxOCr0YPP38QFX9u8DfDh88Kwa02froCM1h1oMCXmKCGq?=
 =?us-ascii?q?2ZMKbVsV+S/OIvIvKMaZQTuDnnLvgq+f/ugWU+mV8HcqmjxYEXZ2ygHvR6P0?=
 =?us-ascii?q?WZZmLhgs8bHmcXugozV/Tqh0efUT5XfnqyWqU85jYhCI24F4vMWoetgLmZ1i?=
 =?us-ascii?q?ehApJWfnxGCkyLEXrwc4WEWvEMaD+dI8N4iTwLS6SuS5I71RGvqA/7y6NrLu?=
 =?us-ascii?q?/T+iIFqJLj0MZ66vbNlRE96zN0Fd6R02KTQGFumGMHWTs20Lp4oUxnxVfQmZ?=
 =?us-ascii?q?R/1tdRDtFCr8hCUg4nO5rR1aQuANnpVxPpZdyJQUuoRti8RDo4CNk2xolKK2?=
 =?us-ascii?q?R0Hti5xjXExTCrGPdBlbmMHoY16Yra1n38JoB60XmQkOEZhkQiCu5IMnerzv?=
 =?us-ascii?q?pn/hXXL5bAjkHckqGtb6la1ynIojSt122L6XpEXRZwXKONZnUWYk/bvJyt/U?=
 =?us-ascii?q?/ZZ6O/ArQgdA1awIiNLbUcOY6htklPWPq2YIeWWGm2gWrlQE/Snr4=3D?=
X-IPAS-Result: =?us-ascii?q?A2BYAgCGHVtc/wHyM5BlGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YEzBTKEKpQGUgaBCAgliTWQVTgBhEACgxoiOBIBAwEBAQEBAQIBbCiCOikBg?=
 =?us-ascii?q?mcBBSMPAQVBEAsYAgImAgJXBgEMCAEBgl8/gXUNrS+BL4VEhHKBC4s4F3iBB?=
 =?us-ascii?q?4E4DIFhfogKglcCkTqRTgmSPQYZkk6IdoE2k0shgVYrCAIYCCEPGiGCbYInF?=
 =?us-ascii?q?4EAAQKNOSEDgTUBAY1zAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2019 17:48:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x16HmrA0030677;
        Wed, 6 Feb 2019 12:48:53 -0500
Subject: Re: New LSM hooks
To:     Casey Schaufler <casey@schaufler-ca.com>,
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
 <7e13bda3-9ef2-d382-19d8-f96203c81395@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <09d3bd67-17ca-4674-dd27-b6613adc0210@tycho.nsa.gov>
Date:   Wed, 6 Feb 2019 12:48:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7e13bda3-9ef2-d382-19d8-f96203c81395@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/6/19 12:44 PM, Casey Schaufler wrote:
> On 2/6/2019 9:06 AM, Stephen Smalley wrote:
>> On 2/6/19 11:30 AM, Casey Schaufler wrote:
>>> On 2/5/2019 5:11 PM, James Morris wrote:
>>>> On Tue, 5 Feb 2019, Paul Moore wrote:
>>>>
>>>>> I believe that will always be a problem, no matter what we do.  The
>>>>> point I was trying to make was that everyone, especially the
>>>>> maintainers, need to watch for this when patches are posted and make
>>>>> sure the patch author posts to the LSM list in addition to any of the
>>>>> relevant LSM specific lists.
>>>> Right, and there is no way a new LSM hook should ever be added to the
>>>> kernel without review and ack/signoffs from folks on the LSM list
>>>> (especially those who are maintainers of in-tree LSMs).
>>>>
>>>> Casey, do you have any examples of this happening?
>>>
>>> overlayfs (according to my records - which may be flawed)
>>> is a prime example. Inifiniband hooks were reviewed/acked
>>> for SELinux, but there was never an attempt made to work
>>> with other security module maintainers. Yes, they were posted
>>> to LSM, but under the title "SELinux support for Infiniband".
>>
>> overlayfs hooks were also posted to and discussed on lsm list, including comments from you.  Admittedly the cover patch said Overlayfs SELinux Support but the individual patches for the hooks were "security, overlayfs: provide copy up security hook for unioned files" and "security,overlayfs: Provide security hook for copy up of xattrs for overlay file".
> 
> OK, apologies all around. My records are still better
> than my memory, but neither is perfect.
> 
>>
>> In either case, did you request a change that was ignored?
> 
> Smack support was definitely not included. I started
> getting complaints almost immediately when overlayfs
> hit upstream.

You can't expect the developer to supply a Smack implementation of the 
hook if they aren't using Smack themselves.

On the other hand, absence of a hook implementation shouldn't break 
existing users.  So if that was the case, then there was a bug in the 
hook's fallback behavior.
