Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985335CB8D
	for <linux-security-module@vger.kernel.org>; Mon, 12 Jan 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232330; cv=none; b=iS7hHdm0emnNqMaOhyqXuR12/tjisA5pOo96n17wJy6cddpKrDbEEqXKW4Z4uNV9Bl8oSpdOBRyT66U6fQnKSkyYvT1oVyoUJt+rS7TdvIuK8aOrQ2zArwGDtPdhzD3tYqu3UAViOeR+IwRFzBZb6KcKY8kMI6/cZZbmERmkSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232330; c=relaxed/simple;
	bh=C5PZ8Ito+QjFFAOnwA6WfPIHE/P6FfzO0rArZMHTG7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euo5inqvRZAZenEcrFJ75YJpJjsNKxnfJ1cJwIMtUvl2qssuZ5RiqjwBwJlippjJVOoKhHaHy5HdfcC9L7nbJA9wDWMc+0+4BhhHGIwBwFdNFKbm5f8dhxVBzRa0wgD11HvxBJl78hUggeGyHq2mvJxBNujInjUiO0oOgbLaEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyUku2D4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyUku2D4"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-790884840baso68859007b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jan 2026 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768232327; x=1768837127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLZmqypCYSswagHO/f0HoyEJBnS6TQwTkRreE89dS8U=;
        b=DyUku2D4OnsJkYWjQLcxGBOkJM0RhktblRAVHUZeBq/Z7Vy7c78KWtcNxVHaXrBfaz
         edrwDbAQ2rnAt2cuYdxcdFiD/iq4s/y8Z3Fu9uAn+Jtmnvr13Uh1R9OQiZax25Ekkhu4
         IJ85AlNm61ocM26NwHc/IVIEsktuxB+0PJNUzpud4b0RWEkzB/7BgEAfJvgEQQcYFK9n
         0fQUeHv/yaZDb0jxaiVL4xPh2XB0y2Y2bwliBtMmnfcOz9u6+GA2OVXSLzKYbZvOSSCq
         DSWy99ZScow5sn7cD4Da9c0OOtupKedYqeYquo4SZ2xt9zU2dIX2+mQB/rihblwvkjE6
         RDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232327; x=1768837127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLZmqypCYSswagHO/f0HoyEJBnS6TQwTkRreE89dS8U=;
        b=Pm36oLt4ez15JhBfUDWZ9XHGLwyOSHG+4aF4AVCQu7Wm/IEFus2D50FfReheSUAF9T
         cjqByjoAyyOGugYXliOquOEpFKHc0GwrW2Yf84oXngP2MNfavLMZ8sy90qHIFCYaiuwY
         94DjB71eFEihO0y65kSDuXMcDd4p+WW3byHLmgtpJ4it5+eEjDjta3Yu4dMhcDArPQ2q
         TsMfs7BM6BIiq9y0nzz6oXFda831KcarR+KwTAOYiy6qZ4WJ0x5h0lFRLwQEE774p7M7
         wmOGgfG4KzT1gu3myX7eFnHzRNZER4OTomo1xhnuIPp6nHnFOP5MMnZ8qJ5KX5CqgsAV
         4+2w==
X-Forwarded-Encrypted: i=1; AJvYcCX4jOvJtcrbb7p9+QyC1rWSGpx9Bm1R0gPUyil7YPJOtSf0cKOLIxdhSjwfadtCQqLK1QN0BiPovKw0EQgyGhCrwKMw8q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNiljVvJm6Nd6xmqvsLHYfEQxhN1ovND2FRyD8XsryeaDb4Ea
	097yD8XEkjLfkDLTY38r4NZ4wnPakmMeQ4PANYib4piHx8JeGgLM2Bfn
