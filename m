Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC23D6467
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777062595; cv=pass; b=U3t12TDMmGfJqRQtTO1HiFGLqZM4xvHktEAuMiLt7kM4Ngej+n9YCRdzZIPV88jEoxuh9LWrDLj+LRA5kZmTdgWfR581n3l4lGw0DqbEJ3KJh0MKQv9ABzpYLyNLoe/VnAUKA9u1/UJFp+3h5Ap8memNuNA+8Mqay72SULBzpoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777062595; c=relaxed/simple;
	bh=+T4F0uNh5J6jVmx6oy3qBJn+uIleAsU3LmMjgFHY7kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZl49mrssVtc8mQFFzmstPXAEHJvzpMbE62dCkui3b3zMxs/+COsXBuhJqMhdPnqDc7noXdWIpEylqq5zC1yDJ8fRydW1vEK1r2866nicb1B4k/RY1v4XfTLOQhUYeSYMFIAVN9iQPCKbJvL3FyUdQklXBcwPKEs+OnYzkX6/I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c1G2CN1C; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c1G2CN1C"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so3216306a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 13:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777062594; cv=none;
        d=google.com; s=arc-20240605;
        b=JxuaTdGR3SYiE22ae5CgIseq2PA6iz/Pwv8SmgouyRJvFhYaii0/wPE0LdKkK0e6Tq
         HCgi5Y8A1Zu1jpzyH4aPIoFNWoszd4kkhsZWd2VNkZlwO1N1SGfDUCEa93LDtPS8Dpeg
         QXW4hp2gHYhDNcXq9rvyByx7S//qOhHOcrlGnCZg+kz5DKlSJQpt4oA8TV7ooZxvUCr+
         LxkVN83LT4EL3n+telPJWgMi/f1hnhlq1tWxSQ84PCLjVWdCl5xFQrVcy5CZQMPcOH4i
         sYNVrD3yxN0dkAPhhBCHwmNUaE18l0aHxDsu5HQKaWbmiQR1575461hNVb3GLgp9RRpw
         XpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMhwv8B42Oswf/FXJKVpTMSL/MUmT8hvMVU/KqHGQy4=;
        fh=tW6c0hT+px9Y6i10wCq/WHp2rxuItY1HfEXhWIjJ4E8=;
        b=CPu277wxoNYTLctppck9cl6d4HOLv1RxDUZW4TrFPhcJj6eLcqA6aT+bxTidzzc2Yr
         2xEfCf45T3P+kkZpSEQjTPHnmYTikBc2jSXklhOXEfwzK6yZYJjv+CjnPqMuIt4XnCWL
         sjQMCOyAn5gnZk28LVf3k2PJHZs7ut+6TqT3yG6s96NQukoIpx2H5zUf85pEEYL/4gJ6
         quedOh8TWYy4c9o1ZUTGqV1bTxFbY3WUiZNJ9v7SZyjKi1BeL/sUntLYFrIrAQiEVxk/
         ZW6LL2gG59DJO7/fHMhy4voYF1c9XAmXHSVdAJVSOjSf/upOxi5UxdcOFvs3gfZECr5b
         LWCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777062594; x=1777667394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMhwv8B42Oswf/FXJKVpTMSL/MUmT8hvMVU/KqHGQy4=;
        b=c1G2CN1CkneFjh8oFfUBALGPUhj5INybitdCwnI0cky12C0x+V0zOvxmwng8KJt4XO
         VZODtdockWiBywa0Vc7xGPsou6698PC+UZQm903TGLBLj3ixGVyu2BbzjGjPv6THQoX8
         n6sLRlyi8sVgnJtH7mDmFANbVl97tBR2RSZpNQhHR/y8nE7f8S48PxFCflHDhwuAKk/i
         4fXyROZr9pwSsR8xDiRIr9/W5BP1Gj6svPBlsmfMY+40Sj2z2GxoVEbQS0JywQDNpVrF
         mKNfsCC4uj8y5OPwb+Y9zEe3SL/M/Dksj50osRHW8KJUJYDlgpOMxeDJFLj9nX+Ykp3o
         4aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777062594; x=1777667394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMhwv8B42Oswf/FXJKVpTMSL/MUmT8hvMVU/KqHGQy4=;
        b=nWCBl2MvMBR6S4EEuMsyE4VWmv4Q+8jcbVv31orh/z43DtQ8kddQ8K1waKKodZlAQw
         cpw2IWa3qyWXrvb9xvg1qFUDjn02VqeKxYISnmHOze0m7o1gOPT47JQczuaDpTBOEfZH
         xsnt2reOdp3Uui5vkXzc6h3/hzCwrE6LrzBR8mQcSVr/hQVuovbVSxuNuI/NwrZz1wKP
         Eyfq/S/blbhy/SLllHpscipMOtvqF5oGAMSeEY55i74aCBarpXF2GFP9f+g4g9KceCqc
         MBt0Ois/nJoH+/3XNyTOgWPk16NBdY//q0EjeO4k3Ta8agNvB4jpNR/tzI1EZt1Pa1s4
         i2VA==
