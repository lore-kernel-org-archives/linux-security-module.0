Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859C23C516
	for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763811692; cv=none; b=mO/Zf3QfBzpdKKi97Rjd5V/FJDFVdio0ULigabNgCRe4lbtPOmRqT96JLO6aIIRwyd5GW94jpallpwYcz/GvQA/f/yrrtta1UAs1B/eUtAunLZpFj7ShNTh8KL+Qi9w3b5jBJD+fTIfrY1vhkot+eewcx/dCt4GGmPmmMNtA0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763811692; c=relaxed/simple;
	bh=mRYSaVswgVmkOOaj/zHm0PtY73ANdFe4HYFmWR0OKTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVc2Y1v1A1ZnzLAeQtJe+LB6LwGcRfx6kxfMvdVCVbseY4m66pzBtv1Mx7+TU6LwhBQT1qsgzgyHPWVU2MXjX0rTDlOjEQTymA1JatDVSYN9ZbVE3/CFxY14vdpd0Xy4o+3a8cNdYrLnHo4kYifO37zlptZa1UfDbZCCye774xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtSdIPZh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtSdIPZh"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b72bf7e703fso469742866b.2
        for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 03:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763811689; x=1764416489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0mtC6iGIMNv7/jx+LcjPNKphH1K/Q6URs5HZ2MxHfvs=;
        b=NtSdIPZhUzGfa0Pm3BEGmfNkjJ8StQma+RaV2/dMzWrvSOWLpB4Zp4YpQvUJQIcqJw
         lDGC3J9iQU3Ts5C+lSGh32YIxyawMqJb+IpITFhHjpDlNJqKROF0l7H2Pq0GfHGra6Ga
         Ie/T3t3rJ+xtJ/KX92LY6rzFAN4e8Sjmp3eyPHzW8tFiNHTGusUf4Dama1S1WvO77fPF
         Z32UKEIuGa4G/TYTRbOuDLnO3Bbncn40gHTjYZEtT85nsK/GBxeUjZhLbhqKhS+Sc+/4
         lxSkBQeDiRphN1U/lIjX1ey+N74Hte2f1knPIv9KrTPG6T2+3Xz9W4bbBLYALT3O3+pG
         Z0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763811689; x=1764416489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mtC6iGIMNv7/jx+LcjPNKphH1K/Q6URs5HZ2MxHfvs=;
        b=OCWN/a8DgJBy9uNIhKhRSMxBQbXtQobukIDww15cJpXpNHs4EyycGOB+FPMM5OnM2m
         wF9c2jJifxkO7aDhJNlyzcX6Th3uaFAYHc1iz6IjCoOhB+o8zv3AvgNLlKVLSsatZMMM
         nzYcdbRaLvSwfmzrlQvMdVdhjTNX2XS6DK3JNiLcQ4eWi3ZNg8IkBH8DADZK/lOzc4pe
         b1AD0OkI4YJi3pO00iFsRrJJK1F+0q+C9ny7zHWcAma6qy+vBouA3iTMZUzvamASz6Yz
         jSwsHl5fxjRvpI7K6q68L/e+/nAKV0bdXsQzvJGSUM90+LB+FCpKx5SNFoXZ+QKKZMSu
         C7rg==
X-Forwarded-Encrypted: i=1; AJvYcCVd4UOZy17jetulxS0yDuFkLCK7j9H5yjq7/ZJGL2Z9n4TNXzsK6Sz3RPQR6PxnqFQohs0eTHKF5M6JZdtQHmbwV+gB3VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnk8zUKhThQqD4cQETJXOuCKGfJx1tQYiKAE1yfFU9NOkMDnJd
	6ZcKuQENlFCE8hMQpZkdqiHDTZHM7YGvHiB0Uzi2iARCA/imXs9h2VFb
