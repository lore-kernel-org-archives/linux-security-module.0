Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796491E4AF;
	Wed, 29 Apr 2026 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487701; cv=none; b=Dp8L+cGKcAycHuKJ8jcgDhsaTjsmdRFTxPlurbXWiZfMMnnzyu5MT/N3nhKSkxwHAK/vtrPdKdH4NMRoesL0gnb+u7+oqqyVvkS3Z471EOUTMNDl8vJaFkT6Mu8hJY4Ml7o78ePm3dMqvRkFnSVu57CCZVrsTVlNQFrKbVcTw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487701; c=relaxed/simple;
	bh=n+NVogIRep+ymWOMp2E7Apj2QseV5XL4POXOI9RDhJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p+xEqE0LprkLzCBWGwPieFNC/dLSzUbdM0LlP/2mGELsrnQuNJeVg557OEpAJQAnCOkBCJO5YWQRuvcnOs4Z9jPEqNk6v/dd0HDPthC6+Y4siX5ouMQ6MhZVtBV4niAlGy2vmgunABXQdXgk3Zp6GJfuYpx42pqPYtRtWtZxleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QA9pTiwH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QA9pTiwH"
Received: from narnia (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7333820B716C;
	Wed, 29 Apr 2026 11:34:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7333820B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777487698;
	bh=aXf97LxHBjTD88WDN+5b5+qAq1In70SnE4SHaSh20fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QA9pTiwHhn5AlGUAySLt/5UyqLZ9EU3CVB01yvPj6G4dFq0p6BPf1BClO56Tf5Wsb
	 hhIW2vL6Sy6E8c9/4luMkhJG21XpcdmhSOoP70rIhVnKAhP5ZTbSeCcQoBwm46ZqLu
	 8zXURytoakXil4veOyees8Dl/5DhUDyTn0+/+2iI=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Fan Wu <wufan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, Andrew Morton
 <akpm@linux-foundation.org>, James.Bottomley@hansenpartnership.com,
 dhowells@redhat.com, Fan Wu <wufan@kernel.org>, Ryan Foster
 <foster.ryan.r@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Song Liu
 <song@kernel.org>
Subject: Re: [PATCH v5 06/10] security: Hornet LSM
In-Reply-To: <CAKtyLkF5L_sDHmtT2eVhmHLdhB_rAxWzotUJER6A5DFQ=S6EPw@mail.gmail.com>
References: <20260420212653.438685-1-bboscaccy@linux.microsoft.com>
 <20260420212653.438685-7-bboscaccy@linux.microsoft.com>
 <CAKtyLkF5L_sDHmtT2eVhmHLdhB_rAxWzotUJER6A5DFQ=S6EPw@mail.gmail.com>
Date: Wed, 29 Apr 2026 11:34:55 -0700
Message-ID: <87jytpk434.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fan Wu <wufan@kernel.org> writes:

> On Mon, Apr 20, 2026 at 2:27=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> This adds the Hornet Linux Security Module which provides enhanced
>> signature verification and data validation for eBPF programs. This
>> allows users to continue to maintain an invariant that all code
>> running inside of the kernel has actually been signed and verified, by
>> the kernel.
>>
>> This effort builds upon the currently excepted upstream solution. It
>> further hardens it by providing deterministic, in-kernel checking of
>> map hashes to solidify auditing along with preventing TOCTOU attacks
>> against lskel map hashes.
>>
>> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
>> determines the extent which the eBFP program is signed and defers to
>> other LSMs for policy decisions.
>>
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>
> ...
>
>> diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
>> new file mode 100644
>> index 0000000000000..19406aa237ac6
>> --- /dev/null
>> +++ b/security/hornet/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config SECURITY_HORNET
>> +       bool "Hornet support"
>> +       depends on SECURITY
>
> The dependency doesn't seem to be complete, for example,
> PKCS7_MESSAGE_PARSER is not selected.
>
>> +       default n
>> +       help
>> +         This selects Hornet.
>> +         Further information can be found in
>> +         Documentation/admin-guide/LSM/Hornet.rst.
>> +
>> +         If you are unsure how to answer this question, answer N.
>> diff --git a/security/hornet/Makefile b/security/hornet/Makefile
>> new file mode 100644
>> index 0000000000000..26b6f954f762e
>> --- /dev/null
>> +++ b/security/hornet/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_SECURITY_HORNET) :=3D hornet.o
>> +
>> +hornet-y :=3D hornet.asn1.o \
>> +       hornet_lsm.o \
>> +
>> +$(obj)/hornet.asn1.o: $(obj)/hornet.asn1.c $(obj)/hornet.asn1.h
>> diff --git a/security/hornet/hornet.asn1 b/security/hornet/hornet.asn1
>> new file mode 100644
>> index 0000000000000..c8d47b16b65d7
>> --- /dev/null
>> +++ b/security/hornet/hornet.asn1
>> @@ -0,0 +1,13 @@
>> +-- SPDX-License-Identifier: BSD-3-Clause
>> +--
>> +-- Copyright (C) 2009 IETF Trust and the persons identified as authors
>> +-- of the code
>
> I'm not a lawyer, but since this is a new AA which is not in the RFC,
> should the copyright belong to IETF?
>

