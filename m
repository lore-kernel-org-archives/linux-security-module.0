Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15849E545
	for <linux-security-module@vger.kernel.org>; Sun, 24 Dec 2023 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YOtIarov"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2041e117abaso1761018fac.0
        for <linux-security-module@vger.kernel.org>; Sun, 24 Dec 2023 12:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703451208; x=1704056008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eJ5kELvKhedX9EnpknPh9Uzs8+yLEfkilDmWrRStKw=;
        b=YOtIarov/J6s9xsM6LiDPNK781OXlfgxMeMGXf2gy+ubMCSSqe8JmweU4DRCxIID72
         iAFaKfGmgTyPnB0SHaKIyp5BbHF36gC6fyv37TjbgrxKWhQmC3vWwNiyD7DNfShd7oDw
         PfIqwSMqF8iSyMQW/pFlidLHJYmNyzwjOS1MetE/oU1sk+O6v7xhmX8Qb/HowVAumivC
         hB/whMgie+6f03Rp3wtvN/x6l8/SY3sRhna2Tlo6QkJbEPmX2dubuc5HnmRLOTtSntqm
         FbF4L4A4UsZpMQ1S68abZOLVPDrLo3Bj1Q+VPyLRoCUk8LZ/tjVAtEtLVsQhKUrrr/fW
         N3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703451208; x=1704056008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eJ5kELvKhedX9EnpknPh9Uzs8+yLEfkilDmWrRStKw=;
        b=rkR4kGnZbYE8QQ+nWEWxgZDgnmRDgNLMDnIjLS/iOinyAWBWkSGEHAuLECLgoDqS+a
         ojCgA39+ZQDs3YoKcVIidYd9I3SGoLs5dqXzNEQSZUCKORyQMdUmcRKApQy/3fXg3sqQ
         TC1LQ43XcEOzuX1+7+61hfMrRKes+qapU2dpq0ii+LV2Czz62rNfbpjq83ASgXp4Hox8
         MlZqMEQFK0J/N8b8REftWuBEDz0LmyjylP2306GfBRmxuzDqi2cy/66lBnX5IgikfrTJ
         Ze2TvgzFfTFKKT2ES7MybzOfnuO88+wrBizfUYzB8HgI6xW48JBNcZe9ZLEJ9tp/ih1w
         4EAA==
X-Gm-Message-State: AOJu0Ywoim7ru2E9C5q5C0bEykDTEK/0ockMQqXVdzE8XAN98xfwlnkY
	hRbtsb1k1662K2Ipbjr8X+VL6y/W7F/uRl+RrKQtOCxo5FIV
X-Google-Smtp-Source: AGHT+IHJn2RMPINVg7kRyhtjoEo7CrInLSg++LDl2IOK5pQWVQokOc8gh9qoWmJejDIY2LhqBpVSFISgcHzHDX7bp84=
X-Received: by 2002:a05:6358:7e56:b0:174:c61a:4dd4 with SMTP id
 p22-20020a0563587e5600b00174c61a4dd4mr3742363rwm.41.1703451208018; Sun, 24
 Dec 2023 12:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 15:53:16 -0500
Message-ID: <CAHC9VhRDPv4-gNNiFMNtP_vL8UM66RQX0vxB0WkNw3Rn_Lcfmg@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Alfred Piccioni <alpic@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:09=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that is
> called from the compat ioctl syscall. All current LSMs have been changed
> to support this hook.
>
> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/ioctl.c                    |  3 +--
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  security/selinux/hooks.c      | 28 ++++++++++++++++++++++++++++
>  security/smack/smack_lsm.c    |  1 +
>  security/tomoyo/tomoyo.c      |  1 +
>  7 files changed, 57 insertions(+), 2 deletions(-)

I made some minor style tweaks around line length and alignment, but
otherwise this looked good to me.  Thanks all!

While I agree this is definitely stable kernel material, given where
we are at in the current kernel cycle, and with the end-of-year
holidays in full swing, I'm going to merge this into lsm/dev and send
it up to Linus during the next merge window.  The stable tag will
remain intact, so it will end up trickling down into the stable
kernels, it will just take an extra week or so (which I think will be
good from a testing perspective).

--=20
paul-moore.com