X-Gm-Gg: ASbGncsl4Kvo9tJMdOpSD/Ngf2KS85XdarOUIlbd5ue/x9nqMxna4NAzJ1Xzgzykb5r
	62Un+aPmONF4sGlODGAZkeD5ooZ7+vMhJo1r/Nla9Q2UNd06W9ng4zi6fKH3e2Ahh0MpdFoAJLP
	qm4/b2m8hx2H7XXFllo5taIKAMnGFpWSWWG1g0EfYXBo4YI2LXyDQn9CdeSdZcHHtOZlt/24bkb
	nEAMUZkHZRvDH/NAeORO1VQTJSFC3I1sOe+moSBzwO8h+C3+AwCXjtvju3WKYOBNm6U/Zs9lCGV
	W4EoqoHMMEhSwwgy3fifMVSmW0vbAeWrQ1eX39nAHTHxGJNHglwCNV2Y019d76du1322Bo2Y49o
	9rvV2SZX5BgqxX+AdnnzjzgMzesYCzLdm+p1t6VglskZnFRCoQv5NbNSOYnZmQDLoheKWW+9PUd
	IHqh0gkZ0P7n3YR9ixukSvZvxRqmZYIxvPDDU0z1g/yJlN9qM=
X-Google-Smtp-Source: AGHT+IE1UIU9Cfto810wPwfYombVwh3UXvoZUfKXcbSUurQQWiM74s9/61kh/88UujAObqge46w3Fw==
X-Received: by 2002:a17:906:ef03:b0:b73:737e:2a21 with SMTP id a640c23a62f3a-b7671b12c6emr536943766b.54.1763811688573;
        Sat, 22 Nov 2025 03:41:28 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d54cf2sm704567766b.18.2025.11.22.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 03:41:28 -0800 (PST)
Date: Sat, 22 Nov 2025 12:41:26 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, gnoack@google.com, willemdebruijn.kernel@gmail.com,
	matthieu@buffet.re, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	yusongping@huawei.com, artem.kuzin@huawei.com,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH v4 06/19] landlock: Add hook on socket creation
Message-ID: <20251122.78c6cd69a873@gnoack.org>
References: <20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com>
 <20251118134639.3314803-7-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118134639.3314803-7-ivanov.mikhail1@huawei-partners.com>

