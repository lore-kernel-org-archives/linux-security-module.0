Return-Path: <SRS0=6aHe=OM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8398C04EBF
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB42206B7
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI1OGcUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB42206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLCWY3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:24:29 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:41240 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLCWY2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Dec 2018 17:24:28 -0500
Received: by mail-pg1-f179.google.com with SMTP id 70so6359412pgh.8
        for <linux-security-module@vger.kernel.org>; Mon, 03 Dec 2018 14:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNfAB/20tEl89R6fHi+iJdNymgMzz4I/etolfaEWJ4A=;
        b=dI1OGcUOzGMR1D+FKbJYckj4DL+ZElbu6SqliWLkSVlTeaWYN8MQU/vQSCYVgN6vXX
         WDehN54oD+oTxEjv9HH2hRSZE1/i+wZ0OWwp1mepslsGedL/ta31NyF+YYGpnMRrumJh
         FLACzNcunLi853RtX8k3iLj+6lBG2iTQuPl7Xr9iT/f1AqLWcRWgjs8zVVCpFgZhpdzk
         tvlxCJVKVCUmc44rVcDGafmWHI9/Y3+K7dNx5tH1j+0/8+SDn/VvdWxB87YKP4YOXqtD
         ApqxvLvhv6KN0TJG14YCiCMYN2aPXeTycLUQeIL4k6dqAkvgOlnhXE3/K93vzBhHvFmM
         B4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNfAB/20tEl89R6fHi+iJdNymgMzz4I/etolfaEWJ4A=;
        b=lSojpcNdhgnSTbwZb8DdPAOZk7rrg4WyllKUbixjTuy87WPDw9e5pAwHXTu4QEWnNJ
         PjkfZcaL3/mKHhTpTXGDpUFGd5jZNq8zqiN0vLuF/s4R9AHmzMcOz8Lo35LqtPZIETte
         rJiBMENlJxOyeiNZBdAvT4D8GsdTkMuUndj26SR6epufMM0p3Hacw+GprxDkrYVS2owM
         IJUxJ9x5Cvn9Y4mmDT4UjldFlmyE7X9wLkRHgzwDECS0DdE93+8pPGnQboq6hvKh1BGF
         ULKVPDL0RDMkuKVCcmzkMBCMvVg8stCDk5Nqgp5Uq2JMN3xSbWb00u2qHbfbvIWwWEYX
         1ucQ==
X-Gm-Message-State: AA+aEWbX2lMn0hgLBPX6oF0X89HFWF2w/SfkzpRRydzQhn0rsN2r2fJd
        Jy1WZpUd1eFivZdHVUzGyq/Vu9qVBjx30DnERufogihB
X-Google-Smtp-Source: AFSGD/Xg3XSnLYkP0EL75/AeCbPKFC0Z/NpBq1E65/PDvmzd5LVW+blH1arC4UWg475I28jcq0BV4G7GFBTjiH+0s/o=
X-Received: by 2002:a63:4342:: with SMTP id q63mr14789008pga.63.1543875868041;
 Mon, 03 Dec 2018 14:24:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKxm1-F9XOExo0F1QuR+ekHkpqCi+BVpMyAVRGN26t=Q1McB8g@mail.gmail.com>
 <8a74fb14-47bf-3415-2742-bec56b19e6f6@schaufler-ca.com>
In-Reply-To: <8a74fb14-47bf-3415-2742-bec56b19e6f6@schaufler-ca.com>
From:   Tamir Carmeli <carmeli.tamir@gmail.com>
Date:   Tue, 4 Dec 2018 00:23:51 +0200
Message-ID: <CAKxm1-GmS5zYh3W_Fz+XxrrF37p-ciqno_2BwCjz=hqOn1Xvqw@mail.gmail.com>
Subject: Re: LSM hook for module loading and unloading
To:     casey@schaufler-ca.com
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for the reference for loadpin - I didn't know this module before.

I understand that unloading a module is a pretty far-fetched security
risk. I have one use case I think might be worth a shot: An exploit in
the module unloading flow or in a vulnerable process that unloads a
module enables an attacker to unload one of the iptable_filter modules
before some user space process adds an ip filter, and by that, enables
network traffic that otherwise would have been blocked.

Again, this is pretty far fetched, but an attacker that unloads a
module that contributes to the system security might hurt the system
security.
On Mon, Dec 3, 2018 at 6:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 12/1/2018 7:49 AM, Tamir Carmeli wrote:
> > Hi,
> > I believe that this is the right place to ask the question, but if it
> > isn't please let me know of a better forum to ask.
>
> This is the right list.
>
> > Is there a reason why LSM hooks for kernel module deletion and loading
> > don't exist? (for delete_module syscall and load_module kernel
> > function)
>
> security_kernel_load_data() is the hook for loading.
>
> > Is there some design problem I'm not aware of, or whether the
> > necessity hasn't come up from any of the mainline LSMs?
>
> No one has seen the need for a hook during unload.
>
> > I'm considering to write such patch, and I'd like to hear reasons for
> > why it might be a bad idea.
>
> To what end? Look at the Loadpin security module in security/loadpin
> for one approach to protecting module loading.
>
> > Thanks.
>
