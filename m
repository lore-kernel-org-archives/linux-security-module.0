Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1420F3F5;
	Fri, 25 Oct 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869497; cv=none; b=UNiqN0Zp5wLyOujqG7GjJeg8NTdzaUpA9Tw3HeRGPl4T0YHyIoSBIiZPsW5W2xjmM9TriQKLD5E1CBVKT6LL+N9ATOSbTItfRrEwxeXc7EMf5npv7Kh8BTAq/o7cDendcTlXBIePgn4I9tbQ1zosTEozIavSXPfoZCBF9ZfirJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869497; c=relaxed/simple;
	bh=yvo/kBUymHvCb+JUMGdtykJClLo6Asc5Iy2562Ew7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYIXM/tEfp8eVh7xVeMYwBsWvSOOeUux8P3ntsM+FSEv7UyV3oB6TlmRgRpQOJ9NNV74U9B8O3tscaKFPw0PNryJqmxpgMakjcwnhPbDb9qaDEzHu/liosD5aXe0hUf8kqtZzPxTz1YuXqLsXS4A+ouEGsVb8IRuYW/QZMuURy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=reI8OX7f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="reI8OX7f"
Received: from pwmachine.localnet (84-115-216-151.cable.dynamic.surfer.at [84.115.216.151])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB143211A5B4;
	Fri, 25 Oct 2024 08:18:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB143211A5B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729869494;
	bh=nI0uI5G09AGa0LcwoqlAJHlp79iY6kVb3cSVEl3GJvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reI8OX7fPwx7agFCGOa1ErdswW7GIZMtUqr6xuAQ8JnbZ2YgvPBXCsCMGktxWymZd
	 svPvSY1pNRLyRUOkIxishluUywWYI82kg1RYv+aGaiAID+L0ogFAGHX+NWgAuHo4mg
	 adqz7mchgFABb+ilpHSmyLNmvIJa73E9c5YqPO2w=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/14] landlock: Add unique ID generator
Date: Fri, 25 Oct 2024 17:18:06 +0200
Message-ID: <1962333.tdWV9SEqCh@pwmachine>
In-Reply-To: <20241022161009.982584-5-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!

