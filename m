Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29C1F95C;
	Mon, 28 Jul 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706982; cv=none; b=eEXXaJ/F7sNpsmn/nCZFQNb/QmgyTdfLXi+4lkjJ5AxFPFEqWwiolNU9JUBXI3tOTt3xtfzrWzt8TrWMHOZoSJ+ersRkv/0Jb5Mx3xiocdjil0v/S1fGY3k2eZozmb9PWTajeRfKRzCIGFoGL4I0iJ8+U0FTTFZtmrOYCdduDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706982; c=relaxed/simple;
	bh=H9qXRbx94MewBNxrR4fM5mh6/UQ6BbG5/scOH9fENcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGgaj0E7Z1JSDkHQFaeP2JEFAJCGid/Q/llOq3N59W+gjvuoqe6YZ1DMFDyQdY4N/YUon9Fz/etqCSw/t+WcuXW6755jhpreFPJibPE+WZUozzOO/4uKfGIonEulnvenhu3QNRYqKtFbmN0AJdTIcnI6NZGPK1uGvYlptWsiXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 130E5357; Mon, 28 Jul 2025 07:49:37 -0500 (CDT)
Date: Mon, 28 Jul 2025 07:49:37 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
Message-ID: <aIdx4Y/lRYKs/quV@mail.hallyn.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <20250728111517.134116-3-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728111517.134116-3-nik.borisov@suse.com>

On Mon, Jul 28, 2025 at 02:15:16PM +0300, Nikolay Borisov wrote:
> Add a bunch of tests to ensure lockdown's conversion to bitmap hasn't
> regressed it.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

(And I see this answers my question to patch 1, but still a comment
there would be nice :)

thanks,
-serge

> ---
>  security/lockdown/Kconfig         |  5 +++
>  security/lockdown/Makefile        |  1 +
>  security/lockdown/lockdown.c      |  5 ++-
>  security/lockdown/lockdown_test.c | 54 +++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 1 deletion(-)
>  create mode 100644 security/lockdown/lockdown_test.c
> 
> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> index e84ddf484010..5fb750da1f8c 100644
> --- a/security/lockdown/Kconfig
> +++ b/security/lockdown/Kconfig
> @@ -6,6 +6,11 @@ config SECURITY_LOCKDOWN_LSM
>  	  Build support for an LSM that enforces a coarse kernel lockdown
>  	  behaviour.
>  
> +config SECURITY_LOCKDOWN_LSM_TEST
> +	tristate "Test lockdown functionality" if !KUNIT_ALL_TESTS
> +	depends on SECURITY_LOCKDOWN_LSM && KUNIT
> +	default KUNIT_ALL_TESTS
> +
>  config SECURITY_LOCKDOWN_LSM_EARLY
>  	bool "Enable lockdown LSM early in init"
>  	depends on SECURITY_LOCKDOWN_LSM
> diff --git a/security/lockdown/Makefile b/security/lockdown/Makefile
> index e3634b9017e7..f35d90e39f1c 100644
> --- a/security/lockdown/Makefile
> +++ b/security/lockdown/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM) += lockdown.o
> +obj-$(CONFIG_SECURITY_LOCKDOWN_LSM_TEST) += lockdown_test.o
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 5014d18c423f..412184121279 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -25,7 +25,10 @@ static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
>  /*
>   * Put the kernel into lock-down mode.
>   */
> -static int lock_kernel_down(const char *where, enum lockdown_reason level)
> +#if !IS_ENABLED(CONFIG_KUNIT)
> +static
> +#endif
> +int lock_kernel_down(const char *where, enum lockdown_reason level)
>  {
>  
>  	if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
> diff --git a/security/lockdown/lockdown_test.c b/security/lockdown/lockdown_test.c
> new file mode 100644
> index 000000000000..3a3c6db5b470
> --- /dev/null
> +++ b/security/lockdown/lockdown_test.c
> @@ -0,0 +1,54 @@
> +#include <linux/security.h>
> +#include <kunit/test.h>
> +
> +int lock_kernel_down(const char *where, enum lockdown_reason level);
> +
> +static void lockdown_test_invalid_level(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, -EINVAL, lock_kernel_down("TEST", LOCKDOWN_CONFIDENTIALITY_MAX+1));
> +}
> +
> +static void lockdown_test_depth_locking(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_INTEGRITY_MAX));
> +	for (int i = 1; i < LOCKDOWN_INTEGRITY_MAX; i++)
> +		KUNIT_EXPECT_EQ_MSG(test, -EPERM, security_locked_down(i), "at i=%d", i);
> +
> +	KUNIT_EXPECT_EQ(test, -EPERM, security_locked_down(LOCKDOWN_INTEGRITY_MAX));
> +}
> +
> +static void lockdown_test_individual_level(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_PERF));
> +	KUNIT_EXPECT_EQ(test, -EPERM, security_locked_down(LOCKDOWN_PERF));
> +	/* Ensure adjacent levels are untouched */
> +	KUNIT_EXPECT_EQ(test, 0, security_locked_down(LOCKDOWN_TRACEFS));
> +	KUNIT_EXPECT_EQ(test, 0, security_locked_down(LOCKDOWN_DBG_READ_KERNEL));
> +}
> +
> +static void lockdown_test_no_downgrade(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_CONFIDENTIALITY_MAX));
> +	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_INTEGRITY_MAX));
> +	/*
> +	 * Ensure having locked down to a lower leve after a higher level
> +	 * lockdown nothing is lost
> +	 */
> +	KUNIT_EXPECT_EQ(test, -EPERM, security_locked_down(LOCKDOWN_TRACEFS));
> +}
> +
> +static struct kunit_case lockdown_tests[] = {
> +	KUNIT_CASE(lockdown_test_invalid_level),
> +	KUNIT_CASE(lockdown_test_depth_locking),
> +	KUNIT_CASE(lockdown_test_individual_level),
> +	KUNIT_CASE(lockdown_test_no_downgrade),
> +	{}
> +};
> +
> +static struct kunit_suite lockdown_test_suite = {
> +	.name = "lockdown test",
> +	.test_cases = lockdown_tests,
> +};
> +kunit_test_suite(lockdown_test_suite);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
