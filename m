Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B33E717C
	for <linux-security-module@vger.kernel.org>; Mon,  4 May 2026 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938788; cv=none; b=kADaJY5wTW7G21jXku4goLT9/7LY57gDg5qNxla57BPO4KUnZgMCwrQn7ITzoyoJ8j404RSoe7bEQ5NDfnbR7r/+FrEG5xicclesswH92qeg4FY28maMe+snRK25hBSP9NKnRItYZRJNban/MIQ+b/Oxota0gepEOfoTB9UPqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938788; c=relaxed/simple;
	bh=v2B76rnIbEY1RLyBW3Ji/wNq62wifPsND4rPenRvdyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/2tEkY0JZvIuBu0XDzcHJwL9HyJp5dNlSceMjIROF6jsC0hS7ghBsQXYl/RkjLUazVLdQPPG9zhX3hs8y1RgKFF2Zj4+Ln3bQrZxxDWRfiP56CB1U2vKCDkcbhN7ZgNYypFc7nqXpPwWfdQ/rQvOrrojo8ascp2qzwORpkRb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH13hYOV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH13hYOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65C0C2BCC9
	for <linux-security-module@vger.kernel.org>; Mon,  4 May 2026 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938788;
	bh=v2B76rnIbEY1RLyBW3Ji/wNq62wifPsND4rPenRvdyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fH13hYOVpfHKThzqvuHsUKjIF5yYfZoZG1IapMH6BRHloVsXg4wC7OOQPHVw9zQlJ
	 BPgpxhziC0GSLI0jTSJAmIUx+ecRbzXld1VSgmtHqLJOghosoPuaoma3JfmNVxCz+T
	 XRBYWzTdYIecn/L9pf8lvTWnO9/0f92bwzEtBtED+djR7yp5n0LJJDZ+bWdTOmtCOf
	 i/SrdD/SZrgloI4WNkv3jBGvp2/3n3/q4yY8mA2TtX128STfqOLVYUr8RdEHkX0s3j
	 Xxyla7Jyrnan09ErUHhAMSfzzhghkbBDvp+uvIGPK2YdZHBUidbO4zr60xPJv84Jdj
	 DGqZHwxkq4DOA==
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c8ccc7755so6658746c88.0
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 16:53:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8uoa8AQ6w2MwxPSzEtg3gaXc+NVI7FilNIZx80HRadornR2FBh2FEKkQhGohgOzEYq7KSgIOmkg6Onpu39PMqJQQQQSZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLRfPirIbpsQtYRv6dlD/zkYIFqzxfKQ7vwslmqw0Igzxwf+F
	cXDMQ8RTL6RzC56qwjcNBdeLWzb1rboUFG4QcwFgHkS1MdZJzR9utKaI8VaZqmKs+UgcRfff8Ue
	mr9Fu/QnoxTDRRuTrd1KVAQgMSu8sB/s=
X-Received: by 2002:a05:7022:f403:b0:12d:de3e:86b7 with SMTP id
 a92af1059eb24-12dfd844a54mr5034298c88.39.1777938787676; Mon, 04 May 2026
 16:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com> <20260429191431.2345448-11-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260429191431.2345448-11-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 4 May 2026 16:52:54 -0700
X-Gmail-Original-Message-ID: <CAKtyLkFv_3ZD=h+04X4rq6QqjRpxtxvXw2M2atGuunB9_OEEbQ@mail.gmail.com>
X-Gm-Features: AVHnY4IYPwKmM_ICG_6oHIAU7ynuppO2p5ry6osHz-58Xf5OVJgOfpC5XSJqEDM
Message-ID: <CAKtyLkFv_3ZD=h+04X4rq6QqjRpxtxvXw2M2atGuunB9_OEEbQ@mail.gmail.com>
Subject: Re: [v6 10/10] ipe: Add BPF program load policy enforcement via
 Hornet integration
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

