Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754850;
	b=5guCYY5hihSvkyR5RygCtSv8CkHP1FFZk0hNzRaMU3CFxifvFhQTlgAlj95lK9RkbogI
	 n6xqpd8PQAPcDdERVBfvIdAHWwwvnijOEKukjLuRGbhxuxiCTGhYIM5HIG4VcfaRcQYpf
	 wJRhrz6Jn//XgQr99eV+lWAKvfPf360LHyDPObWA8o9OwV58B+49J2ulatvdg2LKpB6Mp
	 qIkjrSFTcTXEEYAuzUz9sUHhtNHO3NVoXmC3HIeBBQfY8a+CXfmZtX+rhRNfjRJW+NFkk
	 DM3gCsGnJ8tgosE02hKP4/G5FT0rX+cf6Ufpbx1BYgUrP8KDqNw1KtSrrZIizKCOC+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
	b=sL4UsZed1HoCjFgsr0vldBrsXtjsd7QatARV7pvih0PjJln97AoNSDqp7EzORBVrRA7Q
	 aL69ipJxkYLQkE5jxuwswXUfdgyb55sxWlIbzsZRteh9Eg8Gey/OIGlayJryy5Ml6DYd7
	 bTnM/ceQKhVaYHSdO8s+mieNZ1f+E2F4zaSKiHvkJ/KYlQFKTErj6mZr4kZRES8A7jTnZ
	 mzxPl/BYhb5Rhva5TWznUSDcG8d2Z79OlYuOwkzeBzqwZZFgf9xIU8X5w8mSv7kLuSzAW
	 PBV7/jlyTiVKYyJLU2A4RLnMDNgolrNnHd1ueTKtQQfZ6qeShSuufjC7LuAPVRquQlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B99606A32E
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 15:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B99606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4395d31228so439662766b.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 07:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754849; cv=none;
        d=google.com; s=arc-20260327;
        b=qpmTc5OA2qQqhfGk4Htp3A2mLVPOoSel6SDl5JWvscBkLyQfbAavxqW+C4zWxhTFRy
         o95363fOuBxKb2ij5+x/P8E93evvSX1u/2NQOLQKJzpy3eHxh3VFlKQSMEavxXfHjxO8
         GpvtksO6qsKmKxq7hgRGYV7/FZgWI2mfjIaiw127U0E0rD5yFVc8Y1uXkN987peJtujU
         NZerfQ/XT3JvlXsQgN5ab73W8caqPqUIV1PvTRKq/a04Ukge0BgKC+dDfe+VciauuDzB
         bGclqZVMMNkGrLsqSojF80FwpYDQiX9MHunf7ze343AdOvpz+UwojegcfyAhdTjF1zBu
         A35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        fh=E0Sq2FA8PE0ErAtCRISm+wvazrLHIba5lYoDqt85Hpw=;
        b=llqOHwJNtz/a6XjS4sb0Qglbw7hjDRdK7PM9L7CO/ONIy3EgJo8b+IdV2Cz97W8/Jp
         ePJzd8YdmdUITZUJusOE6Ti7hUo/IxvluqtgYhz6i37JZshG3OY8GFapstrQhx73gMfq
         ryKJ73epSIPMQt1WH3WW6q5OE4Pe+NaKoeVN8O1JIVf1PTnnKxOA8bBn40chji7PJGZi
         RfolorIwHa6cnvfgcv649I5o49EXhTl5qjNA1mDMZW6hfnagdNcPhMlPCH44fdx0uDSm
         o3gfEHdFKaWF7sHELAIrGoJ2Fws+/ZdqI40Ao5x4l0EGsLPSHmGljn90I5YaiN2VnTn6
         QUhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754849; x=1795359649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=SHyOkxQwYuLtL0+Qa53+jCNHfMYZrDoIhK10usTnr/SPlsQtxy3DYcaURrAaqZRP6p
         j9KX2LwDO7WvpxAFvRbeGvPMOpBnbsJEvuh/a+pWnWLMDcViXZq6b/VVaPZ68EhpaptP
         zHr4LucIEpdLZQDJogd72JZdMAkBHyXTxsReEVunL/+oJmqoO/hXoqxPt2Qr8UINUk8W
         PKisRAodcZl5vzpIsG78e9fRi2Mkv3dgu35W/QqWyi6fF9QsZX61BfySIbEHZ7oFXuQb
         7fuxV2YOwjcp9LUN7zRZYNpbm5Ey2kJzr2xgJrjMsYP1vCyRno2ESPfdF+IIuftfMTEI
         HtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754849; x=1795359649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=2zS3Spn9Qpd6N4o1YeJBDuKHiz7/6XZwg1/l5Asc/15uQejSJ9rWwsJheLzfh52W0G
         C6kwesMyaZdEjHQGFAiN7jdXynVFHXn7/Zob8QBLhyfnVaQ1MQoOylApMleI4yoy/oUB
         CL85828MzfiK7TCQzEq3ONJ8SK/6sZG3eEvB3hjR3m1aM/Iy/keTFrfYFn9hIjhaN9PN
         CYJ87xGhJ1a1i6kca3ENMP+G1Rg00MlEJ5TcjHs6nZXh8BiyPYH8MGdWQ4pa1jjFbBdu
         g0jp1Mw4GO7S1OQXwDo20uu7zI5fL2dpibnXIM/CbpCGcWW/YGn/QqIpIwHIDNONMQZv
         PQsA==
