Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0612CDA5
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776730750; cv=none; b=uppxyVGAzz+qwyGQA0kdRXKud8UYFGUIoasKbNkRh4Jz8/2p0Ccd+4AyrJ1ldp2E6ZRYsiqxplb2U/eIVl92fftopaOT4rhH2UEfcJ5hzM6lQheBcorRFkGUyyMfzGu/fVMNaJj6lxER0mziuIx1e//TqwsBPIcibHlPuoMEntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776730750; c=relaxed/simple;
	bh=KXS8VUn+I0Rlv06Y0qm6NF1tUvNAG7EcKgHO0taOsig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLapDMyK1DH5RINuFC1SaIm79jZfZ4eXe1Bm9ZbotirKwlt4uilA8A4qwqEyf6U2+3m7HJh7OjpCeCZARXoD+ki9sQ/85DJwVSk9AskLDSaTsbBPJq3x4db08J5UJwWFFTZK0gQpxmDdOKxkuc/pgJoucixJNzWRp4AS3uti27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM/5ggrA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM/5ggrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7119C2BCB9
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776730749;
	bh=KXS8VUn+I0Rlv06Y0qm6NF1tUvNAG7EcKgHO0taOsig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QM/5ggrANiqesB8KSOU9LTOFXR5QQCIle1Rvuv9Z/cmHvbNA/NXsjtwmKbVl+bNlX
	 e+KwAeQJejwq3Y3kvUO0nUs8OLF/xuDI+YYe8sMOdi58VhZK/WFkSxBKeLPDkr/GNS
	 ytDVnFxkyyGeb5aLjE8SXbuLpkFyjWBCbhLfagpngOPsaj/w8arPWobr5aJ0BE1R+c
	 lmXQtHFv+xaW0Z9PiwMJ56IjBqnnhpa/tO+kaA05iMscZa/s0hGJeUgXxVyesmrJXr
	 lILeLGo/Ara1SbfNXlmTUqy4uXZgYtUTkX2T1WNhB0YdPYd181Pz7P8tkZyO1KrpNR
	 QFn/In3FSh84g==
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4640419eec.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 17:19:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8kzyhduCE2KktDJ6kEzz9vNOrBxiN4LkPPKon+v8b1zrW0FYdmhUlbZvoJ+RXggWExQU58RsoAwYD2S34TejIItpL97Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4+chBoW8s4Nhs2G3M4SIR6MjbiG0NFPou31NS+JjMuW2fgMW
	NKZMKX4Fr8p/+Gz3r+/ZqVvRykvsCocjS03wOQSy3FgRai2dZ8F4K0e5BzYYgV1/6ZnSWOgO/NO
	v1j2m+yCJ3VNOLZoqGA+hB4l2jnnlH9Y=
X-Received: by 2002:a05:7022:6627:b0:128:ca83:5aa1 with SMTP id
 a92af1059eb24-12c73f9217dmr9020004c88.16.1776730748952; Mon, 20 Apr 2026
 17:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420212653.438685-1-bboscaccy@linux.microsoft.com> <20260420212653.438685-8-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260420212653.438685-8-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 20 Apr 2026 17:18:56 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGXfe5JV4BMAhCMnT=ZqHGpNc+W3fTz2VbEUd3jH8hYgw@mail.gmail.com>
