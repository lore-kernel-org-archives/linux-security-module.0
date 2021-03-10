Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C337BC433E6
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 21:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8479C64DDA
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 21:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhCJVIr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhCJVIT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 16:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615410498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5MvdvNqgLulzxneBJsB2bgilIJpPxPGUd0qWzobxoU=;
        b=G4ZGAqcWy+ZPkEcyJzyrNy5foYws1YtxbIL6lI/kbMysZ4WGUm090dsn2hmJ/t1Ar25s12
        qCiAs9txeWvrX6u4vVP/+QJE+NKX3NnR+49f+3WEJ3/UwqC9CoUDpE+59yJ93oLBVWlzVF
        j/lekVBQ/bNNXWoW85dwVrBmfj1yZuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-UfAqW5lXOqquGR65FNcb1A-1; Wed, 10 Mar 2021 16:08:14 -0500
X-MC-Unique: UfAqW5lXOqquGR65FNcb1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1196C1019638;
        Wed, 10 Mar 2021 21:08:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 788D960C05;
        Wed, 10 Mar 2021 21:08:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <161529606657.163428.3340689182456495390.stgit@warthog.procyon.org.uk>
References: <161529606657.163428.3340689182456495390.stgit@warthog.procyon.org.uk> <161529604216.163428.4905283330048991183.stgit@warthog.procyon.org.uk>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] certs: Add ability to preload revocation certs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <305837.1615410490.1@warthog.procyon.org.uk>
Date:   Wed, 10 Mar 2021 21:08:10 +0000
Message-ID: <305838.1615410490@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Eric,

Can you check this patch?  I rolled your changes into it.

David

