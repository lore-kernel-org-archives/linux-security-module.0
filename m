Return-Path: <SRS0=T836=S4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19805C43218
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97C12077B
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="a1z6ESlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZPYZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:24:25 -0400
Received: from a9-32.smtp-out.amazonses.com ([54.240.9.32]:48122 "EHLO
        a9-32.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbfDZPYZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Apr 2019 11:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1556292264;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=ALmtrPU+FyjyIGvxYdiM4DkEmpDksNeNpQjWCn4I9O4=;
        b=a1z6ESlxgzd3G0crCTtKbTvr+mqzstFzSaiZPg0lk9nXaKS6z69dp2C2MVu9hF60
        sdJt5OvWwl39SsUxZ/dqrDDOlhVqmQiu7cOgurwsOpZSXEihIPXvxFGHakjVnQOMR6n
        IUX6/EltlGJP1PbgEboreeLc/GPwxojlWQeu+J2c=
Date:   Fri, 26 Apr 2019 15:24:24 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Alexander Potapenko <glider@google.com>
cc:     akpm@linux-foundation.org, dvyukov@google.com,
        keescook@chromium.org, labbott@redhat.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/3] mm: security: introduce the init_allocations=1 boot
 option
In-Reply-To: <alpine.DEB.2.21.1904260911570.8340@nuc-kabylake>
Message-ID: <0100016a5a3f6121-e7ed483e-bc29-4d75-bd0a-8e3b973529f5-000000@email.amazonses.com>
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-2-glider@google.com> <alpine.DEB.2.21.1904260911570.8340@nuc-kabylake>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.26-54.240.9.32
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hmmmm.... Maybe its better to zero on free? That way you dont need to
initialize the allocations. You could even check if someone mucked with
the object during allocation. This is a replication of some of the
inherent debugging facilities in the allocator though.

