Return-Path: <SRS0=DaHd=S3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26942C43219
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Apr 2019 21:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E42920717
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Apr 2019 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mbx65Zyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfDYVoe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:44:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54145 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfDYVoe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Apr 2019 17:44:34 -0400
Received: by mail-it1-f193.google.com with SMTP id z4so2612884itc.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Apr 2019 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBOxVxp8/fobUOXjEzHji0avhjUOX9P/t7LglNwt8Ms=;
        b=Mbx65ZylU3kKx5TCA3NoMjPMCwG3Sn/Ktt0BD34bitv+7dUE0OaejlciCqItIabHZ+
         5yojU0coBr9X6C7E+jZuFAinateM0u3dCq6jSmBy4dfi0Yzg4Qu63fqSfPC54n25RzNd
         zUnsJpdlTzyyKlT5ZCRK66VFN8zN6PGo+ewBNiYoux2UnwcGssPCDZf1XHlt6f7C1hzY
         949nJY3Yz0HJvJqsuLouFzYW3TcFExQHxEvirPH0aBBcvxM1l4L5XOpH8uoTbf/1BuYl
         SQkZ5NfVq2DuSoqCuAnUAD/u77mK5xEF9xjeYhEFXrWWPc+VBdTj4s6qsDGYQivq8Ni6
         Zxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBOxVxp8/fobUOXjEzHji0avhjUOX9P/t7LglNwt8Ms=;
        b=rP6t27lwuwiuaxjJcPdUuueO1ehfUHOy6kF+Xf+b7Dmz+WGfWIgQQBzw1VYcUHakBI
         DrKua0OI1Dx30UC3XN1BwhWXZ2iHJRj9CdOAoYAYE8XhphtinSKx3/gTQap910clNSKb
         HdDySd9lsquRsfpQ0nl6X/XDhDy5BHkpvEkSd+TT88QovaVaoZvfZ3MvVtcJzSIjJHh1
         zqtwVyU45kiJF2SSYSoQ3YiarLmrNacg/B9/TsrRh4DCwtkddDXY+Slt5wyyqCk/ZVv9
         Rx8VZJtMhjmDfkMF+2DMeIz5u8o15Gg2WhrzwbZo3vJ/ZGXqPvcKsW3pQmYBkqGbP6T7
         XyHQ==
X-Gm-Message-State: APjAAAXq4Dy/XJ/W2XWqjd5NwAynXx6+EuBjLGhzIhyxUFyVeGGXbICU
        HYG6pKJRhMy7Y0LUHOf3UxI+Cm3rpG3rUQiZLBboag==
X-Google-Smtp-Source: APXvYqyjdDsE1m47mIyR76q85jCF9v3GxCBqSp6Y/WqaAAF03X9v05J/Bl/135+xHvxEMkI71zWRK+e9pFPOMf/qR6A=
X-Received: by 2002:a24:eb04:: with SMTP id h4mr3642585itj.16.1556228672987;
 Thu, 25 Apr 2019 14:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
 <20190306235913.6631-27-matthewgarrett@google.com> <your-ad-here.call-01556189354-ext-1943@work.hours>
In-Reply-To: <your-ad-here.call-01556189354-ext-1943@work.hours>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 25 Apr 2019 14:44:21 -0700
Message-ID: <CACdnJuvHTcB3HgbfGg0LApWyZGqBS=wB=58N6DZqF9JK5=+wAw@mail.gmail.com>
Subject: Re: [PATCH 26/27] debugfs: Restrict debugfs when the kernel is locked down
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 25, 2019 at 3:49 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> I would appreciate if you consider that change, possibly just
> squashing into yours.

Thanks, I've squashed that in.
