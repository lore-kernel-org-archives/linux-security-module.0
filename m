Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112840;
	b=PEHDITwIcz7YM/eFwUT2QUsAhKfG4FowxcqYhscMKgIOt40e1YzlS+QkV10ZcZYZ6TvK
	 xTzLiNH0s+vbEgwEJkPfKOPBurk13RVdUW/xQnM/rApAd1u4OODWHOe+NSQiTlgAwIDg3
	 Wju2+Ta2VvEGY3IBWMPe6eIoeNgn3GCnic0tEcjvjnXG4dyPZuj9jzmh0g3ZtU5o52iqw
	 GJY90ihzyrWQkZdFVkYZvOWTDYc5tFMei0gAs9/yas7Sf2hEfvTJT8oyjCvLY/0n041iV
	 e8x1NPpBlymG4aCHBGydBRMfSJi7diDGb/jVBjRMjMG1CODsCm+KOoRNTyqSP5+rAng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aCG2e9yyNs6h3rkDXnjBqmb1knCApUuqekvjibfwuKE=;
	b=PQ+Y6yGJv2Wet01nvl6hJjPf7RKD3HHmNYEo0WseibF62qsq9O8UvNyNL339prUpKc5d
	 X17yE00MGEjSEBo1gvc4kkD8T6z8OE0bsvAMEEjSRiyCyys0HYwxAjldBY5SRSNnyyESA
	 EjcakpMpc8lQ4CpcHCx7Ly+toHKHbgS9Fwr3JpDnwlYLrSqDOymtDEZi5QQPBdEyvdrIZ
	 nYBYW2ob5B6Ab773oMH4c31iA1HjfKcZ1q3mzljjFvkt9E/qyzVaa7CL58a20V6G0lk/5
	 ibGvmYF295JC/dEAuDUmtzedpI8z8E/k/idGBdHWh/+BGEc8MhhVLKTIFA0fRXRe4kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW3YpsGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86D606A31A;
	Tue, 27 Oct 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW3YpsGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7256D1F01825;
	Tue, 27 Oct 2026 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112839;
	bh=aCG2e9yyNs6h3rkDXnjBqmb1knCApUuqekvjibfwuKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dW3YpsGACz/EAPjYgqSNBpOyxnbaJ0HrDTFxMIIQrr9uq1i63jB1zsxRbOCar8YcO
	 Xya8AAQGE8TFqPsXoao75xAE/lyj7zDN8lJECuzuP6L+UJTHs00lgeMYqW9gv2Xmrx
	 b7RZeMDOe/79t09LjREq2TfiASpKRw9t23qmMtsLStJXwOlpa7Vjwu0hUQfRoJPzMT
	 u11Vef2g8ZAqihaKn8NzCm2e4FgqcCnu9bucnoin6pdJn0JmXI+pIbDgeiLfNJCoCR
	 /zpn34aSUMbhgjOr3cjRQluY78/ov2+fnbo+1wVhVGm7UQ4jsNEYcsgeog7r9Fo3U9
	 hbGxzcD5eOfzQ==
Date: Tue, 27 Oct 2026 14:53:51 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Andrey Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auCxjbvY3qPv1sV6@gremlin>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>

The existing implementation is a bit of a mess, so any work that extends it
has to put in the work to improve things first.

I _hate_ VM_SEALED_SYSMAP. It's a hack. A tasteful way of doing this is
really required for a series touching this to be taken, honestly.

See below for implementation ideas.

(Also it's the merge window, so no more revisions until -rc1, when you need
to resend, thanks.)

On Tue, Oct 27, 2026 at 07:43:04PM +0800, Chris Down wrote:
> CONFIG_MSEAL_SYSTEM_MAPPINGS seals each process' system mappings when
> they are created. As it is today this can only be toggled at build time,
> so hosts that need sealing and hosts running software which moves or
> unmaps these mappings end up with separate kernels. This is not ideal
> since it adds more complexity of deployment, it would be great to be
> able to have one kernel which can configurably do both.

Could we have some actual justification for the use of the feature please?
So far I've seen arm-waving.

>
> So, to improve this, let's add mseal_system_mappings= so that this can
> be chosen at boot.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  .../admin-guide/kernel-parameters.txt         |   7 ++
>  Documentation/userspace-api/mseal.rst         |   3 +-
>  include/linux/mm.h                            |   3 +-
>  mm/mseal.c                                    |  12 ++
>  security/Kconfig                              |   2 +
>  .../mseal_system_mappings/sysmap_is_sealed.c  | 104 +++++++++++++++---
>  6 files changed, 115 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e75344f4e0cd..b1ec9a8a979e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4270,6 +4270,13 @@ Kernel parameters
>  	MTD_Region=	[MTD] Format:
>  			<name>,<region-number>[,<base>,<size>,<buswidth>,<altbuswidth>]
>
> +	mseal_system_mappings=
> +			[KNL,EARLY] Under CONFIG_MSEAL_SYSTEM_MAPPINGS,
> +			whether system mappings are sealed for this boot.
> +			See Documentation/userspace-api/mseal.rst.
> +			Format: <bool>
> +			Default: 1 (enabled).

