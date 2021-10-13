Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51812C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 22:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304C4610D0
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 22:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhJMWDp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:03:45 -0400
Received: from namei.org ([65.99.196.166]:56432 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhJMWDo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Oct 2021 18:03:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 3D4854A2;
        Wed, 13 Oct 2021 21:51:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 3D4854A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1634161914; bh=crwpcPDPfqhOEItFpX0KQi8ZF7K7m6bms2MCaFaNIAk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uaJyrL4nFIHwsOyxj4ZPfHHPzqj9fktEdNEdEwESQOXuBr5Hzi1FSXnJB+eypVVD6
         MSxFAp8K/B8azKTr08x0kca/hPf9/5R79sI5Nma7DdxBvueVzmPXizM4QvzeHJ0aeL
         AZ0feRt3/jsNT68hfzBlV1e7bi3vQzySTWSKQUDk=
Date:   Thu, 14 Oct 2021 08:51:54 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] LSM: Avoid warnings about potentially unused hook
 variables
In-Reply-To: <CAHC9VhT0+omwDjqrJ2BtnRfa8SSGAkyUvB6WX95E=ntf9gUbmQ@mail.gmail.com>
Message-ID: <f1a143f5-7972-413d-497c-617b915c4b30@namei.org>
References: <20211013172847.1196305-1-keescook@chromium.org> <CAHC9VhT0+omwDjqrJ2BtnRfa8SSGAkyUvB6WX95E=ntf9gUbmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 13 Oct 2021, Paul Moore wrote:

> Looks reasonable to me, thanks Kees.  Unless James wants to pick this
> up for the security tree, I can pull this into the SElinux tree with
> the io_uring change which is causing the testing robot to complain.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Sounds good.


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

