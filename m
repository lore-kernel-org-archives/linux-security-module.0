Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A658C64EC4
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Feb 2023 21:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjB1V35 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Feb 2023 16:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1V35 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Feb 2023 16:29:57 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E02D156
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 13:29:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eg37so45658569edb.12
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677619792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8cphB32FCA+JDrayMTXIg9hnTVIdgiqn6d+31xf70g=;
        b=RnvoGAxGwdikhKT4SupAxcADFamYOt+/v6RSL1oTb/zDbv1TM2he0JfutFX0uxibsD
         aXfgAAPUlUpjgysAiDQd4529DHvHf+CRHuCzA3rdEZt3Lo9uF070u8Vc6hdwtGGCfB+P
         QOl8M4FHCDbGl0EnClfCc8ZznvdwK40yN+tsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677619792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8cphB32FCA+JDrayMTXIg9hnTVIdgiqn6d+31xf70g=;
        b=dkotsjPv/cyUV06NBT0EasY6X5PujY0O2UP7re6VBMkybPnBZebu1uP3bTfmM/X78Q
         EB+pzA6RdJvkiq6gY5n4Vm23TjOhCjEPiizycGsfW8bgTnZtghJc57yCDALHsHQOY87L
         Im1QiyGkce1Dt2jqw7K67seVgy2rd7lFuwwAMrELu5pDIOUopOLcNSYirWA6B1DaXWwV
         s9YaoaeXzxx7JwEPcj37pYD6px8KKSZAgc0waIDi+6fr5+pm345goqEQqBclYYCed5MY
         4kEwZMVb8+lc1jhVvECR+8rxE2LHMyAGA/thTMpKNBwXiRce94iLbQzoGwRQKmVybq/d
         YlqA==
X-Gm-Message-State: AO0yUKWPjKwQyyyr4RdOBSYVUU8bRb5TCHEbOA/1pIgfSDKMzZR3AxVz
        CZYsEUrkOEDEW6WKL2+MvpP8hattTG2nca7CPis=
X-Google-Smtp-Source: AK7set9ITmfkSf23Ijk4VO47fSHhYC7XWU/RdttsAMUigPXAS7Id1LbskoGOgY3XW+0nxB34UYMjow==
X-Received: by 2002:a17:907:2495:b0:8ac:8f3c:7f65 with SMTP id zg21-20020a170907249500b008ac8f3c7f65mr4294188ejb.48.1677619792358;
        Tue, 28 Feb 2023 13:29:52 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id rs9-20020a170907036900b008d21431e705sm4850939ejb.84.2023.02.28.13.29.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 13:29:51 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id da10so45909202edb.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 13:29:51 -0800 (PST)
X-Received: by 2002:a50:c34a:0:b0:4ae:f144:2c8e with SMTP id
 q10-20020a50c34a000000b004aef1442c8emr2699107edb.5.1677619791223; Tue, 28 Feb
 2023 13:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
 <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com> <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com>
In-Reply-To: <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 13:29:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
Message-ID: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 28, 2023 at 1:21=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> This is part of the crap which made me unwilling to do the clean up.

Yeah, it's not pretty.

That said, the old code was worse. The only redeeming feature of the
old code was that "nobody has touched it in ages", so it was at least
stable.

              Linus