On Tue, Nov 18, 2025 at 09:46:26PM +0800, Mikhail Ivanov wrote:
> Add hook on security_socket_create(), which checks whether the socket
> of requested protocol is allowed by domain.
> 
> Due to support of masked protocols Landlock tries to find one of the
> 4 rules that can allow creation of requested protocol.
> 
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v3:
> * Changes LSM hook from socket_post_create to socket_create so
>   creation would be blocked before socket allocation and initialization.
> * Uses credential instead of domain in hook_socket create.
> * Removes get_raw_handled_socket_accesses.
> * Adds checks for rules with wildcard type and protocol values.
> * Minor refactoring, fixes.
> 
> Changes since v2:
> * Adds check in `hook_socket_create()` to not restrict kernel space
>   sockets.
> * Inlines `current_check_access_socket()` in the `hook_socket_create()`.
> * Fixes commit message.
> 
> Changes since v1:
> * Uses lsm hook arguments instead of struct socket fields as family-type
>   values.
> * Packs socket family and type using helper.
> * Fixes commit message.
> * Formats with clang-format.
> ---
>  security/landlock/setup.c  |  2 +
>  security/landlock/socket.c | 78 ++++++++++++++++++++++++++++++++++++++
>  security/landlock/socket.h |  2 +
>  3 files changed, 82 insertions(+)
> 
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index bd53c7a56ab9..140a53b022f7 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "id.h"
>  #include "net.h"
> +#include "socket.h"
>  #include "setup.h"
>  #include "task.h"
>  
> @@ -68,6 +69,7 @@ static int __init landlock_init(void)
>  	landlock_add_task_hooks();
>  	landlock_add_fs_hooks();
>  	landlock_add_net_hooks();
> +	landlock_add_socket_hooks();
>  	landlock_init_id();
>  	landlock_initialized = true;
>  	pr_info("Up and running.\n");
> diff --git a/security/landlock/socket.c b/security/landlock/socket.c
> index 28a80dcad629..d7e6e7b92b7a 100644
> --- a/security/landlock/socket.c
> +++ b/security/landlock/socket.c
> @@ -103,3 +103,81 @@ int landlock_append_socket_rule(struct landlock_ruleset *const ruleset,
>  
>  	return err;
>  }
> +
> +static int check_socket_access(const struct landlock_ruleset *dom,
> +			       uintptr_t key,
> +			       layer_mask_t (*const layer_masks)[],
> +			       access_mask_t handled_access)
> +{
> +	const struct landlock_rule *rule;
> +	struct landlock_id id = {
> +		.type = LANDLOCK_KEY_SOCKET,
> +	};
> +
> +	id.key.data = key;

This line can be made part of the designated initializer:

    struct landlock_id id = {
      .type = ...,
      .key.data = ...,
    };


> +	rule = landlock_find_rule(dom, id);
> +	if (landlock_unmask_layers(rule, handled_access, layer_masks,
> +				   LANDLOCK_NUM_ACCESS_SOCKET))
> +		return 0;
> +	return -EACCES;
> +}
> +
> +static int hook_socket_create(int family, int type, int protocol, int kern)
> +{
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_SOCKET] = {};
> +	access_mask_t handled_access;
> +	const struct access_masks masks = {
> +		.socket = LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	const struct landlock_cred_security *const subject =
> +		landlock_get_applicable_subject(current_cred(), masks, NULL);
> +	uintptr_t key;
> +
> +	if (!subject)
> +		return 0;
> +	/* Checks only user space sockets. */
> +	if (kern)
> +		return 0;
> +
> +	handled_access = landlock_init_layer_masks(
> +		subject->domain, LANDLOCK_ACCESS_SOCKET_CREATE, &layer_masks,
> +		LANDLOCK_KEY_SOCKET);

Nit: I had to double check to confirm that the same PF_INET/PF_PACKET
transformation (which net/socket.c refers to as the "uglymoron") has
already happened on the arguments before hook_socket_create() gets
called from there.  Maybe it's worth a brief mention in a comment
here.

> +	/*
> +	 * Error could happen due to parameters are outside of the allowed range,

Grammar nit: drop the "are"

Suggestion: "If this error happens, the parameters are outside of the
allowed range, so this combination can't have been added to the
ruleset previously."

> +	 * so this combination couldn't be added in ruleset previously.
> +	 * Therefore, it's not permitted.
> +	 */
> +	if (pack_socket_key(family, type, protocol, &key) == -EACCES)
> +		return -EACCES;

BUG: pack_socket_key() does never return -EACCES!

(Consider whether that function should really return an error?  Maybe
a boolean would be better, if you anyway need a different error code
in both locations where it is called.)

Can this code path actually get hit, or do the entry points for
creating sockets refuse these wrong values at an earlier stage with
EINVAL already?

> +	if (check_socket_access(subject->domain, key, &layer_masks,
> +				handled_access) == 0)
> +		return 0;
> +
> +	/* Ranges were already checked. */
> +	(void)pack_socket_key(family, TYPE_ALL, protocol, &key);
> +	if (check_socket_access(subject->domain, key, &layer_masks,
> +				handled_access) == 0)
> +		return 0;
> +
> +	(void)pack_socket_key(family, type, PROTOCOL_ALL, &key);
> +	if (check_socket_access(subject->domain, key, &layer_masks,
> +				handled_access) == 0)
> +		return 0;
> +
> +	(void)pack_socket_key(family, TYPE_ALL, PROTOCOL_ALL, &key);
> +	if (check_socket_access(subject->domain, key, &layer_masks,
> +				handled_access) == 0)
> +		return 0;
> +
> +	return -EACCES;
> +}

It initially doesn't look very nice to drop the error from
pack_socket_key() repeatedly.  The call repeats the bounds checks and
requires more cross-function reasoning to understand.

Since 'key' is an uintptr_t anyway, and the wildcards are all ones,
maybe a simpler way is to define masks for the wildcards?

    const uintptr_t any_type_mask     = (union key){.data.type     = UINT8_MAX}.packed;
    const uintptr_t any_protocol_mask = (union key){.data.protocol = UINT16_MAX}.packed;

and then, after calling pack_socket_key() once with error check, use
the combinations

  * key
  * key | any_type
  * key | any_protocol
  * key | any_type | any_protocol

to construct the wildcard-enabled keys in the four calls to
check_socket_access()?  You could have compile-time assertions or
tests to check that the masking does the same as packing it from
scratch when passing -1.

(That being said, I don't feel strongly about it.)

Remark on the side: I was briefly confused why we don't need to guard
on CONFIG_SECURITY_NETWORK, but this is already required by
CONFIG_LANDLOCK. So that looks good.

–Günther
