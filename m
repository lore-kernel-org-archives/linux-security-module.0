Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5C6FC5
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776730135; cv=none; b=JyN/GByjSn70diUmRoX14NUa90V7NnkWoRB0QaOJO4Dj3uZ35Pi+lfqRWZNMCkzhljoQNG1wi9Twg6Hp/4Gy6dwj60Hd7NhMnsKzj07Qo8/I7aXU8nGOJOzD8cZ00C3/q0dzYw7k4SrGqzOVl9FweJ+VwYL94vfhNZlNL9V32WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776730135; c=relaxed/simple;
	bh=ATCgYw55EOTp5lCVqtX9sVNwcdW6hNzESvgRXize5fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB2u66gJ2VanMjLe7EAiBvHLUbG8Z+Y2kEwyuvkukJ462CXSowczwJYRlH+3IRGFg7ZULYFxwTTr2/rV7UjqgWlZt2cHf1nVmddFBxVidvDt+Vl1bbSleqwVvoM6+/KgpB1hgwopU30L6pbL8M7VepbWbGQR85LfDNDuQ+zP4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcJJOsON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcJJOsON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A437EC2BCB3
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 00:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776730134;
	bh=ATCgYw55EOTp5lCVqtX9sVNwcdW6hNzESvgRXize5fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OcJJOsONjmI57n/aCmUh9vO5u/3d884+pIz7Bjbz/ETQYQPSrBVP13WhmuSZS0jCE
	 FHNIW902GdbIhlsj1+/0CN/B1Yh+ZAshRi6+huPoiUljzw5zc9zdXxCRvy+nrZICQ5
	 vMNePAFcvxsD38nuSA0BgPL1YRey7KtNyt9FkQllesLCyE+ghRqXoOSLgT3zHMH1DM
	 3/LcXzXfw1hpUhCCL6HWwZQl+gQxsY+i0D29P1Xtdj4KTzkDvekPA7M7AMzocTJjam
	 mAeuKhChkcIa7GutKh5uWiBkeQPmOVwJ9iNoqILL+cIfQ3n+um+XWqdc9eqcddKHDL
	 wbWA7DuG2MBag==
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c45281a06so4806745c88.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 17:08:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mLEM+4Z/qrvqEZW93L1vbrTnePMIZKYDgZ2EJ4XiZgywwv7+3JGwbiHnwXf2CTrXUFJgfbRgfn5paw16lx+WxYzXlPEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf41+0ojFr1azPI257ZqDDgIHwVBW5lLGypGQoewsRBvG4kgy1
	lIxQTNmugSztUQrp0l82lANdAQCT2VJ7pRaL4c3TSKhyxXQsgIVLYfxFOZL4yQyKqAJqjQleG5y
	gz7tZ7UjiuZeVV3B+S8Su0anCq9sDWqc=
X-Received: by 2002:a05:7022:6728:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-12c73f7595emr9114238c88.11.1776730134015; Mon, 20 Apr 2026
 17:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420212653.438685-1-bboscaccy@linux.microsoft.com> <20260420212653.438685-7-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260420212653.438685-7-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 20 Apr 2026 17:08:42 -0700
X-Gmail-Original-Message-ID: <CAKtyLkF5L_sDHmtT2eVhmHLdhB_rAxWzotUJER6A5DFQ=S6EPw@mail.gmail.com>
X-Gm-Features: AQROBzAq9vn23GJvfUzynZvcjGwb_i9NPY5naNJwza-6jOjiQM2f4M5e8MVf3ZI
Message-ID: <CAKtyLkF5L_sDHmtT2eVhmHLdhB_rAxWzotUJER6A5DFQ=S6EPw@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 2:27=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This adds the Hornet Linux Security Module which provides enhanced
> signature verification and data validation for eBPF programs. This
> allows users to continue to maintain an invariant that all code
> running inside of the kernel has actually been signed and verified, by
> the kernel.
>
> This effort builds upon the currently excepted upstream solution. It
> further hardens it by providing deterministic, in-kernel checking of
> map hashes to solidify auditing along with preventing TOCTOU attacks
> against lskel map hashes.
>
> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
> determines the extent which the eBFP program is signed and defers to
> other LSMs for policy decisions.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>

...

> diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
> new file mode 100644
> index 0000000000000..19406aa237ac6
> --- /dev/null
> +++ b/security/hornet/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SECURITY_HORNET
> +       bool "Hornet support"
> +       depends on SECURITY

The dependency doesn't seem to be complete, for example,
PKCS7_MESSAGE_PARSER is not selected.

