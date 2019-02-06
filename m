Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428CC282CB
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 01:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CC92175B
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 01:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfBFBLZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:11:25 -0500
Received: from namei.org ([65.99.196.166]:50496 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBFBLZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 20:11:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x161BKxt020212;
        Wed, 6 Feb 2019 01:11:20 GMT
Date:   Wed, 6 Feb 2019 12:11:20 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>
Subject: Re: New LSM hooks
In-Reply-To: <CAHC9VhQ6p=LoEN6Rqze48FrVDsX0mfXHY4BvEaxU97w1azP4YQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1902061207010.19811@namei.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com> <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com> <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
 <CAHC9VhQ6p=LoEN6Rqze48FrVDsX0mfXHY4BvEaxU97w1azP4YQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 5 Feb 2019, Paul Moore wrote:

> I believe that will always be a problem, no matter what we do.  The
> point I was trying to make was that everyone, especially the
> maintainers, need to watch for this when patches are posted and make
> sure the patch author posts to the LSM list in addition to any of the
> relevant LSM specific lists.

Right, and there is no way a new LSM hook should ever be added to the 
kernel without review and ack/signoffs from folks on the LSM list 
(especially those who are maintainers of in-tree LSMs).

Casey, do you have any examples of this happening?


-- 
James Morris
<jmorris@namei.org>

