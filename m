Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4363E51F7
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787372; cv=pass; b=aba98JuHmcD5h0w2Ki052gkWzEaoJx3XgtimvBF45mD2Tdd6mLVjqLX5cBvYZsE1P5u1/oMdwl8l1J7zS4HM72o87cg0W3o1tUPl/CceLVfAeFBx9FmJN6yOcVyfcVtW/q4GPKfzK/kKedq3kOn+kZrotvi75hJCapDYpmXa0WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787372; c=relaxed/simple;
	bh=oScUuIjIjb/tZulbsi2FkIBZwopgeujtHsSn1k3PGiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAOCx0h98EzHN9xZGaKZb+N1hqCj/PDf0QbOb00mQ5umTIgw8a0+nOem0257roddeXIN4Nuhaqs5Of3e84Vb2X4GI2pdVYbINU5V/nn4lCTiJwa31yyK1e0VW/9sgBB9scXnCS/3bIdQZGBwJud4koEx87ov8skp7Jua6BjeWh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rp4KChT/; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rp4KChT/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so2280222b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 15:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773787369; cv=none;
        d=google.com; s=arc-20240605;
        b=jiXpsVuoSw+JoR37H4FvrLgeRzpK1OG5nIC+h2iWqcpgziXtHIjUCP56rHV/rJCaHM
         yDU9KjJlWhFp+sE3GLUEGnGZcENwHgHxfBmOc17UARwbfSMD4A2jDzPVbUQtJLSmsJAj
         pyC1pcj6okIOr9l8rDFD4zJOnjfhpnkg7/KDT1llcyqpu00TcjOZc4B/gPaq8Gd2f3nb
         QZFjyRkkdHMzFIKshHcOPJYqUn7uwKdYTOn7tJ1vYMYFb7JZBeypDUDPqYHmFddjHLrS
         2CzIAVjNFAzZvgwGI2/nP44byQzyWYoTbrBQdMPYDDo0pu8VpJWbVQRTxUAHm9X5CUyh
         cFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        fh=/XpAAIYvsh+24QrHGHWY/Lehbv+i1IXtGhm0V3NZrs0=;
        b=ItxvD0SGsUCZxIKv02o4+t00oT6XFMvUq9o0uTSygBdWcDVSta0kLPknrIMm9H09Cm
         TRbuAjem9xn/RJDMKU4lzkud7qPTj/JqcWoRdx32+itZ+GgUO7lB5Ko4PuS2VU3wk3wi
         vNqweamW6vCFSbxh7RyVtNyHwBXOkwt/33JSSWmGWn8+KbMq3ITRGpZuWTL0ij/ZkiZd
         3ZLnmTUfrDvYaL20W5BD/Cu2fr0RCNf51a4PQZ+nf2oeL1zOv8cWTtr6VIRX+gYEOGaP
         eb2T7X4AEwPUnFHkj/M3vClqR0B1IuwrV4aSEgH9uV2CRpvI2W/lYL/qYpG7VitM/Pgy
         cySA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773787369; x=1774392169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=Rp4KChT/WWpTu8I8ai/ucT9lIndTLNcnHKlKHGJEhA9cz9/jOtKHRfTj8Mt4k99hLz
         /I89gTL4UvFCXEXQ+emW/vqxpORQl6tRIFW8QI509j2GTSrVZtaum8vUBrpYmpT8jd0A
         wISeWETh5lykScg+b9x3/WRqzlb+SKvIZCRY3dNv6Dl6SFOWy6A033zHv7EsB5rYeEko
         x5aPlsVTKpmigGziLqh1SSMCTlzwf+Rl1EejgXkWvWLlaOaqd9ELuzLTq9ZeivFTN19l
         O/ftWife1HLsD1vxt+eBkShi1+KqmNcKNpSCyVKzgaGVSMOMFeuIaCIQZbGea997OFsZ
         J51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773787369; x=1774392169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=UJjQfvu52wdcu9hcNjrUUXSDlscbDuAbQLnJKgvyCInShTpk5wRnIGlRuWTihOw/4y
         DU7q16Au7PgpUSZ3KS+/9MeEcabSPafsdVnh4mS5bYbjaBMQwDKn2pHT2NCz9yQ/LYs4
         pLkVwzuegyPNcOjHa2D7mxe8Y/Jp94iC0COPuhTZsVTlFReJyuMpH3zvsGL1OOkh0vzh
         5u9nLI39JPXHR4Hn0hQtZJgYQRwVQnDCdhM1PPS/IQSoOI8BstMmLLdgCt1w1McSeDNI
         0ieFX87mUdPX3NEEI819enig+olzkBc7Lrs1FEI8+stUNBPyYKVh2FkwNjfhyoKxfmMT
         LKwQ==