> +       default n
> +       help
> +         This selects Hornet.
> +         Further information can be found in
> +         Documentation/admin-guide/LSM/Hornet.rst.
> +
> +         If you are unsure how to answer this question, answer N.
> diff --git a/security/hornet/Makefile b/security/hornet/Makefile
> new file mode 100644
> index 0000000000000..26b6f954f762e
> --- /dev/null
> +++ b/security/hornet/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SECURITY_HORNET) :=3D hornet.o
> +
> +hornet-y :=3D hornet.asn1.o \
> +       hornet_lsm.o \
> +
> +$(obj)/hornet.asn1.o: $(obj)/hornet.asn1.c $(obj)/hornet.asn1.h
> diff --git a/security/hornet/hornet.asn1 b/security/hornet/hornet.asn1
> new file mode 100644
> index 0000000000000..c8d47b16b65d7
> --- /dev/null
> +++ b/security/hornet/hornet.asn1
> @@ -0,0 +1,13 @@
> +-- SPDX-License-Identifier: BSD-3-Clause
> +--
> +-- Copyright (C) 2009 IETF Trust and the persons identified as authors
> +-- of the code

I'm not a lawyer, but since this is a new AA which is not in the RFC,
should the copyright belong to IETF?

> +--
> +-- https://www.rfc-editor.org/rfc/rfc5652#section-3
> +
> +HornetData ::=3D SET OF Map
> +
> +Map ::=3D SEQUENCE {
> +       index                   INTEGER ({ hornet_map_index }),
> +       sha                     OCTET STRING ({ hornet_map_hash })
> +} ({ hornet_next_map })
> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> new file mode 100644
> index 0000000000000..f7d62fe6229c9
> --- /dev/null
> +++ b/security/hornet/hornet_lsm.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Hornet Linux Security Module
> + *
> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> + *
> + * Copyright (C) 2026 Microsoft Corporation
> + */
> +
> +#include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> +#include <linux/bpf.h>
> +#include <linux/verification.h>
> +#include <crypto/public_key.h>
> +#include <linux/module_signature.h>
> +#include <crypto/pkcs7.h>
> +#include <linux/sort.h>
> +#include <linux/asn1_decoder.h>
> +#include <linux/oid_registry.h>
> +#include "hornet.asn1.h"
> +
> +#define MAX_USED_MAPS 64
> +
> +struct hornet_maps {
> +       bpfptr_t fd_array;
> +};
> +
> +/* The only hashing algorithm available is SHA256 due to it be hardcoded
> +   in the bpf subsystem. */
> +
> +struct hornet_parse_context {
> +       int indexes[MAX_USED_MAPS];
> +       bool skips[MAX_USED_MAPS];
> +       unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
> +       int hash_count;
> +};
> +
> +struct hornet_prog_security_struct {
> +       bool checked[MAX_USED_MAPS];
> +       unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
> +};
> +
> +struct hornet_map_security_struct {
> +       bool checked;
> +       int index;
> +};
> +

Can maps be shared between programs? If so, since the LSM blob is
per-map, a second program's load will overwrite map_security->index
set by the first. A later run of the first program would then fail to
find its own map.

