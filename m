Return-Path: <SRS0=p3Qd=62=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD09C2D0F7
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 20:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D3720784
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 20:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VquWJTl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELUh0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 May 2020 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELUh0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 May 2020 16:37:26 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5047C061A0C;
        Tue, 12 May 2020 13:37:25 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e10so8702741vsp.12;
        Tue, 12 May 2020 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3Spc78U/N6XjhGZXt18IfDs/uw+nEmxOU/UHCVmAu0=;
        b=VquWJTl/bAhNE5y+HVyOduy2Bc/6gYWcd+z/NJV1EQbfucayOcA3CNQMc461Y2rmHR
         ZzobrLJpn4C9QRqTtHijNEw/gipYDLl7lI/oG4zQ/jlDYKmycgf0KTahG5F9epaXmq6s
         Y7NUmybTgcH0pE5qrGfqjeE2USELQjSrDI5Zc56QfNH9yJtHwSlPDZBjx5s5t3VlmduH
         06jUnTS/NfcSCZuxPNYUA9V0vjdDG8Ltb+Q1kKmKCex36IbuR/3e7My0JANnt1R6yLFQ
         RlX9qDPZRm03R07oQjl2upxYF83AYwyFdG/N+z00xoajZ7gIYh9nP+xZ2+Rezawoz7zK
         TGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3Spc78U/N6XjhGZXt18IfDs/uw+nEmxOU/UHCVmAu0=;
        b=NP5vwmWWERc/wLlYOii1kuSG4tJGI1ykMkD/yLQLlRRRm0qn3DeKdjzgcGCxxUSrvc
         KmI9FP++7shOp1/5iASTa3jo9OAULWaLyUdnOELaCl/jT+XHBmFXi4oJqNsyIaOuVqdM
         HxKY6cF8GYhfFcndhQ3Lnzd0daX7ZnAWJ+wKWZ3COPw3YPn7r7Qoa2E61pZ6HEx5nl1B
         eAszf9YzIONWp3tIpAfLeneBuZt1PKq89H4B0aa8KNCsqOSRxtiR6e3p8B3NiC84Ty7I
         sqPvnzqggdtcAQrg5B8ZBuobdgp69MrYkn/FGHWCkUDqxEWghEdmY06Z1w3tigic5Rv8
         dZhA==
X-Gm-Message-State: AGi0PuY1YlLfV8szqRwvKlilADze7Ze1z9r/pQXnTJDx4D1NTgbkzwzj
        vNpvKPKO2Zjl0ctnMBvZf39oFdnz5+CvlBn5Qd2/IeBuOpM=
X-Google-Smtp-Source: APiQypJAcGYX8xew4K3dHgTLC/NKBFWjtQAMXZ7xDDLKp2BWHmOWrAnYgAHrLU1C92FsGghwc0pJtqYd5dn/ssbujeU=
X-Received: by 2002:a67:fb06:: with SMTP id d6mr16684070vsr.66.1589315844877;
 Tue, 12 May 2020 13:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
 <20200508082028.GP487496@lahna.fi.intel.com> <CAD2FfiG2c4iXmTjUpQAUqRVBVyH0Hm4VfO5PBTXf03VXHR22ng@mail.gmail.com>
 <20200511104504.GK487496@lahna.fi.intel.com> <CAD2FfiHn0PNaC3aFXE-hn9Mmtt5JW_D8BK0hOScYXR9EJLNbcw@mail.gmail.com>
 <20200511162811.GA487496@lahna.fi.intel.com> <CAD2FfiHo1EzRupjgKhtLX0Zguq-bVeW5+u_PNQGAzV0x+AtfVw@mail.gmail.com>
 <20200512064401.GF487496@lahna.fi.intel.com>
In-Reply-To: <20200512064401.GF487496@lahna.fi.intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Tue, 12 May 2020 21:37:13 +0100
Message-ID: <CAD2FfiEOqTUO-XOgar1RtR9PtXWf4tKtsdZX6oS-Q-_y=k6tig@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 12 May 2020 at 07:44, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I mean for the SPI-NOR controller PCI device registers (not the LPC PCI
> device, sorry about not being clear), like config space.

I don't think I need to care about those, but I'll admit I'm a bit of
a newbie with all the terminology. I'll respin the patch now and cc
you on the new version too.

> If that's the case then I guess this should go to intel-spi-pci/platform
> drivers after all. I think one option is that we add Kconfig option that
> makes the driver load but only provide the security bits without
> actually calling intel_spi_probe().

I think getting distros to enable any of the SPI_INTEL_SPI* options
might be an uphill battle.

Richard.
