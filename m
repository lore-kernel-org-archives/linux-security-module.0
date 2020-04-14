Return-Path: <SRS0=Yj31=56=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774ECC2BA2B
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 00:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F1421655
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 00:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMRE9MFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbgDNAaC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390467AbgDNAaB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Apr 2020 20:30:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03979C008616
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2020 17:30:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c5so5229284pgi.7
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2020 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GtP40NBc6K+wY7TevCqJVJVyGGxw6eyhk3x6njvRZbI=;
        b=PMRE9MFBjRNguCLZJxvQ0tC6cbj5HN/L0mNJHOjg1H5naWvyPaji8Uw6CjXqOQ2azW
         MhWs/LuNrHlvICFisvb7Cy6SJ3VKQrmiHJlokad5hGoOXcGXzDY3vorrrgpyAZrAVUDE
         dUN76VdbMCLvs9G10TRyVoj/R2uKEUPKhrkRhwWPh9Qq6Oj8zqhrDAXwnWHye+K8R3ym
         lDZQumSHVx6+RupP9U0o1EyjztcXPr7zTXefIIyzd+nYkxQBJg3bKkumuWN4k6N/hrZC
         eN210smaNX58gX6QVglgalvDGfi5xzWfnOSt7/cWPG1d3xQeaexIo7gZ03EO3NRYAH/8
         2wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GtP40NBc6K+wY7TevCqJVJVyGGxw6eyhk3x6njvRZbI=;
        b=NLSa7GRoAwSZPEfXtkYYg145Hxz/b2jsBcuddxa2xUg5avrx/PdgmortlhS41weQd3
         nCPV9M8KDOpb1XZyPUzF+GsFVJlta2mJj28FVJ8RYmCn9rJKFK/JDQC2g/rqKDk1yDY8
         PuRh/9DXMevSw8Fv243fulavuBjlSQi5phDOpIcsGyJeUX1gUm5RcQUDqsnoWRhMT5Nc
         t3JzHxUsM4uXm5BXZOTDMxKrC5vymZ+dCPCr5g0MAVPoE4LAYnUrjKQPfF2xl8wp07Hg
         8RYmAnIBKzUIxPi3/RG/vSBY3GZ1qJi5jglHMxQAqPyrikPmmFFlYlCCtkSCCwrD9O/D
         CFfA==
X-Gm-Message-State: AGi0PuY7EAF8QbBFeSS9fnOQfbxXyb2v+JAbYo575VyI5gbk1FteJt6b
        hFAb5vvDySi0sqfaOPAZAwHZwQ==
X-Google-Smtp-Source: APiQypL5W5g7xmsU3GZXO1UecYYPwVLK1dPD412glciRM3pdZ8NSkRu/LjnNHn8Pg6Fxg4L/cgCpIw==
X-Received: by 2002:a62:dd48:: with SMTP id w69mr10144721pff.86.1586824199909;
        Mon, 13 Apr 2020 17:29:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g11sm10055136pjs.17.2020.04.13.17.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 17:29:59 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:29:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Waiman Long <longman@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-ppp@vger.kernel.org,
        wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        cocci@systeme.lip6.fr, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, treewide: Rename kzfree() to kfree_sensitive()
In-Reply-To: <20200413211550.8307-2-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.2004131729410.260270@chino.kir.corp.google.com>
References: <20200413211550.8307-1-longman@redhat.com> <20200413211550.8307-2-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 13 Apr 2020, Waiman Long wrote:

> As said by Linus:
> 
>   A symmetric naming is only helpful if it implies symmetries in use.
>   Otherwise it's actively misleading.
> 
>   In "kzalloc()", the z is meaningful and an important part of what the
>   caller wants.
> 
>   In "kzfree()", the z is actively detrimental, because maybe in the
>   future we really _might_ want to use that "memfill(0xdeadbeef)" or
>   something. The "zero" part of the interface isn't even _relevant_.
> 
> The main reason that kzfree() exists is to clear sensitive information
> that should not be leaked to other future users of the same memory
> objects.
> 
> Rename kzfree() to kfree_sensitive() to follow the example of the
> recently added kvfree_sensitive() and make the intention of the API
> more explicit. In addition, memzero_explicit() is used to clear the
> memory to make sure that it won't get optimized away by the compiler.
> 
> The renaming is done by using the command sequence:
> 
>   git grep -w --name-only kzfree |\
>   xargs sed -i 's/\bkzfree\b/kfree_sensitive/'
> 
> followed by some editing of the kfree_sensitive() kerneldoc and the
> use of memzero_explicit() instead of memset().
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
