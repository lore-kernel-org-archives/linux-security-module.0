Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7538EC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B662073B
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590691908;
	bh=ET8yM6AWMNpDjaCHAyz3Kke+AsO4jCxWygmB2OrK0MQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bSx3MHMbU6BkwEesA4SR03QR9aUkT9hrUEl0mNVa4dM47Z5nvShQ5fQ07dyObeFcu
	 /w2q8pKgnBqDMC93g8fjiu2o7jJvo6zN0bj/nyspdHoCMkZVI750GW8VctjTgSCpJC
	 9gFh3NhDeLIkRek9v8easi58cbGgfIh1/1ytdxNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405993AbgE1Svn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405951AbgE1Svm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 14:51:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D1C08C5C9
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 11:51:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so17215447lfd.7
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhLg0g9nIVFkh8Xej4e2gvlmNSMTD4F2E/T/7QsRMv8=;
        b=AYcUjneN2MB3Dg+M1pugzVZJdxa872FQyc0afbyKSWW1oWb/d1rwk9bn7+CzdK3mHa
         tArLlEWWcS0pmgUdgvh4UhxapiHNyCYitzgmuPpFaFrB1CcK1PCfLpwMLGY/rt9ZbGVr
         HuHNIUVtpMtoMJZ4AirU8Bfo1+H2VgFd0PSHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhLg0g9nIVFkh8Xej4e2gvlmNSMTD4F2E/T/7QsRMv8=;
        b=lmZClhLfTwJ1FCO8XdmhWYXzioxhUmjDm1HXM+J6huSyVPT9CKTa4VT+qweB9sjiK6
         CybC2oKbPdNTgFJQUTFSbShTGLzDjwdTqJ1mUgl5Jxv/rmbK6NVxMIAE6gvp+Li6Wm1s
         jRoi2Repx0Iz8TRq7z0fevRm7aq4t+9//Ei0Y0nxANDV6PApfYOqxCcifQVjgZRbY6po
         Vsr39N39CVh+7nS/1LJOE//IeKuksQ4tdMjEhxX1pMg+CEvSuhbUPqa95CYMxLSJIA/r
         UbpgKDbaZkt/9BTcQTJNV+Voe48kawIN0ToUfu6yz5FwVJOCnDzHY51FYtghsGlmsQs9
         bhWw==
X-Gm-Message-State: AOAM531zTYb9t6TUYdwbq/UaKEJSN/0bnkmqqIMvOSh9YCBY1jOu5L5v
        HstPrN7G7Rz2+p03+fy/+PH3Jyn/D3Y=
X-Google-Smtp-Source: ABdhPJwedB/+S/VwOgCf2xgAkNPA0h3aS7iZzeUvh7tmJhC3CWCz+icrKqfTHaIfWlE17M8HB/bh3g==
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr2379611lfn.10.1590691899028;
        Thu, 28 May 2020 11:51:39 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h16sm834642lja.87.2020.05.28.11.51.37
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:51:38 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id z18so34692925lji.12
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 11:51:37 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr1927771ljg.421.1590691897249;
 Thu, 28 May 2020 11:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de>
In-Reply-To: <20200528054043.621510-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 11:51:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Message-ID: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Subject: Re: clean up kernel_{read,write} & friends v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 27, 2020 at 10:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> this series fixes a few issues and cleans up the helpers that read from
> or write to kernel space buffers, and ensures that we don't change the
> address limit if we are using the ->read_iter and ->write_iter methods
> that don't need the changed address limit.

Apart from the "please don't mix irrelevant whitespace changes with
other changes" comment, this looks fine to me.

And a rant related to that change: I'm really inclined to remove the
checkpatch check for 80 columns entirely, but it shouldn't have been
triggering for old lines even now.

Or maybe make it check for something more reasonable, like 100 characters.

I find it ironic and annoying how "checkpatch" warns about that silly
legacy limit, when checkpatch itself then on the very next few lines
has a line that is 124 columns wide

And yes, that 124 character line has a good reason for it. But that's
kind of the point. There are lots of perfectly fine reasons for longer
lines.

I'd much rather check for "no deep indentation" or "no unnecessarily
complex conditionals" or other issues that are more likely to be
_real_ problems.  But do we really have 80x25 terminals any more that
we'd care about?

               Linus
