Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0007276026
	for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047634; cv=none; b=QwGgCgFk+Ub4HRJuaUiH0nCA6U77EEOJSAPzpvHppAvJRkJopPglXF8oz1w9e/dGHjF0+mk1+Pu2PjyphQDoquuVlGuyLV6w/+/mKN/FMKCzvwck9VRItmmZcTn7qMFbQRGq1GVQ8R9LsJNM33rgK1z4kKX+nSu05Z/5TEtW8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047634; c=relaxed/simple;
	bh=AEFbW1ywfYTW+GjxH8IL0gQ8bPI3y/MENbOZAOyHRhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QdLlXBZaCs4fY74uK0OKe6En3r4Jj015Ei4jQ1YTgJfclyt936kBxZkYkIY7am+tplDqreSXLen8ghv0UQbmyo7xMus+VjyfpnWr8Om1dryVGAv0YYNXqn9UDVBAsElhDsa3hNvqEIzwwSLD2uI4gKn05erbwlAwt0q8t7iVVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxAWrIdL; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxAWrIdL"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5f62cbc6d5cso4347554a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 04:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747047631; x=1747652431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzE+CeGC4cBk1T8TUfMB6R/c9EYPPFN0mDRYYWLWrkQ=;
        b=XxAWrIdLgwJNO0qJLOIyeLxoEfZ5DB54oq5qi+1nFUkJt9XMrKa3jbBfdgavTXBKY2
         w0uhjYTjCHGrlIK7kUpOsL9eov5z+wgQ0VixfGht6v4B5vSDjLqjXokL5O18pl/6e7NT
         0FsFIyk4dJgdN1c4KrDIeoAQQRmpY60MTXm1Y7b0RybocJUpuYKanVdNqWUatQMwIAni
         f81BrvsTyplxWH26wJ0HQ3kW9dpCWww8I55/Vffbss3yPtJ0NxIpJL9IA+EEMXaFrWRr
         YkwU28gLv51nVweq9p9jLAkp07/aj/tPjwFCD+lLGhhL1mqrBiDkj+vjgbCmF0fjb3Rw
         jChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747047631; x=1747652431;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qzE+CeGC4cBk1T8TUfMB6R/c9EYPPFN0mDRYYWLWrkQ=;
        b=YDp/3J7yYikJxSy3Qhl2+PABj1HJJNNnylYpagF7pgMSS9I+04cetIu6EID5VfLur9
         vLjvhTmvNdQKWiK83EB9A+qt36Wzt8HbMKq7HoDV7hgbWq2h7cmSOX415MxdWxhNZ8M5
         VikzW+L8zx3eeP7nrrO7tYupGCzZMnvKFFNdl14cKIs/fLaAYtYAhenwGdZvHsxsextD
         Qdzi7VGHVtUALUPRT7hK3NDcO4FOTzlaceauSKxLqe0mXSp0E+c935YJyOBckPmv6vzQ
         VlqnbcVU2eI8k34v/pMefqZX3ps7NmXJTDDFkTgsj6FM8aueomP9Uiv0QOvgccZ/MjJo
         Vl7g==
X-Gm-Message-State: AOJu0Yw+PtqpdNPjn/IQwjw9w6vIHZl7cC2YxlRUmJrSBMrQLLvzdos7
	oETyANu5brq6V4za8DzOG80fQ/vk6S6JWnfdUYzpDxB74jB1Y+rblR9LlIY6HDOo3kcr4TAYAZM
	tRA==
X-Google-Smtp-Source: AGHT+IHRMqhpnP8nbps8MRWJtQaZZaj+BfpXZBHCJvPR2pM1hkrMeCFK5NeMWF8/mk/pRlMpoBf89rceUkM=
X-Received: from edbet8.prod.google.com ([2002:a05:6402:3788:b0:5fb:f293:d540])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4301:b0:5fe:a303:a6a3
 with SMTP id 4fb4d7f45d1cf-5fea303a6b9mr1350135a12.23.1747047631177; Mon, 12
 May 2025 04:00:31 -0700 (PDT)
