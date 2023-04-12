Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B194C7619A
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Apr 2023 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjDLQuq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Apr 2023 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjDLQuk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Apr 2023 12:50:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB5659E
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 09:50:15 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54f6fc7943eso112332247b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681318158; x=1683910158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8x2GYQVTWi+sPNYvJWEXQwUM4/xewwyCUDz0TcH8TOo=;
        b=K6l7g0Yj4XlJqjAsyHyWP+Q1rL9gJtHxD1PnxWOB3Q7aHr+SYV9cIBfSPEOu9Nx5k1
         UbHIT8aHIROyoCvDEUMRaT348cFCflSr5lG/byaxjgOTXyGRGGL7JSjPpoenu7LHieTq
         V2eRmw7klQlY++6lH9RMNUxrJyuPhVLhLvocwndrawpEtqiKc6KRi0SofZhGrsicNbno
         +jbxiR+iaUQwpiscPx9oZ3A031YDcBndEmEmk7kK02NxmotA7B5EZobCi1pNG/Pl5DN/
         8Vur2y1JAU+LAzV78OPE/yUndwunnnm0A5aw3gzV7VjAuNrLE4rE6VrllMOWDWCMUrd1
         KSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318158; x=1683910158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8x2GYQVTWi+sPNYvJWEXQwUM4/xewwyCUDz0TcH8TOo=;
        b=j0HwbBIrpYOA/PwjJZxHPKOhu1UJpQ+gGEmuEsBbLxMwb7tEqwCPedI5t3RQfTNPyT
         xrVS0vAz0L6SK8rJ0r2Z4/JodKOWQqjAxN1CfUHPAn0J0fJPPyaSZWikbXbpIgFJ7PWv
         uzqjaECB335o53wcG+mA1fJW6KxMHATKYoGhDThDCnGUSBvFhQDj/nIKZNMrGyeJrVy9
         KMP4DdoqquGCHz6fibYWyanHN/SS4YRn5pzQ1hKiM95Rc+CM4mRS6lqPwerfRlFBJ02r
         EcI64mRnCYbBDbLAmRnRhByyfg3T/Ov4j8sKgapLqNTTxdtxhgy/AMJ9i3AX3ZpYAtjE
         nrDg==
X-Gm-Message-State: AAQBX9fklalUMWGhGzeQsI1p8g6GHUNEwRrOZADoE3o7Mi158ByF1Nzv
        YMl9CBxU4DR/6NCTxTmP8Bk++HUnz21a/rt5+z9h
X-Google-Smtp-Source: AKy350ZDdYjcoWPVpXbg3FDE6dTQVUa/J9xJsjd6TMn/vmDnRg7KoxhVhQyxkVUzi7NoSRBJQKREjnpA/3hquvo0mek=
X-Received: by 2002:a81:a744:0:b0:54f:69a4:151e with SMTP id
 e65-20020a81a744000000b0054f69a4151emr4401389ywh.8.1681318157759; Wed, 12 Apr
 2023 09:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org>
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 12:49:06 -0400
Message-ID: <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, whi=
ch
> are meant to allow highly-granular LSM-based control over the usage of BP=
F
> subsytem. Specifically, to control the creation of BPF maps and BTF data
> objects, which are fundamental building blocks of any modern BPF applicat=
ion.
>
> These new hooks are able to override default kernel-side CAP_BPF-based (a=
nd
> sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
> implement LSM policies that could granularly enforce more restrictions on
> a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> capabilities), but also, importantly, allow to *bypass kernel-side
> enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and=
 use
> cases.

One of the hallmarks of the LSM has always been that it is
non-authoritative: it cannot unilaterally grant access, it can only
restrict what would have been otherwise permitted on a traditional
Linux system.  Put another way, a LSM should not undermine the Linux
discretionary access controls, e.g. capabilities.

If there is a problem with the eBPF capability-based access controls,
that problem needs to be addressed in how the core eBPF code
implements its capability checks, not by modifying the LSM mechanism
to bypass these checks.

--=20
paul-moore.com
