Return-Path: <SRS0=04rW=UQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977ECC31E5B
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Jun 2019 22:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D91820833
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Jun 2019 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560809430;
	bh=6hk1cXgfeLMtsbZeOg0ZmMrTcg85OizuNzmzx7hw5Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WBLJamAg+X5FvLFJ5wC3N8sJBg1vAWtXUS1ow/kIPSz49Z9CD4t8sWgv7nA0zi94U
	 r+XMjpXCDqDD4N5oFTjokX34ryhDOagFD6OLiJmCyn/QNBalNBTVJJr4zQGjJAeuqK
	 m2Z6SatcDAJyrRJ32eabQaOZ9qL4BcsptgFscuz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfFQWK3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfFQWK3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Jun 2019 18:10:29 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C63C2063F;
        Mon, 17 Jun 2019 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560809428;
        bh=6hk1cXgfeLMtsbZeOg0ZmMrTcg85OizuNzmzx7hw5Qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H48R91d0qMOGPYc36iLZLmJlRYEKAuboBC6PlZ9ejBJSJze08FWJ9JVor9FNIsA7u
         lYq2c89IGdozntcAfBaEyx4Rd8jMHeGcEzDqBs2fxtvbpqhd0ZqIb3uoby3nU4r+NA
         QC6TyqKkmVl9RQzC6UReWmI4QGQ4j6deJdV8sc14=
Date:   Mon, 17 Jun 2019 15:10:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-Id: <20190617151027.6422016d74a7dc4c7a562fc6@linux-foundation.org>
In-Reply-To: <20190617151050.92663-2-glider@google.com>
References: <20190617151050.92663-1-glider@google.com>
        <20190617151050.92663-2-glider@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 17 Jun 2019 17:10:49 +0200 Alexander Potapenko <glider@google.com> wrote:

> Slowdown for the new features compared to init_on_free=0,
> init_on_alloc=0:
> 
> hackbench, init_on_free=1:  +7.62% sys time (st.err 0.74%)
> hackbench, init_on_alloc=1: +7.75% sys time (st.err 2.14%)

Sanity check time.  Is anyone really going to use this?  Seriously,
honestly, for real?  If "yes" then how did we determine that?

Also, a bit of a nit: "init_on_alloc" and "init_on_free" aren't very
well chosen names for the boot options - they could refer to any kernel
object at all, really.  init_pages_on_alloc would be better?  I don't think
this matters much - the boot options are already chaotic.  But still...


