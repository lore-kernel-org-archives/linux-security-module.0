Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A98CC4360F
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 14:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E56A2084C
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 14:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jLcsXa4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDCOjN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:39:13 -0400
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:62398 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCOjN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 10:39:13 -0400
X-EEMSG-check-017: 212919126|UPBD19PA07_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Apr 2019 14:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1554302348; x=1585838348;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xdN0VT+4BDCZewj72gfJARjEuEJLYS06oqxp3VGtgfw=;
  b=jLcsXa4xzVubzr0cToFo5A+QWlUU9eAvO6BUlrgEIAWEI989yVFxQNSV
   z8VCxiNfvAH3qvQv+Z/o7y9Q6TcxlWG0LInOjD39uTr/7ayNWOkr5gbt6
   CJ8A+7yrsd+qOab/QD/qBtRtEPaMxqnkSu5mt3A+ZPOllUX/z2o8zGCrL
   5jdLO4ZY/mU1CelXzZHiiHLxVnV/EQygU1Yydc4rW476PvVB7dNyUebnc
   iOc8+BxjFCMlcTjylXdPa42UuRpcQy5L4R9zwE1NbVBDbCd8R9cEdcFQz
   T7QsMxxmg9J6I+iR4AzUoIp+pOjU8EPKjpbM1c959tJ3McLoRmqyFuXPa
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,304,1549929600"; 
   d="scan'208";a="22132999"
IronPort-PHdr: =?us-ascii?q?9a23=3A9HGxehHCmIL25vmko+wbPZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76oc69bnLW6fgltlLVR4KTs6sC17OP9fi7EjFZqdbZ6TZeKcQKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZ/Jqor1h?=
 =?us-ascii?q?fErHREduRLyWh1IV6fgwvw6t2/8ZJ+7yhcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdX4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMqoHoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0Mg2zw+bnEtp9zJgTWWaOAq?=
 =?us-ascii?q?+fLaPTvkWE5uM0LOmJfoMapDH9K/097f70kXA5gUMdfbWu3ZYPaXC0BPVnI0?=
 =?us-ascii?q?WCbnX2hNcBFnkKsxE5TOzvkF2CSyNTZ22pX6I9/D43EpimDZrbTIC3nLOBxD?=
 =?us-ascii?q?u7HoFRZm1eD1CME3joeoWAVvoXZyKSJchhkjMAVbe/UYMuyRautAriwbp9Mu?=
 =?us-ascii?q?XU4jEYtY7k1NVt5O3ciw899SdoAMSa1GGNTHp5kX8IRz8s26B/pE19ykqG0a?=
 =?us-ascii?q?RihPxYD9NT7etTUggmLZ7c0/B6C9fqVw3dZNiJU0ipQ9W9DDEqUt0xw8UBY1?=
 =?us-ascii?q?tzG9WmkB/DxTOmDKMPmLCRGJM09afc1WDrJ8lh03bGyLUhj14+T8tXL2Kmm6?=
 =?us-ascii?q?p/+hPLB4HTjkWZk7+mdaEb3C7K7meM03CCs11fUA51Sa/FR2wQZlPKrdTl4U?=
 =?us-ascii?q?PPV72uCbMnMgtH08KCKKxKat3zglVAX/fsJtLebnmtlGiqAxaIwbWMbIv2dG?=
 =?us-ascii?q?oH2CXRElQLkwcW/XyeLwgxGj+ho37CDDxpDV/vZ0Ls8e9jqHK0V0M0zgeKb1?=
 =?us-ascii?q?F/2Lq64B4VhOCcSvMI07IatycutS90EEy+393IEdqAoRRufKFGbdM6+ldH2n?=
 =?us-ascii?q?rTtxZhMZy4M6Bimlkefhx1v0z00RV3DIVAnNMlrHMtywpyJqaY301bezyE2p?=
 =?us-ascii?q?DwP6XdKnPu8xC3d67Wxlbe3c6S+qcO7vQ4tlrisBiyFkU873pnzsNV03qA5p?=
 =?us-ascii?q?TKFQYSVJXxXVsq9xh+ub7XeTc954zK2n12K6W0sSHN28gvBOQ7zhasZdBfML?=
 =?us-ascii?q?mLFFy6L8pPIsmrKaQYnFigdFpQLudS/bQcO8KgauvA2aSueu1nmWTixUVI55?=
 =?us-ascii?q?o14EKG/ix7VKac3tAXw/uR2AyZfzD5lE28qdv2kMZeeGdWVk+21TTkCZEZSa?=
 =?us-ascii?q?RoZ4sXFS/6Js+4m4RWiJnqVHpVslWkAgVCkOykdAHaRFv63kUE1kkaunegni?=
 =?us-ascii?q?iQxDxulDQos6/Z2zbBlaCqXxMcN38Df2JihEriJYWux4QRVVOlfiAynxus+E?=
 =?us-ascii?q?j+yrIer605JG7WFwMARyHrKylHVayqu/LWe8dS7LswuDhTFeG7ZkqXDLX6pk?=
 =?us-ascii?q?1emwHkH20W5jc7fjext5Oxyx59iGTbLnFzpXzCdMdYzh7Z49rdTvdVmDEBQX?=
 =?us-ascii?q?8rpyPQAw2HI9Sx/diS36zGu+S6WnPpAoZfagH33IiAs229/mQsDhqhyaPg0u?=
 =?us-ascii?q?b7GBQ3hHeon+JhUj/F+VOlP9jm?=