On Wed, Apr 29, 2026 at 12:15=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
> to make policy decisions about BPF program loading based on integrity
> verdicts provided by the Hornet LSM.
>
> New policy operation:
>   op=3DBPF_PROG_LOAD - Matches BPF program load events
>
> New policy properties:
>   bpf_signature=3DNONE      - No Verdict
>   bpf_signature=3DOK        - Program signature and map hashes verified
>   bpf_signature=3DUNSIGNED  - No signature provided
>   bpf_signature=3DPARTIALSIG - Signature OK but no map hash data
>   bpf_signature=3DUNKNOWNKEY - Cert not trusted

This one should be: The keyring requested by the user is invalid.

>   bpf_signature=3DUNEXPECTED - An unexpected hash value was encountered
>   bpf_signature=3DFAULT      - System error during verification
>   bpf_signature=3DBADSIG    - Signature or map hash verification failed
>   bpf_keyring=3DBUILTIN     - Program was signed using a builtin keyring
>   bpf_keyring=3DSECONDARY   - Program was signed using the secondary keyr=
ing
>   bpf_keyring=3DPLATFORM    - Program was signed using the platform keyri=
ng
>   bpf_kernel=3DTRUE         - Program originated from kernelspace
>   bpf_kernel=3DFALSE        - Program originated from userspace
>
> These properties map directly to the lsm_integrity_verdict enum values
> provided by the Hornet LSM through security_bpf_prog_load_post_integrity.
>
> The feature is gated on CONFIG_IPE_PROP_BPF_SIGNATURE which depends on
> CONFIG_SECURITY_HORNET.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 162 +++++++++++++++++++++++++-
>  Documentation/security/ipe.rst        |  39 +++++++
>  security/ipe/Kconfig                  |  14 +++
>  security/ipe/audit.c                  |  15 +++
>  security/ipe/eval.c                   |  73 +++++++++++-
>  security/ipe/eval.h                   |  11 ++
>  security/ipe/hooks.c                  |  63 ++++++++++
>  security/ipe/hooks.h                  |  15 +++
>  security/ipe/ipe.c                    |  14 +++
>  security/ipe/ipe.h                    |   3 +
>  security/ipe/policy.h                 |  14 +++
>  security/ipe/policy_parser.c          |  27 +++++
>  12 files changed, 448 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index a756d81585317..4dfbf0d325a8a 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -559,7 +559,8 @@ policy. Two properties are built-into the policy pars=
er: 'op' and 'action'.
>  The other properties are used to restrict immutable security properties
>  about the files being evaluated. Currently those properties are:
>  '``boot_verified``', '``dmverity_signature``', '``dmverity_roothash``',
> -'``fsverity_signature``', '``fsverity_digest``'. A description of all
> +'``fsverity_signature``', '``fsverity_digest``', '``bpf_signature``',
> +'``bpf_keyring``', '``bpf_kernel``'. A description of all
>  properties supported by IPE are listed below:
>
>  op
> @@ -603,6 +604,14 @@ as the first token. IPE supports the following opera=
tions:
>        Controls loading IMA certificates through the Kconfigs,
>        ``CONFIG_IMA_X509_PATH`` and ``CONFIG_EVM_X509_PATH``.
>
> +   ``BPF_PROG_LOAD``:
> +
> +      Pertains to BPF programs being loaded via the ``bpf()`` syscall.
> +      This operation is used in conjunction with the ``bpf_signature``,
> +      ``bpf_keyring``, and ``bpf_kernel`` properties to control BPF
> +      program loading based on integrity verification provided by the
> +      Hornet LSM.
> +
>  action
>  ~~~~~~
>
> @@ -713,6 +722,105 @@ fsverity_signature
>
>        fsverity_signature=3D(TRUE|FALSE)
>
> +bpf_signature
> +~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization of BPF program loads =
based
> +   on the integrity verdict provided by the Hornet LSM. When a BPF progr=
am is
> +   loaded, Hornet performs cryptographic verification of the program's P=
KCS#7
> +   signature (if present) and passes an integrity verdict to IPE via the
> +   ``security_bpf_prog_load_post_integrity`` hook. IPE can then allow or=
 deny
