Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1B5C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 10:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbjKBKBU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Nov 2023 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbjKBKBT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Nov 2023 06:01:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E05136
        for <linux-security-module@vger.kernel.org>; Thu,  2 Nov 2023 03:01:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB41DC433C8
        for <linux-security-module@vger.kernel.org>; Thu,  2 Nov 2023 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698919275;
        bh=5Tenz6IsQxQGTAcqCMrHFIRzA1ReDvwUimtWjz7Pk6c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aa0PC0QENyM19cM5GFisLoGFzExFRKJrBnvjoR3qHALDCXZvW7+UTyDZppoizXLRv
         RRQ4vRysGaE+RbWOKQYH+jBobEqYhPBdL0JmSSju/kyF0mHLlsi+nG/6050UCS7fbO
         gM1klJBdsZ+42Vq6soiJWNGYSObEs+/AF1oyONsfrraVK61m3U3NQvkCqst8PXiGq0
         kcSi9ukjfa2jDu3AWCNi6jLHs8aVc9IeYPCKhx1HHyDKhtsowKkU5GHKXEPvvlZswh
         YppZvvv8QpN9eBgR/A66NGuzEIpP0YsDWdOCnVc0TtxAEU3LiWMYTLMihIeEJoyAm8
         5HXyfElUi3WZw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so1482996a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Nov 2023 03:01:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yym81MZBbTeooIPOlwDudNK2c5hpAkr2KW7YMObCF12otYrTGhp
        dXc/ZSMDYFGf2VkbCWgBXRYX9Fhmx/oOAevHlLEpcg==
X-Google-Smtp-Source: AGHT+IFSvp6vXpWavXqy0F9iwkZFc10mUQFAau8fMesG9rp8W0PAa+qisA/0gq7T56jtN9r4Hb92jBAWfBPBzUICsS4=
X-Received: by 2002:aa7:d6c4:0:b0:543:42ac:c9f3 with SMTP id
 x4-20020aa7d6c4000000b0054342acc9f3mr4566613edr.19.1698919274251; Thu, 02 Nov
 2023 03:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org> <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
In-Reply-To: <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 2 Nov 2023 11:01:03 +0100
X-Gmail-Original-Message-ID: <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
Message-ID: <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 2, 2023 at 10:42=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I didn't get your response on https://lkml.kernel.org/r/c588ca5d-c343-4ea=
2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp .
>
> Do you agree that we cannot replace LKM-based LSMs with eBPF-based access=
 control mechanisms,
> and do you admit that this series makes LKM-based LSMs more difficult to =
use?

If you want to do a proper in-tree version of dynamic LSMs. There can
be an exported symbol that allocates a dynamic slot and registers LSM
hooks to it. This is very doable, but it's not my use case so, I am
not going to do it.

No it does not make LKM based LSMs difficult to use. I am not ready to
have that debate again.  I suggested multiple extensions in my replies
which you chose to ignore.

Regarding BPF it's very much possible, as I suggested many times, you
need to rethink about it in terms of implementing policy and not try
to dump the whole code and interface into BPF and expect it to work.
It will need some design work and that's on you. We can help you, we
can also take patches for anything BPF would need to make stuff work
(I don't see anything obvious needed yet). But we surely won't write
the code for you.



>
