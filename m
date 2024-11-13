Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54370835
	for <linux-security-module@vger.kernel.org>; Wed, 13 Nov 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511303; cv=none; b=GQUcquS00R189dkalPmI7F2SutrADCsS4MYgi36jeVII55N1Hb52yqBJx/3gtXkw8IRKRj3k5p62UJ5trcwkauO6qyzWih8Cf1ZWkHVSmxWby3oQKLWTZelwIiaLD8qtu21tSTt0HwDjiW5dCnjH+ppPy1QmK+BMH/feCUzXTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511303; c=relaxed/simple;
	bh=WGghjI6cThBnu0b5EM2jNNMbAl6iCF8Cs8L4IKBgifA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=banehVBCkGHPRGOA0vPbNaTjUO/0EhwtQ4emVnMgCiSPghp8VFPcsqj3JmkAQRKJZVQKMEoWJnCPsX9SiFvpBKDGRKnE8tOcIsQRwKitsLSmNm/54akDq3xG7nDcU7FRlGnWzFF/mlYyOABCLaNlfAOPWOOG/l3YhVjbVjdCjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HG1pYTaw; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HG1pYTaw"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XpRp93hfSznj9;
	Wed, 13 Nov 2024 16:21:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731511297;
	bh=YbnAIknfu1TEUOLxVgxcWpBBsI4APXs72jc4RFha1kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG1pYTawMwHq7xn887x4SSi/M5cD4ZqL7tR5WiD7Ux8y7QlgUpSNBpyYHEjiKybUy
	 3ufXxJdQRH2KzAZX65G2oAyhhZUVbd+JxrJ8piq1Vw8TPNMNiaRJucRnV+yiTL5yNA
	 rFwQMiI2JMRCMvgI40XLFWvEj48k4ZlO9CoUmohk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XpRp83bkFzkHH;
	Wed, 13 Nov 2024 16:21:36 +0100 (CET)
Date: Wed, 13 Nov 2024 16:21:35 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/14] landlock: Log file-related denials
Message-ID: <20241113.Sheez6xieyij@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
 <20241022161009.982584-11-mic@digikod.net>
 <8501854.T7Z3S40VBb@pwmachine>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8501854.T7Z3S40VBb@pwmachine>
X-Infomaniak-Routing: alpha