X-Forwarded-Encrypted: i=1; AL+hErHsYGh+YHtCwm7IYw0qvAZARhXikJC351It0bHNFu8enwf8ehQCD77yHcZZwuERPBYP8gnxsYfoQhkEmWDa1fyj6f7oPJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PBeCSdIaojJ33m3kcCfgYjCTnNpCbPqB3VH/weWQmpw/lkfKW
	8CAqRqpDV4SPTreIMuah3ZBKRHj03aNd0RuDNrtSkixVQxQdx1tKBh/DLEI2YnKSC/9XEd2uiu1
	fRdqK4W+qDClP+l5zeBP0iivofwOswqw=
X-Gm-Gg: AYBFou2Q1vnpXrMNAB079Qz1Rz1XHvJQ80fGNheixQjnMZZY/8zSdhQxh4G7/9ifzbm
	0z9n8RaN6u0mc09wjm4OsTr96ORZdJ9rFYUFnAuDhVJ5EjKFSjthLwwI8PD7O+J8QgnS3NYTar6
	C4BAO3ncaZUgIShzCuTsJQDBzKPTHqghoyPvudeYKtTRhoeCMHT6nMTNl1L3hRf+voGCRP/j99k
	9IUYetyDmXJJTefwlfn8tB0FTS3rIWI6Y8U7OUbwbu/dTd8H6EAAELzLYHFJoZSxiGITzT11luO
	Hs4pWE1cAt8n8Q6UDQPraxLnHNyyZfI7316kv17xkxsOrm7lySRE8HWn/BTeb2xufRFUTlvNWc7
	9rQP+3cVMir3rOO1V9sYk0dXBqsZdGu27BNOdhB62kZTSf/Cjoo+MQVhGBP1HjLBBJosNrw==
X-Received: by 2002:a17:907:6d11:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c509612a23fmr694079266b.6.1794754848470; Sun, 15 Nov 2026
 07:00:48 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:00:36 +0100
X-Gm-Features: AclHuK_wHYShIpzO3KRe2QttGftKj9EtJqTGjYXExDCpgXdtVHvMQ3jGuPVE7gY
Message-ID: <CAOQ4uxjoHbevvu8auB4m8AVcY9H6uHdDAP6mfi9OOMh+3775xA@mail.gmail.com>
Subject: Re: [PATCH 02/13] fs: add d_real_data_inode() and d_real_metadata_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Currently, d_real() can't fail. When overlayfs fails to look up the data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's more
> problematic than current callers realize.
>
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register() fails
> with an -EIO that has nothing to do with the actual problem. For IMA it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the real
> file.
>
> Teach d_real() to fail and teach all callers to handle errors. This adds
> two helpers for the callers to switch over to:
>
> - d_real_data_inode() returns the inode hosting the data or an ERR_PTR()
>   if that can't be resolved.
>
> - d_real_metadata_inode() returns the inode hosting the metadata. It
>   never has to look anything up and so never fails (but no promises for
>   the future).

About those promises...

>
> d_real() can't fail yet so this is a pure preparation. d_real_inode()
> stays around until all callers are converted.
>
> No functional changes.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/dcache.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 84b0cfe4ed0e7..674bc50b81827 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_DCACHE_H
>
>  #include <linux/atomic.h>
> +#include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/math.h>
>  #include <linux/rculist.h>
> @@ -660,6 +661,49 @@ static inline struct inode *d_real_inode(const struc=
t dentry *dentry)
>         return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
>  }
>
> +/**
> + * d_real_data_inode - Return the real inode hosting the data
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its data. Otherwise return d_inode(=
).
> + *
> + * The union/overlay may have to look up the data first. This can sleep =
and it
> + * can fail, e.g., because the data is missing or because its verity dig=
est
> + * doesn't match.
> + *
> + * Return: The real inode hosting the data of @dentry, or an ERR_PTR() i=
f it
> + * can't be resolved.
> + */
> +static inline struct inode *d_real_data_inode(const struct dentry *dentr=
y)
> +{
> +       struct dentry *real;
> +
> +       /* This usage of d_real() results in const dentry */
> +       real =3D d_real((struct dentry *)dentry, D_REAL_DATA);
> +       if (IS_ERR(real))
> +               return ERR_CAST(real);
> +       return d_inode(real);
> +}
> +
> +/**
> + * d_real_metadata_inode - Return the real inode hosting the metadata
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its metadata. Otherwise return d_in=
ode().
> + *
> + * Unlike d_real_data_inode() this never has to look anything up and so =
it
> + * never fails.
> + *
> + * Return: The real inode hosting the metadata of @dentry.
> + */
> +static inline struct inode *d_real_metadata_inode(const struct dentry *d=
entry)
> +{
> +       /* This usage of d_real() results in const dentry */
> +       return d_inode(d_real((struct dentry *)dentry, D_REAL_METADATA));
> +}
> +

Wondering out loud - since you needed to change IMA anyway and need
IMA patches reviews, do you think it is hard to also gracefully deal with e=
rrors
from d_real_metadata_inode() and not have to promise that it never fails?

This question is not intended to block your patches.
If there is a reason we should keep this promise for now,
I have no problem with it, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