Date: Mon, 12 May 2025 11:00:28 +0000
In-Reply-To: <20250512093732.1408485-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512093732.1408485-1-mic@digikod.net>
Message-ID: <aCHUzDJ4HzqGlL1l@google.com>
Subject: Re: [PATCH v2] landlock: Improve bit operations in audit code
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack3000@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:37:30AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Use the BIT() and BIT_ULL() macros in the new audit code instead of
> explicit shifts to improve readability.  Use bitmask instead of modulo
> operation to simplify code.
>=20
> Add test_range1_rand15() and test_range2_rand15() KUnit tests to improve
> get_id_range() coverage.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>=20
> Changes since v1:
> https://lore.kernel.org/r/20250507185404.1029055-1-mic@digikod.net
> - Use bitmask instead of modulo operation to simplify random value
>   truncation, suggested by G=C3=BCnther.
> - Add KUnit tests.
> ---
>  security/landlock/audit.c    |  2 +-
>  security/landlock/id.c       | 33 +++++++++++++++++++++++++++++++--
>  security/landlock/syscalls.c |  3 ++-
>  3 files changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 58d5c40d4d0e..c52d079cdb77 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -437,7 +437,7 @@ void landlock_log_denial(const struct landlock_cred_s=
ecurity *const subject,
>  		return;
> =20
>  	/* Checks if the current exec was restricting itself. */
> -	if (subject->domain_exec & (1 << youngest_layer)) {
> +	if (subject->domain_exec & BIT(youngest_layer)) {
>  		/* Ignores denials for the same execution. */
>  		if (!youngest_denied->log_same_exec)
>  			return;
> diff --git a/security/landlock/id.c b/security/landlock/id.c
> index 11fab9259c15..56f7cc0fc744 100644
> --- a/security/landlock/id.c
> +++ b/security/landlock/id.c
> @@ -7,6 +7,7 @@
> =20
>  #include <kunit/test.h>
>  #include <linux/atomic.h>
> +#include <linux/bitops.h>
>  #include <linux/random.h>
>  #include <linux/spinlock.h>
> =20
> @@ -25,7 +26,7 @@ static void __init init_id(atomic64_t *const counter, c=
onst u32 random_32bits)
>  	 * Ensures sure 64-bit values are always used by user space (or may
>  	 * fail with -EOVERFLOW), and makes this testable.
>  	 */
> -	init =3D 1ULL << 32;
> +	init =3D BIT_ULL(32);
> =20
>  	/*
>  	 * Makes a large (2^32) boot-time value to limit ID collision in logs
> @@ -105,7 +106,7 @@ static u64 get_id_range(size_t number_of_ids, atomic6=
4_t *const counter,
>  	 * to get a new ID (e.g. a full landlock_restrict_self() call), and the
>  	 * cost of draining all available IDs during the system's uptime.
>  	 */
> -	random_4bits =3D random_4bits % (1 << 4);
> +	random_4bits &=3D 0b1111;
>  	step =3D number_of_ids + random_4bits;
> =20
>  	/* It is safe to cast a signed atomic to an unsigned value. */
> @@ -144,6 +145,19 @@ static void test_range1_rand1(struct kunit *const te=
st)
>  		init + 2);
>  }
> =20
> +static void test_range1_rand15(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 15), init);
> +	KUNIT_EXPECT_EQ(
> +		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> +		init + 16);
> +}
> +
>  static void test_range1_rand16(struct kunit *const test)
>  {
>  	atomic64_t counter;
> @@ -196,6 +210,19 @@ static void test_range2_rand2(struct kunit *const te=
st)
>  		init + 4);
>  }
> =20
> +static void test_range2_rand15(struct kunit *const test)
> +{
> +	atomic64_t counter;
> +	u64 init;
> +
> +	init =3D get_random_u32();
> +	atomic64_set(&counter, init);
> +	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 15), init);
> +	KUNIT_EXPECT_EQ(
> +		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> +		init + 17);
> +}
> +
>  static void test_range2_rand16(struct kunit *const test)
>  {
>  	atomic64_t counter;
> @@ -232,10 +259,12 @@ static struct kunit_case __refdata test_cases[] =3D=
 {
>  	KUNIT_CASE(test_init_once),
>  	KUNIT_CASE(test_range1_rand0),
>  	KUNIT_CASE(test_range1_rand1),
> +	KUNIT_CASE(test_range1_rand15),
>  	KUNIT_CASE(test_range1_rand16),
>  	KUNIT_CASE(test_range2_rand0),
>  	KUNIT_CASE(test_range2_rand1),
>  	KUNIT_CASE(test_range2_rand2),
> +	KUNIT_CASE(test_range2_rand15),
>  	KUNIT_CASE(test_range2_rand16),
>  	{}
>  	/* clang-format on */
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index b9561e3417ae..33eafb71e4f3 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -9,6 +9,7 @@
> =20
>  #include <asm/current.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/bitops.h>
>  #include <linux/build_bug.h>
>  #include <linux/capability.h>
>  #include <linux/cleanup.h>
> @@ -563,7 +564,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ru=
leset_fd, const __u32,
>  	new_llcred->domain =3D new_dom;
> =20
>  #ifdef CONFIG_AUDIT
> -	new_llcred->domain_exec |=3D 1 << (new_dom->num_layers - 1);
> +	new_llcred->domain_exec |=3D BIT(new_dom->num_layers - 1);
>  #endif /* CONFIG_AUDIT */
> =20
>  	return commit_creds(new_cred);
> --=20
> 2.49.0
>=20

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
