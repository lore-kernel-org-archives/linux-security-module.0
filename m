Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC69C6FA8B
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 01:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIWBTA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Sep 2022 21:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiIWBSr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Sep 2022 21:18:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66743115F61
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 18:18:46 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1278a61bd57so16379909fac.7
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 18:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wauY9icRcEzEDbhLIuBAjc38+zIZU9tq0CBry9g6Ooc=;
        b=slE4TJt9/dXDYfy+rMRKeN5k8cMVUfrps+7LGvGQhlqHE6ERCjN/lfbKJ4KjF9nXeo
         6AJfMTUFZk/R3ITkRAB/Iu6XNtGdRXBPvSyxmSSN46t4/ltDu6V8cBEYShJL5X92F18m
         G47uf8YuxIn+QgNPctzUMP3X6nCwc3O2N7GYJfAX+lJn8dMhfM1Fs9wWxlcxmEFakRjg
         FhXSZXSyWPYguhFhFLJaTPt3Tkf8N/sWD6l6MqxIPratLG/PZSTYa5OdrMZZxjtYgoFG
         Yr38vg6UpQ7rqJipbno3wA0356WdNtTAe8GeHQaSCsCsZefmQgqMzuM5E1DiycXT6Um/
         qm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wauY9icRcEzEDbhLIuBAjc38+zIZU9tq0CBry9g6Ooc=;
        b=f4hKMwm7MM5u9PMsid5R6laMzdWRiEjkn6F/DpSkZtJcNOQ+M+iSvzFPYESBTJ7d4E
         Hl8p3pjv6Zy0aY3m6PG75891nD+y1CKDDwuab+uRFaI4dUyN5rY0ZzvS9cYSneZS/CVH
         dQeq31iLgvrcbCV7AgRR7AfbK8jGFB0zPy0v/eFrfM/r1vz4wTpypzPfHOl0Q/osHCgu
         fF/YcFP3syGvlamfGkKMDRYBhwpzlnhjYgg6q3sU8nMFTHSkJBh3ifHyDDKRfN4bvioP
         5qBKpSu0ni0evGudPtuv//hV0YDSvAQofuTR5J63BPu4hcJcphcQQnqIB7neV0cXPoEc
         Gkqw==
X-Gm-Message-State: ACrzQf0n/64cabYgQnCNMXafTAohAprEavWSmwvlF+/m8WoWJEmO0K0r
        J+0mP7ifweK6qCdDZIdCUikbpeUcUiedhP9pkCAA
X-Google-Smtp-Source: AMsMyM7nqnRFdhUa3AKhiMDrdqfkMkNMtS+CAPxM0mIQs/OrjYyKafG9iMOvWz5ktyQ7ZfkZNj8lp2r17TUOYM734bw=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr3740124oaa.172.1663895925469; Thu, 22
 Sep 2022 18:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220922193817.106041-1-nathanl@linux.ibm.com> <20220922193817.106041-2-nathanl@linux.ibm.com>
In-Reply-To: <20220922193817.106041-2-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 21:18:34 -0400
Message-ID: <CAHC9VhQG_jEh_H8pV-qJgX2oX_fyGjXoBV7_EJOgvOd4ndc+Xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/pseries: block untrusted device tree changes
 when locked down
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        mpe@ellerman.id.au, serge@hallyn.com, ajd@linux.ibm.com,
        gcwilson@linux.ibm.com, nayna@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 22, 2022 at 3:38 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> The /proc/powerpc/ofdt interface allows the root user to freely alter
> the in-kernel device tree, enabling arbitrary physical address writes
> via drivers that could bind to malicious device nodes, thus making it
> possible to disable lockdown.
>
> Historically this interface has been used on the pseries platform to
> facilitate the runtime addition and removal of processor, memory, and
> device resources (aka Dynamic Logical Partitioning or DLPAR). Years
> ago, the processor and memory use cases were migrated to designs that
> happen to be lockdown-friendly: device tree updates are communicated
> directly to the kernel from firmware without passing through untrusted
> user space. I/O device DLPAR via the "drmgr" command in powerpc-utils
> remains the sole legitimate user of /proc/powerpc/ofdt, but it is
> already broken in lockdown since it uses /dev/mem to allocate argument
> buffers for the rtas syscall. So only illegitimate uses of the
> interface should see a behavior change when running on a locked down
> kernel.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/reconfig.c | 5 +++++
>  include/linux/security.h                  | 1 +
>  security/security.c                       | 1 +
>  3 files changed, 7 insertions(+)

A couple of small nits below, but in general this seems reasonable.
However, as we are currently at -rc6 I would like us to wait to merge
this until after the upcoming merge window closes (I don't like
merging new functionality into -next at -rc6).

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/README.md

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7bd0c490703d..1ca8dbacd3cc 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -122,6 +122,7 @@ enum lockdown_reason {
>         LOCKDOWN_XMON_WR,
>         LOCKDOWN_BPF_WRITE_USER,
>         LOCKDOWN_DBG_WRITE_KERNEL,
> +       LOCKDOWN_DEVICE_TREE,

I would suggest moving LOCKDOWN_DEVICE_TREE to be next to
LOCKDOWN_ACPI_TABLES.  It's not a hard requirement, but it seems like
a nice idea to group similar things when we can.

>         LOCKDOWN_INTEGRITY_MAX,
>         LOCKDOWN_KCORE,
>         LOCKDOWN_KPROBES,
> diff --git a/security/security.c b/security/security.c
> index 4b95de24bc8d..2863fc31eec6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -60,6 +60,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>         [LOCKDOWN_XMON_WR] = "xmon write access",
>         [LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
>         [LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
> +       [LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",

Might as well move this one too.

>         [LOCKDOWN_INTEGRITY_MAX] = "integrity",
>         [LOCKDOWN_KCORE] = "/proc/kcore access",
>         [LOCKDOWN_KPROBES] = "use of kprobes",
> --
> 2.37.3

-- 
paul-moore.com
