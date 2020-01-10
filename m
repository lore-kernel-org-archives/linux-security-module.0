Return-Path: <SRS0=H0F3=27=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0686C282DD
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jan 2020 17:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00E220678
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jan 2020 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgAJRts (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:49:48 -0500
Received: from namei.org ([65.99.196.166]:56728 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbgAJRts (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jan 2020 12:49:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 00AHmwAG017114;
        Fri, 10 Jan 2020 17:48:58 GMT
Date:   Sat, 11 Jan 2020 04:48:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF
 (KRSI)
In-Reply-To: <20200110152758.GA260168@google.com>
Message-ID: <alpine.LRH.2.21.2001110448330.17040@namei.org>
References: <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com> <201912301112.A1A63A4@keescook> <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov> <alpine.LRH.2.21.2001090551000.27794@namei.org> <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org> <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov> <alpine.LRH.2.21.2001100558550.31925@namei.org> <20200109194302.GA85350@google.com> <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
 <20200110152758.GA260168@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 10 Jan 2020, KP Singh wrote:

> 
> Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
> specific verification for the v2 of the patch-set which would require
> all BPF-LSM programs to be GPL.

Sounds good to me.

-- 
James Morris
<jmorris@namei.org>