X-Gm-Message-State: AOJu0Yz/aAcYPFP5X/Wj95QrHsm6PvY9zW2NIuVYEI5+F4RKBdU89kdv
	gRWZ3/DJy9IOTIWIJzNn6Q2JrSrtL/FcP/KJWApFqETAcWigC/rx+2HRfg1lmzWB4st0hxJ16Q3
	EniKVhOuJs+5z4lk/xGMwpL8K6P0mKIDtnr/8u3s3
X-Gm-Gg: AeBDieuprwBXCOP1GAl7tYHPvETvLKTk+tvzAC+JmlYRWvKXXW56D2ubYFv2haf5foV
	Rf07+alvzEvaQMpa4s3k39wqH7JQOl7SQxn4Or4Rm4H9tLudegbwD12fvuZjIT9m+wyX9Gy8zLI
	doc948KtYvdK1894qrh67XKmqcgt6ot4bzR9hJZbc0/UHVQkP+Ky2UlpG/N803kXPZf67+0C8W/
	/F2Tqbvvb5ME92Bx+3eGU2ZWSodwqpc+iaxImRky6LXTsz715eT2K9C8+7GqUoR6M/LY73I9r8w
	gRXRjTIwJ27rbD6Kvw==
X-Received: by 2002:a05:6a20:e211:b0:3a2:7ef4:81df with SMTP id
 adf61e73a8af0-3a27ef485b0mr27995081637.26.1777062593995; Fri, 24 Apr 2026
 13:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225192143.14448-2-casey@schaufler-ca.com>
 <c25833f447e6c00868b352cfea50d2b2@paul-moore.com> <fadac326-d6cc-4d28-8ebe-b4ed3a06ddd0@schaufler-ca.com>
In-Reply-To: <fadac326-d6cc-4d28-8ebe-b4ed3a06ddd0@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 16:29:40 -0400
X-Gm-Features: AQROBzA0OT_v6zCGlJnHnfaAeWLqvw1KB9PbY7WrmJzxL-y-1ou3DTCM5FkLECM
Message-ID: <CAHC9VhRkup6GSj_wXp26_8PmjgBZSZK7Fk=F6RPy+bjbCRgJyQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] LSM: add a flags field to the LSM hook definitions
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:24=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 4/23/2026 6:19 PM, Paul Moore wrote:
> > On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Add a field for flags to the definition of LSM hooks.  This allows
> >> for hooks to be identified at system initialization for special
> >> processing.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/bpf_lsm.h       |   2 +-
> >>  include/linux/lsm_hook_defs.h | 614 ++++++++++++++++++---------------=
-
> >>  include/linux/lsm_hooks.h     |   4 +-
> >>  kernel/bpf/bpf_lsm.c          |  10 +-
> >>  security/bpf/hooks.c          |   2 +-
> >>  security/security.c           |   6 +-
> >>  6 files changed, 331 insertions(+), 307 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> >> index 643809cc78c3..d71ba8c87e79 100644
> >> --- a/include/linux/bpf_lsm.h
> >> +++ b/include/linux/bpf_lsm.h
> >> @@ -14,7 +14,7 @@
> >>
> >>  #ifdef CONFIG_BPF_LSM
> >>
> >> -#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> >> +#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
> >>      RET bpf_lsm_##NAME(__VA_ARGS__);
> >>  #include <linux/lsm_hook_defs.h>
> >>  #undef LSM_HOOK
> >> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_de=
fs.h
> >> index 8c42b4bde09c..acda3a02da97 100644
> >> --- a/include/linux/lsm_hook_defs.h
> >> +++ b/include/linux/lsm_hook_defs.h
> >> @@ -18,451 +18,475 @@
> >>   * The macro LSM_HOOK is used to define the data structures required =
by
> >>   * the LSM framework using the pattern:
> >>   *
> >> - *  LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> >> + *  LSM_HOOK(<return_type>, <default_value>, <flags>, <single>,
> >> + *           <hook_name>, args...)
> >>   *
> >>   * struct security_hook_heads {
> >> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME=
;
> >> + *   #define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) struct hlist_he=
ad NAME;
> >>   *   #include <linux/lsm_hook_defs.h>
> >>   *   #undef LSM_HOOK
> >>   * };
> >>   */
> >> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> >> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> >> +LSM_HOOK(int, 0, 0, binder_set_context_mgr, const struct cred *mgr)
> >> +LSM_HOOK(int, 0, 0, binder_transaction, const struct cred *from,
> >>       const struct cred *to)
> > I think adding a flag field to the LSM_HOOK() macro/definitions is a go=
od
> > and useful addition, but I'd prefer if we created a LSM_FLAG_NONE #defi=
ne
> > and used it here just so we could avoid the back-to-back 0's and do a b=
it
> > of self-documentation.
>
> I had LSM_FLAG_NONE initially, but removed it when I saw the amount of co=
de
> churn it introduced. I'm happy to put it back.

You're already touching every LSM_HOOK() definition to add a another
parameter, changing that parameter from 0 to LSM_FLAG_NONE shouldn't
make it that much worse.

--=20
paul-moore.com
