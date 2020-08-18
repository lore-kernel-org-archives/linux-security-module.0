Return-Path: <SRS0=wQ8B=B4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF26C433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D602065D
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="F3TJolfs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S1ijLZW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHRQTx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:19:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51336 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgHRQTj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 12:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5F2EA8EE1A9;
        Tue, 18 Aug 2020 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597767575;
        bh=L/MN+lxn8x8KGJbs1vAEkdW/rjO9wlNxW0FetUNgKJE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F3TJolfs2dnkOc99Rj/5Zn8QU8AwiBtf/PoD+Ybd46WQYFKE47TMO4K9Rse9ySnha
         K8EiUDemagYiEcnjDJ3wb7TRylgGNWzB4SBFLklBk+HUeu6VYP1lI7fBVPerHFKl2G
         4AG081qyKmoSiPoq1FuBRwnepFJ2OsaN6DveGoOc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5V37A5Z9zYZ5; Tue, 18 Aug 2020 09:19:34 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1EEAE8EE17F;
        Tue, 18 Aug 2020 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597767574;
        bh=L/MN+lxn8x8KGJbs1vAEkdW/rjO9wlNxW0FetUNgKJE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S1ijLZW5ep+iwtdY2BSLm5T+ZmNajMO7m+g+9JVex4iRAXkSI2+oCoXpb2vIS3IKS
         SC1rbcuo8t6pBK5PPcflRruDFKgZ7qdmGNInHRGVS68Dq7jZisFZrfRFusbJqEojj1
         BioijcDNFNk01kzf/xCm0lQWStYSXsperJU1UIBc=
Message-ID: <1597767571.3898.15.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     krzysztof.struczynski@huawei.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, stefanb@linux.vnet.ibm.com,
        sunyuqiong1988@gmail.com, mkayaalp@cs.binghamton.edu,
        dmitry.kasatkin@gmail.com, serge@hallyn.com, jmorris@namei.org,
        christian@brauner.io, silviu.vlasceanu@huawei.com,
        roberto.sassu@huawei.com
Date:   Tue, 18 Aug 2020 09:19:31 -0700
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N> <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2020-08-18 at 17:20 +0200, krzysztof.struczynski@huawei.com
wrote:
> The measurement list remains global, with the assumption that there
> is only one TPM in the system. Each IMA namespace has a unique ID,
> that allows to track measurements per IMA namespace. Processes in one
> namespace, have access only to the measurements from that namespace.
> The exception is made for the initial IMA namespace, whose processes
> have access to all entries.

So I think this can work in the use case where the system owner is
responsible for doing the logging and attestation and the tenants just
trust the owner without requiring an attestation.  However, in a multi-
tenant system you need a way for the attestation to be per-container
(because the combined list of who executed what would be a security
leak between tenants).  Since we can't virtualise the PCRs without
introducing a vtpm this is going to require a vtpm infrastructure like
that used for virtual machines and then we can do IMA logging per
container.

I don't think the above has to be in your first patch set, we just have
to have an idea of how it could be done to show that nothing in this
patch set precludes a follow on from doing this.

James