You _have_ to duplicate the list of things this breaks here please.

> +
>  	mtdparts=	[MTD]
>  			See drivers/mtd/parsers/cmdlinepart.c
>
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index c039d782f9f5..4e50215e4762 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -142,7 +142,8 @@ Use cases
>
>    If supported by an architecture (CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS),
>    the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
> -  architecture.
> +  architecture. The kernel command line parameter
> +  ``mseal_system_mappings=0`` turns this off at boot.

This is just really confusing.

Adding a flag that defaults to on but only defaults to on if the config
option is enabled...

Let's just refactor this properly to stop abusing a 'VMA flag' (which is
really not a VMA flag, but an alias).

Let's negate things first. Make the boot flag 'no_mseal_sys_mappings'
rather than confusingly implying mseal_system_mappings=1 could enable it
even with a config option not provided.

Then add something like:

static inline bool mseal_system_mappings(void)
{
        return IS_ENABLED(CONFIG_MSEAL_SYSTEM_MAPPINGS) &&
               !mseal_system_mappings_disabled;
}

And call that in _install_special_mapping().

The LLM overlords tell me that only uprobe trampolines would see a delta
from this given the ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS restriction.

This would improve things a lot.

>
>    WARNING: This feature breaks programs which rely on relocating
>    or unmapping system mappings. Known broken software at the time
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5f82be0fcde5..2329d81b7d46 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -568,7 +568,8 @@ enum {
>  #define VM_STACK_FLAGS vma_flags_to_legacy(VMA_STACK_FLAGS)
>
>  #ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> -#define VM_SEALED_SYSMAP	VM_SEALED
> +extern bool mseal_sysmap_enabled;
> +#define VM_SEALED_SYSMAP	(mseal_sysmap_enabled ? VM_SEALED : VM_NONE)

No, you don't use the legacy VMA flags API for new work. Sorry.

See above as to a pointer as to how this should look.

>  #else
>  #define VM_SEALED_SYSMAP	VM_NONE
>  #endif
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 7a8ac66dc215..e0563796cfa3 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -7,6 +7,8 @@
>   *  Author: Jeff Xu <jeffxu@chromium.org>
>   */
>
> +#include <linux/init.h>
> +#include <linux/kstrtox.h>
>  #include <linux/mempolicy.h>
>  #include <linux/minmax.h>
>  #include <linux/mman.h>
> @@ -16,6 +18,16 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>
> +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> +bool mseal_sysmap_enabled __ro_after_init = true;

See above re: rework of this.

> +
> +static int __init early_mseal_sysmap(char *buf)
> +{
> +	return kstrtobool(buf, &mseal_sysmap_enabled);
> +}
> +early_param("mseal_system_mappings", early_mseal_sysmap);
> +#endif
> +
>  static bool range_contains_unmapped(unsigned long start, unsigned long end)
>  {
>  	VMA_ITERATOR(vmi, current->mm, start);
> diff --git a/security/Kconfig b/security/Kconfig
> index f7bf6cdc6229..d5e83af1bfc6 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -67,6 +67,8 @@ config MSEAL_SYSTEM_MAPPINGS
>  	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
>  	  this config can't be enabled universally.
>
> +	  Sealing can be turned off at boot with "mseal_system_mappings=0".
> +

'With this configuration option set, sealing can...' right now this reads a
little like it's defaulted on.

Also can we move this Kconfig option out of security and into mm please?
This is explicitly an mm feature, and it should never have been added there
(mm needs to know if somebody sets this default=y or something for
instance).

In any case, as above, no_mseal_sys_mappings is probably a better way, then
this becomes something like:

"With this configuration option set, the feature can be disabled
with the no_mseal_sys_mappings boot parameter.'

>  	  For complete descriptions of memory sealing, please see
>  	  Documentation/userspace-api/mseal.rst
>
> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> index cb0ca6ed7ebe..97348c2a0689 100644
> --- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

Tests as separate commits please.

> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * test system mappings are sealed when
> - * KCONFIG_MSEAL_SYSTEM_MAPPINGS=y
> + * Test system mapping sealing and the mseal_system_mappings= boot parameter.
>   */

Can we have test changes as separate commits please.

>
>  #define _GNU_SOURCE
>  #include <stdio.h>
>  #include <errno.h>
> +#include <ctype.h>
>  #include <unistd.h>
>  #include <string.h>
>  #include <stdbool.h>
> @@ -17,6 +17,73 @@
>  #define VMFLAGS "VmFlags:"
>  #define MSEAL_FLAGS "sl"
>  #define MAX_LINE_LEN 512
> +#define SYSMAP_PARAM "mseal_system_mappings="
> +
> +static int parse_bool(const char *s, bool *res)
> +{
> +	if (!s)
> +		return -EINVAL;
> +
> +	switch (tolower((unsigned char)s[0])) {
> +	case 'e':
> +	case 'y':
> +	case 't':
> +	case '1':
> +		*res = true;
> +		return 0;
> +	case 'd':
> +	case 'n':
> +	case 'f':
> +	case '0':
> +		*res = false;
> +		return 0;
> +	case 'o':
> +		switch (tolower((unsigned char)s[1])) {
> +		case 'n':
> +			*res = true;
> +			return 0;
> +		case 'f':
> +			*res = false;
> +			return 0;
> +		}
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int sysmap_sealed_expected(void)
> +{
> +	char cmdline[4096], *tok, *save;
> +	int sealed = 1;
> +	bool value;
> +	size_t len;
> +	FILE *f;
> +
> +	f = fopen("/proc/cmdline", "r");
> +	if (!f)
> +		return -1;
> +	len = fread(cmdline, 1, sizeof(cmdline) - 1, f);
> +	if (ferror(f) || !feof(f)) {
> +		fclose(f);
> +		return -1;
> +	}
> +	fclose(f);
> +	cmdline[len] = '\0';
> +
> +	for (tok = strtok_r(cmdline, " \t\n", &save); tok;
> +	     tok = strtok_r(NULL, " \t\n", &save)) {
> +		if (!strcmp(tok, "--"))
> +			break;
> +		if (strncmp(tok, SYSMAP_PARAM, strlen(SYSMAP_PARAM)))
> +			continue;
> +
> +		if (!parse_bool(tok + strlen(SYSMAP_PARAM), &value))
> +			sealed = value;
> +	}
> +
> +	return sealed;
> +}

This seems total overkill, you're checking whether a boot parameter works?

>
>  bool has_mapping(char *name, FILE *maps)
>  {
> @@ -30,7 +97,7 @@ bool has_mapping(char *name, FILE *maps)
>  	return false;
>  }
>
> -bool mapping_is_sealed(char *name, FILE *maps)
> +int mapping_is_sealed(FILE *maps)
>  {
>  	char line[MAX_LINE_LEN];
>
> @@ -43,7 +110,7 @@ bool mapping_is_sealed(char *name, FILE *maps)
>  		}
>  	}
>
> -	return false;
> +	return -1;
>  }
>
>  FIXTURE(basic) {
> @@ -67,53 +134,62 @@ FIXTURE_TEARDOWN(basic)
>  FIXTURE_VARIANT(basic)
>  {
>  	char *name;
> -	bool sealed;
> +	bool sysmap;
>  };
>
>  FIXTURE_VARIANT_ADD(basic, vdso) {
>  	.name = "[vdso]",
> -	.sealed = true,
> +	.sysmap = true,
>  };
>
>  FIXTURE_VARIANT_ADD(basic, vvar) {
>  	.name = "[vvar]",
> -	.sealed = true,
> +	.sysmap = true,
>  };
>
>  FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
>  	.name = "[vvar_vclock]",
> -	.sealed = true,
> +	.sysmap = true,
>  };
>
>  FIXTURE_VARIANT_ADD(basic, sigpage) {
>  	.name = "[sigpage]",
> -	.sealed = true,
> +	.sysmap = true,
>  };
>
>  FIXTURE_VARIANT_ADD(basic, vectors) {
>  	.name = "[vectors]",
> -	.sealed = true,
> +	.sysmap = true,
>  };
>
>  FIXTURE_VARIANT_ADD(basic, uprobes) {
>  	.name = "[uprobes]",
> -	.sealed = true,
> +	.sysmap = true,
>  };
>
>  FIXTURE_VARIANT_ADD(basic, stack) {
>  	.name = "[stack]",
> -	.sealed = false,
> +	.sysmap = false,
>  };
>
>  TEST_F(basic, check_sealed)
>  {
> +	int expected = 0, sealed;
> +
>  	if (!has_mapping(variant->name, self->maps)) {
>  		SKIP(return, "could not find the mapping, %s",
>  			variant->name);
>  	}
>
> -	EXPECT_EQ(variant->sealed,
> -		mapping_is_sealed(variant->name, self->maps));
> +	sealed = mapping_is_sealed(self->maps);
> +	if (sealed < 0)
> +		SKIP(return, "could not read the mapping's sealing state");
> +	if (variant->sysmap) {
> +		expected = sysmap_sealed_expected();
> +		if (expected < 0)
> +			SKIP(return, "could not determine the expected sealing state");
> +	}
> +	EXPECT_EQ(expected, sealed);
>  };
>
>  TEST_HARNESS_MAIN
> --
> 2.54.0
>

--
Cheers, Lorenzo
