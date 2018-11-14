Return-Path: <SRS0=+5fq=NZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ABAC43441
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Nov 2018 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B26921780
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Nov 2018 18:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B26921780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeKOEEg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:04:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKOEEg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Nov 2018 23:04:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A53A3164668;
        Wed, 14 Nov 2018 18:00:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D3931001F41;
        Wed, 14 Nov 2018 18:00:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org
Subject: keyutils-1.6 released
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25166.1542218422.1@warthog.procyon.org.uk>
Date:   Wed, 14 Nov 2018 18:00:22 +0000
Message-ID: <25167.1542218422@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 14 Nov 2018 18:00:24 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I have tagged and push keyutils v1.6 to:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

Significant changes since v1.5.11 include:

 - When scanning its config files to find a helper to execute, request-key now
   takes the match with the least number of characters matching a wildcard
   rather than the first match.

   This allows a more specific match on a particular type to be installed that
   overrides a general match (say with the DNS resolver).

 - request-key has an additional flag that allows helper execution to be
   suppressed to make config debugging easier.

 - Support in keyctl for public key operations using asymmetric-type keys
   (requires kernel v4.20).

 - The dependency on MIT Kerberos is removed.

 - Added pkg-config spec for libkeyutils.

David
