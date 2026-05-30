Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693EE2F4A0C
	for <linux-security-module@vger.kernel.org>; Sat, 30 May 2026 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103516; cv=none; b=Qqpm33v1cAkb4CfAkzbbcblSSq6XU1to3rDOIeJucUmslS75yV5nIgO7nNq9qGBfF9spaE4vM2jh6u6yRPsVoGTJvWY46ZwfGy5tIAaBxY2tAPwu3P6/jZUo0MrDecpu3B9jmI4afYgRmzjFEzYWwI/okBm7iM4nr0YhaRI9qYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103516; c=relaxed/simple;
	bh=SAWXaOWFVO2Y1zflXOXcLzaX0B+yVSoO3qOFT5lN+kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxlHweiznNB7W3wyteCLm7GwMr3GN6yjOlD1qOkKsFEk9PS5njA9jCzZFwb7slPPXWb+SBW6RvIpqy+7xY+SDvBzq0m2g9dNClv2NPKwsv3GuJnzpzJuprA0wIpEE5NfiPvbonqLmd0N43BxN26AiKfj5IAB2+9b6E8b6CaNxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY2+0BfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY2+0BfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4068D1F00A02
	for <linux-security-module@vger.kernel.org>; Sat, 30 May 2026 01:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103514;
	bh=DElGjh6LQzf+4Y1JB4fnCul+HjoB5rvgbhhuFXRC9zM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FY2+0BfGqIelcML89kbNSXXH1b14QaAwOSak+Vzdaih2nZOOgC3bs0/z5gbS2LHoW
	 9uS1nLyYUxvELm8SgtN4TYq/uZyGYGYqDbH/qDF2qnTzM/1kE/ZcY54ql1AQ98LLQf
	 pw8IuB7EpnLs/P5Fh+6lNkYfeAaqztE/FW/K7qIEeOpE15oVL3fQIiTVRarM2po72S
	 5nokPHwQ1XCK0AB71lvCtVeq6U3RwOsDgFKlbF7uc0+YJVD7YY2u8CAgmg2M71l5uw
	 0rMMT7GX3Z0CQ+EThs7kHEJC4wtZM/00+yAINkLuXNUCftSu8b66rxpeo/oD16hA8X
	 /7o87Hh1YE1cA==
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso6151591c88.0
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 18:11:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+q2PXNEnxLrZuzuUzJSvAel1R9QwQfzb5s6O4rbq3OTm/P6ZxDWVjL0P7UmoysBPeHEGqp5fRG3L45Y0EqW/9ktdh12ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1u0aIfTJ3Iv9sCoaIlxjX6Cd5q9ThfOhaXJiAxit9J0BVCTc
	Tu+IM63KBmcskoDe/78yo6DJmxVBW3W0F79AfoQJRng6kDDnYil9Tgte37TFEmOC7KUx1diQ9We
	eICBRhPvcxIMwa6n86zBPoAXZRkiUTH8=
X-Received: by 2002:a05:7022:ff48:b0:136:b370:64c5 with SMTP id
 a92af1059eb24-137d426d974mr866561c88.30.1780103513554; Fri, 29 May 2026
 18:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com> <20260528030915.2654994-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260528030915.2654994-2-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Fri, 29 May 2026 18:11:42 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEy5QeWmozTr8v_CEFfJTK3WJq3CBr3h_T2=HMr9YfCFA@mail.gmail.com>
X-Gm-Features: AVHnY4LNU2ijm6HSwh5GaaMRnhVg0WRi8xglxJGEixTSTbmEb-TF2V-_mCYZVKQ
Message-ID: <CAKtyLkEy5QeWmozTr8v_CEFfJTK3WJq3CBr3h_T2=HMr9YfCFA@mail.gmail.com>
Subject: Re: [PATCH 01/11] hornet: fix TOCTOU in signed program verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, Fan Wu <wufan@kernel.org>, 
	James.Bottomley@hansenpartnership.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 8:09=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> The signature verification path was vulnerable to a time-of-check vs
