Return-Path: <SRS0=X4hF=YC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32697C4360C
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Oct 2019 02:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5F20873
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Oct 2019 02:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gnew97C5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfJICSL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:18:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36550 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfJICSL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Oct 2019 22:18:11 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so1540419iof.3
        for <linux-security-module@vger.kernel.org>; Tue, 08 Oct 2019 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hyGtFYQiv1Yn2S99OC7OoYmGIdFfpfcg76zXN+1O3Y=;
        b=Gnew97C5M5yGW/IiuM0QLHj0r5iu55tSm2w3gnj7nyhTPvpXtQqgXoF1APoicmjttU
         BNk0UcPk27kaLkEoBuGe17L0agFA25MI3EEqxPB5UQKfwLFx/j4BAdlQCqYIdTs2nh6e
         W1sR3OFYPix2B7HPTCEK5STbbjZie8TQRxF4lWze8F3UcrIGUF2JatMtJqfVFaKnfoPU
         7MIMk1Qy21npdiqE1WnHb/tU91fSwGXuKg7t6kUFibog33yNyHedj8SLmPdW/XOdJKPh
         SaYFtG4N/f2p4m43nIK3JLlWcgExOzsQi24KpdWujcGq41XO+peLEX9d2yyve4hJQmU0
         /UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hyGtFYQiv1Yn2S99OC7OoYmGIdFfpfcg76zXN+1O3Y=;
        b=Lcj6uyoDQndjm9+CSrFy0ls1nN4Emz6UDreiSxqZQ7Y3H445+MpKw6xoEltSAcYgFI
         XjkVVsKKXz61SkJcLvhHP8/p48ET13g6NkWeJaP/2FUSgOG27dU8TExWBVpQEf3wM+Zn
         XhgDRFUP+7zpB7YOnGyo/iKP8bR06Ei+r5wyU4AbPj+RXzg5HB8AM7hg6i+4tAimIntT
         +kDmbCgAKrAEkRJXDjzEQMNWUuID9ih0x5XuOqUf5bbkrvOa3iJXNpCDkCAW5QiznpZJ
         /FCLATr8a7tNjbtJ/bmHeNe5Db7gpOxxcVrn8qKGvVNkUNPDXXSIM5jY5ENNR+VysjK3
         y+Ug==
X-Gm-Message-State: APjAAAXnpjhoss4oULxNLLgN1Z/JNR5xfxnxSEj6UGOYdqIWpx13mkrh
        0zgVaPlXqiuv9n3bOfG7gzemoElnLurM0KVDSNKUGA==
X-Google-Smtp-Source: APXvYqxwIKqW27ucq+a99beZjsiBvn75o81k2oBEjZ8B324EAdi/ExE2N+8ycBcM6VNVXQRWrQHX8aH6ykb/yNfK5JA=
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr1074617jaq.103.1570587489682;
 Tue, 08 Oct 2019 19:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191008105510.6975-1-javierm@redhat.com>
In-Reply-To: <20191008105510.6975-1-javierm@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 9 Oct 2019 13:17:58 +1100
Message-ID: <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
Subject: Re: [PATCH v2] efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Hu <ivan.hu@canonical.com>,
        Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Micah Morton <mortonm@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 8, 2019 at 9:55 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Laszlo Ersek <lersek@redhat.com>

Acked-by: Matthew Garrett <mjg59@google.com>
