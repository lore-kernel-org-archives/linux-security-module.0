Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B97C169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0985E2073D
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HcHSGfGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfBFRrP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:47:15 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:59125 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbfBFRqP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:15 -0500
X-EEMSG-check-017: 675297755|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="675297755"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2019 17:45:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549475147; x=1581011147;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=n4Kdvefi7wvVZ/0xU4XbOOZHyFbW5yodL4b+I0ni9Dg=;
  b=HcHSGfGGwkKpDeK6a2kvewR/F9RJ1ERCiUSi83O74alzymH0gLOSJyOp
   xNUICrx6JChTfjNmZXXrbyGK+730RPjl1lL3/nTTSxWF3/8+khoxRalhf
   I5o2RlZZwpPb53DWexh3CEd/TjHnIB9qLsFFf3XZ51GU7FZzJEULwoM3a
   w2yJai3fbP/51uDespcbEj5n/n5GeDa5bIsgZ7apVTRmRx+Czp54GXOzB
   lL8PiTs5oNp0cj5csTCqHvQy8AvspYH9rUvlXYYpAfGmZxGQvSeTmT8AD
   5MD1sO+nKBadNk1BanMru+aH0p7jgLgx13C2lucmFxbdg/XDCM3vXgdFw
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="23585294"
IronPort-PHdr: =?us-ascii?q?9a23=3AZBDbHR3MXQsrLBLpsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWLP3xwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDs27ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkywnzhx3PDJIL3gD47WLnffkLfuZ6?=
 =?us-ascii?q?t960BYyAUt19BT/o5bBasbLP3vXU/xscTSDgUlPAys3+bnFNJ925scWWKKBa?=
 =?us-ascii?q?+ZKrnSsV6T5u80JemDfooVtyj8K/Q/4P7ul3A5k0cHfaa1xZsXdGy4HvN+Lk?=
 =?us-ascii?q?WBe3Xsn9MBHHwSvgUkUezqjESOUTtUZ3a1RaIz+Cs3B56hDYfGXoqtmqCO3D?=
 =?us-ascii?q?+nHp1KYWBLElSMEXbud4WZVPYAcTmSLdF9nTwZT7ihSpMh1BG3uA//zLpoM/?=
 =?us-ascii?q?fU+ikGup/4yth16PPclQso+Tx3EcudyWeNQH9wnm8SQD82xq9/8gRBzQKo2L?=
 =?us-ascii?q?N1krRjHtxa+v1NXx1yYZXV1OFrI8v5WgvccNOEUhOtS5OtBjRnCpoTytoDeA?=
 =?us-ascii?q?5YHM+4jwuLiyivBKUPlqejApUx/6Oa2GL+cYI183/b0OEEiF48T4MbLWS7go?=
 =?us-ascii?q?Zn/hXXQovOlF+U0a2tcPJP8jTK8TK40WeWvExeGDV1WKHBUGFXMlDatvzl90?=
 =?us-ascii?q?jCSPmoEr1hPQxfn53RYpBWY8Hk2A0VDMzoP87TNifowT+9?=
X-IPAS-Result: =?us-ascii?q?A2BFCgDWHFtc/wHyM5BlHAEBAQQBAQcEAQGBZQKBVAUpg?=
 =?us-ascii?q?TMFMoQqlAZSBoEILYk1kFU4AYRAAoMaIjkFDAEDAQEBAQEBAgFsKII6KQGCZ?=
 =?us-ascii?q?wEFIw8BBUEQCxIGAgImAgJJDgYBDAgBAYJfP4F1Da0vgS+FRIR1gQuLOBd4g?=
 =?us-ascii?q?QeBOIJriAqCVwKROpFOCZI9BhmSToosk0wggVYrCAIYCCEPO4JtgicXjjwhA?=
 =?us-ascii?q?4E1AQGNcwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2019 17:44:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x16Hirxi030646;
        Wed, 6 Feb 2019 12:44:53 -0500
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
 <84c96e67-6668-b954-0a6b-2bccb00c124c@tycho.nsa.gov>
 <ca70d18c-3576-fce9-a65b-faf585a536b2@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bd373344-fdfe-ff58-ff06-3b36df623648@tycho.nsa.gov>
Date:   Wed, 6 Feb 2019 12:44:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ca70d18c-3576-fce9-a65b-faf585a536b2@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/6/19 12:24 PM, Casey Schaufler wrote:
> On 2/6/2019 5:20 AM, Stephen Smalley wrote:
>> On 2/5/19 8:11 PM, James Morris wrote:
>>> On Tue, 5 Feb 2019, Paul Moore wrote:
>>>
>>>> I believe that will always be a problem, no matter what we do.  The
>>>> point I was trying to make was that everyone, especially the
>>>> maintainers, need to watch for this when patches are posted and make
>>>> sure the patch author posts to the LSM list in addition to any of the
>>>> relevant LSM specific lists.
>>>
>>> Right, and there is no way a new LSM hook should ever be added to the
>>> kernel without review and ack/signoffs from folks on the LSM list
>>> (especially those who are maintainers of in-tree LSMs).
>>>
>>> Casey, do you have any examples of this happening?
>>
>> Most of the times I've seen that it has come from vfs folks or other subsystems as part of some major reworking of that subsystem rather than from security module developers, e.g. the mount hooks overhaul.
> 
> David Howells did contact me directly on the mount hook
> changes well in advance. I'm more concerned with special
> purpose hooks like we have for binder, kernfs, nfs, tun,
> Infiniband and bpf. I'm not saying that we never need to
> provide hooks with a single user, but you do have to
> wonder about security_ismaclabel().

binder is an IPC mechanism, so just like all the other IPC mechanisms, 
we needed hooks to mediate it.  No different than having hooks for 
System V IPC or Unix sockets. If LSM were a proper abstraction layer 
like the Flask architecture or even the BSD MAC framework, then we'd 
have some general purpose access control interface with a small number 
of entrypoints to invoke, but instead we just push all of that behind 
the LSM interface.  I wasn't an advocate for the LSM approach at the 
time but it is what was adopted and we have to live with it.

kernfs doesn't follow the usual rules for inode setup, so we have to 
play by its rules. Not our choice to make, and there is a reason why 
kernfs is the way it is.

NFSv4.2 chose to support MAC labels as a first class citizen rather than 
just xattrs (and there was a reason for that too), so we need a 
different path for getting and setting those labels.

And so on for tun, infiniband, and bpf.  Remember that LSM by design 
does nothing more than expose the kernel objects and operations to the 
security modules and leaves it up to the module writer to do everything 
else.