> +struct lsm_blob_sizes hornet_blob_sizes __ro_after_init =3D {
> +       .lbs_bpf_map =3D sizeof(struct hornet_map_security_struct),
> +       .lbs_bpf_prog =3D sizeof(struct hornet_prog_security_struct),
> +};
> +
> +static inline struct hornet_prog_security_struct *
> +hornet_bpf_prog_security(struct bpf_prog *prog)
> +{
> +       return prog->aux->security + hornet_blob_sizes.lbs_bpf_prog;
> +}
> +
> +static inline struct hornet_map_security_struct *
> +hornet_bpf_map_security(struct bpf_map *map)
> +{
> +       return map->security + hornet_blob_sizes.lbs_bpf_map;
> +}
> +
> +static int hornet_verify_hashes(struct hornet_maps *maps,
> +                               struct hornet_parse_context *ctx,
> +                               struct bpf_prog *prog)
> +{
> +       int map_fd;
> +       u32 i;
> +       struct bpf_map *map;
> +       int err =3D 0;
> +       unsigned char hash[SHA256_DIGEST_SIZE];
> +       struct hornet_prog_security_struct *security =3D hornet_bpf_prog_=
security(prog);
> +       struct hornet_map_security_struct *map_security;
> +
> +       for (i =3D 0; i < ctx->hash_count; i++) {
> +               if (ctx->skips[i])
> +                       continue;
> +
> +               err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> +                                             ctx->indexes[i] * sizeof(ma=
p_fd),
> +                                             sizeof(map_fd));
> +               if (err < 0)
> +                       return LSM_INT_VERDICT_FAULT;
> +
> +               CLASS(fd, f)(map_fd);
> +               if (fd_empty(f))
> +                       return LSM_INT_VERDICT_FAULT;
> +               if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))
> +                       return LSM_INT_VERDICT_FAULT;
> +
> +               map =3D fd_file(f)->private_data;
> +               if (!map->frozen)
> +                       return LSM_INT_VERDICT_FAULT;
> +
> +               map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
> +
> +               err =3D memcmp(hash, &ctx->hashes[i * SHA256_DIGEST_SIZE]=
,
> +                             SHA256_DIGEST_SIZE);
> +               if (err)
> +                       return LSM_INT_VERDICT_UNEXPECTED;
> +
> +               security->checked[i] =3D true;
> +               memcpy(&security->hashes[i * SHA256_DIGEST_SIZE], hash, S=
HA256_DIGEST_SIZE);
> +               map_security =3D hornet_bpf_map_security(map);
> +               map_security->checked =3D true;
> +               map_security->index =3D i;
> +       }
> +       return LSM_INT_VERDICT_OK;
> +}
> +
> +int hornet_next_map(void *context, size_t hdrlen,
> +                    unsigned char tag,
> +                    const void *value, size_t vlen)
> +{
> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)context;
> +
> +       if (++ctx->hash_count >=3D MAX_USED_MAPS)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +int hornet_map_index(void *context, size_t hdrlen,
> +                    unsigned char tag,
> +                    const void *value, size_t vlen)
> +{
> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)context;
> +
> +       if (vlen > 1)
> +               return -EINVAL;
> +
> +       ctx->indexes[ctx->hash_count] =3D *(u8 *)value;
> +       return 0;
> +}
> +
> +int hornet_map_hash(void *context, size_t hdrlen,
> +                   unsigned char tag,
> +                   const void *value, size_t vlen)
> +
> +{
> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)context;
> +
> +       if (vlen !=3D SHA256_DIGEST_SIZE && vlen !=3D 0)
> +               return -EINVAL;
> +
> +       if (vlen) {
> +               ctx->skips[ctx->hash_count] =3D false;
> +               memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE]=
, value, vlen);
> +       } else
> +               ctx->skips[ctx->hash_count] =3D true;
> +
> +       return 0;
> +}
> +
> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *a=
ttr,
> +                               struct bpf_token *token, bool is_kernel,
> +                               enum lsm_integrity_verdict *verdict)
> +{
> +       struct hornet_maps maps =3D {0};
> +       bpfptr_t usig =3D make_bpfptr(attr->signature, is_kernel);
> +       struct pkcs7_message *msg;
> +       struct hornet_parse_context *ctx;
> +       void *sig;
> +       int err;
> +       const void *authattrs;
> +       size_t authattrs_len;
> +       struct key *key;
> +
> +       if (!attr->signature) {
> +               *verdict =3D LSM_INT_VERDICT_UNSIGNED;
> +               return 0;
> +       }
> +
> +       ctx =3D kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       maps.fd_array =3D make_bpfptr(attr->fd_array, is_kernel);
> +       sig =3D kzalloc(attr->signature_size, GFP_KERNEL);
> +       if (!sig) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +       err =3D copy_from_bpfptr(sig, usig, attr->signature_size);
> +       if (err !=3D 0)
> +               goto cleanup_sig;
> +
> +       msg =3D pkcs7_parse_message(sig, attr->signature_size);
> +       if (IS_ERR(msg)) {
> +               *verdict =3D LSM_INT_VERDICT_BADSIG;
> +               err =3D 0;
> +               goto cleanup_sig;
> +       }
> +
> +       if (system_keyring_id_check(attr->keyring_id) =3D=3D 0)
> +               key =3D (struct key*)(unsigned long)attr->keyring_id;
> +       else
> +               key =3D key_ref_to_ptr(lookup_user_key(attr->keyring_id, =
0, KEY_DEFER_PERM_CHECK));

You might need to key_put the user key.

> +
> +       if (verify_pkcs7_message_sig(prog->insnsi, prog->len * sizeof(str=
uct bpf_insn), msg,
> +                                    key,
> +                                    VERIFYING_BPF_SIGNATURE,
> +                                    NULL, NULL)) {
> +               *verdict =3D LSM_INT_VERDICT_UNKNOWNKEY;
> +               err =3D 0;
> +               goto cleanup_msg;
> +       }
> +
> +       if (pkcs7_get_authattr(msg, OID_hornet_data,
> +                              &authattrs, &authattrs_len) =3D=3D -ENODAT=
A) {
> +               *verdict =3D LSM_INT_VERDICT_PARTIALSIG;
> +               err =3D 0;
> +               goto cleanup_msg;
> +       }
> +
> +       err =3D asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authatt=
rs_len);
> +       if (err < 0 || authattrs =3D=3D NULL) {
> +               *verdict =3D LSM_INT_VERDICT_BADSIG;
> +               err =3D 0;
> +               goto cleanup_msg;
> +       }
> +
> +       err =3D hornet_verify_hashes(&maps, ctx, prog);
> +       if (err =3D=3D 0)
> +               *verdict =3D LSM_INT_VERDICT_OK;
> +       else
> +               *verdict =3D err;
> +
> +cleanup_msg:
> +       pkcs7_free_message(msg);
> +cleanup_sig:
> +       kfree(sig);
> +out:
> +       kfree(ctx);
> +       return err;
> +}
> +
> +static const struct lsm_id hornet_lsmid =3D {
> +       .name =3D "hornet",
> +       .id =3D LSM_ID_HORNET,
> +};
> +
> +static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union b=
pf_attr *attr,
> +                                         struct bpf_token *token, bool i=
s_kernel)
> +{
> +       enum lsm_integrity_verdict verdict;
> +       int result =3D hornet_check_program(prog, attr, token, is_kernel,=
 &verdict);
> +
> +       if (result < 0)
> +               return result;
> +
> +       return security_bpf_prog_load_post_integrity(prog, attr, token, i=
s_kernel,
> +                                                    &hornet_lsmid, verdi=
ct);
> +}
> +
> +static int hornet_verify_map(struct bpf_prog *prog, int index)
> +{
> +       unsigned char hash[SHA256_DIGEST_SIZE];
> +       int i;
> +       struct bpf_map *map;
> +       struct hornet_prog_security_struct *security =3D hornet_bpf_prog_=
security(prog);
> +       struct hornet_map_security_struct *map_security;
> +
> +       if (!security->checked[index])
> +               return 0;
> +
> +       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +               map =3D prog->aux->used_maps[i];
> +               map_security =3D hornet_bpf_map_security(map);
> +               if (map_security->index !=3D index)
> +                       continue;
> +
> +               if (!map->frozen)
> +                       return -EPERM;
> +
> +               map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
> +               if (memcmp(hash, &security->hashes[index * SHA256_DIGEST_=
SIZE],
> +                          SHA256_DIGEST_SIZE) !=3D 0)
> +                       return -EPERM;
> +               else
> +                       return 0;
> +       }
> +       return -EINVAL;
> +}
> +
> +static int hornet_check_prog_maps(u32 ufd)
> +{
> +       CLASS(fd, f)(ufd);
> +       struct bpf_prog *prog;
> +       int i, result =3D 0;
> +
> +       if (fd_empty(f))
> +               return -EBADF;
> +       if (fd_file(f)->f_op !=3D &bpf_prog_fops)
> +               return -EINVAL;
> +
> +       prog =3D fd_file(f)->private_data;
> +
> +       mutex_lock(&prog->aux->used_maps_mutex);
> +       if (!prog->aux->used_map_cnt)
> +               goto out;
> +
> +       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +               result =3D hornet_verify_map(prog, i);
> +               if (result)
> +                       goto out;
> +       }

