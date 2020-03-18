Return-Path: <SRS0=DElp=5D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434FC10DCE
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Mar 2020 16:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67B420753
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Mar 2020 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584549424;
	bh=GtO3h5LfPzZi/9AqSF52rEVhhdDidm949zcOUZxWt3o=;
	h=Date:From:To:Subject:List-ID:From;
	b=IiWfmaki9WwDXJ01RTJJS03guO0qxE4Hs/Ci2oBRGxIQM9rKEOqYfAq2NBsPqeoFQ
	 zSTzpd0pXmuokLj8qiQKxAxeigoeNsz8T13SnnVf+0+rwOSV1O6mo+ThjMWgFXhoQV
	 3AdM/trCWFc+XoZFIGifyao6dhd+74WYsOJG6mEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCRQhE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:37:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38632 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgCRQhD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Mar 2020 12:37:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so9506756wrv.5
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=caW/QunyOk5mz+Kj+0iK5Gu+F5vdx65w78WqgIIoRGs=;
        b=ZjNx7Sf1n3+kVCFmJE+djiy5zPRTR6crhwkoSVVAFtwvOUFaPXzwHcVL/btuAtu4VV
         MCDH3TQ2g3Jim7CrimceXcYuOw5MPEDx5Lw+tfGklF/7Ls4uREQ0l129DrpRmGF4vdew
         O5EZ9oCLVd9PWxIofRwGil3cysplruRBp3HPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=caW/QunyOk5mz+Kj+0iK5Gu+F5vdx65w78WqgIIoRGs=;
        b=lgMKL2+exMO3kVa0mU1cSz+t6q894tWtarseO3gRRAOYq8sZQUQj9/3uBNuMUvH3SU
         f51aR5sopS0iIZsoIWc7vJleDHMGet8bjoY7v6/XvO36pS08i4expMRCQRiRVVKqR9u7
         sJ0twzhJbY0Lsa6BxiVA5T9GrFY3bWRxBZFd+bfKoRhZCak1FlNl6prUOYbKS8v98DlP
         dK2x+3tU7KPLZmFtg/rJ7ikQVoNyjzFirBCzWjan8r2/IRLyRIarZMwf5NxN28f3Ivwr
         wkYpZtKF6TUxynHVJTkx5hOCz6153GrOq3/HkVJL/lGvcgLnIG0tB38TIrezDXIi1Qr9
         g1rw==
X-Gm-Message-State: ANhLgQ0TS2AV6ktVPoIHyJZD+gjjluTBw4IDV6FsD4PWizHpLR51Afoy
        rC8XlSOB+bQAuMbqXgMMNeKfRnh04N4zIA==
X-Google-Smtp-Source: ADFU+vvkBKWqGB2FmNU0oDRqox2zhx6GoZfnb9uuMUIuPFzfGah+MCxo5STsaHA13xSSc8XiI6CxKw==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr6781833wrq.150.1584549420839;
        Wed, 18 Mar 2020 09:37:00 -0700 (PDT)
Received: from chatter.i7.local ([85.159.237.210])
        by smtp.gmail.com with ESMTPSA id z6sm9522080wrp.95.2020.03.18.09.36.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:36:59 -0700 (PDT)
Date:   Wed, 18 Mar 2020 12:36:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-security-module@vger.kernel.org
Subject: Looking for help testing patch attestation
Message-ID: <20200318163656.wxuta53jopgp5f2y@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello, all:

I'm reaching out to you because you're a security-oriented mailing list 
and would likely be among the folks most interested in end-to-end 
cryptographic patch attestation features -- or, at least, you're likely 
to be least indifferent about it. :)

In brief:

- the mechanism I propose uses an external mailing list for attestation 
  data, so list subscribers will see no changes to the mailing list 
  traffic at all (no proliferation of pgp signatures, extra junky 
  messages, etc)
- attestation can be submitted after the fact for patches/series that 
  were already sent to the list, so a maintainer can ask for attestation 
  to be provided post-fact before they apply the series to their git 
  tree
- a single attestation document is generated per series (or, in fact, 
  any collection of patches)

For technical details of the proposed scheme, please see the following 
LWN article:
https://lwn.net/Articles/813646/

The proposal is still experimental and requires more real-life testing 
before I feel comfortable inviting wider participation. This is why I am 
approaching individual lists that are likely to show interest in this 
idea.

If you are interested in participating, all you need to do is to install 
the "b4" tool and start submitting and checking patch attestation.  
Please see the following post for details:

https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

With any feedback, please email the tools@linux.kernel.org list in order 
to minimize off-topic conversations on this list.

Thanks in advance,
-- 
Konstantin Ryabitsev
The Linux Foundation