X-Gm-Features: AQROBzB11YLGb4Kb8u0HqItuKuRibey7StefJT6KkIu_5l15FPswgBDy1G003Tw
Message-ID: <CAKtyLkGXfe5JV4BMAhCMnT=ZqHGpNc+W3fTz2VbEUd3jH8hYgw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] hornet: Introduce gen_sig
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
> This introduces the gen_sig tool. It creates a pkcs#7 signature of a
> data payload. Additionally it appends a signed attribute containing a
> set of hashes.
>
> Typical usage is to provide a payload containing the light skeleton
> ebpf syscall program binary and it's associated maps, which can be
> extracted from the auto-generated skeleton header.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  scripts/Makefile            |   1 +
>  scripts/hornet/Makefile     |   5 +
>  scripts/hornet/gen_sig.c    | 392 ++++++++++++++++++++++++++++++++++++
>  scripts/hornet/write-sig.sh |  27 +++
>  4 files changed, 425 insertions(+)
>  create mode 100644 scripts/hornet/Makefile
>  create mode 100644 scripts/hornet/gen_sig.c
>  create mode 100755 scripts/hornet/write-sig.sh
>
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 0941e5ce7b575..dea8ab91bbe4e 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -63,6 +63,7 @@ subdir-$(CONFIG_GENKSYMS) +=3D genksyms
>  subdir-$(CONFIG_GENDWARFKSYMS) +=3D gendwarfksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) +=3D selinux
>  subdir-$(CONFIG_SECURITY_IPE) +=3D ipe
> +subdir-$(CONFIG_SECURITY_HORNET) +=3D hornet
>
>  # Let clean descend into subdirs
>  subdir-        +=3D basic dtc gdb kconfig mod
> diff --git a/scripts/hornet/Makefile b/scripts/hornet/Makefile
> new file mode 100644
> index 0000000000000..3ee41e5e9a9ff
> --- /dev/null
> +++ b/scripts/hornet/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +hostprogs-always-y     :=3D gen_sig
> +
> +HOSTCFLAGS_gen_sig.o =3D $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2>=
 /dev/null)
> +HOSTLDLIBS_gen_sig =3D $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /de=
v/null || echo -lcrypto)
> diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
> new file mode 100644
> index 0000000000000..f966516ebc99b
> --- /dev/null
> +++ b/scripts/hornet/gen_sig.c
> @@ -0,0 +1,392 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> + *
> + * Generate a signature for an eBPF program along with appending
> + * map hashes as signed attributes
> + *
> + * Copyright =C2=A9 2025      Microsoft Corporation.
> + *
> + * Authors: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public License
> + * as published by the Free Software Foundation; either version 2.1
> + * of the licence, or (at your option) any later version.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <err.h>
> +#include <getopt.h>
> +
> +#include <openssl/cms.h>
> +#include <openssl/err.h>
> +#include <openssl/evp.h>
> +#include <openssl/pkcs7.h>
> +#include <openssl/x509.h>
> +#include <openssl/pem.h>
> +#include <openssl/objects.h>
> +#include <openssl/asn1.h>
> +#include <openssl/asn1t.h>
> +#include <openssl/opensslv.h>
> +#include <openssl/bio.h>
> +#include <openssl/stack.h>
> +
> +#if OPENSSL_VERSION_MAJOR >=3D 3
> +# define USE_PKCS11_PROVIDER
> +# include <openssl/provider.h>
> +# include <openssl/store.h>
> +#else
> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +#  define USE_PKCS11_ENGINE
> +#  include <openssl/engine.h>
> +# endif
> +#endif
> +#include "../ssl-common.h"
> +
> +#define SHA256_LEN 32
> +#define BUF_SIZE   (1 << 15) // 32 KiB
> +#define MAX_HASHES 64
> +
> +struct hash_spec {
> +       char *file;
> +       int index;
> +};
> +
> +typedef struct {
> +       ASN1_INTEGER *index;
> +       ASN1_OCTET_STRING *hash;
> +
> +} HORNET_MAP;
> +
> +DECLARE_ASN1_FUNCTIONS(HORNET_MAP)
> +ASN1_SEQUENCE(HORNET_MAP) =3D {
> +       ASN1_SIMPLE(HORNET_MAP, index, ASN1_INTEGER),
> +       ASN1_SIMPLE(HORNET_MAP, hash, ASN1_OCTET_STRING)
> +} ASN1_SEQUENCE_END(HORNET_MAP);
> +
> +IMPLEMENT_ASN1_FUNCTIONS(HORNET_MAP)
> +
> +DEFINE_STACK_OF(HORNET_MAP)
> +
> +typedef struct {
> +       STACK_OF(HORNET_MAP) * maps;
> +} MAP_SET;
> +
> +DECLARE_ASN1_FUNCTIONS(MAP_SET)
> +ASN1_SEQUENCE(MAP_SET) =3D {
> +       ASN1_SET_OF(MAP_SET, maps, HORNET_MAP)
> +} ASN1_SEQUENCE_END(MAP_SET);
> +
> +IMPLEMENT_ASN1_FUNCTIONS(MAP_SET)
> +
> +#define DIE(...) do { fprintf(stderr, __VA_ARGS__); fputc('\n', stderr);=
 \
