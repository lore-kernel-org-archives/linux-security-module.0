Return-Path: <SRS0=T836=S4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD42C43218
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97877206C1
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 14:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="U4RFCPQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZOOs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:14:48 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:57492 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfDZOOs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Apr 2019 10:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1556288087;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=w9slGZvLHxuV7S3a5IfAzVKNyURT39PnsyVIpnGpH9A=;
        b=U4RFCPQWz4jXUFfMGOHX4HlHYj86E0xiwRKBsja0h5KkUEcbg030FIk1xEfdMOP+
        6NtV8IjdnxUm+2JCNqWPJri0AwN8QzdR6rnn1ulMRWuJXoueQ1audlHWTtKSRf4JvwI
        5yQTY0JYLP6FLFj/XbeqnIrsWlc9S/CnWTLeXbVs=
Date:   Fri, 26 Apr 2019 14:14:47 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Alexander Potapenko <glider@google.com>
cc:     akpm@linux-foundation.org, dvyukov@google.com,
        keescook@chromium.org, labbott@redhat.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/3] mm: security: introduce the init_allocations=1 boot
 option
In-Reply-To: <20190418154208.131118-2-glider@google.com>
Message-ID: <0100016a59ffa618-56d49996-ecb0-481c-88c3-380495651623-000000@email.amazonses.com>
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-2-glider@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.26-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 18 Apr 2019, Alexander Potapenko wrote:

> This option adds the possibility to initialize newly allocated pages and
> heap objects with zeroes. This is needed to prevent possible information
> leaks and make the control-flow bugs that depend on uninitialized values
> more deterministic.
>
> Initialization is done at allocation time at the places where checks for
> __GFP_ZERO are performed. We don't initialize slab caches with
> constructors to preserve their semantics. To reduce runtime costs of
> checking cachep->ctor we replace a call to memset with a call to
> cachep->poison_fn, which is only executed if the memory block needs to
> be initialized.

Just check for a ctor and then zero or use whatever pattern ? Why add a
new function?
