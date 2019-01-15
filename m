Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1984EC43444
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 04:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA72C20651
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 04:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfAOEHn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:07:43 -0500
Received: from namei.org ([65.99.196.166]:56082 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAOEHm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Jan 2019 23:07:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0F47Na1029493;
        Tue, 15 Jan 2019 04:07:23 GMT
Date:   Tue, 15 Jan 2019 15:07:23 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     serge@hallyn.com, keescook@chromium.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] LSM: add SafeSetID module that gates setid calls
In-Reply-To: <20190111171302.26152-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1901151505250.28810@namei.org>
References: <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com> <20190111171302.26152-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 11 Jan 2019, mortonm@chromium.org wrote:

> From: Micah Morton <mortonm@chromium.org>
> 
> SafeSetID gates the setid family of syscalls to restrict UID/GID
> transitions from a given UID/GID to only those approved by a
> system-wide whitelist. These restrictions also prohibit the given
> UIDs/GIDs from obtaining auxiliary privileges associated with
> CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> mappings. For now, only gating the set*uid family of syscalls is
> supported, with support for set*gid coming in a future patch set.
> 

I can't recall if this has been mentioned, but is this code already 
shipping in any distros or products, and are any distros planning on 
enabling this feature?



- James
-- 
James Morris
<jmorris@namei.org>

