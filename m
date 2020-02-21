Return-Path: <SRS0=8B0L=4J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC0C3565B
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 19:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62124208E4
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 19:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EjzllT9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBUTly (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:41:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgBUTlx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 14:41:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so3298491wrx.11
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2020 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lF+X01NQeyowOxsjGyQ+K+InDP6nyF3s7HMSuCIuqwU=;
        b=EjzllT9j0FNgXh1gzp7ZKM8N0I91TP8vAm+bivdngSVLKq+0Euegsefdl+EWU6IdGD
         JfHB+Oo9gLRRQrSy4UYadFpYIhdU5UzkXn6LbpRsAoT1YKLo7m/QhEGJMp4BVC1oX25h
         fxQ/ObVXBcP3rVK/4oaOYEep3dzK7dFngxXR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lF+X01NQeyowOxsjGyQ+K+InDP6nyF3s7HMSuCIuqwU=;
        b=LSde4wrlm4uOS/VEMyHxOk0KdiOZ3Gt2ib8fSJXdVt/msdZ2p7WHtUXvRYh4wflK59
         AUwuGludHW1cuSCcpJaBTGVjRMMBSKvHcgvgV2ESptTb59/e61bw3uPugghWQ1UwEmRc
         H8NIqcpQu91fTs5cI7SrZYUpKO2FyTxWsJMYvRyxgvGrpaKLbZHvSutZNSgeqCnKyL5m
         NuHq6GbSE4xy5MYdNHNxzMzq6tt/eU5JDmClJa8LSvs2uJ5vkF6g6yR+hiHQX4CdrERa
         5ZS0oEYHeo1baz0kzUrvet/rDzMnOu93DCyyyRp61sBDQwlkrKbRxO4Al+0ohwcOP+A3
         nH/A==
X-Gm-Message-State: APjAAAWqADZ+a0I7jQfN0op1XgD7yLV82xVets9Uo9x1Y0rY4w7gEzMo
        rSB659HdQ+Kqal60YDCtZ8xR9Q==
X-Google-Smtp-Source: APXvYqyL2tJY+xCx1IxetlPHAreYcfbb2r6BdONhVVQhPwEP6L4cDen3gHqn7ZWgxMe1TyhBVYCdtw==
X-Received: by 2002:a05:6000:128a:: with SMTP id f10mr52557069wrx.116.1582314111976;
        Fri, 21 Feb 2020 11:41:51 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id 25sm5152414wmi.32.2020.02.21.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 11:41:51 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 21 Feb 2020 20:41:49 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200221194149.GA9207@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 21-Feb 11:19, Casey Schaufler wrote:
> On 2/20/2020 9:52 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> 
> Again, apologies for the CC list trimming.
> 
> >
> > # v3 -> v4
> >
> >   https://lkml.org/lkml/2020/1/23/515
> >
> > * Moved away from allocating a separate security_hook_heads and adding a
> >   new special case for arch_prepare_bpf_trampoline to using BPF fexit
> >   trampolines called from the right place in the LSM hook and toggled by
> >   static keys based on the discussion in:
> >
> >     https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com/
> >
> > * Since the code does not deal with security_hook_heads anymore, it goes
> >   from "being a BPF LSM" to "BPF program attachment to LSM hooks".
> 
> I've finally been able to review the entire patch set.
> I can't imagine how it can make sense to add this much
> complexity to the LSM infrastructure in support of this
> feature. There is macro magic going on that is going to
> break, and soon. You are introducing dependencies on BPF
> into the infrastructure, and that's unnecessary and most
> likely harmful.

We will be happy to document each of the macros in detail. Do note a
few things here:

* There is really nothing magical about them though, the LSM hooks are
  collectively declared in lsm_hook_names.h and are used to delcare
  the security_list_options and security_hook_heads for the LSM
  framework (this was previously maitained in two different places):

  For BPF, they declare:

    * bpf_lsm_<name> attachment points and their prototypes.
    * A static key (bpf_lsm_key_<name>) to enable and disable these
       hooks with a function to set its value i.e.
       (bpf_lsm_<name>_set_enabled).

* We have kept the BPF related macros out of security/.
* All the BPF calls in the LSM infrastructure are guarded by
  CONFIG_BPF_LSM (there are only two main calls though, i.e.
  call_int_hook, call_void_hook).

Honestly, the macros aren't any more complicated than
call_int_progs/call_void_progs.

- KP

> 
> Would you please drop the excessive optimization? I understand
> that there's been a lot of discussion and debate about it,
> but this implementation is out of control, disruptive, and
> dangerous to the code around it.
> 
> 
