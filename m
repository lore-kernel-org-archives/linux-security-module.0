Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB7C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBAF206DD
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 12:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="LW6ltFme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfC2Mae (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:30:34 -0400
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:17226 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729411AbfC2Mae (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 08:30:34 -0400
X-EEMSG-check-017: 125744591|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Mar 2019 12:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1553862632; x=1585398632;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TLnDQodnLwD7o3gpAwB2DCKbb725S5UY1ldLWOLqbIQ=;
  b=LW6ltFmepLsFS9z0Id3sqsoV0awgh7fHVRYaDMIfrzd4i6Ynke6kVPtA
   AXnpaowlQ98NgDm1J4vlU9MtC+ede4greKu+sFdbzFAjYmEnx44ceZp82
   tdMFM/qOTGbFR3oPL4nixvj0Wbb2Lzq6/wRCLUi+35WOehueZTPjNHGzp
   6j3gBnSLhmbjNRIOEnJrKiToGknEcIV/cJNYmo8BE9KT54r1tAoYy4HAM
   ZQIQ5U6bevEg37hTpwUE4wvz+INl/aykM8iLy73weHTCOSOq9BY3fvytw
   Gus3pbtQN73eM8ZhjnzjX8aJqo0Cq/E5tl1NK1JnEfEhnJWUADSqlJcS8
   g==;
X-IronPort-AV: E=Sophos;i="5.60,284,1549929600"; 
   d="scan'208";a="25628522"
IronPort-PHdr: =?us-ascii?q?9a23=3AfCT91hQBPU67HHcwR7ftjOlHn9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YheAt8tkgFKBZ4jH8fUM07OQ7/m4Hzxfqs/a+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiqoQnLtcQbg4RuJrs/xx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBWzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzjjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXm9muCE/yrIcuJ?=
 =?us-ascii?q?67ejAHyJs9xx7EdfOIb5WI4gjiVOaNITZ0nnRld6yjhxu07EOuyfX8W9Gp3F?=
 =?us-ascii?q?tFoSdJiNnBum0X2xDN5cWLVOFx8lqn1D2SzQ7c8PtELloxlafDLp4hxaM/mY?=
 =?us-ascii?q?QLvETYGy/2hF32jKiLdkU44uSo6/roYrHhppKEK497kBv+MqUzmsykG+g4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1H2QK5WgfEsl6nZsZTaKdwapq6/HQBVzp4u5wuwAjqpyt?=
 =?us-ascii?q?gVnWQLIEhbdB+IkYTlIUzCLOj9DfilglSslDlrx+rBPr3kGpjNNWXMkKz6cL?=
 =?us-ascii?q?Zh609T1AozzddF65JSEbEOOuj/WkD2tNzGFhM5KRC7w/77CNVh0YMTQWOOAq?=
 =?us-ascii?q?iZMKzIq1+F/eYvI+iKZI8ItzfxMfkl6OXrjXMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9cAC2sLvwo+Q/fwh12EVj5TeW2/X6U55jEjEoKmEJzDRpusgLObxi?=
 =?us-ascii?q?u7BIBWbHhcCl+QCXfoa5mEW/AUZSKXIM9hnTwJWLy6Ro8u0hGuswD6y755Ie?=
 =?us-ascii?q?bO5iIYspfj3sBv5+LPjREy6SB0D8OF3mGOUW57gHgISCMx3KB4okxw0UuM0a?=
 =?us-ascii?q?hig/xfENxT5u5JUgIgOZ7b1ex6BMj4WhjdcdeRVFamXtKmDCktQd0r2N8BfU?=
 =?us-ascii?q?Z8Fs65jh/f3yqlGaIVl7KPBJMq6KLQxmT+KNxnx3na06khikEsQtFTOm2+mq?=
 =?us-ascii?q?5/6w/TCpbRk0qDiqaqcb8R3DbX+2eeyWqCpURYUAl3UaXfQ38TfFfZrdP85k?=
 =?us-ascii?q?naVb+hFawnMhddyc6FMqZKaNrpjVVARPv5OtTeZGKxlH22BRaT2LyMapHndH?=
 =?us-ascii?q?kH0yXbD0gElQET8mqcOgg6HCuuv2XeDDl2H1L1f0zs6fV+qG+8TkIsywGKbk?=
 =?us-ascii?q?th16e6+xIMhPycTe8T0awLuCc7qjV0AFa80snIC9qPuQVhZr9QYdAj71dd02?=
 =?us-ascii?q?LWqQh9MoanL6B4iV4Uax53sF/21xVrFoVAltAnrHEwwwp0L6KY0EhMdzyf3Z?=
 =?us-ascii?q?D3Nb3XLnf98AqzZK7R31HUyMyW9bsX6PQkt1XjuxmkFk4j83VhztlU3GKQ5o?=
 =?us-ascii?q?7UAwUOTJLxSEc39wR6pr3DZyk94J7b1WBoMaaqqTLCxd0pC/U/yhq6fNdQLr?=
 =?us-ascii?q?mEFAnsHM0eHcSuL/Yqm1f6Ji4DacVT8a98DcSmfuHOjLysPO96tDani3lXpo?=
 =?us-ascii?q?F31wSH8C8qDqbp0JEfi8OY1AKBUCm02FbnoMD9kIZDexkVG3Kl1DP/BYcXfL?=
 =?us-ascii?q?AkOc4uAHuyI8Cojvp3nYTgR2IQoFuhCA5X8MCufhWWYhr22ggGkQw0rHG80Q?=
 =?us-ascii?q?C/yD88xzIko7GU2yvN6+/ibh0CO3NOAm54ggGoaaO9lN0LFHOjbwE0mh+o/w?=
 =?us-ascii?q?6uzKFAqbVXNGLTSFpGeyXsamprFKC3s+zGK/ZG9ZdglCJQSun0NUiTV7rVux?=
 =?us-ascii?q?IH12bmGGxEyXYwcDT8/t3bmBx8wECaLH91t3ffMZVywhfZot7bRfdXxTcAbC?=
 =?us-ascii?q?Jxjz7RB1O1O5+i+tDCxLnZteXrbH6sTp1ed2HQyIqEsCaqrTlxDQaXg+G4mt?=
 =?us-ascii?q?qhFxMzlyD8yY85Bm3zsB/gb9yzhOyBOuV9cxwtXQSt5g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A4AQDsDp5c/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFnK?=
 =?us-ascii?q?mhQMyeEDpNFTAEBAQEBAQaBNYlGkHEyCAGEQAKFNyI4EgEBAwEBAQgBAwIBb?=
 =?us-ascii?q?BwMgjopAYJnAQUjDwEFNgsQCxgCAiYCAlcGAQwIAQGCXz8BgWgND6kOgS+EB?=
 =?us-ascii?q?AE/QUGEZgWBCySLMhd4gQeBOIJrPodOglcDpSsJh2yLVQYalAwtin+GCY89I?=
 =?us-ascii?q?YFWKwgCGAghDzuCbIpRhUMBUiMDMAELeQEBjm4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Mar 2019 12:30:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2TCUS6Z008999;
        Fri, 29 Mar 2019 08:30:29 -0400
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
 <1552945715.8658.299.camel@linux.ibm.com>
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
Date:   Fri, 29 Mar 2019 08:28:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553857187.9420.49.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/29/19 6:59 AM, Mimi Zohar wrote:
> [Cc'ing the LSM mailing list and others]
> 
> On Fri, 2019-03-29 at 13:00 +0300, Igor Zhbanov wrote:
>> Hi Mimi,On 28.03.2019 20:17, Mimi Zohar wrote:
> 
>>> I just came across the grsecurity article on mprotect.[1]
>>>   Has anyone looked at it? Would it make sense to make it a minor LSM?
>>>
>>> [1]https://pax.grsecurity.net/docs/mprotect.txt
>>
>> Interesting article. It is almost exactly of what I wanted to be implemented.
>>
>> If this minor LSM would be stackable to allow combining with e.g. SELinux
>> then why not.
> 
> Stacking shouldn't be a problem.  Other LSMs are already on the
> mprotect hook.  Let's hear what others think.

SELinux already provides a set of controls over executable mappings; see 
selinux_mmap_file and selinux_file_mprotect. Other major security 
modules may do likewise but I can't speak to that. Is there some gap you 
are trying to address that isn't already covered, or are you just trying 
to provide such restrictions without requiring one of the major modules?



