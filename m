Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477791F7547;
	Fri, 25 Oct 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869840; cv=none; b=Hf00SYfo/LAAsMc5o8jhhYZ6BtQZKP5BpDp7vWOQ+hgbAwJIs4zSA33+wHWfYCNhaZ4fwMAx6t4KsD8tnNIkPEv1g+6cQq/UiUx/nbnPiByWrZzWuTEGu9bKX9YtXWnKpmjVXqAw+g8iu8SFFoyBbZLiwM/xGqAh7zICpGUVzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869840; c=relaxed/simple;
	bh=LPe9PDDHsb1edCu1M8o7YlZyo8qGP77hiMrydhq7oxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8WGe7kORbholvqNySK4kQBMu8eMxm1Gzen9Lt7ofJd5B7PfPQMEgvnM5F8q0jTZUoR/ibAQamcxJvVjl7ZrtRB8GrX+Arot+HdxkFbxDvG8xhsx9Zeb3snMNCFSjmROgH9W1PPCaGDtWi2pMezLSfZL3eyvwU8YOO/k6MGLzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iyPz6Hs9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iyPz6Hs9"
Received: from pwmachine.localnet (84-115-216-151.cable.dynamic.surfer.at [84.115.216.151])
	by linux.microsoft.com (Postfix) with ESMTPSA id 15F9A211A5AF;
	Fri, 25 Oct 2024 08:23:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15F9A211A5AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729869836;
	bh=C8hQTH5DteYO9ta8j0G7ZbJVPnF04IeGGSRGN0H5rmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyPz6Hs9vOcNz4U9hoWZ/jDFnMONjsWMwvGU7aQd7Sb69URqqH7UT+AR7jcKNBQj/
	 VIFSCfmIi1BYNBfrj+P//05f2MPprLJxH6YC+/JIjXTn8PnQCfRzaAwk/U0038Njmc
	 oL0XgulGpZfi+g8mBrbxgq53YKi3gA1MxROWlW/s=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/14] landlock: Log file-related denials
