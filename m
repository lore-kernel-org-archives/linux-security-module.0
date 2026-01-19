Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028052144C7
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823413; cv=none; b=L1I5cTjiyH8kd8vtFabOYTmy7/17mxAFyioBLhIsqURkoC4iFaDBmjtFSGrlx4BVqn9gHMmoRwnGFMBSj9Bm5gdU7HnTwaYeMQqmpBFhgCaGAM346L8Sfxynibt3uHj2a0XM26Fb+UHlIDmK57RvzsDijw1EEDrbUBTTTZc37cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823413; c=relaxed/simple;
	bh=ulSfS13N28RF5MKCYMFYvfR38qlbipjnnV+R8VGlkW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC/ii7ab2Kn5bZomcU9gvtCmDRmZE8/kNR6KxsBHJeuvRU/m8yIcvLwR4DWFcd/Nlv/+5VNfbueI2aQx0tRWhtxsNji8Sn+Pk//JxMGsD6U4I7U4d39YyYyTjC19ucYWxc/HIFGmcFx6/Kk+Uw1+AAXjArlHPy5SCAUoBAI7z5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IWjIzl7d; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IWjIzl7d"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dvpVm6fgDz810;
	Mon, 19 Jan 2026 12:43:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768822992;
	bh=THBD5X/WeeF/GvoV0ikRXnmVJ5yZmUNsJYl89Obu6Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWjIzl7djMVIN1QKGsx0Z8e5pkgniOLPja8kov8myPsGto9Bi8U33WlRHh2RLg0d0
	 XkHHoToH0ZHK4X+BVQxjOhGofNRul3cFl5ppjn57K6y3zJmJI7HltxLpy6X//RawCk
	 hd2UhuwNNM84NXJ2SgEPhNGe2yBvATCqw1S1RjOI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dvpVl6swWzhQD;
	Mon, 19 Jan 2026 12:43:11 +0100 (CET)
Date: Mon, 19 Jan 2026 12:43:05 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v2 2/5] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260119.eicaeSei5Ahk@digikod.net>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-6-gnoack3000@gmail.com>
 <735dd623-f8ff-43ff-8d06-fc0443e0f892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <735dd623-f8ff-43ff-8d06-fc0443e0f892@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jan 12, 2026 at 10:38:44AM -0500, Justin Suess wrote:
> On 1/10/26 09:32, Günther Noack wrote:
> > * Add new access rights which control the look up operations for named
> >   UNIX domain sockets.  The resolution happens during connect() and
> >   sendmsg() (depending on socket type).
> >   * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM
> >   * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM
> >   * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
> Might be a crazy thought but would it be better to implement the
> STREAM/DGRAM/SEQPACKET as an add_rule flag rather than as a separate
> access right? There are other types of address families like AF_CAN,
> AF_BLUETOOTH, AF_VSOCK that support multiple socket types.

There should only be one LANDLOCK_ACCESS_FS_RESOLVE_UNIX, not one per
stream/dgram/seqpacket.

I guess there is no other type of address families that can be tied to
the filesystem, so there is no need for a more generic approach.
Moreover, each new access right should come with a good test coverage,
so adding a generic access right would be too much work.

The add_rule flags should make sense for any kind of rule type e.g.,
related to how the rule is applied.  We also have a lot of flexibility
with the landlock_*_attr structs where we can add new fields.

FYI, this patch series will make it possible to restrict socket creation
according to their properties:
https://lore.kernel.org/all/20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com/

> 
> This saves us on access right numbers if they get added in the future to
> landlock.

Even if we reach 64 access rights per type, we can still add new types.
Anyway, I guess this would not happen because more specific
landlock_*_attr would probably fit best.

> 
> So we could have:
> 
> LANDLOCK_ADD_RULE_SOCK_STREAM
> LANDLOCK_ADD_RULE_SOCK_DGRAM
> LANDLOCK_ADD_RULE_SOCK_SEQPACKET

This would be the wrong semantic because users don't really care about
the stream/dgram/seqpacket type but about the path name and the peer.

If we want to restrict other socket types, we would probably use
landlock_net_port_attr or create a new struct if necessary.

