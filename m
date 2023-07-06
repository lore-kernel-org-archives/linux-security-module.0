Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE62EB64D9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jul 2023 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjGFNnY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGFNnW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jul 2023 09:43:22 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0797B1BDB
        for <linux-security-module@vger.kernel.org>; Thu,  6 Jul 2023 06:43:13 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57a1f51d7a7so10276377b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jul 2023 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688650992; x=1691242992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT8BY107F234pJUFYRDnxShe9JwENWMd0PVN0/HLaoA=;
        b=WKXBYdJLM9rBsmygJxSANUdW8/Y/DLQu4jhfDBccMqplufuI4kb6jhM2Zg+04ixAmn
         Udd9TNJ3Q38uJ1oRrPDx8SShx73ZP4KhfKVJpIEg7txoO+2fuvUr739jqP8fze1YmnT8
         I5CPeJBcBXBPhB96ellqPiLdvgbXASHje7gi8bsdJ0gUYfGeUMBWs7EMhCeDytmED4lD
         OoYhlRal6ieNbhebtpC3QIArA5RpjE1/8olxmKO61ihOiDoHGbwSy0N9qE5cUGUp3XG4
         k02CBQ3RSH8r18O47EaM4IKL9grwmgQrQ8kckZc+OMG8TS55ObkN7MtKIBy3AZxf+P9i
         CH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650992; x=1691242992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT8BY107F234pJUFYRDnxShe9JwENWMd0PVN0/HLaoA=;
        b=Q5tUVCvrwGJr99JYHHnU5UEmAJ27F3qeub1tFlxTjuiu5Do66XIeAzkY3U9sIoI4JH
         OOk4/9x+inmEa3TTPsYicllKTRg4lY8n0p62FNOEey4FiPL/xAjEWk82dy6LN5Ifibmc
         CWqJFBXhuiAL3DyWHwplUwTuDlOIQmpS66QG8hBpolqt6aHxqCbJ7iIBAxLK1Fh4SMx/
         D/IwOivKX1pUeunYm19ZEMkFIXjvMcgNXGTU0zjEb5J78YZ4+cTgSfIGmUltuTHaY/M6
         fYnH/T+7kzIfMVq918mvNXTAhGOTXtPYBRC7XO/CIlnoYAv+KE6CcZzr2UH8JSAfmO/1
         FZ5Q==
X-Gm-Message-State: ABy/qLZwNyuj1Mz5hcC1Wh5PRtVzjN+WhkQqelCul5mP2LM6+fm3BAe1
        gMRPOLe0NlrZMuMWjvmypcKFLAq9Zk8nOxB2l/Hc
X-Google-Smtp-Source: APBJJlGH0atS+gjJyrkhl7Uc3dpEbmOj63q7B80Q3VKQ4Ga/362PigIeY2Hlt6E2++dGDdwQw8PSt8TQnE8JqpK9PK8=
X-Received: by 2002:a0d:d206:0:b0:576:f0d6:3d68 with SMTP id
 u6-20020a0dd206000000b00576f0d63d68mr3400501ywd.32.1688650992162; Thu, 06 Jul
 2023 06:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
In-Reply-To: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Jul 2023 09:43:01 -0400
Message-ID: <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process
 on Host
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 6, 2023 at 1:20=E2=80=AFAM Leesoo Ahn <lsahn@wewakecorp.com> wr=
ote:
>
> Hello! Here is another weird behavior of lsm stacking..
>
> test env
> - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> - boot param: lsm=3Dapparmor,selinux
> - AppArmor (Host) + SELinux (LXD Container Fedora 36)
>
> In the test environment mentioned above and applying selinux policy
> enforcing by running "setenforce 1" within the container, executing the
> following command on the host will result in "Permission denied" output.

SELinux operates independently of containers, or kernel namespacing in
general.  When you load a SELinux policy it applies to all processes
on the system, regardless of where they are in relation to the process
which loaded the policy into the kernel.

This behavior is independent of the LSM stacking work, you should be
able to see the same behavior even in cases where SELinux is the only
loaded LSM on the system.

--=20
paul-moore.com
