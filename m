Return-Path: <SRS0=R80q=QB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448A9C282C0
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 20:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14028218B0
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfAYUPm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:15:42 -0500
Received: from namei.org ([65.99.196.166]:48380 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfAYUPm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 Jan 2019 15:15:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0PKFMeW001645;
        Fri, 25 Jan 2019 20:15:22 GMT
Date:   Sat, 26 Jan 2019 07:15:22 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     serge@hallyn.com, keescook@chromium.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid
 calls
In-Reply-To: <20190116154606.92331-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1901260714380.27585@namei.org>
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com> <20190116154606.92331-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 16 Jan 2019, mortonm@chromium.org wrote:

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
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> Acked-by: Kees Cook <keescook@chromium.org>

Both applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