> +   the load based on the verdict.
> +
> +   This property depends on ``SECURITY_HORNET`` and is controlled by the
> +   ``IPE_PROP_BPF_SIGNATURE`` config option.
> +   The format of this property is::
> +
> +      bpf_signature=3D(NONE|OK|UNSIGNED|PARTIALSIG|UNKNOWNKEY|UNEXPECTED=
|FAULT|BADSIG)
> +
> +   The possible values correspond to the integrity verdicts from Hornet:
> +
> +      ``NONE``
> +
> +         No integrity verdict was set (default/uninitialized).
> +
> +      ``OK``
> +
> +         The BPF program's signature and all map hashes were successfull=
y
> +         verified.
> +
> +      ``UNSIGNED``
> +
> +         No signature was provided with the BPF program.
> +
> +      ``PARTIALSIG``
> +
> +         The program signature was verified, but no authenticated map ha=
sh
> +         data was present.
> +
> +      ``UNKNOWNKEY``
> +
> +         The signing certificate is not trusted by the specified keyring=
.

Same above.

> +
> +      ``UNEXPECTED``
> +
> +         An unexpected map hash value was encountered during verificatio=
n.
> +
> +      ``FAULT``
> +
> +         A system error occurred during signature verification.
> +
> +      ``BADSIG``
> +
> +         The signature or hash verification failed.
> +
> +bpf_keyring
> +~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization of BPF program loads =
based
> +   on the keyring specified in the ``bpf_attr`` during the ``BPF_PROG_LO=
AD``
> +   syscall. This allows policies to restrict which keyring must be used =
for
> +   signature verification of BPF programs.
> +
> +   This property shares the ``IPE_PROP_BPF_SIGNATURE`` config option wit=
h
> +   ``bpf_signature``.
> +   The format of this property is::
> +
> +      bpf_keyring=3D(BUILTIN|SECONDARY|PLATFORM)
> +
> +   The possible values correspond to the system keyrings:
> +
> +      ``BUILTIN``
> +
> +         The builtin trusted keyring (``.builtin_trusted_keys``), which
> +         contains keys embedded at kernel compile time.
> +
> +      ``SECONDARY``
> +
> +         The secondary trusted keyring (``.secondary_trusted_keys``), wh=
ich
> +         includes both builtin trusted keys and keys added at runtime.
> +
> +      ``PLATFORM``
> +
> +         The platform keyring (``.platform``), which contains keys provi=
ded
> +         by the platform firmware (e.g. UEFI db keys).
> +
> +bpf_kernel
> +~~~~~~~~~~
> +
> +   This property can be utilized for authorization of BPF program loads =
based
> +   on whether the load originated from kernel space or user space. The B=
PF
> +   light skeleton infrastructure performs a secondary kernel-originated =
program
> +   load that will not carry a signature. This property allows policies t=
o
> +   permit such kernel-originated loads while still requiring signatures =
for
> +   user-space loads.
> +
> +   This property shares the ``IPE_PROP_BPF_SIGNATURE`` config option wit=
h
> +   ``bpf_signature``.
> +   The format of this property is::
> +
> +      bpf_kernel=3D(TRUE|FALSE)
> +
>  Policy Examples
>  ---------------
>
> @@ -788,6 +896,58 @@ Allow execution of a specific fs-verity file
>
>     op=3DEXECUTE fsverity_digest=3Dsha256:fd88f2b8824e197f850bf4c5109bea5=
cf0ee38104f710843bb72da796ba5af9e action=3DALLOW
>
> +Allow only signed BPF programs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllow_Signed_BPF policy_version=3D0.0.0
> +   DEFAULT action=3DALLOW
> +
> +   DEFAULT op=3DBPF_PROG_LOAD action=3DDENY
> +   op=3DBPF_PROG_LOAD bpf_kernel=3DTRUE action=3DALLOW
> +   op=3DBPF_PROG_LOAD bpf_signature=3DOK action=3DALLOW
> +
> +This policy allows all other operations but restricts BPF program loadin=
g
> +to only programs that either originate from kernel space (e.g. light ske=
leton
> +reloads) or have a valid signature verified by the Hornet LSM. Unsigned =
or
> +improperly signed BPF programs from user space will be denied.
> +
> +Allow signed BPF programs from a specific keyring
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllow_BPF_Builtin_Keyring policy_version=3D0.0.0
> +   DEFAULT action=3DALLOW
> +
> +   DEFAULT op=3DBPF_PROG_LOAD action=3DDENY
> +   op=3DBPF_PROG_LOAD bpf_kernel=3DTRUE action=3DALLOW
> +   op=3DBPF_PROG_LOAD bpf_signature=3DOK bpf_keyring=3DBUILTIN action=3D=
ALLOW
> +
> +This policy further restricts BPF program loading to only accept program=
s
> +whose signatures were verified using the builtin trusted keyring. Progra=
ms
> +signed against the secondary or platform keyrings will be denied, provid=
ing
> +tighter control over which signing keys are acceptable.
> +
> +Allow signed BPF programs with relaxed partial signatures
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllow_BPF_Partial policy_version=3D0.0.0
> +   DEFAULT action=3DALLOW
> +
> +   DEFAULT op=3DBPF_PROG_LOAD action=3DDENY
> +   op=3DBPF_PROG_LOAD bpf_kernel=3DTRUE action=3DALLOW
> +   op=3DBPF_PROG_LOAD bpf_signature=3DOK action=3DALLOW
> +   op=3DBPF_PROG_LOAD bpf_signature=3DPARTIALSIG action=3DALLOW
> +
> +This policy allows BPF programs that have been fully verified (``OK``) a=
s
> +well as programs with a valid program signature but without authenticate=
d
> +map hash data (``PARTIALSIG``). This can be useful during development or
> +for programs that do not use maps.
> +
>  Additional Information
>  ----------------------
>
> diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.=
rst
> index 4a7d953abcdc3..de8fcf1dc173d 100644
> --- a/Documentation/security/ipe.rst
> +++ b/Documentation/security/ipe.rst
> @@ -412,6 +412,44 @@ a standard securityfs policy tree::
>
>  The policy is stored in the ``->i_private`` data of the MyPolicy inode.
>
> +BPF/Hornet Integration
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +IPE integrates with the Hornet LSM to enforce integrity policies on BPF
> +program loading. Hornet performs cryptographic verification of BPF progr=
am
> +signatures (PKCS#7 with authenticated attributes containing map hashes) =
and
> +provides an integrity verdict to IPE via the
> +``security_bpf_prog_load_post_integrity`` hook.
> +
> +The hook flow is:
> +
> +  1. User space invokes ``BPF_PROG_LOAD`` via the ``bpf()`` syscall.
> +  2. Hornet's ``bpf_prog_load_integrity`` hook calls ``hornet_check_prog=
ram()``
> +     to verify the program's signature and map hashes.
> +  3. Hornet calls ``security_bpf_prog_load_post_integrity()`` with the
> +     resulting ``lsm_integrity_verdict``.
> +  4. IPE evaluates the verdict against the active policy's ``BPF_PROG_LO=
AD``
> +     rules and returns ``-EACCES`` if denied.
> +

This part needs to be updated.

> +Three properties are available for BPF policy rules:
> +
> +  - ``bpf_signature``: Matches against the integrity verdict (OK, UNSIGN=
ED,
> +    BADSIG, etc.)
> +  - ``bpf_keyring``: Matches against the keyring specified in ``bpf_attr=
``
> +    (BUILTIN, SECONDARY, PLATFORM)
> +  - ``bpf_kernel``: Matches whether the load originated from kernel spac=
e
> +    (TRUE/FALSE). This is important because the BPF light skeleton
> +    infrastructure performs a secondary kernel-originated program load t=
hat
> +    does not carry a signature.
> +
> +All three properties are gated on ``CONFIG_IPE_PROP_BPF_SIGNATURE`` whic=
h
> +depends on ``CONFIG_SECURITY_HORNET``.
> +
> +The evaluation context (``struct ipe_eval_ctx``) carries three BPF-speci=
fic
> +fields: ``bpf_verdict`` (the integrity verdict enum), ``bpf_keyring_id``
> +(the ``s32`` keyring ID from ``bpf_attr``), and ``bpf_kernel`` (bool
> +indicating kernel origin).
> +
>  Tests
>  -----
>
> @@ -439,6 +477,7 @@ IPE has KUnit Tests for the policy parser. Recommende=
d kunitconfig::
>    CONFIG_IPE_PROP_DM_VERITY_SIGNATURE=3Dy
>    CONFIG_IPE_PROP_FS_VERITY=3Dy
>    CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG=3Dy
> +  CONFIG_IPE_PROP_BPF_SIGNATURE=3Dy
>    CONFIG_SECURITY_IPE_KUNIT_TEST=3Dy
>
>  In addition, IPE has a python based integration
> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> index a110a6cd848b7..4c1d46847582b 100644
> --- a/security/ipe/Kconfig
> +++ b/security/ipe/Kconfig
> @@ -95,6 +95,20 @@ config IPE_PROP_FS_VERITY_BUILTIN_SIG
>
>           if unsure, answer Y.
>
> +config IPE_PROP_BPF_SIGNATURE
> +       bool "Enable support for Hornet BPF program signature verificatio=
n"
> +       depends on SECURITY_HORNET
> +       help
> +         This option enables the 'bpf_signature' and 'bpf_keyring'

bpf_kernel is missing.

> +         properties within IPE policies. The 'bpf_signature' property
> +         allows IPE to make policy decisions based on the integrity
> +         verdict provided by the Hornet LSM when a BPF program is loaded=
.
> +         Verdicts include OK, UNSIGNED, PARTIALSIG, BADSIG, and others.
> +         The 'bpf_keyring' property allows policies to match against the
> +         keyring specified in bpf_attr (BUILTIN, SECONDARY, PLATFORM).
> +
> +         If unsure, answer Y.
> +
>  endmenu
>
>  config SECURITY_IPE_KUNIT_TEST
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index 3f0deeb549127..251c6ec2f8423 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -41,6 +41,7 @@ static const char *const audit_op_names[__IPE_OP_MAX + =
1] =3D {
>         "KEXEC_INITRAMFS",
>         "POLICY",
>         "X509_CERT",
> +       "BPF_PROG_LOAD",
>         "UNKNOWN",
>  };
>
> @@ -51,6 +52,7 @@ static const char *const audit_hook_names[__IPE_HOOK_MA=
X] =3D {
>         "MPROTECT",
>         "KERNEL_READ",
>         "KERNEL_LOAD",
> +       "BPF_PROG_LOAD",
>  };
>
>  static const char *const audit_prop_names[__IPE_PROP_MAX] =3D {
> @@ -62,6 +64,19 @@ static const char *const audit_prop_names[__IPE_PROP_M=
AX] =3D {
>         "fsverity_digest=3D",
>         "fsverity_signature=3DFALSE",
>         "fsverity_signature=3DTRUE",
> +       "bpf_signature=3DNONE",
> +       "bpf_signature=3DOK",
> +       "bpf_signature=3DUNSIGNED",
> +       "bpf_signature=3DPARTIALSIG",
> +       "bpf_signature=3DUNKNOWNKEY",
> +       "bpf_signature=3DUNEXPECTED",
> +       "bpf_signature=3DFAULT",
> +       "bpf_signature=3DBADSIG",
> +       "bpf_keyring=3DBUILTIN",
> +       "bpf_keyring=3DSECONDARY",
> +       "bpf_keyring=3DPLATFORM",
> +       "bpf_kernel=3DFALSE",
> +       "bpf_kernel=3DTRUE",
>  };
>
>  /**
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 21439c5be3364..9a6d583fea125 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -11,6 +11,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/moduleparam.h>
>  #include <linux/fsverity.h>
> +#include <linux/verification.h>
>
>  #include "ipe.h"
>  #include "eval.h"
> @@ -265,8 +266,52 @@ static bool evaluate_fsv_sig_true(const struct ipe_e=
val_ctx *const ctx)
>  }
>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>
> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> +/**
> + * evaluate_bpf_sig() - Evaluate @ctx against a bpf_signature property.
> + * @ctx: Supplies a pointer to the context being evaluated.
> + * @expected: The expected lsm_integrity_verdict to match against.
> + *
> + * Return:
> + * * %true     - The current @ctx matches the expected verdict
> + * * %false    - The current @ctx doesn't match the expected verdict
> + */
> +static bool evaluate_bpf_sig(const struct ipe_eval_ctx *const ctx,
> +                            enum lsm_integrity_verdict expected)
> +{
> +       return ctx->bpf_verdict =3D=3D expected;
> +}
> +#else
> +static bool evaluate_bpf_sig(const struct ipe_eval_ctx *const ctx,
> +                            enum lsm_integrity_verdict expected)
> +{
> +       return false;
> +}
> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
> +
> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> +/**
> + * evaluate_bpf_keyring() - Evaluate @ctx against a bpf_keyring property=
.
> + * @ctx: Supplies a pointer to the context being evaluated.
> + * @expected: The expected keyring_id to match against.
> + *
> + * Return:
> + * * %true     - The current @ctx matches the expected keyring
> + * * %false    - The current @ctx doesn't match the expected keyring
> + */
> +static bool evaluate_bpf_keyring(const struct ipe_eval_ctx *const ctx,
> +                                s32 expected)
> +{
> +       return ctx->bpf_keyring_id =3D=3D expected;
> +}
> +#else
> +static bool evaluate_bpf_keyring(const struct ipe_eval_ctx *const ctx,
> +                                s32 expected)
> +{
> +       return false;
> +}
> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
>  /**
> - * evaluate_property() - Analyze @ctx against a rule property.
>   * @ctx: Supplies a pointer to the context to be evaluated.
>   * @p: Supplies a pointer to the property to be evaluated.
>   *
> @@ -297,6 +342,32 @@ static bool evaluate_property(const struct ipe_eval_=
ctx *const ctx,
>                 return evaluate_fsv_sig_false(ctx);
>         case IPE_PROP_FSV_SIG_TRUE:
>                 return evaluate_fsv_sig_true(ctx);
> +       case IPE_PROP_BPF_SIG_NONE:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_NONE);
> +       case IPE_PROP_BPF_SIG_OK:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_OK);
> +       case IPE_PROP_BPF_SIG_UNSIGNED:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNSIGNED);
> +       case IPE_PROP_BPF_SIG_PARTIALSIG:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_PARTIALSIG);
> +       case IPE_PROP_BPF_SIG_UNKNOWNKEY:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNKNOWNKEY);
> +       case IPE_PROP_BPF_SIG_UNEXPECTED:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNEXPECTED);
> +       case IPE_PROP_BPF_SIG_FAULT:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_FAULT);
> +       case IPE_PROP_BPF_SIG_BADSIG:
> +               return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_BADSIG);
> +       case IPE_PROP_BPF_KEYRING_BUILTIN:
> +               return evaluate_bpf_keyring(ctx, 0);
> +       case IPE_PROP_BPF_KEYRING_SECONDARY:
> +               return evaluate_bpf_keyring(ctx, (s32)(unsigned long)VERI=
FY_USE_SECONDARY_KEYRING);
> +       case IPE_PROP_BPF_KEYRING_PLATFORM:
> +               return evaluate_bpf_keyring(ctx, (s32)(unsigned long)VERI=
FY_USE_PLATFORM_KEYRING);
> +       case IPE_PROP_BPF_KERNEL_FALSE:
> +               return !ctx->bpf_kernel;
> +       case IPE_PROP_BPF_KERNEL_TRUE:
> +               return ctx->bpf_kernel;

bpf_kernel part needs to be guarded by #ifdef, like the other two.

-Fan

>         default:
>                 return false;
>         }
