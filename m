Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B7C169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003E220844
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="m0rHK+8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfBFNVC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:21:02 -0500
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:28740 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfBFNVC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 08:21:02 -0500
X-EEMSG-check-017: 382880668|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2019 13:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549459260; x=1580995260;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6+z2VzC31vGuYnuskcYXaAMKf4DTahsKkSHRgohIfbY=;
  b=m0rHK+8t8tee7vcAAzfEQIG+Rn1GWUZcR7RobxvKjpgxp7nKsb6sQOA+
   YyZyOa4kGnxBcweCqC3E6nqimWwq/UobvLSeIU0B/a54m49ix0jagsbFC
   X6WmjYTlAxBgVI+sz+AxGKoGs3mGl9laFNv4tqmAAJMI/zcsweKR7BO42
   P8Ex/wO+KwJuZK6STOjgetsFo+DcAdx9LNNxG0anARuVMwXeVbJPPCTfV
   MsVzuPUsAC/i+fX7CoH83EHwmio7iU7153tOxxPQqlcXujTU70958ZYg2
   kz6k2LVVUMW+3r0G2j29B3ByqYYPJ6aatPSRzcp/RVfKfKzOQD9g9skES
   A==;
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="20248687"
IronPort-PHdr: =?us-ascii?q?9a23=3An1nu1B2upjy+8JCRsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWK/XxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkyukDduwPDGJKfhApTWLnXYlrfuZ7?=
 =?us-ascii?q?N95FBdyAYpytBf/Z1UAKkbIP3vQk/xqMDYDhghPgys2ennFdF925gGWW2VH6?=
 =?us-ascii?q?+ZNLresVqP5uIoOemDepUZtyr6K/gg//Tul2M2mUcBfam12psacGy3Ee59I0?=
 =?us-ascii?q?qHYXvhmcwBHnsKvgUkUezqhlmCXiBJZ3qrQ60z/Cs3B56hDYfGXoqtmqCO3D?=
 =?us-ascii?q?+nHp1KYWBLElSMEXbud4WZVPYAcTmSLdF9nTwZT7ihSpMh1BG3uA//zLpoM/?=
 =?us-ascii?q?fU+ikGup/4yth16PPclQso+Tx3EcudyWeNQH9wnm8SQD82xq9/8gRBzQKh2K?=
 =?us-ascii?q?11mLR9EsZJ5ugBBgU/MoTGzvdSDdn3VwOHec2GHhLuety7BXkUSdUrzpdae0?=
 =?us-ascii?q?9gH/26hw3Hmi+tBKUY0beMAcpn3Ljb2i3KO8tly3vAnJIkhl0iT9oHYXaqnY?=
 =?us-ascii?q?Zj5gPTAMjPiEzfmKG0I/dPlBXR/XuOmDLd9HpTVxR9BOCcBygS?=
X-IPAS-Result: =?us-ascii?q?A2CKBQDi3lpc/wHyM5BlGwEBAQEDAQEBBwMBAQGBZQKBV?=
 =?us-ascii?q?AUpgTcBMoQqlFEBAQEBAQEGgQgIJYk1jluBejgBhEACgxkiOwMMAQMBAQEBA?=
 =?us-ascii?q?QECAWwogjopAYJnAQUjFUEQCw4KAgImAgJXBgEMCAEBgl8/gXUNrH+BL4VEh?=
 =?us-ascii?q?HiBC4s4F3iBB4E4DIJfiAqCVwKRADqRTgmSPQYZkk6KLJNdAQ6BVisIAhgII?=
 =?us-ascii?q?Q87gm2QeiEDgTUBAY1zAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2019 13:20:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x16DKjOh011350;
        Wed, 6 Feb 2019 08:20:45 -0500
Subject: Re: New LSM hooks
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com>
 <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
 <CAHC9VhQ6p=LoEN6Rqze48FrVDsX0mfXHY4BvEaxU97w1azP4YQ@mail.gmail.com>
 <alpine.LRH.2.21.1902061207010.19811@namei.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <84c96e67-6668-b954-0a6b-2bccb00c124c@tycho.nsa.gov>
Date:   Wed, 6 Feb 2019 08:20:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1902061207010.19811@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/5/19 8:11 PM, James Morris wrote:
> On Tue, 5 Feb 2019, Paul Moore wrote:
> 
>> I believe that will always be a problem, no matter what we do.  The
>> point I was trying to make was that everyone, especially the
>> maintainers, need to watch for this when patches are posted and make
>> sure the patch author posts to the LSM list in addition to any of the
>> relevant LSM specific lists.
> 
> Right, and there is no way a new LSM hook should ever be added to the
> kernel without review and ack/signoffs from folks on the LSM list
> (especially those who are maintainers of in-tree LSMs).
> 
> Casey, do you have any examples of this happening?

Most of the times I've seen that it has come from vfs folks or other 
subsystems as part of some major reworking of that subsystem rather than 
from security module developers, e.g. the mount hooks overhaul.
