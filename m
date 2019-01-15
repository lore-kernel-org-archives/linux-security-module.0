Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C21C43444
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F5D20656
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxAj0fQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbfAOTnG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:43:06 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36025 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389315AbfAOTnF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 14:43:05 -0500
Received: by mail-yb1-f193.google.com with SMTP id a190so1542521ybg.3
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=222ZQco2eFSgK8ebfpPIazTkMQkPzB1cFXFi4XONIX8=;
        b=VxAj0fQ82xOFfy21o4fuoN83gPEnKdbHwJyt3DVVBm21pslmVNp1FSCwEa2wfNdx3Y
         OrC0KVFi8+QhjtazQ1Ivu5F4/BUHyTEtmk4nDVEJBMXA3lIDh290uWXb8uTXEp2KmxbK
         CQC2j5k1gA71SlTfNoRhoS89mInTVlsjb4exE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=222ZQco2eFSgK8ebfpPIazTkMQkPzB1cFXFi4XONIX8=;
        b=CYUlgMGbQLc4pHRU23MWFJ6QcCT+qSujsdlzPWFVeYCRHmNVbOdydIw+jCS+Bd3xqS
         fjdasVHgjjyrZxuErUVKyaQ3JG/2gdTiNN2lSyOF42gAqVUodScfzZksZ/ME5dYZmvN3
         TH/Dfv9LLXiBOFd8pOpLyC480ntlV/YDmbeiY0220jvqCe3sUBH10vvJGlaOl/SL+DOG
         bwiOjJv/bwZjvVucrLm3lAJmUua1ZcTNuFYI1hIlvnJD3S0bx4lZNTPD3V3ij6ZiDEmp
         l/PBjR8X5LKA5FKc/Bph9EuOsBDtuz+Lho9fectuB5F4WxZ6Eevn0KSgCiXEVhJmOmwt
         S/EQ==
X-Gm-Message-State: AJcUukcTL9CoY/pFcZrf9XX2r7PheVSEL8tJ8DpCGE7u9ZyIRSjeRjXJ
        o4LkUw4zaULOp4kAKfo/7vQfklC1zKmQ995fk+LtEw==
X-Google-Smtp-Source: ALg8bN43usYOLUdLfIzJ9sdE/I2NNvhXpaZ4SGIvc6Nb+LrNXAeiiY63QRsWjRRD7TQvM0qR6i6b0oi42JUwvWGWk3A=
X-Received: by 2002:a25:abaf:: with SMTP id v44mr4431467ybi.97.1547581385025;
 Tue, 15 Jan 2019 11:43:05 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com>
 <20190111171302.26152-1-mortonm@chromium.org> <alpine.LRH.2.21.1901151505250.28810@namei.org>
In-Reply-To: <alpine.LRH.2.21.1901151505250.28810@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 15 Jan 2019 11:42:54 -0800
Message-ID: <CAJ-EccO6Wm=PwjP2Q5PCBDSdcofbiZGyG2U0zMkWF=AhQNeUTg@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: add SafeSetID module that gates setid calls
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 14, 2019 at 8:07 PM James Morris <jmorris@namei.org> wrote:
>
> On Fri, 11 Jan 2019, mortonm@chromium.org wrote:
>
> > From: Micah Morton <mortonm@chromium.org>
> >
> > SafeSetID gates the setid family of syscalls to restrict UID/GID
> > transitions from a given UID/GID to only those approved by a
> > system-wide whitelist. These restrictions also prohibit the given
> > UIDs/GIDs from obtaining auxiliary privileges associated with
> > CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> > mappings. For now, only gating the set*uid family of syscalls is
> > supported, with support for set*gid coming in a future patch set.
> >
>
> I can't recall if this has been mentioned, but is this code already
> shipping in any distros or products, and are any distros planning on
> enabling this feature?

It is shipping on ChromeOS (the hooking is done in our own LSM that we
maintain, but everything else is the same, and we have integration
tests for it). We use it to lock down a handful of system daemons that
need to switch to certain, predetermined UIDs on the system (but not
root). There look to be a few use cases for this LSM in Android as
well, which is a possibility in the future.

>
>
>
> - James
> --
> James Morris
> <jmorris@namei.org>
>