This loop is kind of confusing for me, I guess it's just iterating
through the maps the program currently in use. I feel the nested loop
is unnecessary and the hash could be saved into the map's blob
instead. Please correct me if I'm wrong here.

-Fan

> +out:
> +       mutex_unlock(&prog->aux->used_maps_mutex);
> +       return result;
> +}
> +
> +static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size, =
bool kernel)
> +{
> +       /* in horent_bpf(), anything that had originated from kernel spac=
e we assume
> +          has already been checked, in some form or another, so we don't=
 bother
> +          checking the intergity of any maps. In hornet_bpf_prog_load_in=
tegrity(),
> +          hornet doesn't make any opinion on that and delegates that to =
the downstream
> +          policy enforcement. */
> +
> +       if (cmd !=3D BPF_PROG_RUN)
> +               return 0;
> +       if (kernel)
> +               return 0;
> +
> +       return hornet_check_prog_maps(attr->test.prog_fd);
> +}
> +
> +static struct security_hook_list hornet_hooks[] __ro_after_init =3D {
> +       LSM_HOOK_INIT(bpf_prog_load_integrity, hornet_bpf_prog_load_integ=
rity),
> +       LSM_HOOK_INIT(bpf, hornet_bpf),
> +};
> +
> +static int __init hornet_init(void)
> +{
> +       pr_info("Hornet: eBPF signature verification enabled\n");
> +       security_add_hooks(hornet_hooks, ARRAY_SIZE(hornet_hooks), &horne=
t_lsmid);
> +       return 0;
> +}
> +
> +DEFINE_LSM(hornet) =3D {
> +       .id =3D &hornet_lsmid,
> +       .blobs =3D &hornet_blob_sizes,
> +       .init =3D hornet_init,
> +};
> --
> 2.53.0
>
