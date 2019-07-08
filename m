Return-Path: <SRS0=y5yI=VF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D6C606BD
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jul 2019 17:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620F720644
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jul 2019 17:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTS27VBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfGHRiB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:38:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35218 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfGHRiB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 13:38:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so13257820oii.2
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jul 2019 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dDlUWXE3BDiYJAkGp7CGjzY68vf5TiBs2gkLxCROPg=;
        b=oTS27VBGAXTGyWJrG+1bRf5KktV5vuIvxa8IWh1u4JAjBQEhi23d4SyczOUH26kY2R
         y//ajtI2TI29q75dcyp4FSN6kHo6UyR1wPu6Y62WtELMtJtY2Xkr824CBphlKwNvrFuO
         ieIrosIuDlKuPw3h2M3licdQ3No/OcsZmxHFpt3c0Kc+o5hSNDIzOkDfH9Z91ZQWyD9C
         grhZTvCUxZJhweX5ja9rWveALtoabLG30fihRzI/xTkp6fk/mdSPQab2R5qH1XoaWpiD
         o9GNdIcFxNYegyyTxVLrvQTgO8RvIuuA7e/Fsm1h2c1BcSOCqsarhQ/oMOQ4o/vR2/An
         BE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dDlUWXE3BDiYJAkGp7CGjzY68vf5TiBs2gkLxCROPg=;
        b=Tu3NOIaDngXYYqlRLn3D/1J/CNuPW8RL9zCzDdSV+1utWCJjL7psJjnZp5pG7cgJc2
         4pwE8YViOf9M3z8JChpGHglEJzaaottsUffWbPyZadvCypXr8wJ5Qo+ExBAPhE/heYoY
         fgTu4BVgQvzALYcjgr1ont7GPjhYHztnup3bSCk3KTE0DbeJ51BFQCPs/JM/o8dHmmgQ
         JZJy+6100kueu8FYdWz3KnWDNtLy1y/8ngj5NldbOBhKHczMbjwgn/48CXLLgsQUIzne
         6EdCS0TNq6O0jcRsYKWfMRPO48IPzM5Ptq0wiBg2uKth7/y0mGzpqmH/X0A9Eg8rYu+k
         JNrg==
X-Gm-Message-State: APjAAAUQblDqb1/QHErrSSdybhFxVDb4IicOuqn9gCNQAKTYN/PSB3hu
        N3qtJoajk/M3Qeh/d5pjiqcPejEQ+FouKodWJFe0oD4Q9fTD2w==
X-Google-Smtp-Source: APXvYqxWC2WzfHpl8ZigyXVHyyT6QtrbedYXY8/NrWJL/zNHr0x2cmYj/XsDrwdBKxwSxPY6OsYxHdMmiMEzeBNat6Y=
X-Received: by 2002:aca:b06:: with SMTP id 6mr10585303oil.175.1562607480451;
 Mon, 08 Jul 2019 10:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com> <CAG48ez35oJhey5WNzMQR14ko6RPJUJp+nCuAHVUJqX7EPPPokA@mail.gmail.com>
 <CAJHCu1+35GhGJY8jDMPEU8meYhJTVgvzY5sJgVCuLrxCoGgHEg@mail.gmail.com>
In-Reply-To: <CAJHCu1+35GhGJY8jDMPEU8meYhJTVgvzY5sJgVCuLrxCoGgHEg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 8 Jul 2019 19:37:33 +0200
Message-ID: <CAG48ez2f1TbUZt_0F99DLyzn-3DhjuoTJZ7Dwxgmto7J9ZQ95g@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] S.A.R.A.: generic DFA for string matching
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jul 7, 2019 at 6:01 PM Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> Jann Horn <jannh@google.com> wrote:
> > Throughout the series, you are adding files that both add an SPDX
> > identifier and have a description of the license in the comment block
> > at the top. The SPDX identifier already identifies the license.
>
> I added the license description because I thought it was required anyway.
> IANAL, if you tell me that SPDX it's enough I'll remove the description.

IANAL too, but Documentation/process/license-rules.rst says:

====
The common way of expressing the license of a source file is to add the
matching boilerplate text into the top comment of the file.  Due to
formatting, typos etc. these "boilerplates" are hard to validate for
tools which are used in the context of license compliance.

An alternative to boilerplate text is the use of Software Package Data
Exchange (SPDX) license identifiers in each source file.  SPDX license
identifiers are machine parsable and precise shorthands for the license
under which the content of the file is contributed.  SPDX license
identifiers are managed by the SPDX Workgroup at the Linux Foundation and
have been agreed on by partners throughout the industry, tool vendors, and
legal teams.  For further information see https://spdx.org/

The Linux kernel requires the precise SPDX identifier in all source files.
The valid identifiers used in the kernel are explained in the section
`License identifiers`_ and have been retrieved from the official SPDX
license list at https://spdx.org/licenses/ along with the license texts.
====

and there have been lots of conversion patches to replace license
boilerplate headers with SPDX identifiers, see e.g. all the "treewide:
Replace GPLv2 boilerplate/reference with SPDX" patches.
