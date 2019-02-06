Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A9C169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AD2175B
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="htgU56Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfBFRGh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:06:37 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:23102 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727218AbfBFRGh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 12:06:37 -0500
X-EEMSG-check-017: 231785907|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2019 17:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549472772; x=1581008772;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EebLuDJ7QVGk6P8gQildxf5gIdVBBdQfG0G+PpI+DfI=;
  b=htgU56GziF0Dk5eU0ooTpKPxUlyWRRocxRLxrtSCKXIFb5cZC0RuCvaM
   8HPMbQcl+v0v0oAPbVTnpVihOqv5AtpuQAqjr9ve8eR2b46Ql/hFABsR/
   z5UK1JLdHOwrKbophd38Rva6a4gwz4uBqSUcuv5Ck0rVMnSkk3EsCENis
   jkyna4F8tx8dKaw91c14V+h574Bnf+JCBcjr757zGcpCoQLcRzOfSI71i
   RxYSryH24vC7nENgVA5QxnTcmnLj5jCHYTMa0XAKoynMs93RdqCPDgCgv
   S4jmAHHLanGI9pZqCaY/hgeRwqexYisPgcCaZ9cpjn/Va/SCBTtwRl/m+
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="20265391"
IronPort-PHdr: =?us-ascii?q?9a23=3AP2U/sBfToRMhN7qzIMfUfX9rlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26YhWN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujaMbL7GZXCMHjCnaz6fb?=
 =?us-ascii?q?lh605T0hczzd5b551KELENOe78VVXruNPECR85NhS+w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?ebMKPXtl+I/PgvI+iXZIIOvjbyMf0l6ODvjXMjnl8dZ6ap14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9cZC2gKow4+QffyiFKYTD5TY2++X6c75jE8EoKpE53PSZyqgLyExC?=
 =?us-ascii?q?27BIFZZnhaClCQFnflb4GEW/YKaCKPLc5tiycEWqa9RI88zxGutRP6yrp+Iu?=
 =?us-ascii?q?rR/S0XqI/j1Nxr6ODIixEy+iJ7D96H32GOUW50hGUISCEy3Kxlpkx90FiDgu?=
 =?us-ascii?q?BEhKlzHMde9rtyWQczKJDYwvYyX9v7QQ/QVsyCSF+7TNGrG3Q6R5Q6xNpYJw?=
 =?us-ascii?q?5fEtCvlVjm2DCwAqRdw76OA4Yu87n02XH0Ksc7zGzJgu1pt1A7RoNqMmq8i+?=
 =?us-ascii?q?Yr7wHOA6bRmlid0qOtcr4RmiXK8THQ43CJuRRjTANoUajDFUsab0/SoMWxsl?=
 =?us-ascii?q?jOVJeyGL8nNU1H0sfEJaxUPI66xW5aTevubYyNK1m6nH29UFPRnOuB?=
X-IPAS-Result: =?us-ascii?q?A2BYAgDUEltc/wHyM5BlGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YEzBTKEKpQGUgaBCAgliTWQVTgBhEACgxoiOBIBAwEBAQEBAQIBbCiCOikBg?=
 =?us-ascii?q?mcBBSMVQRALGAICJgICVwYBDAgBAYJfP4F1Da0tgS+FRIR3gQuLOBd4gQeBO?=
 =?us-ascii?q?AyCX4gKglcCkQA6kU4Jkj0GGZJOiiyTSyGBVisIAhgIIQ8aIYJtgicXjjwhA?=
 =?us-ascii?q?4E1AQGNcwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2019 17:06:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x16H64fM018918;
        Wed, 6 Feb 2019 12:06:04 -0500
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6598f48a-f50f-1976-f766-126c0a43f7d9@tycho.nsa.gov>
Date:   Wed, 6 Feb 2019 12:06:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e1492ac6-d1b2-ce2b-c0df-1f30601747ad@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/6/19 11:30 AM, Casey Schaufler wrote:
> On 2/5/2019 5:11 PM, James Morris wrote:
>> On Tue, 5 Feb 2019, Paul Moore wrote:
>>
>>> I believe that will always be a problem, no matter what we do.  The
>>> point I was trying to make was that everyone, especially the
>>> maintainers, need to watch for this when patches are posted and make
>>> sure the patch author posts to the LSM list in addition to any of the
>>> relevant LSM specific lists.
>> Right, and there is no way a new LSM hook should ever be added to the
>> kernel without review and ack/signoffs from folks on the LSM list
>> (especially those who are maintainers of in-tree LSMs).
>>
>> Casey, do you have any examples of this happening?
> 
> overlayfs (according to my records - which may be flawed)
> is a prime example. Inifiniband hooks were reviewed/acked
> for SELinux, but there was never an attempt made to work
> with other security module maintainers. Yes, they were posted
> to LSM, but under the title "SELinux support for Infiniband".

overlayfs hooks were also posted to and discussed on lsm list, including 
comments from you.  Admittedly the cover patch said Overlayfs SELinux 
Support but the individual patches for the hooks were "security, 
overlayfs: provide copy up security hook for unioned files" and 
"security,overlayfs: Provide security hook for copy up of xattrs for 
overlay file".

In either case, did you request a change that was ignored?


