Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863DC25B06
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Aug 2022 00:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiHLAUJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Aug 2022 20:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLAUI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Aug 2022 20:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B40419AE
        for <linux-security-module@vger.kernel.org>; Thu, 11 Aug 2022 17:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E36615B9
        for <linux-security-module@vger.kernel.org>; Fri, 12 Aug 2022 00:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3117C433D6
        for <linux-security-module@vger.kernel.org>; Fri, 12 Aug 2022 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660263605;
        bh=VcBgOx72SrKAynvtEB4eJUbvGpRlwEh9BrnfUqJELdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h24mYW6Smp0tPJ6xgXWsTD3QXIw7kPqDPwYkneA3hzQRvVvbze5cozomfYkvGy6zQ
         BJDYVZqE2/260gOit/wJe3u2/iSRkTBZdyjo/vRY7lszHpivQm0tNkJASUwN/DAkUr
         c2eJU1S753riEYBeuFQrUGPT5/Ml18B/RQc3Ys3ueKE9bpZ8PWy97M4ZoQL3w+97pc
         qE1Ot/2HpT8UgITsXfghDJ9u4gO9ZC2kXNmhI3ljxtHGCfIkPtzxfTgFsDZKjrTTz7
         bTltCa6Gu7vg8Z8d2nyIbUPfERtmHA6398Q8YAQUj6ZFG4TfV7UtXKWktmo+p/6TJR
         uG86TM+qvHkug==
Received: by mail-ot1-f53.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so13804210otk.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Aug 2022 17:20:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo2Zkxs+JWhyvucunL9tJW405+7fEpgYh1S739gU1U5Vi8K5XHmT
        r5UbQme+Ps9kG02Ndrw1fWyhDGg3O+dNm+7POGziMg==
X-Google-Smtp-Source: AA6agR6dgH9Z0J57ZbSVmYT07RMNRaN2A8XBE58y1N2O6lsg+5CWO9rMzDJgZiq9KCWy3gOsBt3vlp+7vnloPLKLXnU=
X-Received: by 2002:a0d:d282:0:b0:329:74d3:b0da with SMTP id
 u124-20020a0dd282000000b0032974d3b0damr1809994ywd.340.1660263594446; Thu, 11
 Aug 2022 17:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220810165932.2143413-1-roberto.sassu@huawei.com> <20220810165932.2143413-5-roberto.sassu@huawei.com>
In-Reply-To: <20220810165932.2143413-5-roberto.sassu@huawei.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 12 Aug 2022 02:19:43 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6YC_rkX-DFt28_cbSFU23LV4sqq0PL5F6a=NL8GCRdQQ@mail.gmail.com>
Message-ID: <CACYkzJ6YC_rkX-DFt28_cbSFU23LV4sqq0PL5F6a=NL8GCRdQQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, corbet@lwn.net, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 10, 2022 at 6:59 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
> kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
> validate the kfunc parameters.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: KP Singh <kpsingh@kernel.org>
