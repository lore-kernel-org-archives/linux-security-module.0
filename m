Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29596C48BD6
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C0C2086D
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJWfF4PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfF0KGI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:06:08 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45510 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0KGH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 06:06:07 -0400
Received: by mail-ua1-f66.google.com with SMTP id v18so608192uad.12
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d3Ru/epqcKSdd6urtlGQx+RBPxT9C1o3y8n/GaRj0IQ=;
        b=WJWfF4PVo0+95PvGT5hg2e4Xeu/u3T/2L4nJe69VTor4JJVxeDdlqbkIbil08BQcFq
         4WNizc0907sGpZ4DC8lCEjX+TqmlXc6gNLvaAixKpQpcDzXZ/csQnyTyJ9LyWnlKP5XK
         DfzkoEGW0SfvupgEB+clKSA6s//2MV85T08hiVgG34Mr+wMKt1v7ZYUd4D5ntgPfiIWT
         BQIO/8nMl3PMVW49ehtZAe939r/ma8rq5oFi0/exvVxF+r/wj/vRmU7YNMfyJa4c2yiW
         3wy4T1Z6Y7C0Nl2uGzKVuMCPOreBitQMkM5u9hBPZtV3zoOH/jyJBhyExmyBNM5uutqZ
         op6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d3Ru/epqcKSdd6urtlGQx+RBPxT9C1o3y8n/GaRj0IQ=;
        b=rGQ2f0PRnxJVQepVnZv7UjVmXpQ2toHnTxgOAP1VkUF5URpLgjfNKbjPRDw6tLQH+3
         iWb2QEqUmXj5Xs7gNQtrIYpD0Lf7zEB+t4lIrC8MRcb87VGyJSPjM2HCBhbzhYlMq6Qr
         IXOaG5zLCyC8hj6YZB7i4pyxbO2rFmLsmwJBxsm8teBekwWQKAF/48uepQg92CBk4Q6l
         nLqYfXDbCSt62XfQSpRBfOMVjZQTfoA5pZj0N5XlY8xrigKAXGpqvFiYc6h54opOxoGY
         gW6q8znE0hchqey/DsNTFIXDibJm1iaZlDy9Kz0/P4Xv/R4B3IUCo+j10wI+Zp4sgKaZ
         lU6A==
X-Gm-Message-State: APjAAAVd3Q56LoBcJ3sBPTOi1KXzxugLBkySNQxYikmjoKFZ9bGNO+nt
        QzeaTp1DMTRdap7NMvUTXlVySJlQjj2I3ViIlvcQcw==
X-Google-Smtp-Source: APXvYqy57wqyZI8LbJdgFCXKbEYhDUuoxxAgY0BAe68utv9cKzvGiUTExbd/UyfLgBKJ4hy2WFzLkW2oZMYLWpxsMYo=
X-Received: by 2002:ab0:64cc:: with SMTP id j12mr1845628uaq.110.1561629965902;
 Thu, 27 Jun 2019 03:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190626121943.131390-1-glider@google.com> <20190626121943.131390-2-glider@google.com>
 <20190626162835.0947684d36ef01639f969232@linux-foundation.org>
In-Reply-To: <20190626162835.0947684d36ef01639f969232@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Jun 2019 12:05:54 +0200
Message-ID: <CAG_fn=XF1C-3CCKGCHTrgCtcsh-u390hjM=rp5ZRv3ijTH5YgQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 27, 2019 at 1:28 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Wed, 26 Jun 2019 14:19:42 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> >  v8:
> >   - addressed comments by Michal Hocko: revert kernel/kexec_core.c and
> >     apply initialization in dma_pool_free()
> >   - disable init_on_alloc/init_on_free if slab poisoning or page
> >     poisoning are enabled, as requested by Qian Cai
> >   - skip the redzone when initializing a freed heap object, as requeste=
d
> >     by Qian Cai and Kees Cook
> >   - use s->offset to address the freeptr (suggested by Kees Cook)
> >   - updated the patch description, added Signed-off-by: tag
>
> v8 failed to incorporate
>
> https://ozlabs.org/~akpm/mmots/broken-out/mm-security-introduce-init_on_a=
lloc=3D1-and-init_on_free=3D1-boot-options-fix.patch
> and
> https://ozlabs.org/~akpm/mmots/broken-out/mm-security-introduce-init_on_a=
lloc=3D1-and-init_on_free=3D1-boot-options-fix-2.patch
>
> it's conventional to incorporate such fixes when preparing a new
> version of a patch.
>

Ah, sorry about that.
I'll probably send out v9 with proper poison handling and will pick
those two patches as well.
--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
