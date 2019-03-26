Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04944C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 19:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D02075D
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553628105;
	bh=3G5OLDJGt2VUj4PBtRdTYEfb1U+H5AzAVGZwalvrssE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iKUyYh87ew0F8BfVHb2zH+leH7FiOK7RapfFUZyPuRe3bqcWT+4CzsqytA+fJGuo8
	 Kgfg9OXo4nINIFb08x86Doy/LRFqHVryjilm6lZrpzKgQ9AUvQe39iJwRu3NRaMVT4
	 mrxegOtw6GiDuooOiCMnUj9iGhk79fRcOpCBGVnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfCZTVp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCZTVi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 15:21:38 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73BF8208E4
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553628097;
        bh=3G5OLDJGt2VUj4PBtRdTYEfb1U+H5AzAVGZwalvrssE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ujWgSVmPTiCJxHUFiLdNFRIQ3LNz/y2sT6zjgX6M5tpeyZMPlFA7/kAhrZsRmfsEw
         BfqVVBiytLlSlOES3pK4D6WEj0zlUUELO7S2EfISBp5BLpATL8aSExwGrgqPQUNbvh
         ei7uRzKraSVTBZ4hUpujhNNzMk5rDWg3hnDrs07Y=
Received: by mail-wr1-f46.google.com with SMTP id h4so106628wre.7
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 12:21:37 -0700 (PDT)
X-Gm-Message-State: APjAAAUyGM0VPRHV+nTOY1aRMWrBmMicknKXoVR2LL6Fr5/OHsKYSmmL
        +bQC76PQTHEIHi5GR+SG13UAWlH0JmzZSuQBrjET2A==
X-Google-Smtp-Source: APXvYqxcunQWBDndSLRqy9+hfd85lsPv4VZV9ONiALbX5mgkPo4ruMBSbrDRvugQ9Go9DnUG8bauRTNb2ulhmq8wsgk=
X-Received: by 2002:a5d:53d0:: with SMTP id a16mr185634wrw.309.1553628096107;
 Tue, 26 Mar 2019 12:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com> <20190326182742.16950-23-matthewgarrett@google.com>
In-Reply-To: <20190326182742.16950-23-matthewgarrett@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 12:21:24 -0700
X-Gmail-Original-Message-ID: <CALCETrUtYir8bCCMMH2kEAEmWBB_h4tL_9fq0zgNwRNXmZfG6A@mail.gmail.com>
Message-ID: <CALCETrUtYir8bCCMMH2kEAEmWBB_h4tL_9fq0zgNwRNXmZfG6A@mail.gmail.com>
Subject: Re: [PATCH V31 22/25] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: David Howells <dhowells@redhat.com>
>
> There are some bpf functions can be used to read kernel memory:
> bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> private keys in kernel memory (e.g. the hibernation image signing key) to
> be read by an eBPF program and kernel memory to be altered without
> restriction. Disable them if the kernel has been locked down in
> confidentiality mode.
>

:)

This is yet another reason to get the new improved bpf_probe_user_read
stuff landed!