Date: Fri, 25 Oct 2024 17:23:48 +0200
Message-ID: <8501854.T7Z3S40VBb@pwmachine>
In-Reply-To: <20241022161009.982584-11-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-11-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le mardi 22 octobre 2024, 18:10:05 CEST Micka=EBl Sala=FCn a =E9crit :
> Add audit support for path_mkdir, path_mknod, path_symlink, path_unlink,
> path_rmdir, path_truncate, path_link, path_rename, and file_open hooks.
>=20
> Audit record sample for a link action:
>=20
>   DENY:     domain=3D4533720568 blockers=3Dfs_refer path=3D"/usr/bin" dev=
=3D"vda2"
> ino=3D351 DOM_INFO: domain=3D4533720568 parent=3D0 pid=3D325 uid=3D0
> exe=3D"/root/sandboxer" comm=3D"sandboxer" DENY:     domain=3D4533720568
> blockers=3Dfs_make_reg,fs_refer path=3D"/usr/local" dev=3D"vda2" ino=3D36=
5 SYSCALL:
>  arch=3Dc000003e syscall=3D265 success=3Dno exit=3D-13 ...
>=20
> Cc: G=FCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022161009.982584-11-mic@digikod.net
> ---
>=20
> Changes since v2:
> * Revamp logging and support the path_link and path_rename hooks.
> * Add KUnit tests.
>=20
> Changes since v1:
> * Move audit code to the ptrace patch.
> ---
>  security/landlock/audit.c | 173 ++++++++++++++++++++++++++++++++++++--
>  security/landlock/audit.h |   9 ++
>  security/landlock/fs.c    |  64 +++++++++++---
>  3 files changed, 229 insertions(+), 17 deletions(-)
>=20
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 4cd9407459d2..9c8b6c246884 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -7,23 +7,55 @@
>=20
>  #include <kunit/test.h>
>  #include <linux/audit.h>
> +#include <linux/bitops.h>
>  #include <linux/lsm_audit.h>
>  #include <linux/pid.h>
>  #include <linux/uidgid.h>
> +#include <uapi/linux/landlock.h>
>=20
>  #include "audit.h"
> +#include "common.h"
>  #include "cred.h"
>  #include "domain.h"
>  #include "ruleset.h"
>=20
> -static const char *get_blocker(const enum landlock_request_type type)
> +static const char *const fs_access_strings[] =3D {
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D "fs_execute",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] =3D "fs_write_file",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] =3D "fs_read_file",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] =3D "fs_read_dir",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] =3D "fs_remove_dir",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_FILE)] =3D "fs_remove_file",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_CHAR)] =3D "fs_make_char",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_DIR)] =3D "fs_make_dir",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] =3D "fs_make_reg",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SOCK)] =3D "fs_make_sock",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_FIFO)] =3D "fs_make_fifo",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_BLOCK)] =3D "fs_make_block",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SYM)] =3D "fs_make_sym",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] =3D "fs_refer",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] =3D "fs_truncate",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] =3D "fs_ioctl_dev",
> +};
> +static_assert(ARRAY_SIZE(fs_access_strings) =3D=3D LANDLOCK_NUM_ACCESS_F=
S);
> +
> +static __attribute_const__ const char *
> +get_blocker(const enum landlock_request_type type,
> +	    const unsigned long access_bit)
>  {
>  	switch (type) {
>  	case LANDLOCK_REQUEST_PTRACE:
> +		WARN_ON_ONCE(access_bit !=3D -1);
>  		return "ptrace";
>=20
>  	case LANDLOCK_REQUEST_FS_CHANGE_LAYOUT:
> +		WARN_ON_ONCE(access_bit !=3D -1);
>  		return "fs_change_layout";
> +
> +	case LANDLOCK_REQUEST_FS_ACCESS:
> +		if (WARN_ON_ONCE(access_bit >=3D ARRAY_SIZE(fs_access_strings)))
> +			return "unknown";
> +		return fs_access_strings[access_bit];
>  	}
>=20
>  	WARN_ON_ONCE(1);
> @@ -31,9 +63,20 @@ static const char *get_blocker(const enum
> landlock_request_type type) }
>=20
>  static void log_blockers(struct audit_buffer *const ab,
> -			 const enum landlock_request_type type)
> +			 const enum landlock_request_type type,
> +			 const access_mask_t access)
>  {
> -	audit_log_format(ab, "%s", get_blocker(type));
> +	const unsigned long access_mask =3D access;
> +	unsigned long access_bit;
> +	size_t i =3D 0;
> +
> +	for_each_set_bit(access_bit, &access_mask, BITS_PER_TYPE(access)) {
> +		audit_log_format(ab, "%s%s", (i =3D=3D 0) ? "" : ",",
> +				 get_blocker(type, access_bit));
> +		i++;
> +	}
> +	if (i =3D=3D 0)
> +		audit_log_format(ab, "%s", get_blocker(type, -1));
>  }
>=20
>  static void log_node(struct landlock_hierarchy *const node)
> @@ -121,9 +164,110 @@ static void test_get_hierarchy(struct kunit *const
> test)
>=20
>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
>=20
> +static size_t get_denied_layer(const struct landlock_ruleset *const doma=
in,
> +			       access_mask_t *const access_request,
> +			       const layer_mask_t (*const layer_masks)[],
> +			       const size_t layer_masks_size)
> +{
> +	const unsigned long access_req =3D *access_request;

Nit: should access_request being checked for not being NULL?

> +	unsigned long access_bit;
> +	access_mask_t missing =3D 0;
> +	long youngest_layer =3D -1;
> +
> +	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> +		const access_mask_t mask =3D (*layer_masks)[access_bit];
> +		long layer;
> +
> +		if (!mask)
> +			continue;
> +
> +		/* __fls(1) =3D=3D 0 */
> +		layer =3D __fls(mask);
> +		if (layer > youngest_layer) {
> +			youngest_layer =3D layer;
> +			missing =3D BIT(access_bit);
> +		} else if (layer =3D=3D youngest_layer) {
> +			missing |=3D BIT(access_bit);
> +		}
> +	}
> +
> +	*access_request =3D missing;
> +	if (youngest_layer =3D=3D -1)
> +		return domain->num_layers - 1;
> +
> +	return youngest_layer;
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_get_denied_layer(struct kunit *const test)
> +{
> +	const struct landlock_ruleset dom =3D {
> +		.num_layers =3D 5,
> +	};
> +	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT(0),
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] =3D BIT(1),
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] =3D BIT(1) | BIT(0),
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] =3D BIT(2),
> +	};
> +	access_mask_t access;
> +
> +	access =3D LANDLOCK_ACCESS_FS_EXECUTE;
> +	KUNIT_EXPECT_EQ(test, 0,
> +			get_denied_layer(&dom, &access, &layer_masks,
> +					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_EXECUTE);
> +
> +	access =3D LANDLOCK_ACCESS_FS_READ_FILE;
> +	KUNIT_EXPECT_EQ(test, 1,
> +			get_denied_layer(&dom, &access, &layer_masks,
> +					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_FILE);
> +
> +	access =3D LANDLOCK_ACCESS_FS_READ_DIR;
> +	KUNIT_EXPECT_EQ(test, 1,
> +			get_denied_layer(&dom, &access, &layer_masks,
> +					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
> +
> +	access =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR;
> +	KUNIT_EXPECT_EQ(test, 1,
> +			get_denied_layer(&dom, &access, &layer_masks,
> +					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, access,
> +			LANDLOCK_ACCESS_FS_READ_FILE |
> +				LANDLOCK_ACCESS_FS_READ_DIR);
> +
> +	access =3D LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_READ_DIR;
> +	KUNIT_EXPECT_EQ(test, 1,
> +			get_denied_layer(&dom, &access, &layer_masks,
> +					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
> +
> +	access =3D LANDLOCK_ACCESS_FS_WRITE_FILE;
> +	KUNIT_EXPECT_EQ(test, 4,
> +			get_denied_layer(&dom, &access, &layer_masks,
> +					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, access, 0);
> +}
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> +
>  static bool is_valid_request(const struct landlock_request *const reques=
t)
>  {
> -	if (WARN_ON_ONCE(!request->layer_plus_one))
> +	if (WARN_ON_ONCE(!(!!request->layer_plus_one ^ !!request->access)))
> +		return false;
> +
> +	if (request->access) {
> +		if (WARN_ON_ONCE(!request->layer_masks))
> +			return false;
> +	} else {
> +		if (WARN_ON_ONCE(request->layer_masks))
> +			return false;
> +	}
> +
> +	if (WARN_ON_ONCE(!!request->layer_masks ^ !!request-
>layer_masks_size))
>  		return false;
>=20
>  	return true;
> @@ -140,6 +284,7 @@ void landlock_log_denial(const struct landlock_ruleset
> *const domain, {
>  	struct audit_buffer *ab;
>  	struct landlock_hierarchy *youngest_denied;
> +	access_mask_t missing;
>=20
>  	if (WARN_ON_ONCE(!domain || !domain->hierarchy || !request))
>  		return;
> @@ -155,9 +300,24 @@ void landlock_log_denial(const struct landlock_rules=
et
> *const domain, if (!ab)
>  		return;
>=20
> -	youngest_denied =3D get_hierarchy(domain, request->layer_plus_one - 1);
> +	missing =3D request->access;
> +	if (missing) {
> +		size_t youngest_layer;
> +
> +		/* Gets the nearest domain that denies the request. */
> +		if (request->layer_masks) {
> +			youngest_layer =3D get_denied_layer(
> +				domain, &missing, request->layer_masks,
> +				request->layer_masks_size);
> +		}
> +		youngest_denied =3D get_hierarchy(domain, youngest_layer);

If request->layer_masks is 0, it is possible to call get_hierarchy() with
uninitialized youngest_layer, is this wanted?

> +	} else {
> +		youngest_denied =3D
> +			get_hierarchy(domain, request->layer_plus_one - 1);
> +	}
> +
>  	audit_log_format(ab, "domain=3D%llu blockers=3D", youngest_denied->id);
> -	log_blockers(ab, request->type);
> +	log_blockers(ab, request->type, missing);
>  	audit_log_lsm_data(ab, &request->audit);
>  	audit_log_end(ab);
>=20
> @@ -204,6 +364,7 @@ void landlock_log_drop_domain(const struct
> landlock_ruleset *const domain) static struct kunit_case test_cases[] =3D=
 {
>  	/* clang-format off */
>  	KUNIT_CASE(test_get_hierarchy),
> +	KUNIT_CASE(test_get_denied_layer),
>  	{}
>  	/* clang-format on */
>  };
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 6f5ad04b83c2..25fc8333cddc 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -11,11 +11,13 @@
>  #include <linux/audit.h>
>  #include <linux/lsm_audit.h>
>=20
> +#include "access.h"
>  #include "ruleset.h"
>=20
>  enum landlock_request_type {
>  	LANDLOCK_REQUEST_PTRACE =3D 1,
>  	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
> +	LANDLOCK_REQUEST_FS_ACCESS,
>  };
>=20
>  /*
> @@ -33,6 +35,13 @@ struct landlock_request {
>  	 * extra one is useful to detect uninitialized field.
>  	 */
>  	size_t layer_plus_one;
> +
> +	/* Required field for configurable access control. */
> +	access_mask_t access;
> +
> +	/* Required fields for requests with layer masks. */
> +	const layer_mask_t (*layer_masks)[];
> +	size_t layer_masks_size;
>  };
>=20
>  #ifdef CONFIG_AUDIT
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index a099167d2347..7f69bed9e095 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -730,6 +730,7 @@ static void test_is_eacces_with_write(struct kunit
> *const test) *     those identified by @access_request_parent1).  This
> matrix can *     initially refer to domain layer masks and, when the
> accesses for the *     destination and source are the same, to requested
> layer masks. + * @log_request_parent1: Audit request to fill if the relat=
ed
> access is denied. * @dentry_child1: Dentry to the initial child of the
> parent1 path.  This *     pointer must be NULL for non-refer actions (i.e.
> not link nor rename). * @access_request_parent2: Similar to
> @access_request_parent1 but for a @@ -738,6 +739,7 @@ static void
> test_is_eacces_with_write(struct kunit *const test) *     the source.  Mu=
st
> be set to 0 when using a simple path request. * @layer_masks_parent2:
> Similar to @layer_masks_parent1 but for a refer *     action.  This must =
be
> NULL otherwise.
> + * @log_request_parent2: Audit request to fill if the related access is
> denied. * @dentry_child2: Dentry to the initial child of the parent2 path=
=2E=20
> This *     pointer is only set for RENAME_EXCHANGE actions and must be NU=
LL
> *     otherwise.
> @@ -757,10 +759,12 @@ static bool is_access_to_paths_allowed(
>  	const struct path *const path,
>  	const access_mask_t access_request_parent1,
>  	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
> -	const struct dentry *const dentry_child1,
> +	struct landlock_request *const log_request_parent1,
> +	struct dentry *const dentry_child1,
>  	const access_mask_t access_request_parent2,
>  	layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
> -	const struct dentry *const dentry_child2)
> +	struct landlock_request *const log_request_parent2,
> +	struct dentry *const dentry_child2)
>  {
>  	bool allowed_parent1 =3D false, allowed_parent2 =3D false, is_dom_check,
>  	     child1_is_directory =3D true, child2_is_directory =3D true;
> @@ -907,6 +911,24 @@ static bool is_access_to_paths_allowed(
>  	}
>  	path_put(&walker_path);
>=20
> +	if (!allowed_parent1 && log_request_parent1) {
> +		log_request_parent1->type =3D LANDLOCK_REQUEST_FS_ACCESS,
> +		log_request_parent1->audit.type =3D LSM_AUDIT_DATA_PATH,
> +		log_request_parent1->audit.u.path =3D *path;
> +		log_request_parent1->access =3D access_request_parent1;
> +		log_request_parent1->layer_masks =3D layer_masks_parent1;
> +		log_request_parent1->layer_masks_size =3D
> +			ARRAY_SIZE(*layer_masks_parent1);
> +	}
> +	if (!allowed_parent2 && log_request_parent2) {
> +		log_request_parent2->type =3D LANDLOCK_REQUEST_FS_ACCESS,
> +		log_request_parent2->audit.type =3D LSM_AUDIT_DATA_PATH,
> +		log_request_parent2->audit.u.path =3D *path;
> +		log_request_parent2->access =3D access_request_parent2;
> +		log_request_parent2->layer_masks =3D layer_masks_parent2;
> +		log_request_parent2->layer_masks_size =3D
> +			ARRAY_SIZE(*layer_masks_parent2);
> +	}

You may want to add a function to set these fields in log_request.

>  	return allowed_parent1 && allowed_parent2;
>  }
>=20
> @@ -915,6 +937,7 @@ static int current_check_access_path(const struct path
> *const path, {
>  	const struct landlock_ruleset *const dom =3D get_current_fs_domain();
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> +	struct landlock_request request =3D {};
>=20
>  	if (!dom)
>  		return 0;
> @@ -922,9 +945,10 @@ static int current_check_access_path(const struct pa=
th
> *const path, access_request =3D landlock_init_layer_masks(
>  		dom, access_request, &layer_masks, LANDLOCK_KEY_INODE);
>  	if (is_access_to_paths_allowed(dom, path, access_request,=20
&layer_masks,
> -				       NULL, 0, NULL, NULL))
> +				       &request, NULL, 0, NULL, NULL, NULL))
>  		return 0;
>=20
> +	landlock_log_denial(dom, &request);
>  	return -EACCES;
>  }
>=20
> @@ -1093,6 +1117,7 @@ static int current_check_refer_path(struct dentry
> *const old_dentry, struct dentry *old_parent;
>  	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] =3D {},
>  		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] =3D {};
> +	struct landlock_request request1 =3D {}, request2 =3D {};
>=20
>  	if (!dom)
>  		return 0;
> @@ -1124,10 +1149,13 @@ static int current_check_refer_path(struct dentry
> *const old_dentry, access_request_parent1 =3D landlock_init_layer_masks(
>  			dom, access_request_parent1 | access_request_parent2,
>  			&layer_masks_parent1, LANDLOCK_KEY_INODE);
> -		if (is_access_to_paths_allowed(
> -			    dom, new_dir, access_request_parent1,
> -			    &layer_masks_parent1, NULL, 0, NULL, NULL))
> +		if (is_access_to_paths_allowed(dom, new_dir,
> +					       access_request_parent1,
> +					       &layer_masks_parent1, &request1,
> +					       NULL, 0, NULL, NULL, NULL))
>  			return 0;
> +
> +		landlock_log_denial(dom, &request1);
>  		return -EACCES;
>  	}
>=20
> @@ -1162,12 +1190,22 @@ static int current_check_refer_path(struct dentry
> *const old_dentry, * parent access rights.  This will be useful to compare
> with the * destination parent access rights.
>  	 */
> -	if (is_access_to_paths_allowed(
> -		    dom, &mnt_dir, access_request_parent1,=20
&layer_masks_parent1,
> -		    old_dentry, access_request_parent2, &layer_masks_parent2,
> -		    exchange ? new_dentry : NULL))
> +	if (is_access_to_paths_allowed(dom, &mnt_dir, access_request_parent1,
> +				       &layer_masks_parent1, &request1,
> +				       old_dentry, access_request_parent2,
> +				       &layer_masks_parent2, &request2,
> +				       exchange ? new_dentry : NULL))
>  		return 0;
>=20
> +	if (request1.access) {
> +		request1.audit.u.path.dentry =3D old_parent;
> +		landlock_log_denial(dom, &request1);
> +	}
> +	if (request2.access) {
> +		request2.audit.u.path.dentry =3D new_dir->dentry;
> +		landlock_log_denial(dom, &request2);
> +	}
> +
>  	/*
>  	 * This prioritizes EACCES over EXDEV for all actions, including
>  	 * renames with RENAME_EXCHANGE.
> @@ -1546,6 +1584,7 @@ static int hook_file_open(struct file *const file)
>  		optional_access;
>  	const struct landlock_ruleset *const dom =3D landlock_match_ruleset(
>  		landlock_cred(file->f_cred)->domain, any_fs);
> +	struct landlock_request request =3D {};
>=20
>  	if (!dom)
>  		return 0;
> @@ -1571,7 +1610,7 @@ static int hook_file_open(struct file *const file)
>  		    dom, &file->f_path,
>  		    landlock_init_layer_masks(dom, full_access_request,
>  					      &layer_masks, LANDLOCK_KEY_INODE),
> -		    &layer_masks, NULL, 0, NULL, NULL)) {
> +		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
>  		allowed_access =3D full_access_request;
>  	} else {
>  		unsigned long access_bit;
> @@ -1601,6 +1640,9 @@ static int hook_file_open(struct file *const file)
>  	if ((open_access_request & allowed_access) =3D=3D open_access_request)
>  		return 0;
>=20
> +	/* Sets access to reflect the actual request. */
> +	request.access =3D open_access_request;
> +	landlock_log_denial(dom, &request);
>  	return -EACCES;
>  }