gah thanks.=20
>> +--
>> +-- https://www.rfc-editor.org/rfc/rfc5652#section-3
>> +
>> +HornetData ::=3D SET OF Map
>> +
>> +Map ::=3D SEQUENCE {
>> +       index                   INTEGER ({ hornet_map_index }),
>> +       sha                     OCTET STRING ({ hornet_map_hash })
>> +} ({ hornet_next_map })
>> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
>> new file mode 100644
>> index 0000000000000..f7d62fe6229c9
>> --- /dev/null
>> +++ b/security/hornet/hornet_lsm.c
>> @@ -0,0 +1,346 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Hornet Linux Security Module
>> + *
>> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> + *
>> + * Copyright (C) 2026 Microsoft Corporation
>> + */
>> +
>> +#include <linux/lsm_hooks.h>
>> +#include <uapi/linux/lsm.h>
>> +#include <linux/bpf.h>
>> +#include <linux/verification.h>
>> +#include <crypto/public_key.h>
>> +#include <linux/module_signature.h>
>> +#include <crypto/pkcs7.h>
>> +#include <linux/sort.h>
>> +#include <linux/asn1_decoder.h>
>> +#include <linux/oid_registry.h>
>> +#include "hornet.asn1.h"
>> +
>> +#define MAX_USED_MAPS 64
>> +
>> +struct hornet_maps {
>> +       bpfptr_t fd_array;
>> +};
>> +
>> +/* The only hashing algorithm available is SHA256 due to it be hardcoded
>> +   in the bpf subsystem. */
>> +
>> +struct hornet_parse_context {
>> +       int indexes[MAX_USED_MAPS];
>> +       bool skips[MAX_USED_MAPS];
>> +       unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
>> +       int hash_count;
>> +};
>> +
>> +struct hornet_prog_security_struct {
>> +       bool checked[MAX_USED_MAPS];
>> +       unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
>> +};
>> +
>> +struct hornet_map_security_struct {
>> +       bool checked;
>> +       int index;
>> +};
>> +
>
> Can maps be shared between programs? If so, since the LSM blob is
> per-map, a second program's load will overwrite map_security->index
> set by the first. A later run of the first program would then fail to
> find its own map.
>

Yes, it can. We can support that.