On Fri, Oct 25, 2024 at 05:23:48PM +0200, Francis Laniel wrote:
> Le mardi 22 octobre 2024, 18:10:05 CEST Mickaël Salaün a écrit :
> > Add audit support for path_mkdir, path_mknod, path_symlink, path_unlink,
> > path_rmdir, path_truncate, path_link, path_rename, and file_open hooks.
> > 
> > Audit record sample for a link action:
> > 
> >   DENY:     domain=4533720568 blockers=fs_refer path="/usr/bin" dev="vda2"
> > ino=351 DOM_INFO: domain=4533720568 parent=0 pid=325 uid=0
> > exe="/root/sandboxer" comm="sandboxer" DENY:     domain=4533720568
> > blockers=fs_make_reg,fs_refer path="/usr/local" dev="vda2" ino=365 SYSCALL:
> >  arch=c000003e syscall=265 success=no exit=-13 ...
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241022161009.982584-11-mic@digikod.net
> > ---
> > 
> > Changes since v2:
> > * Revamp logging and support the path_link and path_rename hooks.
> > * Add KUnit tests.
> > 
> > Changes since v1:
> > * Move audit code to the ptrace patch.
> > ---
> >  security/landlock/audit.c | 173 ++++++++++++++++++++++++++++++++++++--
> >  security/landlock/audit.h |   9 ++
> >  security/landlock/fs.c    |  64 +++++++++++---
> >  3 files changed, 229 insertions(+), 17 deletions(-)
> > 
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index 4cd9407459d2..9c8b6c246884 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -7,23 +7,55 @@
> > 
> >  #include <kunit/test.h>
> >  #include <linux/audit.h>
> > +#include <linux/bitops.h>
> >  #include <linux/lsm_audit.h>
> >  #include <linux/pid.h>
> >  #include <linux/uidgid.h>
> > +#include <uapi/linux/landlock.h>
> > 
> >  #include "audit.h"
> > +#include "common.h"
> >  #include "cred.h"
> >  #include "domain.h"
> >  #include "ruleset.h"
> > 
> > -static const char *get_blocker(const enum landlock_request_type type)
> > +static const char *const fs_access_strings[] = {
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = "fs_execute",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = "fs_write_file",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = "fs_read_file",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = "fs_read_dir",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = "fs_remove_dir",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_FILE)] = "fs_remove_file",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_CHAR)] = "fs_make_char",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_DIR)] = "fs_make_dir",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = "fs_make_reg",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SOCK)] = "fs_make_sock",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_FIFO)] = "fs_make_fifo",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_BLOCK)] = "fs_make_block",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SYM)] = "fs_make_sym",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs_refer",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs_truncate",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs_ioctl_dev",
> > +};
> > +static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> > +
> > +static __attribute_const__ const char *
> > +get_blocker(const enum landlock_request_type type,
> > +	    const unsigned long access_bit)
> >  {
> >  	switch (type) {
> >  	case LANDLOCK_REQUEST_PTRACE:
> > +		WARN_ON_ONCE(access_bit != -1);
> >  		return "ptrace";
> > 
> >  	case LANDLOCK_REQUEST_FS_CHANGE_LAYOUT:
> > +		WARN_ON_ONCE(access_bit != -1);
> >  		return "fs_change_layout";
> > +
> > +	case LANDLOCK_REQUEST_FS_ACCESS:
> > +		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(fs_access_strings)))
> > +			return "unknown";
> > +		return fs_access_strings[access_bit];
> >  	}
> > 
> >  	WARN_ON_ONCE(1);
> > @@ -31,9 +63,20 @@ static const char *get_blocker(const enum
> > landlock_request_type type) }
> > 
> >  static void log_blockers(struct audit_buffer *const ab,
> > -			 const enum landlock_request_type type)
> > +			 const enum landlock_request_type type,
> > +			 const access_mask_t access)
> >  {
> > -	audit_log_format(ab, "%s", get_blocker(type));
> > +	const unsigned long access_mask = access;
> > +	unsigned long access_bit;
> > +	size_t i = 0;
> > +
> > +	for_each_set_bit(access_bit, &access_mask, BITS_PER_TYPE(access)) {
> > +		audit_log_format(ab, "%s%s", (i == 0) ? "" : ",",
> > +				 get_blocker(type, access_bit));
> > +		i++;
> > +	}
> > +	if (i == 0)
> > +		audit_log_format(ab, "%s", get_blocker(type, -1));
> >  }
> > 
> >  static void log_node(struct landlock_hierarchy *const node)
> > @@ -121,9 +164,110 @@ static void test_get_hierarchy(struct kunit *const
> > test)
> > 
> >  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> > 
> > +static size_t get_denied_layer(const struct landlock_ruleset *const domain,
> > +			       access_mask_t *const access_request,
> > +			       const layer_mask_t (*const layer_masks)[],
> > +			       const size_t layer_masks_size)
> > +{
> > +	const unsigned long access_req = *access_request;
> 
> Nit: should access_request being checked for not being NULL?

This is not necessary because this helper is private and the pointer is
always refering to the stack.

> 
> > +	unsigned long access_bit;
> > +	access_mask_t missing = 0;
> > +	long youngest_layer = -1;
> > +
> > +	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> > +		const access_mask_t mask = (*layer_masks)[access_bit];
> > +		long layer;
> > +
> > +		if (!mask)
> > +			continue;
> > +
> > +		/* __fls(1) == 0 */
> > +		layer = __fls(mask);
> > +		if (layer > youngest_layer) {
> > +			youngest_layer = layer;
> > +			missing = BIT(access_bit);
> > +		} else if (layer == youngest_layer) {
> > +			missing |= BIT(access_bit);
> > +		}
> > +	}
> > +
> > +	*access_request = missing;
> > +	if (youngest_layer == -1)
> > +		return domain->num_layers - 1;
> > +
> > +	return youngest_layer;
> > +}
> > +
> > +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> > +
> > +static void test_get_denied_layer(struct kunit *const test)
> > +{
> > +	const struct landlock_ruleset dom = {
> > +		.num_layers = 5,
> > +	};
> > +	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
> > +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT(0),
> > +		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = BIT(1),
> > +		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = BIT(1) | BIT(0),
> > +		[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = BIT(2),
> > +	};
> > +	access_mask_t access;
> > +
> > +	access = LANDLOCK_ACCESS_FS_EXECUTE;
> > +	KUNIT_EXPECT_EQ(test, 0,
> > +			get_denied_layer(&dom, &access, &layer_masks,
> > +					 sizeof(layer_masks)));
> > +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_EXECUTE);
> > +
> > +	access = LANDLOCK_ACCESS_FS_READ_FILE;
> > +	KUNIT_EXPECT_EQ(test, 1,
> > +			get_denied_layer(&dom, &access, &layer_masks,
> > +					 sizeof(layer_masks)));
> > +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_FILE);
> > +
> > +	access = LANDLOCK_ACCESS_FS_READ_DIR;
> > +	KUNIT_EXPECT_EQ(test, 1,
> > +			get_denied_layer(&dom, &access, &layer_masks,
> > +					 sizeof(layer_masks)));
> > +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
> > +
> > +	access = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR;
> > +	KUNIT_EXPECT_EQ(test, 1,
> > +			get_denied_layer(&dom, &access, &layer_masks,
> > +					 sizeof(layer_masks)));
> > +	KUNIT_EXPECT_EQ(test, access,
> > +			LANDLOCK_ACCESS_FS_READ_FILE |
> > +				LANDLOCK_ACCESS_FS_READ_DIR);
> > +
> > +	access = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_READ_DIR;
> > +	KUNIT_EXPECT_EQ(test, 1,
> > +			get_denied_layer(&dom, &access, &layer_masks,
> > +					 sizeof(layer_masks)));
> > +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
> > +
> > +	access = LANDLOCK_ACCESS_FS_WRITE_FILE;
> > +	KUNIT_EXPECT_EQ(test, 4,
> > +			get_denied_layer(&dom, &access, &layer_masks,
> > +					 sizeof(layer_masks)));
> > +	KUNIT_EXPECT_EQ(test, access, 0);
> > +}
> > +
> > +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> > +
> >  static bool is_valid_request(const struct landlock_request *const request)
> >  {
> > -	if (WARN_ON_ONCE(!request->layer_plus_one))
> > +	if (WARN_ON_ONCE(!(!!request->layer_plus_one ^ !!request->access)))
> > +		return false;
> > +
> > +	if (request->access) {
> > +		if (WARN_ON_ONCE(!request->layer_masks))
> > +			return false;
> > +	} else {
> > +		if (WARN_ON_ONCE(request->layer_masks))
> > +			return false;
> > +	}
> > +
> > +	if (WARN_ON_ONCE(!!request->layer_masks ^ !!request-
> >layer_masks_size))
> >  		return false;
> > 
> >  	return true;
> > @@ -140,6 +284,7 @@ void landlock_log_denial(const struct landlock_ruleset
> > *const domain, {
> >  	struct audit_buffer *ab;
> >  	struct landlock_hierarchy *youngest_denied;
> > +	access_mask_t missing;
> > 
> >  	if (WARN_ON_ONCE(!domain || !domain->hierarchy || !request))
> >  		return;
> > @@ -155,9 +300,24 @@ void landlock_log_denial(const struct landlock_ruleset
> > *const domain, if (!ab)
> >  		return;
> > 
> > -	youngest_denied = get_hierarchy(domain, request->layer_plus_one - 1);
> > +	missing = request->access;
> > +	if (missing) {
> > +		size_t youngest_layer;
> > +
> > +		/* Gets the nearest domain that denies the request. */
> > +		if (request->layer_masks) {
> > +			youngest_layer = get_denied_layer(
> > +				domain, &missing, request->layer_masks,
> > +				request->layer_masks_size);
> > +		}
> > +		youngest_denied = get_hierarchy(domain, youngest_layer);
> 
> If request->layer_masks is 0, it is possible to call get_hierarchy() with
> uninitialized youngest_layer, is this wanted?

Well spotted. This patch seems indeed buggy because I created several
patches touching the same function, but the final code (with all the
patches applied) always initializes youngest_denied.  The current calls
to landlock_log_denial() also always set request->layer_mask, but I'll
fix this patch to avoid confusion.

> 
> > +	} else {
> > +		youngest_denied =
> > +			get_hierarchy(domain, request->layer_plus_one - 1);
> > +	}
> > +
> >  	audit_log_format(ab, "domain=%llu blockers=", youngest_denied->id);
> > -	log_blockers(ab, request->type);
> > +	log_blockers(ab, request->type, missing);
> >  	audit_log_lsm_data(ab, &request->audit);
> >  	audit_log_end(ab);
> > 
> > @@ -204,6 +364,7 @@ void landlock_log_drop_domain(const struct
> > landlock_ruleset *const domain) static struct kunit_case test_cases[] = {
> >  	/* clang-format off */
> >  	KUNIT_CASE(test_get_hierarchy),
> > +	KUNIT_CASE(test_get_denied_layer),
> >  	{}
> >  	/* clang-format on */
> >  };
> > diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> > index 6f5ad04b83c2..25fc8333cddc 100644
> > --- a/security/landlock/audit.h
> > +++ b/security/landlock/audit.h
> > @@ -11,11 +11,13 @@
> >  #include <linux/audit.h>
> >  #include <linux/lsm_audit.h>
> > 
> > +#include "access.h"
> >  #include "ruleset.h"
> > 
> >  enum landlock_request_type {
> >  	LANDLOCK_REQUEST_PTRACE = 1,
> >  	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
> > +	LANDLOCK_REQUEST_FS_ACCESS,
> >  };
> > 
> >  /*
> > @@ -33,6 +35,13 @@ struct landlock_request {
> >  	 * extra one is useful to detect uninitialized field.
> >  	 */
> >  	size_t layer_plus_one;
> > +
> > +	/* Required field for configurable access control. */
> > +	access_mask_t access;
> > +
> > +	/* Required fields for requests with layer masks. */
> > +	const layer_mask_t (*layer_masks)[];
> > +	size_t layer_masks_size;
> >  };
> > 
> >  #ifdef CONFIG_AUDIT
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index a099167d2347..7f69bed9e095 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -730,6 +730,7 @@ static void test_is_eacces_with_write(struct kunit
> > *const test) *     those identified by @access_request_parent1).  This
> > matrix can *     initially refer to domain layer masks and, when the
> > accesses for the *     destination and source are the same, to requested
> > layer masks. + * @log_request_parent1: Audit request to fill if the related
> > access is denied. * @dentry_child1: Dentry to the initial child of the
> > parent1 path.  This *     pointer must be NULL for non-refer actions (i.e.
> > not link nor rename). * @access_request_parent2: Similar to
> > @access_request_parent1 but for a @@ -738,6 +739,7 @@ static void
> > test_is_eacces_with_write(struct kunit *const test) *     the source.  Must
> > be set to 0 when using a simple path request. * @layer_masks_parent2:
> > Similar to @layer_masks_parent1 but for a refer *     action.  This must be
> > NULL otherwise.
> > + * @log_request_parent2: Audit request to fill if the related access is
> > denied. * @dentry_child2: Dentry to the initial child of the parent2 path. 
> > This *     pointer is only set for RENAME_EXCHANGE actions and must be NULL
> > *     otherwise.
> > @@ -757,10 +759,12 @@ static bool is_access_to_paths_allowed(
> >  	const struct path *const path,
> >  	const access_mask_t access_request_parent1,
> >  	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
> > -	const struct dentry *const dentry_child1,
> > +	struct landlock_request *const log_request_parent1,
> > +	struct dentry *const dentry_child1,
> >  	const access_mask_t access_request_parent2,
> >  	layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
> > -	const struct dentry *const dentry_child2)
> > +	struct landlock_request *const log_request_parent2,
> > +	struct dentry *const dentry_child2)
> >  {
> >  	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
> >  	     child1_is_directory = true, child2_is_directory = true;
> > @@ -907,6 +911,24 @@ static bool is_access_to_paths_allowed(
> >  	}
> >  	path_put(&walker_path);
> > 
> > +	if (!allowed_parent1 && log_request_parent1) {
> > +		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS,
> > +		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH,
> > +		log_request_parent1->audit.u.path = *path;
> > +		log_request_parent1->access = access_request_parent1;
> > +		log_request_parent1->layer_masks = layer_masks_parent1;
> > +		log_request_parent1->layer_masks_size =
> > +			ARRAY_SIZE(*layer_masks_parent1);
> > +	}
> > +	if (!allowed_parent2 && log_request_parent2) {
> > +		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS,
> > +		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH,
> > +		log_request_parent2->audit.u.path = *path;
> > +		log_request_parent2->access = access_request_parent2;
> > +		log_request_parent2->layer_masks = layer_masks_parent2;
> > +		log_request_parent2->layer_masks_size =
> > +			ARRAY_SIZE(*layer_masks_parent2);
> > +	}
> 
> You may want to add a function to set these fields in log_request.

There would only be two calls to this function and with at least four
arguments, so for simplicity, I don't think it's worth it.