X-IPAS-Result: =?us-ascii?q?A2CQAAAPxKRc/wHyM5BlGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFmKoFrhDWTNUwBAQEBAQEGgTWJRpB0OwGEQAKFRCI3Bg0BAQMBAQEIA?=
 =?us-ascii?q?QMCAWwogjopAYJnAQUjBAsBBUEQCxgCAiYCAlcGAQwIAQGCXz+BaQ2tXHwzh?=
 =?us-ascii?q?AUBgUCEY4ELJAGIaIJKF3iBB4E4gms+h06CVwOlYwmTcgYaggWJbIZTggIti?=
 =?us-ascii?q?x6VcyKBVisIAhgIIQ+DKJATAVIjA4E1AQGPOAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 03 Apr 2019 14:39:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x33Ed3UB003845;
        Wed, 3 Apr 2019 10:39:03 -0400
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
 <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com>
 <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
 <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
 <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
 <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
 <1554292678.7309.47.camel@linux.ibm.com>
 <648f1a64-e95d-d929-62dc-06decaf5a14b@tycho.nsa.gov>
 <1554301990.7309.71.camel@linux.ibm.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d40b94ed-b9c8-d877-b109-d45c5472ae15@tycho.nsa.gov>
Date:   Wed, 3 Apr 2019 10:33:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1554301990.7309.71.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/3/19 10:33 AM, Mimi Zohar wrote:
> On Wed, 2019-04-03 at 09:10 -0400, Stephen Smalley wrote:
>> On 4/3/19 7:57 AM, Mimi Zohar wrote:
> 
>>> Let's separate the different types of attacks.  From an IMA
>>> perspective, memory attacks are out of scope.  That leaves mmap'ed
>>> files, possibly just mmap'ed shared files.  Currently IMA can be
>>> configured to verify a file's integrity, based on signatures, being
>>> mmap'ed execute.  Assuming that not all files opened require a file
>>> signature, a file could be mmap'ed read/write and later changed to
>>> execute to circumvent the mmap'ed execute signature requirement.  If
>>> the existing LSMs are able to prevent this sort of attack, we could
>>> just document this requirement.
>>
>> I guess I don't understand why IMA isn't already being called from
>> security_file_mprotect(). security_file_mprotect() could just call
>> ima_file_mmap(vma->vm_file, prot) if all of the security hooks pass.
>>
>> SELinux can be used to prevent unauthorized mprotect PROT_EXEC but it
>> won't perform a measurement of the file if it is allowed by policy.
> 
>  From a measurement perspective, this will at least measure the file,
> but the call to ima_file_mmap() will verify the file signature against
> the file, not what is currently in memory, right?

Yes, but you can use SELinux to prevent that (don't allow execmem or 
execmod permissions for that domain).