> time-of-use race at both the program load and program run hook sites:
> between the moment a map's contents were hashed for signature
> verification and the moment the program run hook re-verified them, an
> attacker with sufficient privileges could swap or mutate the map
> contents.
>
> Close the race by snapshotting the map hashes during program load,
> attaching them to the program, and re-verifying them from the
> security_bpf_prog hook against prog->aux->used_maps. Because used_maps
> is the same map set the verifier and runtime resolve against, there is
> no longer a window in which the verified set and the executed set can
> diverge.
>
> Since we are no longer targeting the fd_array passed in, drop the map
> index data entirely and check for whether or not the set of requested
> map hashes is a subset of prog->aux->used_maps.
>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst |  39 +++-----
>  scripts/hornet/gen_sig.c                 |  17 +---
>  security/hornet/hornet.asn1              |   1 -
>  security/hornet/hornet_lsm.c             | 121 +++--------------------
>  tools/testing/selftests/hornet/Makefile  |   2 +-
>  5 files changed, 35 insertions(+), 145 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/adm=
in-guide/LSM/Hornet.rst
> index 0ade4c17374c6..a369bc11408f4 100644
> --- a/Documentation/admin-guide/LSM/Hornet.rst
> +++ b/Documentation/admin-guide/LSM/Hornet.rst
> @@ -86,15 +86,14 @@ Hornet protects against the following threats:
>
>  - **Tampering with map data**: When map hashes are included in the
>    signature, Hornet verifies that frozen BPF maps match their expected
> -  SHA-256 hashes at load time. Maps are also re-verified before program
> -  execution via ``BPF_PROG_RUN``.
> +  SHA-256 hashes at load time after the program is publically exposed.
>
>  Hornet does **not** protect against:
>
>  - Compromise of the signing key itself.
>  - Attacks that occur after a program has been loaded and verified.
>  - Programs loaded by the kernel itself (kernel-internal loads bypass
> -  the ``BPF_PROG_RUN`` map check).
> +  the map check).
>
>  Known Limitations
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -117,6 +116,10 @@ Known Limitations
>    data. It does not guarantee positional binding of maps to specific
>    fd_array slots.
>
> +- Map hash verification does not enforce any ordering. It simply asserts
> +  that the set of map hashes requested to be verified exist in the used
> +  array.
> +
>  - BPF_MAP_TYPE_PROG_ARRAY maps must be frozen for Hornet to verify
>    them. Unfrozen prog array maps are not covered by verification.
>
> @@ -159,24 +162,19 @@ The following describes what happens when a userspa=
ce program calls
>  5. Hornet extracts the authenticated attribute identified by
>     ``OID_hornet_data`` (OID ``2.25.3164873256840224754390369126697893839=
60``)
>     from the PKCS#7 message. This attribute contains an ASN.1-encoded set
> -   of map index/hash pairs.
> +   of map hash hashes
>
> -6. For each map hash entry, Hornet retrieves the corresponding BPF map
> -   via its file descriptor, confirms it is frozen, computes its SHA-256
> -   hash, and compares it against the signed hash.
> +6. For each map hash entry, Hornet retrieves stores the target map hash =
in
> +   the program's LSM blob.
>
>  7. The resulting integrity verdict is passed to the
>     ``bpf_prog_load_post_integrity`` hook so that downstream LSMs can
>     enforce policy.
>
> -Runtime Map Verification
> -------------------------
> -
> -When ``bpf(BPF_PROG_RUN, ...)`` is called from userspace, Hornet
> -re-verifies the hashes of all maps associated with the program. This
> -ensures that map contents have not been modified between program load
> -and execution. If any map hash no longer matches, the ``BPF_PROG_RUN``
> -command is denied.
> +8. After the verifier processes the program, once it's ready to be publi=
shed,
> +   Hornet intercepts the ``bpf_prog`` hook, and verifies that the set of
> +   required hashes exist in the programs used maps. If the map hashes ar=
e
> +   unable to be found, the command is denied.
>
>  Userspace Interface
>  -------------------
> @@ -199,14 +197,10 @@ the following ASN.1 schema::
>    HornetData ::=3D SET OF Map
>
>    Map ::=3D SEQUENCE {
> -      index   INTEGER,
>        sha     OCTET STRING
>    }
>
> -Each ``Map`` entry contains the index of the map in the program's
> -``fd_array`` and its expected SHA-256 hash. A zero-length ``sha`` field
> -indicates that the map at that index should be skipped during
> -verification.
> +Each ``Map`` entry contains an expected SHA-256 hash.
>
>  Tooling
>  =3D=3D=3D=3D=3D=3D=3D
> @@ -229,7 +223,7 @@ Usage::
>            --key <signer.key> \
>            [--pass <passphrase>] \
>            --out <signature.p7b> \
> -          [--add <mapfile.bin>:<index> ...]
> +          [--add <mapfile.bin> ...]
>
>  ``--data``
>    Path to the binary file containing eBPF program instructions to sign.
> @@ -248,8 +242,7 @@ Usage::
>
>  ``--add``
>    Attach a map hash as a signed attribute. The argument is a path to a
> -  binary map file followed by a colon and the map's index in the
> -  ``fd_array``. This option may be specified multiple times.
> +  binary map file. This option may be specified multiple times.
>
>  extract-skel.sh
>  ---------------
> diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
> index 8dd9ed66346a2..b4f983ab24bcd 100644
> --- a/scripts/hornet/gen_sig.c
> +++ b/scripts/hornet/gen_sig.c
> @@ -55,7 +55,6 @@
>
>  struct hash_spec {
>         char *file;
> -       int index;
>  };
>
>  typedef struct {
> @@ -66,7 +65,6 @@ typedef struct {
>
>  DECLARE_ASN1_FUNCTIONS(HORNET_MAP)
>  ASN1_SEQUENCE(HORNET_MAP) =3D {
> -       ASN1_SIMPLE(HORNET_MAP, index, ASN1_INTEGER),
>         ASN1_SIMPLE(HORNET_MAP, hash, ASN1_OCTET_STRING)
>  } ASN1_SEQUENCE_END(HORNET_MAP);
>
> @@ -253,12 +251,11 @@ static int sha256(const char *path, unsigned char o=
ut[SHA256_LEN], unsigned int
>         return rc;
>  }
>
> -static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len=
, int index)
> +static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len=
)
>  {
>         HORNET_MAP *map =3D NULL;
>
>         map =3D HORNET_MAP_new();
> -       ASN1_INTEGER_set(map->index, index);
>         ASN1_OCTET_STRING_set(map->hash, buffer, buffer_len);
>         sk_HORNET_MAP_push(set->maps, map);
>  }
> @@ -320,14 +317,8 @@ int main(int argc, char **argv)
>                         data_path =3D optarg;
>                         break;
>                 case 'A':
> -                       if (strchr(optarg, ':')) {
> -                               hashes[hash_count].file =3D strsep(&optar=
g, ":");
> -                               hashes[hash_count].index =3D atoi(optarg)=
;
> -                               if (++hash_count >=3D MAX_HASHES) {
> -                                       usage(argv[0]);
> -                                       return EXIT_FAILURE;
> -                               }
> -                       } else {
> +                       hashes[hash_count].file =3D optarg;
> +                       if (++hash_count >=3D MAX_HASHES) {
>                                 usage(argv[0]);
>                                 return EXIT_FAILURE;
>                         }
> @@ -371,7 +362,7 @@ int main(int argc, char **argv)
>                 if (sha256(hashes[i].file, hash_buffer, &hash_len) !=3D 0=
) {
>                         DIE("failed to hash input");
>                 }
> -               add_hash(set, hash_buffer, hash_len, hashes[i].index);
> +               add_hash(set, hash_buffer, hash_len);
>         }
>
>         oid =3D OBJ_txt2obj("2.25.316487325684022475439036912669789383960=
", 1);
> diff --git a/security/hornet/hornet.asn1 b/security/hornet/hornet.asn1
> index e60abf451ae23..3cf50379f5e7c 100644
> --- a/security/hornet/hornet.asn1
> +++ b/security/hornet/hornet.asn1
> @@ -7,6 +7,5 @@
>  HornetData ::=3D SET OF Map
>
>  Map ::=3D SEQUENCE {
> -       index                   INTEGER ({ hornet_map_index }),
>         sha                     OCTET STRING ({ hornet_map_hash })
>  } ({ hornet_next_map })
> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> index a4d11fa5b0889..516038413f321 100644
> --- a/security/hornet/hornet_lsm.c
> +++ b/security/hornet/hornet_lsm.c
> @@ -21,26 +21,18 @@
>
>  #define MAX_USED_MAPS 64
>
> -struct hornet_maps {
> -       bpfptr_t fd_array;
> -};
> -
>  /* The only hashing algorithm available is SHA256 due to it be hardcoded
>   * in the bpf subsystem.
>   */
> -
> -struct hornet_parse_context {
> -       int indexes[MAX_USED_MAPS];
> -       bool skips[MAX_USED_MAPS];
> -       unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
> -       int hash_count;
> -};
> -
>  struct hornet_prog_security_struct {
>         int signed_hash_count;
>         unsigned char signed_hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
>  };
>
> +struct hornet_parse_context {
> +       struct hornet_prog_security_struct *security;
> +};
> +
>  struct lsm_blob_sizes hornet_blob_sizes __ro_after_init =3D {
>         .lbs_bpf_prog =3D sizeof(struct hornet_prog_security_struct),
>  };
> @@ -51,79 +43,17 @@ hornet_bpf_prog_security(struct bpf_prog *prog)
>         return prog->aux->security + hornet_blob_sizes.lbs_bpf_prog;
>  }
>
> -static int hornet_verify_hashes(struct hornet_maps *maps,
> -                               struct hornet_parse_context *ctx,
> -                               struct bpf_prog *prog)
> -{
> -       int map_fd;
> -       u32 i;
> -       struct bpf_map *map;
> -       int err =3D 0;
> -       unsigned char hash[SHA256_DIGEST_SIZE];
> -       struct hornet_prog_security_struct *security =3D hornet_bpf_prog_=
security(prog);
> -
> -       for (i =3D 0; i < ctx->hash_count; i++) {
> -               if (ctx->skips[i])
> -                       continue;
> -
> -               err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> -                                             ctx->indexes[i] * sizeof(ma=
p_fd),
> -                                             sizeof(map_fd));
> -               if (err !=3D 0)
> -                       return LSM_INT_VERDICT_FAULT;

It seems this verdict is no longer used.

> -
> -               CLASS(fd, f)(map_fd);
> -               if (fd_empty(f))
> -                       return LSM_INT_VERDICT_FAULT;
> -               if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))
> -                       return LSM_INT_VERDICT_FAULT;
> -
> -               map =3D fd_file(f)->private_data;
> -               if (!READ_ONCE(map->frozen))
> -                       return LSM_INT_VERDICT_FAULT;
> -
> -               if (!map->ops->map_get_hash)
> -                       return LSM_INT_VERDICT_FAULT;
> -
> -               if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash)=
)
> -                       return LSM_INT_VERDICT_FAULT;
> -
> -               err =3D memcmp(hash, &ctx->hashes[i * SHA256_DIGEST_SIZE]=
,
> -                             SHA256_DIGEST_SIZE);
> -               if (err)
> -                       return LSM_INT_VERDICT_UNEXPECTED;

