Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5403DC10F03
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170DC20851
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 22:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNgESof5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCGW1n (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:27:43 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38776 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGW1n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Mar 2019 17:27:43 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so18461902itg.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2019 14:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeVAu/2CmpB2cfJzu9fgIHJ9O24LMTKNu5/wViBrthU=;
        b=NNgESof5mox7G8Hv0Loxzlk+NqdipLK34lwbWzwkccQZRP5m7mDI2/Lhi892EhFjih
         SaEAQkyJg6BLwyWCRQ+K71TctgHEXNlB4eUvyIYwgaxGAhdOr00cdN2oFPrCl+5cuVyG
         vKXtskP0L9Ug4UetozxVXClQmFHZkQR5nFmRR07VC49mvaMjqZ17yD4TxPdWOprypq6E
         mnK2tobJp5lqAYfGnIoz1ZE3zQwylVmjRnQWWx/oSYYxz29tfl+mdRmr04M9mvmTlI/S
         bMWrBDjobhLdG7xut4Z51sCdohAGb7yTLptSiX1i8gxdZ2dfcOqPTmvdLAq+r//JioKt
         934Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeVAu/2CmpB2cfJzu9fgIHJ9O24LMTKNu5/wViBrthU=;
        b=Q2bwI79eQVGlIR9j4VSt6zVXMxwhrmrfFTavL74SODQfCUTuR2BHnk1BtSU1yqdkCc
         QqD5gJTJAajvsJCH9qShX86imOBnJljuKhk8MEUjNTMu2rdiMKQddZjBE2SOcbZgJm/4
         M8bcAYdM33p7vgOJCHA3/YpQ93gdWIcdqnJX0lr3pzxDDC5KoOgRrbk9OkHP98U9rxvG
         SPjeejyPbvH/2yLXM6YVlhd/YHXRal07DVwngtcow+Vo5zq6g/l97nAbmI96ydBSB9Ed
         IVVPngMD+6a4Hjnmxzcu8V8osvjrJfKtHZCO2kc4CkRIovoqmgdUCJ9SGU5rESlAxoZv
         +mQA==
X-Gm-Message-State: APjAAAXlSw5n3ko+mi/nZfOrCGEeToM84YoE40tUzrfmn0XDO9V7ryba
        aEAQWbKYVE5iPFmqvF2Oe2xLLTHzHTf5Jq/KUc4kmA==
X-Google-Smtp-Source: APXvYqxbJLcL/ijDNhiVl36WddXDPvHt3J7DK8v4ybguz/Rvx9zNjG7NKm8O4VOahRH5hXYiEQDaoeFIVroSEgxweAk=
X-Received: by 2002:a24:43d1:: with SMTP id s200mr6643361itb.118.1551997661963;
 Thu, 07 Mar 2019 14:27:41 -0800 (PST)
MIME-Version: 1.0
References: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 14:27:30 -0800
Message-ID: <CACdnJuuPyL3Qo4jAiJDQvUF9Ctch6Yo2bKezEuQ2KaM5ZZ1vqw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/ima: require signed kernel modules
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 13, 2019 at 4:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> -       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
> +       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> +               if (IS_ENABLED(CONFIG_MODULE_SIG))
> +                       set_module_sig_enforced();
>                 return sb_arch_rules;

Linus previously pushed back on having the lockdown features
automatically enabled on secure boot systems. Why are we doing the
same in IMA?
