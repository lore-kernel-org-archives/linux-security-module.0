Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44828EE020F
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Sep 2023 22:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjIMWB4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjIMWBz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Sep 2023 18:01:55 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D481981
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 15:01:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-591ba8bd094so3234547b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694642511; x=1695247311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1BzhoPhb2//zdQEYrBqERcWxq7EXQZgg5EE9xLjsNE=;
        b=LuZacEr4T49S9dYehNHwcdL+HHWpbtTipqgkL/fQ3wwsOeHDCHOBglFEHAzGa5a1qr
         T0xZxk4PUlkGLQZEGKJSCywWAg/F/PDM4HcWOBC+seSjtcatOKFbJuRFL1s/g7QGKv1z
         zfa1VcQeVyhh5t9X1vbTg2THofL8+PCxdWD8O66DZjKWbrCICZM9fVa1Dsx6ngHaKIIk
         g7O219biUD3FuyGnMfUGoKAy4yemS4x9U50wY/+CkChdM+4rbfGjodAVey2wPsqqbCHb
         yixBRqkpajxc/4daptt3p047jWQSIUBtwvhmyn7Fgpw7OGgojtP7K7GVi0OnaRSc4VO1
         PmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642511; x=1695247311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1BzhoPhb2//zdQEYrBqERcWxq7EXQZgg5EE9xLjsNE=;
        b=b4a6ghTljaOQ5zUqAkTNXfnExBWRy5p/okXdYx6xf5QtjPLia4hM4h52tzB2cHwMEe
         ZysZRiUz9i+c2eCs4hbqUDXx8zHoRnluJppm/K24Dxa4djqPBpVcgwogv0cdp/gHmwbR
         x4cgypgetJtyIJS3iy7GhNj0LTAoU846phLkduhLurjaDJvyRT3n8UCoibdbiY/Grziq
         R5XAZe5zGyLU6iWDGcmypwBgQRNpmMOckX2emNjUf3QnEhZjY7cLTLirGUeVoy+OQUe1
         O0SZfDiTseCOqCgvPqn/ZKP1co0RKgc6vO7Z5HBL08JxO5veZe53dAD87wJxMIEYtJci
         qvCA==
X-Gm-Message-State: AOJu0YzuJQWn7OcYo38rRUhBd997rTTt3+8m22cL5J6AGA5H1echxLGR
        hvQVRY16+FCnZ7PgUghUSD4HcAHWQdOtkAeaEqMd
X-Google-Smtp-Source: AGHT+IE/S8VnWj48T5HhcdZ/RxneEfjJCCSGxot8kBZp01rmiH8JIaXQtCkeGNS/ETtaApzkkbtjU52xB6QNSy4jSfg=
X-Received: by 2002:a81:8392:0:b0:595:2de4:c991 with SMTP id
 t140-20020a818392000000b005952de4c991mr3691240ywf.29.1694642511140; Wed, 13
 Sep 2023 15:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZOWtBTKkfcc8sKkY@gmail.com> <ZOX2XDdrfk8rO9+t@casper.infradead.org>
In-Reply-To: <ZOX2XDdrfk8rO9+t@casper.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 18:01:40 -0400
Message-ID: <CAHC9VhRBMmt9UG+FM6ZUERJdoa8UDO-LqoqMK_WadvUvCzTBcw@mail.gmail.com>
Subject: Re: [PATCH] lsm: constify the 'mm' parameter in security_vm_enough_memory_mm()
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 23, 2023 at 8:07=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Wed, Aug 23, 2023 at 11:53:57AM +0500, Khadija Kamran wrote:
> > +++ b/include/linux/mm.h
> > @@ -3064,7 +3064,7 @@ void anon_vma_interval_tree_verify(struct anon_vm=
a_chain *node);
> >            avc; avc =3D anon_vma_interval_tree_iter_next(avc, start, la=
st))
> >
> >  /* mmap.c */
> > -extern int __vm_enough_memory(struct mm_struct *mm, long pages, int ca=
p_sys_admin);
> > +extern int __vm_enough_memory(const struct mm_struct *mm, long pages, =
int cap_sys_admin);
>
> Could you remove the 'extern' when you touch a function prototype?

Khadija, can you please make the change Matthew is requesting?

--=20
paul-moore.com
