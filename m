Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD21171D;
	Fri, 25 Oct 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869649; cv=none; b=E/H0V2edlLsjEVbWIcCGAsntcPprFXluqCJdKLu34YfRF0OaYUWKuzMaLCDHMBZ6y385qv/7Mpsm/DuB2JIAuOpp12RR03ywsl36Yqo1AcMZugJe/lnwFfstHwb5OVSx2kZndii3fNiOc9W4/0LPnUekAeaVhpdMZdbZB2RnWjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869649; c=relaxed/simple;
	bh=TpusFJS0+BU9RBWZqscrSMiZ5ebMeT87AdXHvMb9RaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB45byjDdJUVL31URpd/T8K4vXCeCq7EsbvpCstxNpCH1XFBY9+qskgYMGFFX0C4A/w1Njx9qZEG5hwCTTIbSNVkdalqufTcJ6CkGS2V/QuCGUEr+mTOkukC1o7bdkslYqtxhrm8fUr+n9Oz29rCQSPhp1FOS4v5quFMC+wLq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GCJw8D+J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GCJw8D+J"
Received: from pwmachine.localnet (84-115-216-151.cable.dynamic.surfer.at [84.115.216.151])
	by linux.microsoft.com (Postfix) with ESMTPSA id B0B09211A5AF;
	Fri, 25 Oct 2024 08:20:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0B09211A5AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729869647;
	bh=lxc/OPHAIeJ+Ihfv/bB9xgzXJYpP+ZLvKzdSbqvtdcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCJw8D+J8Xdz2rH1lrmx3BBeP0SQcX6prMyd4yTiM+5fgawKiPV2XQVJT69+gdhcH
	 +1qTnIIyj0C4BG+f2U6N+2rydRYRpSg20WP7pfgeKAp9N/E0sO4NlussuvHkTsjrMo
	 fdXm54MQzumaLn88VGHcjjHMD6ZEVEetiX7UFcFM=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 05/14] landlock: Move access types
Date: Fri, 25 Oct 2024 17:20:39 +0200
Message-ID: <3020507.e9J7NaK4W3@pwmachine>
In-Reply-To: <20241022161009.982584-6-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le mardi 22 octobre 2024, 18:10:00 CEST Micka=EBl Sala=FCn a =E9crit :
> Move ACCESS_FS_OPTIONAL, access_mask_t, struct access_mask, and struct
> access_masks_all to a dedicated access.h file.
>=20
> This file will be extended with a following commit, and it will help to
> avoid dependency loops.
>=20
> Cc: G=FCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022161009.982584-6-mic@digikod.net
> ---
>=20
> Changes since v1:
> * New patch
> ---
>  security/landlock/access.h  | 53 +++++++++++++++++++++++++++++++++++++
>  security/landlock/fs.c      |  1 +
>  security/landlock/fs.h      |  1 +
>  security/landlock/ruleset.h | 31 +---------------------
>  4 files changed, 56 insertions(+), 30 deletions(-)
>  create mode 100644 security/landlock/access.h
>=20
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> new file mode 100644
> index 000000000000..2659fd9b4aaf
> --- /dev/null
> +++ b/security/landlock/access.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock LSM - Access types and helpers
> + *
> + * Copyright =A9 2016-2020 Micka=EBl Sala=FCn <mic@digikod.net>
> + * Copyright =A9 2018-2020 ANSSI
> + * Copyright =A9 2024 Microsoft Corporation
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_ACCESS_H
> +#define _SECURITY_LANDLOCK_ACCESS_H
> +
> +#include <uapi/linux/landlock.h>
> +
> +#include "limits.h"
> +
> +/* clang-format off */
> +#define ACCESS_FS_OPTIONAL ( \
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV)

Nit: The patch message indicates this is moved from somewhere but I cannot =
find=20
deletion for it.

> +/* clang-format on */
> +
> +typedef u16 access_mask_t;
> +/* Makes sure all filesystem access rights can be stored. */
> +static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_FS);
> +/* Makes sure all network access rights can be stored. */
> +static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_NET);
> +/* Makes sure all scoped rights can be stored. */
> +static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_SCOPE);
> +/* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. =
*/
> +static_assert(sizeof(unsigned long) >=3D sizeof(access_mask_t));
> +
> +/* Ruleset access masks. */
> +struct access_masks {
> +	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> +	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> +	access_mask_t scope : LANDLOCK_NUM_SCOPE;
> +};
> +
> +union access_masks_all {
> +	struct access_masks masks;
> +	u32 all;
> +};
> +
> +/* Makes sure all fields are covered. */
> +static_assert(sizeof(((union access_masks_all *)NULL)->masks) =3D=3D
> +	      sizeof(((union access_masks_all *)NULL)->all));
> +
> +typedef u16 layer_mask_t;
> +/* Makes sure all layers can be checked. */
> +static_assert(BITS_PER_TYPE(layer_mask_t) >=3D LANDLOCK_MAX_NUM_LAYERS);
> +
> +#endif /* _SECURITY_LANDLOCK_ACCESS_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 698a623a8184..e0e5775b75ae 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -36,6 +36,7 @@
>  #include <uapi/linux/fiemap.h>
>  #include <uapi/linux/landlock.h>
>=20
> +#include "access.h"
>  #include "common.h"
>  #include "cred.h"
>  #include "fs.h"
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 1487e1f023a1..d445f411c26a 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/rcupdate.h>
>=20
> +#include "access.h"
>  #include "ruleset.h"
>  #include "setup.h"
>=20
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index e00edcb38c5b..7921bbe01344 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -17,6 +17,7 @@
>  #include <linux/workqueue.h>
>  #include <uapi/linux/landlock.h>
>=20
> +#include "access.h"
>  #include "limits.h"
>  #include "object.h"
>=20
> @@ -30,36 +31,6 @@
>  	LANDLOCK_ACCESS_FS_REFER)
>  /* clang-format on */
>=20
> -typedef u16 access_mask_t;
> -/* Makes sure all filesystem access rights can be stored. */
> -static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_FS);
> -/* Makes sure all network access rights can be stored. */
> -static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_NET);
> -/* Makes sure all scoped rights can be stored. */
> -static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_SCOPE);
> -/* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. =
*/
> -static_assert(sizeof(unsigned long) >=3D sizeof(access_mask_t));
> -
> -/* Ruleset access masks. */
> -struct access_masks {
> -	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> -	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> -	access_mask_t scope : LANDLOCK_NUM_SCOPE;
> -};
> -
> -union access_masks_all {
> -	struct access_masks masks;
> -	u32 all;
> -};
> -
> -/* Makes sure all fields are covered. */
> -static_assert(sizeof(((union access_masks_all *)NULL)->masks) =3D=3D
> -	      sizeof(((union access_masks_all *)NULL)->all));
> -
> -typedef u16 layer_mask_t;
> -/* Makes sure all layers can be checked. */
> -static_assert(BITS_PER_TYPE(layer_mask_t) >=3D LANDLOCK_MAX_NUM_LAYERS);
> -
>  /**
>   * struct landlock_layer - Access rights for a given layer
>   */