>> +struct lsm_blob_sizes hornet_blob_sizes __ro_after_init =3D {
>> +       .lbs_bpf_map =3D sizeof(struct hornet_map_security_struct),
>> +       .lbs_bpf_prog =3D sizeof(struct hornet_prog_security_struct),
>> +};
>> +
>> +static inline struct hornet_prog_security_struct *
>> +hornet_bpf_prog_security(struct bpf_prog *prog)
>> +{
>> +       return prog->aux->security + hornet_blob_sizes.lbs_bpf_prog;
>> +}
>> +
>> +static inline struct hornet_map_security_struct *
>> +hornet_bpf_map_security(struct bpf_map *map)
>> +{
>> +       return map->security + hornet_blob_sizes.lbs_bpf_map;
>> +}
>> +
>> +static int hornet_verify_hashes(struct hornet_maps *maps,
>> +                               struct hornet_parse_context *ctx,
>> +                               struct bpf_prog *prog)
>> +{
>> +       int map_fd;
>> +       u32 i;
>> +       struct bpf_map *map;
>> +       int err =3D 0;
>> +       unsigned char hash[SHA256_DIGEST_SIZE];
>> +       struct hornet_prog_security_struct *security =3D hornet_bpf_prog=
_security(prog);
>> +       struct hornet_map_security_struct *map_security;
>> +
>> +       for (i =3D 0; i < ctx->hash_count; i++) {
>> +               if (ctx->skips[i])
>> +                       continue;
>> +
>> +               err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
>> +                                             ctx->indexes[i] * sizeof(m=
ap_fd),
>> +                                             sizeof(map_fd));
>> +               if (err < 0)
>> +                       return LSM_INT_VERDICT_FAULT;
>> +
>> +               CLASS(fd, f)(map_fd);
>> +               if (fd_empty(f))
>> +                       return LSM_INT_VERDICT_FAULT;
>> +               if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))
>> +                       return LSM_INT_VERDICT_FAULT;
>> +
>> +               map =3D fd_file(f)->private_data;
>> +               if (!map->frozen)
>> +                       return LSM_INT_VERDICT_FAULT;
>> +
>> +               map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
>> +
>> +               err =3D memcmp(hash, &ctx->hashes[i * SHA256_DIGEST_SIZE=
],
>> +                             SHA256_DIGEST_SIZE);
>> +               if (err)
>> +                       return LSM_INT_VERDICT_UNEXPECTED;
>> +
>> +               security->checked[i] =3D true;
>> +               memcpy(&security->hashes[i * SHA256_DIGEST_SIZE], hash, =
SHA256_DIGEST_SIZE);
>> +               map_security =3D hornet_bpf_map_security(map);
>> +               map_security->checked =3D true;
>> +               map_security->index =3D i;
>> +       }
>> +       return LSM_INT_VERDICT_OK;
>> +}
>> +
>> +int hornet_next_map(void *context, size_t hdrlen,
>> +                    unsigned char tag,
>> +                    const void *value, size_t vlen)
>> +{
>> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_contex=
t *)context;
>> +
>> +       if (++ctx->hash_count >=3D MAX_USED_MAPS)
>> +               return -EINVAL;
>> +       return 0;
>> +}
>> +
>> +int hornet_map_index(void *context, size_t hdrlen,
>> +                    unsigned char tag,
>> +                    const void *value, size_t vlen)
>> +{
>> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_contex=
t *)context;
>> +
>> +       if (vlen > 1)
>> +               return -EINVAL;
>> +
>> +       ctx->indexes[ctx->hash_count] =3D *(u8 *)value;
>> +       return 0;
>> +}
>> +
>> +int hornet_map_hash(void *context, size_t hdrlen,
>> +                   unsigned char tag,
>> +                   const void *value, size_t vlen)
>> +
>> +{
>> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_contex=
t *)context;
>> +
>> +       if (vlen !=3D SHA256_DIGEST_SIZE && vlen !=3D 0)
>> +               return -EINVAL;
>> +
>> +       if (vlen) {
>> +               ctx->skips[ctx->hash_count] =3D false;
>> +               memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE=
], value, vlen);
>> +       } else
>> +               ctx->skips[ctx->hash_count] =3D true;
>> +
>> +       return 0;
>> +}
>> +
>> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *=
attr,
>> +                               struct bpf_token *token, bool is_kernel,
>> +                               enum lsm_integrity_verdict *verdict)
>> +{
>> +       struct hornet_maps maps =3D {0};
>> +       bpfptr_t usig =3D make_bpfptr(attr->signature, is_kernel);
>> +       struct pkcs7_message *msg;
>> +       struct hornet_parse_context *ctx;
>> +       void *sig;
>> +       int err;
>> +       const void *authattrs;
>> +       size_t authattrs_len;
>> +       struct key *key;
>> +
>> +       if (!attr->signature) {
>> +               *verdict =3D LSM_INT_VERDICT_UNSIGNED;
>> +               return 0;
>> +       }
>> +
>> +       ctx =3D kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
>> +       if (!ctx)
>> +               return -ENOMEM;
>> +
>> +       maps.fd_array =3D make_bpfptr(attr->fd_array, is_kernel);
>> +       sig =3D kzalloc(attr->signature_size, GFP_KERNEL);
>> +       if (!sig) {
>> +               err =3D -ENOMEM;
>> +               goto out;
>> +       }
>> +       err =3D copy_from_bpfptr(sig, usig, attr->signature_size);
>> +       if (err !=3D 0)
>> +               goto cleanup_sig;
>> +
>> +       msg =3D pkcs7_parse_message(sig, attr->signature_size);
>> +       if (IS_ERR(msg)) {
>> +               *verdict =3D LSM_INT_VERDICT_BADSIG;
>> +               err =3D 0;
>> +               goto cleanup_sig;
>> +       }
>> +
>> +       if (system_keyring_id_check(attr->keyring_id) =3D=3D 0)
>> +               key =3D (struct key*)(unsigned long)attr->keyring_id;
>> +       else
>> +               key =3D key_ref_to_ptr(lookup_user_key(attr->keyring_id,=
 0, KEY_DEFER_PERM_CHECK));
>
> You might need to key_put the user key.
>
>> +
>> +       if (verify_pkcs7_message_sig(prog->insnsi, prog->len * sizeof(st=
ruct bpf_insn), msg,
>> +                                    key,
>> +                                    VERIFYING_BPF_SIGNATURE,
>> +                                    NULL, NULL)) {
>> +               *verdict =3D LSM_INT_VERDICT_UNKNOWNKEY;
>> +               err =3D 0;
>> +               goto cleanup_msg;
>> +       }
>> +
>> +       if (pkcs7_get_authattr(msg, OID_hornet_data,
>> +                              &authattrs, &authattrs_len) =3D=3D -ENODA=
TA) {
>> +               *verdict =3D LSM_INT_VERDICT_PARTIALSIG;
>> +               err =3D 0;
>> +               goto cleanup_msg;
>> +       }
>> +
>> +       err =3D asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authat=
trs_len);
>> +       if (err < 0 || authattrs =3D=3D NULL) {
>> +               *verdict =3D LSM_INT_VERDICT_BADSIG;
>> +               err =3D 0;
>> +               goto cleanup_msg;
>> +       }
>> +
>> +       err =3D hornet_verify_hashes(&maps, ctx, prog);
>> +       if (err =3D=3D 0)
>> +               *verdict =3D LSM_INT_VERDICT_OK;
>> +       else
>> +               *verdict =3D err;
>> +
>> +cleanup_msg:
>> +       pkcs7_free_message(msg);
>> +cleanup_sig:
>> +       kfree(sig);
>> +out:
>> +       kfree(ctx);
>> +       return err;
>> +}
>> +
>> +static const struct lsm_id hornet_lsmid =3D {
>> +       .name =3D "hornet",
>> +       .id =3D LSM_ID_HORNET,
>> +};
>> +
>> +static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union =
bpf_attr *attr,
>> +                                         struct bpf_token *token, bool =
is_kernel)
>> +{
>> +       enum lsm_integrity_verdict verdict;
>> +       int result =3D hornet_check_program(prog, attr, token, is_kernel=
, &verdict);
>> +
>> +       if (result < 0)
>> +               return result;
>> +
>> +       return security_bpf_prog_load_post_integrity(prog, attr, token, =
is_kernel,
>> +                                                    &hornet_lsmid, verd=
ict);
>> +}
>> +
>> +static int hornet_verify_map(struct bpf_prog *prog, int index)
>> +{
>> +       unsigned char hash[SHA256_DIGEST_SIZE];
>> +       int i;
>> +       struct bpf_map *map;
>> +       struct hornet_prog_security_struct *security =3D hornet_bpf_prog=
_security(prog);
>> +       struct hornet_map_security_struct *map_security;
>> +
>> +       if (!security->checked[index])
>> +               return 0;
>> +
>> +       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
>> +               map =3D prog->aux->used_maps[i];
>> +               map_security =3D hornet_bpf_map_security(map);
>> +               if (map_security->index !=3D index)
>> +                       continue;
>> +
>> +               if (!map->frozen)
>> +                       return -EPERM;
>> +
>> +               map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
>> +               if (memcmp(hash, &security->hashes[index * SHA256_DIGEST=
_SIZE],
>> +                          SHA256_DIGEST_SIZE) !=3D 0)
>> +                       return -EPERM;
>> +               else
>> +                       return 0;
>> +       }
>> +       return -EINVAL;
>> +}
>> +
>> +static int hornet_check_prog_maps(u32 ufd)
>> +{
>> +       CLASS(fd, f)(ufd);
>> +       struct bpf_prog *prog;
>> +       int i, result =3D 0;
>> +
>> +       if (fd_empty(f))
>> +               return -EBADF;
>> +       if (fd_file(f)->f_op !=3D &bpf_prog_fops)
>> +               return -EINVAL;
>> +
>> +       prog =3D fd_file(f)->private_data;
>> +
>> +       mutex_lock(&prog->aux->used_maps_mutex);
>> +       if (!prog->aux->used_map_cnt)
>> +               goto out;
>> +
>> +       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
>> +               result =3D hornet_verify_map(prog, i);
>> +               if (result)
>> +                       goto out;
>> +       }
>
> This loop is kind of confusing for me, I guess it's just iterating
> through the maps the program currently in use. I feel the nested loop
> is unnecessary and the hash could be saved into the map's blob
> instead. Please correct me if I'm wrong here.
>