X-Gm-Gg: AY/fxX7CuCkP7zcXH/vQfzsWlCUMPz2B7uGbSpB00R+JbBLGHUK5H5Mprpcc/QS+u5e
	FsJoH4J1+5qpI1bcnUnf9LuUedRUpKQBv/qS1SwEO5KGujZcFBe0bSAXBgokvKBhC3YAIUuJHYg
	ai77CD1sAbYMw+1zqp14vPVHDXMVNW+P/urV+BaVuZf+09bcPwV2w7wfrkuRNQeRWVSbeAvoese
	HdLBkJSOTX27Tk1rVOXnMqv6qft9EdjlyHteXxxeQM9ya46istxjq4D6obCYmP8N6cQFyGXBh9g
	siW0wwnv52c8vqm9H/n8hpLexLNIDrdjcMEPrE6ye9wSLG3JorUUfK9MhWQF30IsmWRWYKIlWD7
	YKRQYSPpHDIntdmSOTA34s15H5B+P5VHl2QfxwRfXenZg2aAzNJyoE5zKGgWhVXSgyws2tgTItn
	v7cGl5YExnwjjRxXY7zFPi+P1r0QS7ZUkIKUEKF3vUxqH7kMN5XCO1XpEu4griiJr5XxkLoQ==
X-Google-Smtp-Source: AGHT+IGN/Ld+Rvs/yo3cLtHRM5EcP4YG33X4DZfJulcEmrpVemVGnUnfSNrTplactx3SRszxWK65Og==
X-Received: by 2002:a05:690e:400a:b0:646:a3cf:a2e8 with SMTP id 956f58d0204a3-64716ba374amr14905559d50.40.1768232327023;
        Mon, 12 Jan 2026 07:38:47 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa58f9f5sm69097517b3.24.2026.01.12.07.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 07:38:46 -0800 (PST)
Message-ID: <735dd623-f8ff-43ff-8d06-fc0443e0f892@gmail.com>
Date: Mon, 12 Jan 2026 10:38:44 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] landlock: Control pathname UNIX domain socket
 resolution by path
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
 Tingmao Wang <m@maowtm.org>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-6-gnoack3000@gmail.com>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <20260110143300.71048-6-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/10/26 09:32, Günther Noack wrote:
> * Add new access rights which control the look up operations for named
>   UNIX domain sockets.  The resolution happens during connect() and
>   sendmsg() (depending on socket type).
>   * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM
>   * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM
>   * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
Might be a crazy thought but would it be better to implement the
STREAM/DGRAM/SEQPACKET as an add_rule flag rather than as a separate
access right? There are other types of address families like AF_CAN,
AF_BLUETOOTH, AF_VSOCK that support multiple socket types.

This saves us on access right numbers if they get added in the future to
landlock.

So we could have:

LANDLOCK_ADD_RULE_SOCK_STREAM
LANDLOCK_ADD_RULE_SOCK_DGRAM
LANDLOCK_ADD_RULE_SOCK_SEQPACKET

and use it as such:

landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
                             &path_beneath_for_unix_socket,
                             LANDLOCK_ADD_RULE_SOCK_STREAM |
                             LANDLOCK_ADD_RULE_SOCK_DGRAM);

For address families with only one socket type (ie tcp and udp), the
socket family be implied, which keeps backward compatibility w/ the
existing tcp access right.

This way, we don't have to make completely separate access rights for
future socket families. So we could add a single access right for bluetooth,
for instance, and distinguish which socket families we give it with the
LANDLOCK_ADD_RULE_SOCK_* flags.