Le mardi 22 octobre 2024, 18:09:59 CEST Micka=EBl Sala=FCn a =E9crit :
> Landlock IDs can be generated to uniquely identify Landlock objects.
> For now, only Landlock domains get an ID at creation time.
>=20
> These IDs have important properties:
> * They are unique during the lifetime of the running system thanks to
>   the 64-bit values: at worse, 2^60 - 2*2^32 useful IDs.
> * They are always greater than 2^32 and must then be stored in 64-bit
>   integer types.
> * The initial ID (at boot time) is randomly picked between 2^32 and
>   2^33, which limits collisions in logs between different boots.
> * IDs are sequential, which enables users to order them.
> * IDs may not be consecutive but increase with a random 2^4 step, which
>   limits side channels.
>=20
> Such IDs can be exposed to unprivileged processes, even if it is not the
> case with this audit patch series.  The domain IDs will be useful for
> user space to identify sandboxes and get their properties.
>=20
> Cc: G=FCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022161009.982584-5-mic@digikod.net
> ---
>=20
> Changes since v1:
> * New patch.
> ---
>  security/landlock/.kunitconfig               |   2 +
>  security/landlock/Makefile                   |   2 +
>  security/landlock/id.c                       | 242 +++++++++++++++++++
>  security/landlock/id.h                       |  25 ++
>  security/landlock/setup.c                    |   2 +
>  tools/testing/kunit/configs/all_tests.config |   2 +
>  6 files changed, 275 insertions(+)
>  create mode 100644 security/landlock/id.c
>  create mode 100644 security/landlock/id.h
>=20
> diff --git a/security/landlock/.kunitconfig b/security/landlock/.kunitcon=
fig
> index 03e119466604..f9423f01ac5b 100644
> --- a/security/landlock/.kunitconfig
> +++ b/security/landlock/.kunitconfig
> @@ -1,4 +1,6 @@
> +CONFIG_AUDIT=3Dy
>  CONFIG_KUNIT=3Dy
> +CONFIG_NET=3Dy
>  CONFIG_SECURITY=3Dy
>  CONFIG_SECURITY_LANDLOCK=3Dy
>  CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=3Dy
> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
> index b4538b7cf7d2..e1777abbc413 100644
> --- a/security/landlock/Makefile
> +++ b/security/landlock/Makefile
> @@ -4,3 +4,5 @@ landlock-y :=3D setup.o syscalls.o object.o ruleset.o \
>  	cred.o task.o fs.o
>=20
>  landlock-$(CONFIG_INET) +=3D net.o
> +
> +landlock-$(CONFIG_AUDIT) +=3D id.o
> diff --git a/security/landlock/id.c b/security/landlock/id.c
> new file mode 100644
> index 000000000000..5d0b7743c308
> --- /dev/null
> +++ b/security/landlock/id.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Unique identification number generator
> + *
> + * Copyright =A9 2024 Microsoft Corporation
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/atomic.h>
> +#include <linux/random.h>
> +#include <linux/spinlock.h>
> +
> +#include "common.h"
> +#include "id.h"
> +
> +#define COUNTER_PRE_INIT 0
> +
> +static atomic64_t global_counter =3D ATOMIC64_INIT(COUNTER_PRE_INIT);
> +
> +static void __init init_id(atomic64_t *const counter, const u32
> random_32bits) +{
> +	u64 init;
> +
> +	/*
> +	 * Ensures sure 64-bit values are always used by user space (or may
> +	 * fail with -EOVERFLOW), and makes this testable.
> +	 */
> +	init =3D 1ULL << 32;
> +
> +	/*
> +	 * Makes a large (2^32) boot-time value to limit ID collision in logs
> +	 * from different boots, and to limit info leak about the number of
> +	 * initially (relative to the reader) created elements (e.g. domains).
> +	 */
> +	init +=3D random_32bits;
> +
> +	/* Sets first or ignores.  This will be the first ID. */
> +	atomic64_cmpxchg(counter, COUNTER_PRE_INIT, init);
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_init_min(struct kunit *const test)
> +{
> +	atomic64_t counter =3D ATOMIC64_INIT(COUNTER_PRE_INIT);
> +
> +	init_id(&counter, 0);
> +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), 1ULL + U32_MAX);
> +}
> +
> +static void test_init_max(struct kunit *const test)
> +{
> +	atomic64_t counter =3D ATOMIC64_INIT(COUNTER_PRE_INIT);
> +
> +	init_id(&counter, ~0);
> +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), 1 + (2ULL * U32_MAX));
> +}
> +
> +static void test_init_once(struct kunit *const test)
> +{
> +	const u64 first_init =3D 1ULL + U32_MAX;
> +	atomic64_t counter =3D ATOMIC64_INIT(COUNTER_PRE_INIT);
> +
> +	init_id(&counter, 0);
> +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), first_init);
> +
> +	init_id(&counter, ~0);
> +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), first_init);
> +}
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> +
> +void __init landlock_init_id(void)
> +{
> +	return init_id(&global_counter, get_random_u32());
> +}
> +
> +/*
> + * It's not worth it to try to hide the monotonic counter because it can
> still + * be inferred (with N counter ranges), and if we are allowed to
> read the inode + * number we should also be allowed to read the time
> creation anyway, and it + * can be handy to store and sort domain IDs for
> user space.
> + *
> + * Returns the value of global_counter and increment it to let some space
> for + * the next one.
> + */
> +static u64 get_id(size_t number_of_ids, atomic64_t *const counter,
> +		  u8 random_4bits)
> +{
> +	u64 id, step;
> +
> +	/*
> +	 * We should return at least 1 ID, and we may need a set of=20
consecutive
> +	 * ones (e.g. to generate a set of inodes).
> +	 */
> +	if (WARN_ON_ONCE(number_of_ids <=3D 0))
> +		number_of_ids =3D 1;
> +
> +	/*
> +	 * Blurs the next ID guess with 1/16 ratio.  We get 2^(64 - 4) -
> +	 * (2 * 2^32), so a bit less than 2^60 available IDs, which should be
> +	 * much more than enough considering the number of CPU cycles required
> +	 * to get a new ID (e.g. a full landlock_restrict_self() call), and=20
the
> +	 * cost of draining all available IDs during the system's uptime.
> +	 */
> +	random_4bits =3D random_4bits % (1 << 4);
> +	step =3D number_of_ids + random_4bits;
> +
> +	/* It is safe to cast a signed atomic to an unsigned value. */
> +	id =3D atomic64_fetch_add(step, counter);
> +
> +	/* Warns if landlock_init_id() was not called. */
> +	WARN_ON_ONCE(id =3D=3D COUNTER_PRE_INIT);
> +	return id;
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_range1_rand0(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id(1, &counter, 0), init);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id(get_random_u8(), &counter, get_random_u8()),
> +			init + 1);
> +}
> +
> +static void test_range1_rand1(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id(1, &counter, 1), init);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id(get_random_u8(), &counter, get_random_u8()),
> +			init + 2);
> +}
> +
> +static void test_range1_rand16(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id(1, &counter, 16), init);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id(get_random_u8(), &counter, get_random_u8()),
> +			init + 1);
> +}
> +
> +static void test_range2_rand0(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id(2, &counter, 0), init);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id(get_random_u8(), &counter, get_random_u8()),
> +			init + 2);
> +}
> +
> +static void test_range2_rand1(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id(2, &counter, 1), init);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id(get_random_u8(), &counter, get_random_u8()),
> +			init + 3);
> +}
> +
> +static void test_range2_rand2(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id(2, &counter, 2), init);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id(get_random_u8(), &counter, get_random_u8()),
> +			init + 4);
> +}
> +
> +static void test_range2_rand16(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id(2, &counter, 16), init);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id(get_random_u8(), &counter, get_random_u8()),
> +			init + 2);
> +}
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> +
> +u64 landlock_get_id(size_t number_of_ids)
> +{
> +	return get_id(number_of_ids, &global_counter, get_random_u8());
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static struct kunit_case test_cases[] =3D {
> +	/* clang-format off */
> +	KUNIT_CASE(test_init_min),
> +	KUNIT_CASE(test_init_max),
> +	KUNIT_CASE(test_init_once),
> +	KUNIT_CASE(test_range1_rand0),
> +	KUNIT_CASE(test_range1_rand1),
> +	KUNIT_CASE(test_range1_rand16),
> +	KUNIT_CASE(test_range2_rand0),
> +	KUNIT_CASE(test_range2_rand1),
> +	KUNIT_CASE(test_range2_rand2),
> +	KUNIT_CASE(test_range2_rand16),
> +	{}
> +	/* clang-format on */
> +};
> +
> +static struct kunit_suite test_suite =3D {
> +	.name =3D "landlock_id",
> +	.test_cases =3D test_cases,
> +};
> +
> +kunit_test_suite(test_suite);
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> diff --git a/security/landlock/id.h b/security/landlock/id.h
> new file mode 100644
> index 000000000000..689ba7607472
> --- /dev/null
> +++ b/security/landlock/id.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock LSM - Unique identification number generator
> + *
> + * Copyright =A9 2024 Microsoft Corporation
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_ID_H
> +#define _SECURITY_LANDLOCK_ID_H
> +
> +#ifdef CONFIG_AUDIT
> +
> +void __init landlock_init_id(void);
> +
> +u64 landlock_get_id(size_t number_of_ids);
> +
> +#else /* CONFIG_AUDIT */
> +
> +static inline void __init landlock_init_id(void)
> +{
> +}

Should the function have the same signature than when CONFIG_AUDIT is set?

> +#endif /* CONFIG_AUDIT */
> +
> +#endif /* _SECURITY_LANDLOCK_ID_H */
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index 28519a45b11f..d297083efcb1 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -13,6 +13,7 @@
>  #include "common.h"
>  #include "cred.h"
>  #include "fs.h"
> +#include "id.h"
>  #include "net.h"
>  #include "setup.h"
>  #include "task.h"
> @@ -33,6 +34,7 @@ const struct lsm_id landlock_lsmid =3D {
>=20
>  static int __init landlock_init(void)
>  {
> +	landlock_init_id();
>  	landlock_add_cred_hooks();
>  	landlock_add_task_hooks();
>  	landlock_add_fs_hooks();
> diff --git a/tools/testing/kunit/configs/all_tests.config
> b/tools/testing/kunit/configs/all_tests.config index
> b3b00269a52a..ea1f824ae70f 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -44,6 +44,8 @@ CONFIG_DAMON_DBGFS_DEPRECATED=3Dy
>=20
>  CONFIG_REGMAP_BUILD=3Dy
>=20
> +CONFIG_AUDIT=3Dy
> +
>  CONFIG_SECURITY=3Dy
>  CONFIG_SECURITY_APPARMOR=3Dy
>  CONFIG_SECURITY_LANDLOCK=3Dy

Best regards.


