Return-Path: <SRS0=tN9D=MW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E023C43441
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Oct 2018 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D50C2086E
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Oct 2018 16:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AM7qNIw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D50C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJJX1w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:27:52 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:40131 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJX1w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Oct 2018 19:27:52 -0400
Received: by mail-it1-f172.google.com with SMTP id i191-v6so8752369iti.5
        for <linux-security-module@vger.kernel.org>; Wed, 10 Oct 2018 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YENGBCtGDNENNafXWlxBBnZvNNyOBfbIEYW1DazFJdI=;
        b=AM7qNIw/AG7JWezmvLXawibayAaFFEJ+TAQCUJAlFO17Kk4np/iT6FoOrgjNcYdcO2
         w0/6n7HY3Fe3pfjLHIfxqcefVD1WVmKMUTrrUc2d24b6DTDkC8GL0q1vct4Rk/HCy3Bb
         P6uZ9GsPZk2cdyN21tbOpUNINCUBPD7GQJXQlZTJzvFS5w8rYXATWmrYSahiwJ1Hrqcu
         iQyhGTpDur2G9dShgG4rbGGtgJooTk3B0vV7hRcOy6D1Kz/aqga17EdMKuXAtk1Lki0M
         tqYWcDt5UwG+43zPKzi3IeiQDysOkyq39+Q+fPI0b/Bvk16m6P74QEcHgDQnoz99phQP
         XOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YENGBCtGDNENNafXWlxBBnZvNNyOBfbIEYW1DazFJdI=;
        b=ug58tACfv+RRKs5QcGfI8e9hAoSA1FWtcjamekZypUtvt+Qr2ZDo+Dm/lJNilsaqSw
         gvvyKamZkUnNAzNENSmHDHZSd1RX3pL3RHrsAHtxhTLVBfn85TgCTvJ+/jiMV9xtJ3kK
         eUIUZCQJTmGgbKHa66Iu37afNBrgAIzBBdMhQxkLcUjlmRtlAh1H1s0idwGdKx/t6hqb
         SpUGBSUefeVLvdOxEBDAUdAma0RkIoa+DgIk3xFWlunM2tO730K64Zu35q1mj8gyY4Dm
         +IzCLBey0OLivKpsmRQU4pUGmngr4IueOLSmCbEsCkEebgCauCziHuRE2sXRCA9hoeSP
         IfJg==
X-Gm-Message-State: ABuFfogHNnLXpOT95FqdRBYJ70cd0lbv8coxT5mVz0gOub26XMP6CHYp
        6jlXbMRYgmf00t1sgj9QcFrSf/ta3YDEN52MafbEHten
X-Google-Smtp-Source: ACcGV61ju2hyMK6WIAVYiuNazqmDRVQkqqEyH3Ug+sLaS8EVOSqmQeZggf66Y8bZlo0GI3t4pJoBHYqcN97wXZInWdw=
X-Received: by 2002:a24:1fc1:: with SMTP id d184-v6mr1339264itd.142.1539187502122;
 Wed, 10 Oct 2018 09:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181010104228.GA15360@mwanda>
In-Reply-To: <20181010104228.GA15360@mwanda>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 10 Oct 2018 09:04:50 -0700
Message-ID: <CACdnJuvHVrNNnHDBV0JuugB3Xvkc+FGZ1CX1CymTod6mA2t84A@mail.gmail.com>
Subject: Re: [bug report] apparmor: Parse secmark policy
To:     dan.carpenter@oracle.com
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 10, 2018 at 3:42 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Smatch thinks that these need to be zeroed for security.  I don't know
> the details though.

I don't think these are secret.