> 
> and use it as such:
> 
> landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>                              &path_beneath_for_unix_socket,
>                              LANDLOCK_ADD_RULE_SOCK_STREAM |
>                              LANDLOCK_ADD_RULE_SOCK_DGRAM);
> 
> For address families with only one socket type (ie tcp and udp), the
> socket family be implied, which keeps backward compatibility w/ the
> existing tcp access right.
> 
> This way, we don't have to make completely separate access rights for
> future socket families. So we could add a single access right for bluetooth,
> for instance, and distinguish which socket families we give it with the
> LANDLOCK_ADD_RULE_SOCK_* flags.
> 
> We'd have to track the SOCK_(socket_type) for unix sockets as we gather
> access rights. But afaik unix sockets should be the only socket type that
> has to deal with tree traversal.
> > * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
> >   LSM hook.  Make policy decisions based on the new access rights
> > * Increment the Landlock ABI version.
> > * Minor test adaptions to keep the tests working.
> >
> > Cc: Justin Suess <utilityemal77@gmail.com>
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Link: https://github.com/landlock-lsm/linux/issues/36
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  include/uapi/linux/landlock.h                | 10 ++++++
> >  security/landlock/access.h                   |  2 +-
> >  security/landlock/audit.c                    |  6 ++++
> >  security/landlock/fs.c                       | 34 +++++++++++++++++++-
> >  security/landlock/limits.h                   |  2 +-
> >  security/landlock/syscalls.c                 |  2 +-
> >  tools/testing/selftests/landlock/base_test.c |  2 +-
> >  tools/testing/selftests/landlock/fs_test.c   |  7 ++--
> >  8 files changed, 58 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index f030adc462ee..455edc241c12 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -216,6 +216,13 @@ struct landlock_net_port_attr {
> >   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> >   *   ``O_TRUNC``.  This access right is available since the third version of the
> >   *   Landlock ABI.
> > + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM: Connect to named
> > + *   :manpage:`unix(7)` ``SOCK_STREAM`` sockets.
> > + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM: Send messages to named
> > + *   :manpage:`unix(7)` ``SOCK_DGRAM`` sockets or connect to them using
> > + *   :manpage:`connect(2)`.
> > + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET: Connect to named
> > + *   :manpage:`unix(7)` ``SOCK_SEQPACKET`` sockets.
> >   *
> >   * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
> >   * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> > @@ -321,6 +328,9 @@ struct landlock_net_port_attr {
> >  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> >  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> >  #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
> > +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM		(1ULL << 16)
> > +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM		(1ULL << 17)
> > +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET	(1ULL << 18)
> >  /* clang-format on */
> >  
> >  /**
> > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > index 7961c6630a2d..c7784922be3c 100644
> > --- a/security/landlock/access.h
> > +++ b/security/landlock/access.h
> > @@ -34,7 +34,7 @@
> >  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> >  /* clang-format on */
> >  
> > -typedef u16 access_mask_t;
> > +typedef u32 access_mask_t;
> >  
> >  /* Makes sure all filesystem access rights can be stored. */
> >  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index e899995f1fd5..0645304e0375 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -37,6 +37,12 @@ static const char *const fs_access_strings[] = {
> >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
> >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
> >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM)] =
> > +		"fs.resolve_unix_stream",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM)] =
> > +		"fs.resolve_unix_dgram",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)] =
> > +		"fs.resolve_unix_seqpacket",
> >  };
> >  
> >  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 8205673c8b1c..94f5fc7ee9fd 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -9,6 +9,7 @@
> >   * Copyright © 2023-2024 Google LLC
> >   */
> >  
> > +#include "linux/net.h"
> >  #include <asm/ioctls.h>
> >  #include <kunit/test.h>
> >  #include <linux/atomic.h>
> > @@ -314,7 +315,10 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> >  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM | \
> > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM | \
> > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)
> >  /* clang-format on */
> >  
> >  /*
> > @@ -1588,6 +1592,33 @@ static int hook_path_truncate(const struct path *const path)
> >  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> >  }
> >  
> > +static int hook_unix_path_connect(const struct path *const path, int type,
> > +				  int flags)
> > +{
> > +	access_mask_t access_request = 0;
> > +
> > +	/* Lookup for the purpose of saving coredumps is OK. */
> > +	if (flags & SOCK_COREDUMP)
> > +		return 0;
> > +
> > +	switch (type) {
> > +	case SOCK_STREAM:
> > +		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM;
> > +		break;
> > +	case SOCK_DGRAM:
> > +		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM;
> > +		break;
> > +	case SOCK_SEQPACKET:
> > +		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET;
> > +		break;
> > +	}
> > +
> > +	if (!access_request)
> > +		return 0;
> > +
> > +	return current_check_access_path(path, access_request);
> > +}
> > +
> >  /* File hooks */
> >  
> >  /**
> > @@ -1872,6 +1903,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
> >  	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
> >  	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> >  	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> > +	LSM_HOOK_INIT(unix_path_connect, hook_unix_path_connect),
> >  
> >  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
> >  	LSM_HOOK_INIT(file_open, hook_file_open),
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index 65b5ff051674..1f6f864afec2 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -19,7 +19,7 @@
> >  #define LANDLOCK_MAX_NUM_LAYERS		16
> >  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
> >  
> > -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
> > +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
> >  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
> >  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
> >  
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index 0116e9f93ffe..66fd196be85a 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -161,7 +161,7 @@ static const struct file_operations ruleset_fops = {
> >   * Documentation/userspace-api/landlock.rst should be updated to reflect the
> >   * UAPI change.
> >   */
> > -const int landlock_abi_version = 7;
> > +const int landlock_abi_version = 8;
> >  
> >  /**
> >   * sys_landlock_create_ruleset - Create a new ruleset
> > diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> > index 7b69002239d7..f4b1a275d8d9 100644
> > --- a/tools/testing/selftests/landlock/base_test.c
> > +++ b/tools/testing/selftests/landlock/base_test.c
> > @@ -76,7 +76,7 @@ TEST(abi_version)
> >  	const struct landlock_ruleset_attr ruleset_attr = {
> >  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> >  	};
> > -	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
> > +	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
> >  					     LANDLOCK_CREATE_RULESET_VERSION));
> >  
> >  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index 968a91c927a4..0cbde65e032a 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -575,9 +575,12 @@ TEST_F_FORK(layout1, inval)
> >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> >  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM | \
> > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM | \
> > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)
> >  
> > -#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
> > +#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
> >  
> >  #define ACCESS_ALL ( \
> >  	ACCESS_FILE | \
> 