similar above, they should be removed for the header and for the ipe policy=
.
-Fan

> -
> -               memcpy(&security->signed_hashes[security->signed_hash_cou=
nt * SHA256_DIGEST_SIZE],
> -                      &ctx->hashes[i * SHA256_DIGEST_SIZE], SHA256_DIGES=
T_SIZE);
> -               security->signed_hash_count++;
> -       }
> -       return LSM_INT_VERDICT_OK;
> -}
> -
>  int hornet_next_map(void *context, size_t hdrlen,
>                      unsigned char tag,
>                      const void *value, size_t vlen)
>  {
>         struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)context;
>
> -       if (++ctx->hash_count >=3D MAX_USED_MAPS)
> +       if (++ctx->security->signed_hash_count >=3D MAX_USED_MAPS)
>                 return -EINVAL;
>         return 0;
>  }
>
> -int hornet_map_index(void *context, size_t hdrlen,
> -                    unsigned char tag,
> -                    const void *value, size_t vlen)
> -{
> -       struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)context;
> -
> -       if (vlen !=3D 1)
> -               return -EINVAL;
> -
> -       ctx->indexes[ctx->hash_count] =3D *(u8 *)value;
> -       return 0;
> -}
> -
>  int hornet_map_hash(void *context, size_t hdrlen,
>                     unsigned char tag,
>                     const void *value, size_t vlen)
> @@ -134,11 +64,8 @@ int hornet_map_hash(void *context, size_t hdrlen,
>         if (vlen !=3D SHA256_DIGEST_SIZE && vlen !=3D 0)
>                 return -EINVAL;
>
> -       if (vlen) {
> -               ctx->skips[ctx->hash_count] =3D false;
> -               memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE]=
, value, vlen);
> -       } else
> -               ctx->skips[ctx->hash_count] =3D true;
> +       memcpy(&ctx->security->signed_hashes[ctx->security->signed_hash_c=
ount * SHA256_DIGEST_SIZE],
> +              value, vlen);
>
>         return 0;
>  }
> @@ -147,7 +74,6 @@ static int hornet_check_program(struct bpf_prog *prog,=
 union bpf_attr *attr,
>                                 struct bpf_token *token, bool is_kernel,
>                                 enum lsm_integrity_verdict *verdict)
>  {
> -       struct hornet_maps maps =3D {0};
>         bpfptr_t usig =3D make_bpfptr(attr->signature, is_kernel);
>         struct pkcs7_message *msg;
>         struct hornet_parse_context *ctx;
> @@ -172,7 +98,8 @@ static int hornet_check_program(struct bpf_prog *prog,=
 union bpf_attr *attr,
>         if (!ctx)
>                 return -ENOMEM;
>
> -       maps.fd_array =3D make_bpfptr(attr->fd_array, is_kernel);
> +       ctx->security =3D hornet_bpf_prog_security(prog);
> +
>         sig =3D kzalloc(attr->signature_size, GFP_KERNEL);
>         if (!sig) {
>                 err =3D -ENOMEM;
> @@ -225,7 +152,7 @@ static int hornet_check_program(struct bpf_prog *prog=
, union bpf_attr *attr,
>                 goto cleanup_msg;
>         }
>
> -       *verdict =3D hornet_verify_hashes(&maps, ctx, prog);
> +       *verdict =3D LSM_INT_VERDICT_OK;
>         err =3D 0;
>
>  cleanup_msg:
> @@ -257,10 +184,8 @@ static int hornet_bpf_prog_load_integrity(struct bpf=
_prog *prog, union bpf_attr
>                                                      &hornet_lsmid, verdi=
ct);
>  }
>
> -static int hornet_check_prog_maps(u32 ufd)
> +static int hornet_check_prog_maps(struct bpf_prog *prog)
>  {
> -       CLASS(fd, f)(ufd);
> -       struct bpf_prog *prog;
>         struct hornet_prog_security_struct *security;
>         unsigned char hash[SHA256_DIGEST_SIZE];
>         struct bpf_map *map;
> @@ -268,12 +193,6 @@ static int hornet_check_prog_maps(u32 ufd)
>         bool found;
>         int covered_count =3D 0;
>
> -       if (fd_empty(f))
> -               return -EBADF;
> -       if (fd_file(f)->f_op !=3D &bpf_prog_fops)
> -               return -EINVAL;
> -
> -       prog =3D fd_file(f)->private_data;
>         security =3D hornet_bpf_prog_security(prog);
>
>         if (!security->signed_hash_count)
> @@ -316,26 +235,14 @@ static int hornet_check_prog_maps(u32 ufd)
>         return 0;
>  }
>
> -static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size, =
bool kernel)
> +static int hornet_bpf_prog(struct bpf_prog *prog)
>  {
> -       /* in horent_bpf(), anything that had originated from kernel spac=
e we assume
> -        * has already been checked, in some form or another, so we don't=
 bother
> -        * checking the intergity of any maps. In hornet_bpf_prog_load_in=
tegrity(),
> -        * hornet doesn't make any opinion on that and delegates that to =
the downstream
> -        * policy enforcement.
> -        */
> -
> -       if (cmd !=3D BPF_PROG_RUN)
> -               return 0;
> -       if (kernel)
> -               return 0;
> -
> -       return hornet_check_prog_maps(attr->test.prog_fd);
> +       return hornet_check_prog_maps(prog);
>  }
>
>  static struct security_hook_list hornet_hooks[] __ro_after_init =3D {
>         LSM_HOOK_INIT(bpf_prog_load_integrity, hornet_bpf_prog_load_integ=
rity),
> -       LSM_HOOK_INIT(bpf, hornet_bpf),
> +       LSM_HOOK_INIT(bpf_prog, hornet_bpf_prog),
>  };
>
>  static int __init hornet_init(void)
> diff --git a/tools/testing/selftests/hornet/Makefile b/tools/testing/self=
tests/hornet/Makefile
> index 432bce59f54e7..316364f95f28c 100644
> --- a/tools/testing/selftests/hornet/Makefile
> +++ b/tools/testing/selftests/hornet/Makefile
> @@ -51,7 +51,7 @@ $(OUTPUT)/gen_sig: ../../../../scripts/hornet/gen_sig.c
>
>  sig.bin: insn.bin map.bin $(OUTPUT)/gen_sig
>         $(OUTPUT)/gen_sig --key $(CERTDIR)/signing_key.pem --cert $(CERTD=
IR)/signing_key.x509 \
> -               --data insn.bin --add map.bin:0 --out sig.bin
> +               --data insn.bin --add map.bin --out sig.bin
>
>  signed_loader.h: sig.bin
>         $(SCRIPTSDIR)/write-sig.sh loader.h sig.bin > $@
> --
> 2.53.0
>
