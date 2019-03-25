Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D40BC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 23:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B4021473
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 23:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Hr2sodvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfCYXm0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:42:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39908 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCYXm0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 19:42:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so697980plb.6
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSgTSStmyucgCQUG0l9SmzKEAqnVSFBHIEtJeqjh0Xs=;
        b=Hr2sodviulFCbh9JwInjMrl66OSdt4DR498G9P5YOCX1xfHEuql6GzifbTtbDa08u5
         vrMuRFR9TRow0yDrd97cltle2gtcJJEeWaX5ZFTENNYSpqSzzqunQ/42or7ZVfDkBRgV
         cIbyKRltVv4V1XrTkO0q9LzEQIh5Z7LHdgyFRxruu1/fl+E14iPuVKlvaNAu+MTUe5Du
         9KTe0bshsJAy/JMGKyq4JJiWRFe1T/mKxN4FwVQxxRP5yYAx1hr6rq97p+NJDJeiFcSI
         cK7vzk6D3qt7ywa6lfgx021X6EQpcKlaQUQCJJ2jkkgrUgjP28QS6zBNLE+il1jmsH8W
         9MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSgTSStmyucgCQUG0l9SmzKEAqnVSFBHIEtJeqjh0Xs=;
        b=V6QxtzEDIUzlocVyCIkfaIapWbBXaKMdWShAuE7G7R4WvKFJXOEXRi87i54LsFrbdc
         1EIGrmIrMTvctzgQKsJQZjeet1RtSelM9LAUMlewsgfZiELhuMgNSbMUCQxjSBBcVog3
         c+Y4Z/rW6+ERZ6EPvaVK/lLVDyPEkXxdkObRd63w2lvqli52V5uwUDq0uRWy5WqyYnnU
         etIV9Z98dRbC0U8eoNd8AcCN5STf4Hw+qlzUz2miMyIi/pb0jT6Ijid+Zu3a7oF3OCoB
         QUxLDXre+7y+Yw1rLgn4g7Q1NLyZOydOKt8zzFmvzIFISdAAhd0JRIFfxZD5t9nQ47cu
         ga1Q==
X-Gm-Message-State: APjAAAV8G3c4y0lM8NPV9SV6BYB21zS2vjaDq+iumQsX3q9T7ZUBUN2e
        TJUj6DLLNYq8hwAODg+qrGoBd6dfTj4CoA==
X-Google-Smtp-Source: APXvYqx87hbg4Xed6wnjIWYIiKi+u3b5PK3yqnpj9m8ovw9xr0GeWVPIvLfGlpjDs6em7hjkgNlPAA==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67mr27150786plb.176.1553557345500;
        Mon, 25 Mar 2019 16:42:25 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a13sm18829204pgw.91.2019.03.25.16.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 16:42:25 -0700 (PDT)
Date:   Mon, 25 Mar 2019 16:42:21 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
Message-ID: <20190325164221.5d8687bd@shemminger-XPS-13-9360>
In-Reply-To: <20190325220954.29054-24-matthewgarrett@google.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
        <20190325220954.29054-24-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 25 Mar 2019 15:09:50 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> There are some bpf functions can be used to read kernel memory:
> bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> private keys in kernel memory (e.g. the hibernation image signing key) to
> be read by an eBPF program and kernel memory to be altered without
> restriction.
> 
> Completely prohibit the use of BPF when the kernel is locked down.
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: netdev@vger.kernel.org
> cc: Chun-Yi Lee <jlee@suse.com>
> cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Matthew Garrett <matthewgarrett@google.com>

Wouldn't this mean that Seccomp won't work in locked down mode?
