Return-Path: <SRS0=csG9=SI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA60C282DC
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Apr 2019 16:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C69213A2
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Apr 2019 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JB/yXI+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDFQoI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:44:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33469 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfDFQoH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Apr 2019 12:44:07 -0400
Received: by mail-ua1-f68.google.com with SMTP id g8so3073214uaj.0
        for <linux-security-module@vger.kernel.org>; Sat, 06 Apr 2019 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QPBWvNYRfn9RrwkGQNrcPHT2k49F8+w/Q08uBtT2w4=;
        b=JB/yXI+TgDQVGBmtzY2ZRlJ0qSadgN2Vxb0yPlHggu5bo3idHxxGmeEo3Wuj/TwU2U
         z0YCEy5FRbRoMrBBiPMRerZx88hdPKlC2yYrDiNB0mL1Pydz0See1IP7DuqIRMzxQdWC
         hJSO/JN3BzpXArUnEm570QxEaOQt3LrcyWdmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QPBWvNYRfn9RrwkGQNrcPHT2k49F8+w/Q08uBtT2w4=;
        b=EMDxzt+055v8iHoht+rO4/VRUYrfL3en2u28R8JfQJJ6lyiQvN+OUGD9B2VaU3KOlx
         7t6vCWRxEaz9+AxMS+GjrJnriKt00bRDi6SrrcyZl2RQ1zEnrHOWlz1Uw1F8ErYI5aJF
         o6WzEZijNnXKJACa3ApmyIfwyA4yZykPtcyXGz59UPNkfixr7HyD879UN7U5Y64GH0gM
         vbtDlpEglCRIyEDn9BoCdcVlhbvPoRxchrgEsT9qVGAATuioObgR9VBIn6tYpd/qDpw7
         oDzJl7WjUKE/KfZeb/63SwU8KtG0t6qM4JgHupqw2TT8gOAguIXRqf2bhN28Jdz8xkFb
         P2zQ==
X-Gm-Message-State: APjAAAUtNX8pUuykBtTk+DNXxguq8w6o3ImN33eq7LWXfGZaa59P9Dfy
        zyyjKGofvvBr1rDMnpU5Siv03QgV1po=
X-Google-Smtp-Source: APXvYqwGnxthWihzo3V5f+Ag86oc+ndHSGt2N2V0AcvP604YxfZpa2bO1J6Npisjy5tB01AvL7RUgQ==
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr6115372uah.80.1554569045946;
        Sat, 06 Apr 2019 09:44:05 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id d6sm423010uad.10.2019.04.06.09.44.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 09:44:03 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id d8so5274405vsp.2
        for <linux-security-module@vger.kernel.org>; Sat, 06 Apr 2019 09:44:02 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr11653813vst.30.1554569041739;
 Sat, 06 Apr 2019 09:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554485409.git.rdna@fb.com>
In-Reply-To: <cover.1554485409.git.rdna@fb.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 6 Apr 2019 09:43:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJGC1kB-0e3DimBSprcgEBnWRB=i287g-9T5a-RidFqBg@mail.gmail.com>
Message-ID: <CAGXu5jJGC1kB-0e3DimBSprcgEBnWRB=i287g-9T5a-RidFqBg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, kernel-team <kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 5, 2019 at 12:36 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> v2->v3:
> - simplify C based selftests by relying on variable offset stack access.
>
> v1->v2:
> - add fs/proc/proc_sysctl.c mainteners to Cc:.
>
> The patch set introduces new BPF hook for sysctl.
>
> It adds new program type BPF_PROG_TYPE_CGROUP_SYSCTL and attach type
> BPF_CGROUP_SYSCTL.
>
> BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
> that accesses (read/write) to sysctl can be controlled for specific cgroup
> and either allowed or denied, or traced.
>
> The hook has access to sysctl name, current sysctl value and (on write
> only) to new sysctl value via corresponding helpers. New sysctl value can
> be overridden by program. Both name and values (current/new) are
> represented as strings same way they're visible in /proc/sys/. It is up to
> program to parse these strings.
>
> To help with parsing the most common kind of sysctl value, vector of
> integers, two new helpers are provided: bpf_strtol and bpf_strtoul with
> semantic similar to user space strtol(3) and strtoul(3).
>
> The hook also provides bpf_sysctl context with two fields:
> * @write indicates whether sysctl is being read (= 0) or written (= 1);
> * @file_pos is sysctl file position to read from or write to, can be
>   overridden.
>
> The hook allows to make better isolation for containerized applications
> that are run as root so that one container can't change a sysctl and affect
> all other containers on a host, make changes to allowed sysctl in a safer
> way and simplify sysctl tracing for cgroups.

This sounds more like an LSM than BPF. So sysctls can get blocked when
new BPF is added to a cgroup? Can the BPF be removed (or rather,
what's the lifetime of such BPF?)

-- 
Kees Cook