X-Gm-Message-State: AOJu0YzVId5NM5lC1qhf9FoFCA1tPMuvNJE5eHZEetaaUkZM7xLTN4uY
	pWXQuY/w4slC8ElEyh89jm0Ldy+cZ4qpy5aRoUNvbaBch8t90j12cd480Th+2hyoFaFJktT56Gt
	nQcMAYyuhBkrmvFaFgy3DF7M1LW87OmnDDN9WQQM/ovRCobx722seGZHa
X-Gm-Gg: ATEYQzyfWaUwBFozZDCfSBBtYah4SC4OvrzJ/iE23yMU16Bl/hjdk+nmRTTzK1HKLNl
	gnGzlhxCR/GuHQ+NBlfdmbdsEkKHZ19oxuBe/S2rYngO5VzFPRzpuBM6/Gw6muLFrnXF598fFxg
	rPe4NLUTEB0R4MqW9q9KlwgSlqxGcUNN0Q7qOc85J9S24LFIazbxX7g5zmzRvq2DNd8T8muGBfP
	QGz3r5NfuPkhX6C0kM5H6nU4+5xpiMSKSf4dIUXSQf1hgwrX66jhfpY1VTB7D8GKBXuiT83L0Kh
	E5Nr/665ZmQjiTWAEg==
X-Received: by 2002:a05:6a00:1816:b0:827:2ec9:e1bc with SMTP id
 d2e1a72fcca58-82a6af3b680mr1004833b3a.61.1773787368885; Tue, 17 Mar 2026
 15:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-7-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-7-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 18:42:37 -0400
X-Gm-Features: AaiRm51ktGDW1-usZMxMHsT1xbcaRYx3q6Ml_vERE0ki9AcWlEliFtDWBIy0vmI
Message-ID: <CAHC9VhTiB73F9fB1o3K4NfJ-Fa50MsVA_=79kn6X34L62J_TwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] lsm: add the security_mmap_backing_file() hook
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Add the security_mmap_backing_file() hook to allow LSMs to properly
> enforce access controls on mmap() operations on stacked filesystems
> such as overlayfs.
>
> The existing security_mmap_file() hook exists as an access control point
> for mmap() but on stacked filesystems it only provides a way to enforce
> access controls on the user visible file.  In order to enforce access
> controls on the underlying backing file, the new
> security_mmap_backing_file() hook is needed.
>
> In addition the LSM hook additions, this patch also constifies the file
> struct field in the LSM common_audit_data struct to better support LSMs
> that will likely need to pass a const file struct pointer from the new
> backing_file_user_path_file() API into the common LSM audit code.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/backing-file.c             |  8 +++++++-
>  fs/erofs/ishare.c             |  6 ++++++
>  include/linux/lsm_audit.h     |  2 +-
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 25 +++++++++++++++++++++++++
>  6 files changed, 51 insertions(+), 2 deletions(-)

...

> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 17a4941d4518..d66c3a935d83 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -150,8 +150,14 @@ static ssize_t erofs_ishare_file_read_iter(struct ki=
ocb *iocb,
>  static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *v=
ma)
>  {
>         struct file *realfile =3D file->private_data;
> +       int err;
>
>         vma_set_file(vma, realfile);
> +
> +       err =3D security_mmap_backing_file(vma, realfile, file);
> +       if (err)
> +               return err;
> +
>         return generic_file_readonly_mmap(file, vma);
>  }

The kernel test robot helpfully pointed out that this patch was
missing a security.h include for the newly added LSM hook.  The fixup
below has been applied to the patch in lsm/stable-7.0.

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index d66c3a935d83..f80925b66599 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -4,6 +4,7 @@
 */
#include <linux/xxhash.h>
#include <linux/mount.h>
+#include <linux/security.h>
#include "internal.h"
#include "xattr.h"

--=20
paul-moore.com