We'd have to track the SOCK_(socket_type) for unix sockets as we gather
access rights. But afaik unix sockets should be the only socket type that
has to deal with tree traversal.
> * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
>   LSM hook.  Make policy decisions based on the new access rights
> * Increment the Landlock ABI version.
> * Minor test adaptions to keep the tests working.
>
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://github.com/landlock-lsm/linux/issues/36
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h                | 10 ++++++
>  security/landlock/access.h                   |  2 +-
>  security/landlock/audit.c                    |  6 ++++
>  security/landlock/fs.c                       | 34 +++++++++++++++++++-
>  security/landlock/limits.h                   |  2 +-
>  security/landlock/syscalls.c                 |  2 +-
>  tools/testing/selftests/landlock/base_test.c |  2 +-
>  tools/testing/selftests/landlock/fs_test.c   |  7 ++--
>  8 files changed, 58 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f030adc462ee..455edc241c12 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -216,6 +216,13 @@ struct landlock_net_port_attr {
>   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
>   *   ``O_TRUNC``.  This access right is available since the third version of the
>   *   Landlock ABI.
> + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM: Connect to named
> + *   :manpage:`unix(7)` ``SOCK_STREAM`` sockets.
> + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM: Send messages to named
> + *   :manpage:`unix(7)` ``SOCK_DGRAM`` sockets or connect to them using
> + *   :manpage:`connect(2)`.
> + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET: Connect to named
> + *   :manpage:`unix(7)` ``SOCK_SEQPACKET`` sockets.
>   *
>   * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
>   * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> @@ -321,6 +328,9 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>  #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
> +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM		(1ULL << 16)
> +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM		(1ULL << 17)
> +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET	(1ULL << 18)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 7961c6630a2d..c7784922be3c 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -34,7 +34,7 @@
>  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
>  /* clang-format on */
>  
> -typedef u16 access_mask_t;
> +typedef u32 access_mask_t;
>  
>  /* Makes sure all filesystem access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index e899995f1fd5..0645304e0375 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -37,6 +37,12 @@ static const char *const fs_access_strings[] = {
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM)] =
> +		"fs.resolve_unix_stream",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM)] =
> +		"fs.resolve_unix_dgram",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)] =
> +		"fs.resolve_unix_seqpacket",
>  };
>  
>  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 8205673c8b1c..94f5fc7ee9fd 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -9,6 +9,7 @@
>   * Copyright © 2023-2024 Google LLC
>   */
>  
> +#include "linux/net.h"
>  #include <asm/ioctls.h>
>  #include <kunit/test.h>
>  #include <linux/atomic.h>
> @@ -314,7 +315,10 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)
>  /* clang-format on */
>  
>  /*
> @@ -1588,6 +1592,33 @@ static int hook_path_truncate(const struct path *const path)
>  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>  }
>  
> +static int hook_unix_path_connect(const struct path *const path, int type,
> +				  int flags)
> +{
> +	access_mask_t access_request = 0;
> +
> +	/* Lookup for the purpose of saving coredumps is OK. */
> +	if (flags & SOCK_COREDUMP)
> +		return 0;
> +
> +	switch (type) {
> +	case SOCK_STREAM:
> +		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM;
> +		break;
> +	case SOCK_DGRAM:
> +		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM;
> +		break;
> +	case SOCK_SEQPACKET:
> +		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET;
> +		break;
> +	}
> +
> +	if (!access_request)
> +		return 0;
> +
> +	return current_check_access_path(path, access_request);
> +}
> +
>  /* File hooks */
>  
>  /**
> @@ -1872,6 +1903,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>  	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>  	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> +	LSM_HOOK_INIT(unix_path_connect, hook_unix_path_connect),
>  
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>  	LSM_HOOK_INIT(file_open, hook_file_open),
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 65b5ff051674..1f6f864afec2 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -19,7 +19,7 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>  
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0116e9f93ffe..66fd196be85a 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -161,7 +161,7 @@ static const struct file_operations ruleset_fops = {
>   * Documentation/userspace-api/landlock.rst should be updated to reflect the
>   * UAPI change.
>   */
> -const int landlock_abi_version = 7;
> +const int landlock_abi_version = 8;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 7b69002239d7..f4b1a275d8d9 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 968a91c927a4..0cbde65e032a 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -575,9 +575,12 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)
>  
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
>  
>  #define ACCESS_ALL ( \
>  	ACCESS_FILE | \

