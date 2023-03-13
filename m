Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC17DC61DA4
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Mar 2023 13:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCMNQz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Mar 2023 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCMNQw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Mar 2023 09:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2A13DF7
        for <linux-security-module@vger.kernel.org>; Mon, 13 Mar 2023 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678713367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKyM6Ht9zjiLJ40pzCKLDw3GXf9qFWWMut5Ela7p7gs=;
        b=aAtlfzreisg+TS+fbbtNUNar0el9NacknQxzQAppxDv1BvmB2hob5OnjCH+UnWPfDqifJn
        Ap33n1PpzYCNXgTMgfqlWQf91liNm1ap39cSZ1tBI8gy11Nw5dAW3ATe2uc4p2tKOCbKNW
        cRg1ncvm9vV8an0PuEg54S3F9Y92usc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-O9qKYfxqMoWsQE1sum53pg-1; Mon, 13 Mar 2023 09:16:06 -0400
X-MC-Unique: O9qKYfxqMoWsQE1sum53pg-1
Received: by mail-pg1-f200.google.com with SMTP id q15-20020a63d60f000000b00502e1c551aaso2658275pgg.21
        for <linux-security-module@vger.kernel.org>; Mon, 13 Mar 2023 06:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678713365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKyM6Ht9zjiLJ40pzCKLDw3GXf9qFWWMut5Ela7p7gs=;
        b=YhbXQhH39mpRvw/Xy2vPx/GrGkxY8Oq2t3Tt7p4nwg70RDp62BE0p+Tbe0jXJuC4hA
         BSG4T4uWDtiMyXZVkDziLWrNqOzy7ctY5r0lowsb72bMIniV71jSIreZuBrrL1bb2oRx
         1P/gEfNBkQwAbkPCSVPKRfVS687Mk5bRbpjZFT6ljTSWS2JOyiw9glNmFYOLzPUvJBx5
         npmNMACWTE2A7n9ZoQcn8eVa81xeUF22Cl1DCY84RfT1vbC26OsyYnt+ifPcc+tY8ezg
         5cgF8ThHKhM9X68BmdtzZL4bDGYP1NvUpF8PCLbi976elFNQ9vlH/zHN3ofWKPcu39FF
         VPIg==
X-Gm-Message-State: AO0yUKVRn9N6jzVlwREEs62XT1TfVFI2GUWK0mtZ4ugMMwYOB51NnRSi
        ptTEfXj/nHcLP6YlcHd1HOSv0N360CfeAWirU3OImtxVvkOqbzuIgEZmKZiUpJtARcrKj+gaIwp
        vH+0/eb16t2uVQAJKqwYysFlFjk2NTXUXPeX0ZVIUDUxYTvp13NJ/
X-Received: by 2002:a17:90a:985:b0:23d:27cd:f1dd with SMTP id 5-20020a17090a098500b0023d27cdf1ddmr241959pjo.9.1678713364977;
        Mon, 13 Mar 2023 06:16:04 -0700 (PDT)
X-Google-Smtp-Source: AK7set+SLBCllaY6lNZjLf2eCbIw673Z3tIbWDKAnR8hTQYgqNIrmqcuHi0dKPnJ+lnGCE2DZKJ+sn1hEuJzJdTDuDE=
X-Received: by 2002:a17:90a:985:b0:23d:27cd:f1dd with SMTP id
 5-20020a17090a098500b0023d27cdf1ddmr241952pjo.9.1678713364657; Mon, 13 Mar
 2023 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230217162154.837549-1-omosnace@redhat.com>
In-Reply-To: <20230217162154.837549-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Mar 2023 14:15:53 +0100
Message-ID: <CAFqZXNtjh5WqY-ShdbJr_0=wVhQs=X+-8C00_UzooP666SNnHg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 17, 2023 at 5:21=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Linux Security Modules (LSMs) that implement the "capable" hook will
> usually emit an access denial message to the audit log whenever they
> "block" the current task from using the given capability based on their
> security policy.
>
> The occurrence of a denial is used as an indication that the given task
> has attempted an operation that requires the given access permission, so
> the callers of functions that perform LSM permission checks must take
> care to avoid calling them too early (before it is decided if the
> permission is actually needed to perform the requested operation).
>
> The __sys_setres[ug]id() functions violate this convention by first
> calling ns_capable_setid() and only then checking if the operation
> requires the capability or not. It means that any caller that has the
> capability granted by DAC (task's capability set) but not by MAC (LSMs)
> will generate a "denied" audit record, even if is doing an operation for
> which the capability is not required.
>
> Fix this by reordering the checks such that ns_capable_setid() is
> checked last and -EPERM is returned immediately if it returns false.
>
> While there, also do two small optimizations:
> * move the capability check before prepare_creds() and
> * bail out early in case of a no-op.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: improve commit message
>
>  kernel/sys.c | 69 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 29 deletions(-)

Ping?

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