It turns out that we can. I'll send out the simplified version in v6.

> -Fan
>
>> +out:
>> +       mutex_unlock(&prog->aux->used_maps_mutex);
>> +       return result;
>> +}
>> +
>> +static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size,=
 bool kernel)
>> +{
>> +       /* in horent_bpf(), anything that had originated from kernel spa=
ce we assume
>> +          has already been checked, in some form or another, so we don'=
t bother
>> +          checking the intergity of any maps. In hornet_bpf_prog_load_i=
ntegrity(),
>> +          hornet doesn't make any opinion on that and delegates that to=
 the downstream
>> +          policy enforcement. */
>> +
>> +       if (cmd !=3D BPF_PROG_RUN)
>> +               return 0;
>> +       if (kernel)
>> +               return 0;
>> +
>> +       return hornet_check_prog_maps(attr->test.prog_fd);
>> +}
>> +
>> +static struct security_hook_list hornet_hooks[] __ro_after_init =3D {
>> +       LSM_HOOK_INIT(bpf_prog_load_integrity, hornet_bpf_prog_load_inte=
grity),
>> +       LSM_HOOK_INIT(bpf, hornet_bpf),
>> +};
>> +
>> +static int __init hornet_init(void)
>> +{
>> +       pr_info("Hornet: eBPF signature verification enabled\n");
>> +       security_add_hooks(hornet_hooks, ARRAY_SIZE(hornet_hooks), &horn=
et_lsmid);
>> +       return 0;
>> +}
>> +
>> +DEFINE_LSM(hornet) =3D {
>> +       .id =3D &hornet_lsmid,
>> +       .blobs =3D &hornet_blob_sizes,
>> +       .init =3D hornet_init,
>> +};
>> --
>> 2.53.0
>>
