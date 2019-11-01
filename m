Return-Path: <SRS0=4y41=YZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99DCCA9ED1
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C114B2085B
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572646364;
	bh=R3zHF33lXpbXV7nnsIRwzSf5C2VJ9cDXB6diPjhN9b0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w/EN9gQ+P8bGddECfgh7vKayk2VujqROwnA9XrLy/WlRBicAsZwLCBVaqQd7IpOrl
	 g5kTfEuNBhFdLJ87mmLJfgWPVjA5K4lcfpkBcPwtQ700/dagc6d9cAPa2+lCAW1amW
	 5RBTo0Vj/T5XnD30WW9T3psMeVOkfO/722HiGjrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfKAWMn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33839 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfKAWMm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id 139so11724133ljf.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2019 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=O3mYYvlU9vmiWCuVM7D5zeynWjET9sBTNe2UP3ZA3GeXbBriHFMqoPk2kJgyTgcAeI
         BstBtBLU16kkJaWSMcP9+57VaYHHgUIqojJCqULremk/l27m2Dlyko2Sd9hhC3Y74UKd
         ZPG4og+yRVtEHOd/O+5D/qMCxYtxUKUSxHi24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=Udjt+qpuq8PatWPXB9FY/ZQwE/kD1wEG6JB5ZjaY4X8kVM7mXfPm53+8aNlDgrna1D
         y7xijgO9SzBuxBuDlJHwJUtctT1GQCKjhuuP1Vu+QSCYBgFxfDthwGBAQ7jZ3slVE+An
         ws9uJEHRsTMAHXKYXiZgC3++Rwd89uiMdo+oRSD0d7adu5yQsdyIB1FX2MwKWSjID4o6
         3IpVWc7Ei48R1Vcj/2nwiv0ROHnrJwlXFAKRxcI2KgE+pn208VIR2dRsQ3Fc0TMie+mA
         TP4fdCWdJd+eVrFdWyZz1vTIusmZE+sWK3CwVXdsFktHlOSv9bn8gbMx+0qsDSoioMt2
         3JSQ==
X-Gm-Message-State: APjAAAWuWavgeK7EBywzi6YVtFH4GWLtwSGQPx3LicAnsf5F8KTeWUjZ
        HHG0zp3aulau52EZ4OZgppGi9XgMBks=
X-Google-Smtp-Source: APXvYqzVIDF6kYGCc2ucDwyaCZdvJfRlyO5M+ZxuLshehcG25cgWC+O7tsy5+yr0IFjdjgwQyFKj2A==
X-Received: by 2002:a2e:7004:: with SMTP id l4mr9656111ljc.158.1572646360517;
        Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id l21sm3301338lje.0.2019.11.01.15.12.39
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id q28so8268063lfa.5
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2019 15:12:39 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr8678681lfc.79.1572646359613;
 Fri, 01 Nov 2019 15:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
 <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com> <13964.1572645926@warthog.procyon.org.uk>
In-Reply-To: <13964.1572645926@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 15:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] pipe: Notification queue preparation [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 1, 2019 at 3:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Changing those to non-sync:

Your benchmark seems very insensitive to just about any changes.

I suspect it is because you only test throughput. Latency is what the
pipe wakeup has been optimized for, and which tends to be much more
sensitive to other changes too (eg locking).

That said, I'm not convinced a latency test would show much either.

               Linus