> +               exit(EXIT_FAILURE); } while (0)
> +
> +static BIO *bio_open_wr(const char *path)
> +{
> +       BIO *b =3D BIO_new_file(path, "wb");
> +
> +       if (!b) {
> +               perror(path);
> +               ERR_print_errors_fp(stderr);
> +               exit(EXIT_FAILURE);
> +       }
> +       return b;
> +}
> +
> +static void usage(const char *prog)
> +{
> +       fprintf(stderr,
> +               "Usage:\n"
> +               "  %s --data content.bin --cert signer.crt --key signer.k=
ey [-pass pass]\n"
> +               "     --out newsig.p7b \n"
> +               "     --add FILE:index [--add FILE:index ...]\n",
> +               prog);
> +}
> +
> +static const char *key_pass;
> +
> +static int pem_pw_cb(char *buf, int len, int w, void *v)
> +{
> +       int pwlen;
> +
> +       if (!key_pass)
> +               return -1;
> +
> +       pwlen =3D strlen(key_pass);
> +       if (pwlen >=3D len)
> +               return -1;
> +
> +       strcpy(buf, key_pass);
> +
> +       key_pass =3D NULL;
> +
> +       return pwlen;
> +}
> +
> +static EVP_PKEY *read_private_key(const char *private_key_name)
> +{
> +       EVP_PKEY *private_key;
> +       BIO *b;
> +
> +       b =3D BIO_new_file(private_key_name, "rb");
> +       ERR(!b, "%s", private_key_name);
> +       private_key =3D PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
> +                                             NULL);
> +       ERR(!private_key, "%s", private_key_name);
> +       BIO_free(b);
> +
> +       return private_key;
> +}
> +
> +static X509 *read_x509(const char *x509_name)
> +{
> +       unsigned char buf[2];
> +       X509 *x509;
> +       BIO *b;
> +       int n;
> +
> +       b =3D BIO_new_file(x509_name, "rb");
> +       ERR(!b, "%s", x509_name);
> +
> +       /* Look at the first two bytes of the file to determine the encod=
ing */
> +       n =3D BIO_read(b, buf, 2);
> +       if (n !=3D 2) {
> +               if (BIO_should_retry(b)) {
> +                       fprintf(stderr, "%s: Read wanted retry\n", x509_n=
ame);
> +                       exit(1);
> +               }
> +               if (n >=3D 0) {
> +                       fprintf(stderr, "%s: Short read\n", x509_name);
> +                       exit(1);
> +               }
> +               ERR(1, "%s", x509_name);
> +       }
> +
> +       ERR(BIO_reset(b) !=3D 0, "%s", x509_name);
> +
> +       if (buf[0] =3D=3D 0x30 && buf[1] >=3D 0x81 && buf[1] <=3D 0x84)
> +               /* Assume raw DER encoded X.509 */
> +               x509 =3D d2i_X509_bio(b, NULL);
> +       else
> +               /* Assume PEM encoded X.509 */
> +               x509 =3D PEM_read_bio_X509(b, NULL, NULL, NULL);
> +
> +       BIO_free(b);
> +       ERR(!x509, "%s", x509_name);
> +
> +       return x509;
> +}
> +
> +static int sha256(const char *path, unsigned char out[SHA256_LEN], unsig=
ned int *out_len)
> +{
> +       FILE *f;
> +       int rc;
> +       EVP_MD_CTX *ctx;
> +       unsigned char buf[BUF_SIZE];
> +       size_t n;
> +       unsigned int mdlen =3D 0;
> +
> +       if (!path || !out)
> +               return -1;
> +
> +       f =3D fopen(path, "rb");
> +       if (!f) {
> +               perror("fopen");
> +               return -2;
> +       }
> +
> +       ERR_load_crypto_strings();
> +
> +       rc =3D -3;
> +       ctx =3D EVP_MD_CTX_new();
> +       if (!ctx) {
> +               rc =3D -4;
> +               goto done;
> +       }
> +
> +#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
> +       if (EVP_DigestInit_ex2(ctx, EVP_sha256(), NULL) !=3D 1) {
> +               rc =3D -5;
> +               goto done;
> +       }
> +#else
> +       if (EVP_DigestInit_ex(ctx, EVP_sha256(), NULL) !=3D 1) {
> +               rc =3D -5;
> +               goto done;
> +       }
> +#endif
> +       while ((n =3D fread(buf, 1, sizeof(buf), f)) > 0) {
> +               if (EVP_DigestUpdate(ctx, buf, n) !=3D 1) {
> +                       rc =3D -6;
> +                       goto done;
> +               }
> +       }
> +       if (ferror(f)) {
> +               rc =3D -7;
> +               goto done;
> +       }
> +
> +       if (EVP_DigestFinal_ex(ctx, out, &mdlen) !=3D 1) {
> +               rc =3D -8;
> +               goto done;
> +       }
> +       if (mdlen !=3D SHA256_LEN) {
> +               rc =3D -9;
> +               goto done;
> +       }
> +
> +       if (out_len)
> +               *out_len =3D mdlen;
> +       rc =3D 0;
> +
> +done:
> +       EVP_MD_CTX_free(ctx);
> +       fclose(f);
> +       ERR_free_strings();
> +       return rc;
> +}
> +
> +static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len=
, int index)
> +{
> +       HORNET_MAP *map =3D NULL;
> +
> +       map =3D HORNET_MAP_new();
> +       ASN1_INTEGER_set(map->index, index);
> +       ASN1_OCTET_STRING_set(map->hash, buffer, buffer_len);
> +       sk_HORNET_MAP_push(set->maps, map);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       const char *cert_path =3D NULL;
> +       const char *key_path =3D NULL;
> +       const char *data_path =3D NULL;
> +       const char *out_path =3D NULL;
> +
> +       X509 *signer;
> +       EVP_PKEY *pkey;
> +       BIO *data_in;
> +       CMS_ContentInfo *cms_out;
> +       struct hash_spec hashes[MAX_HASHES];
> +       int hash_count =3D 0;
> +       int flags;
> +       CMS_SignerInfo *si;
> +       MAP_SET *set;
> +       unsigned char hash_buffer[SHA256_LEN];
> +       unsigned int hash_len;
> +       ASN1_OBJECT *oid;
> +       unsigned char *der =3D NULL;
> +       int der_len;
> +       int err;
> +       BIO *b_out;
> +       int i;
> +       char opt;
> +
> +       const char *short_opts =3D "C:K:P:O:A:Sh";
> +
> +       static const struct option long_opts[] =3D {
> +               {"cert", required_argument, 0, 'C'},
> +               {"key",  required_argument, 0, 'K'},
> +               {"pass",  required_argument, 0, 'P'},
> +               {"out",  required_argument, 0, 'O'},
> +               {"data",  required_argument, 0, 'D'},
> +               {"add",  required_argument, 0, 'A'},
> +               {"help",    no_argument,       0, 'h'},
> +               {0, 0, 0, 0}
> +       };
> +
> +       while ((opt =3D getopt_long_only(argc, argv, short_opts, long_opt=
s, NULL)) !=3D -1) {
> +               switch (opt) {
> +               case 'C':
> +                       cert_path =3D optarg;
> +                       break;
> +               case 'K':
> +                       key_path =3D optarg;
> +                       break;
> +               case 'P':
> +                       key_pass =3D optarg;
> +                       break;
> +               case 'O':
> +                       out_path =3D optarg;
> +                       break;
> +               case 'D':
> +                       data_path =3D optarg;
> +                       break;
> +               case 'A':
> +                       if (strchr(optarg, ':')) {
> +                               hashes[hash_count].file =3D strsep(&optar=
g, ":");
> +                               hashes[hash_count].index =3D atoi(optarg)=
;
> +                               hash_count++;

Should the hash_count be compared to MAX_HASHES here?

> +                       } else {
> +                               usage(argv[0]);
> +                               return EXIT_FAILURE;
> +                       }
> +               }
> +       }
> +
> +       if (!cert_path || !key_path || !out_path || !data_path) {
> +               usage(argv[0]);
> +               return EXIT_FAILURE;
> +       }
> +
> +       OpenSSL_add_all_algorithms();
> +       ERR_load_crypto_strings();
> +
> +       signer =3D read_x509(cert_path);
> +       ERR(!signer, "Load cert failed");
> +
> +       pkey =3D read_private_key(key_path);
> +       ERR(!pkey, "Load key failed");
> +
> +       data_in =3D BIO_new_file(data_path, "rb");
> +       ERR(!data_in, "Load data failed");
> +
> +       cms_out =3D CMS_sign(NULL, NULL, NULL, NULL,
> +                          CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_D=
ETACHED);
> +       ERR(!cms_out, "create cms failed");
> +
> +       flags =3D CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_NOSMIMECAP=
 | CMS_DETACHED;
> +
> +       si =3D CMS_add1_signer(cms_out, signer, pkey, EVP_sha256(), flags=
);
> +       ERR(!si, "add signer failed");
> +
> +       set =3D MAP_SET_new();
> +       set->maps =3D sk_HORNET_MAP_new_null();
> +
> +       for (i =3D 0; i < hash_count; i++) {
> +               sha256(hashes[i].file, hash_buffer, &hash_len);

Can sha256 fail here? In that case the program should stop here and
report errors.

-Fan

> +               add_hash(set, hash_buffer, hash_len, hashes[i].index);
> +       }
> +
> +       oid =3D OBJ_txt2obj("2.25.316487325684022475439036912669789383960=
", 1);
> +       if (!oid) {
> +               ERR_print_errors_fp(stderr);
> +               DIE("create oid failed");
> +       }
> +
> +       der_len =3D ASN1_item_i2d((ASN1_VALUE *)set, &der, ASN1_ITEM_rptr=
(MAP_SET));
> +       CMS_signed_add1_attr_by_OBJ(si, oid, V_ASN1_SEQUENCE, der, der_le=
n);
> +
> +       err =3D CMS_final(cms_out, data_in, NULL, CMS_NOCERTS | CMS_BINAR=
Y);
> +       ERR(!err, "cms final failed");
> +
> +       OPENSSL_free(der);
> +       MAP_SET_free(set);
> +
> +       b_out =3D bio_open_wr(out_path);
> +       ERR(!b_out, "opening output path failed");
> +
> +       i2d_CMS_bio_stream(b_out, cms_out, NULL, 0);
> +
> +       BIO_free(data_in);
> +       BIO_free(b_out);
> +       EVP_cleanup();
> +       ERR_free_strings();
> +       return 0;
> +}
> diff --git a/scripts/hornet/write-sig.sh b/scripts/hornet/write-sig.sh
> new file mode 100755
> index 0000000000000..7eaabe3bab9aa
> --- /dev/null
> +++ b/scripts/hornet/write-sig.sh
> @@ -0,0 +1,27 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2025 Microsoft Corporation
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of version 2 of the GNU General Public
> +# License as published by the Free Software Foundation.
> +
> +function usage() {
> +    echo "Sample for rewriting an autogenerated eBPF lskel headers"
> +    echo "with a new signature"
> +    echo ""
> +    echo "USAGE: header_file sig"
> +    exit
> +}
> +
> +ARGC=3D$#
> +
> +EXPECTED_ARGS=3D2
> +
> +if [ $ARGC -ne $EXPECTED_ARGS ] ; then
> +    usage
> +else
> +    SIG=3D$(xxd -p $2 | tr -d '\n' | sed 's/\(..\)/\\\\x\1/g')
> +    sed '/const char opts_sig/,/;/c\\tstatic const char opts_sig[] __att=
ribute__((__aligned__(8))) =3D "\\\n'"$(printf '%s\n' "$SIG")"'\";' $1
> +fi
> --
> 2.53.0
>
