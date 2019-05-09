Return-Path: <SRS0=3Nce=TJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED03DC04AB1
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 20:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62E1217D6
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 20:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557432177;
	bh=FOz+peWbqu/9LVyp5oUypIKzVeLSwt+4vk/iJcA/Fgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0ZQ2RRFdMV5JCbMAAy2QF0L/wrXwnp8Ixo2MjyYzC90LVoiNjlD8xXlYGjxpiuQ8O
	 UpwjEIZEBB/5OhuI+9BkbqVPjAshag33StDueOhD2/vxHuUohbP3KBSoR8DpkY5ob2
	 ppJKZNKp8snIzomLeDk4KBJyRgnmOnHtsNutFCqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfEIUC5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 May 2019 16:02:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42767 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfEIUC4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 16:02:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so2449591lfc.9
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2019 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4anO6pxSRUxDlu2sUWMVHQAiL8Bolm2+gGT+GjS3ttQ=;
        b=GS3qFODCQVjeYSc6JidZ3mDeRER/QJYCQOCN54RdOsfSDjp82uFPrOvVqigR3Rx2Xm
         AvSqYT9ePjUuDg8qUDoTnHJNiyPRIbl6hFaBYEs6aqNTUw78JxwKwBIFtTocASmhRzfC
         sQCL/0hFgsyIXKoXIkVF4Sw3yVPXrhE7TNfPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4anO6pxSRUxDlu2sUWMVHQAiL8Bolm2+gGT+GjS3ttQ=;
        b=VYAqjRBnrvrUsNUqkH0J5sr08EBWPoA1MfUwufQuyAtHbFoArQKfEYCwFvPpuwdGZE
         b6G0sAGvvC3gB4zpL5WfsEBC+reNsavhXXcA1kVIYNc4RqnCIq4/RfwuLiOPqxSTnaC2
         GaAbf2GMe46XBt9doVmUX3QmUm7l9BRLWMhCtWeVltRsy75gWixRhMWK/HOSy73Q1lKU
         Eopni2QOkRtBomPTVn9zYgvWxU/ojo3UtZVnqWa1ZxGc94Zw3vFBqskZgJ9o4nVfXWJj
         978GQ/w1++O1CCmEURukUd+oXFuMjyPpo3gMPddE/4HZap4lXfUxGDnrhU5NL4WGJp/6
         /PqA==
X-Gm-Message-State: APjAAAXkv5APPqSTo6DuJFAzEi544IDhx7/xIRI0uUVPeD4ygJmeG2ox
        yXifeLQSk5PDdUu3v63VRMY3rOfZI6c=
X-Google-Smtp-Source: APXvYqy+xInInNa4v+5Mp10xcdR3bMoLo4+KGCyd8m2ksxgiGLMF2PLxzJfAHP9FwedabmYUIWm6WQ==
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr3453157lfl.120.1557432174611;
        Thu, 09 May 2019 13:02:54 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s12sm559179ljd.66.2019.05.09.13.02.53
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:02:53 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id z1so3123420ljb.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2019 13:02:53 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1796660ljh.22.1557432173233;
 Thu, 09 May 2019 13:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905100325330.25349@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905100325330.25349@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 13:02:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjfZSxaivGyE0A3S2ZHCi=BVGdwG4++QVS80OTshBR1Q@mail.gmail.com>
Message-ID: <CAHk-=wjjfZSxaivGyE0A3S2ZHCi=BVGdwG4++QVS80OTshBR1Q@mail.gmail.com>
Subject: Re: [GIT PULL] Security subsystem: Smack updates for v5.2
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 9, 2019 at 10:28 AM James Morris <jmorris@namei.org> wrote:
>
> From Casey: "There's one bug fix for IPv6 handling and two memory use
> improvements."
>
> Plus a couple of further bugfixes.

I'm going to stop pulling these silly security subsystem "contains
just about as many merges as regular commits" branches starting next
merge window.

Security subsystem guys: just send your pull requests to me directly.
The history is illegible with the completely random pulls in the
middle, and I'm having a hard time editing sane merge messages with
quotes from submaintainers mixed up with other quotes.

This subsystem isn't working. I'm already taking SElinux, audit and
apparmor updates directly from the submaintainers, I'd ratehr just
take the smack updates and the TPM ones that way too. Because this is
just adding confusion as things are now.

I've pulled this, just to not cause extra confusion this merge window,
so this is just a heads-up for the future.

               Linus
