Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D3383333;
	Mon, 31 Aug 2026 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178031; cv=none; b=sxR9aQuwtxswvRRBZQQNxKsdFJJv1G6um5zvGjbxbP9F+15iSLcsJ4Li9vaQKNT0vE6dKmFwzO07JaJn/1ei52JTVXek8qh3ljUOm2dcbCrv/9m9TiVxJ7/6EP1eUAPsmGyNLc63tbCEzsdfVX/YdiEJQpKezUwDvALWMw0Qhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178031; c=relaxed/simple;
	bh=AGa8gyrTJNq9V1Ppc5Z2E3JOwZCxg1B280Zudifaf34=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t92ot4mlOXXsgHCVaCzsC5kUgTQiUwVxmI4tw3cNklJgsJy8SW8XOwfXTGhCq3n/lo3s+ryaOihRgicCarDyqQP100bgtGndoU4G1x9wQenkhTWluqNm7+0atLEjl4eZ3kiH7+L6gb/gBGnJ3L5wcs7sJNhkBH4Bk6/oWqy3xF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpZyuK7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpZyuK7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E7D1F00A3D;
	Mon, 31 Aug 2026 12:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788178029;
	bh=HXgafONsnRtvI90NzR3etwsqR9BlEpVPHg1WliuPJYA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PpZyuK7hgi+KQajgJjl2505gOWrzKbBnxq1RuoLc7a9mBReE2ve3y5kumx1jaS690
	 pvBQZ1gkhwqlgOeCbJOMpxNrEOD/W81CRLZB81nKtH0L9Kg6I8ETtCFVVOR98BX8xp
	 G7XKSi2X3Fzbj+uAK9wmawB7lC2ub7BUhmGVFphciRbXDoF+M4e0a8PzWCdss3RMZJ
	 qqx+KPN2cYbMzk94s+zQMihUHKEr3SQW4ycnYblz8pI+9k+AFpakBGx3c3u2qQoH+m
	 u/yqwHnoT/TWb83bYM0hSIv7Z9z14Qroqd4F4RgsF4gNSmkUd9Viy7D63mNy+m9lpc
	 orE97yaY68big==
Content-Type: multipart/mixed; boundary="===============5368566537779779122=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e2e1c4e876bd26ab17b88d70f0eb96cb56b81ed16358f3ef529a3b224324634f@mail.kernel.org>
In-Reply-To: <20260831110934.241898-6-a.s.protopopov@gmail.com>
References: <20260831110934.241898-6-a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Add netdevsim helper library
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,john.fastabend@gmail.com,brauner@kernel.org,paul@paul-moore.com,torvalds@linux-foundation.org,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 12:07:08 +0000 (UTC)

--===============5368566537779779122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b481b867f372e..c21f89dbe70c0 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -862,6 +862,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
>  			 unpriv_helpers.c 	\
>  			 sysctl_helpers.c	\
>  			 netlink_helpers.c	\
> +			 netdevsim_helpers.c	\
>  			 jit_disasm_helpers.c	\
>  			 io_helpers.c		\
>  			 test_loader.c		\
> diff --git a/tools/testing/selftests/bpf/netdevsim_helpers.c b/tools/testing/selftests/bpf/netdevsim_helpers.c
> new file mode 100644
> index 0000000000000..fbed7442b2e8d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/netdevsim_helpers.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/rtnetlink.h>
> +#include <poll.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include "netdevsim_helpers.h"
> +
> +static int echo(const char *path, const char *fmt, ...)
> +{
> +	char buf[64];
> +	va_list ap;
> +	int fd, len, err = 0;
> +
> +	va_start(ap, fmt);
> +	len = vsnprintf(buf, sizeof(buf), fmt, ap);
> +	va_end(ap);
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd < 0)
> +		return -errno;
> +	if (write(fd, buf, len) != len)
> +		err = -errno;
> +	close(fd);
> +
> +	return err;
> +}

A subsystem pattern flags this as potentially concerning: the guide
directs reporting when a test hand-rolls sysfs/file I/O instead of using
existing utilities that the subsystem already provides.

Looking at echo(), it implements the open(O_WRONLY)/write()/close()
sequence that write_sysctl() in test_progs.c already performs for BPF
selftests. Could this reuse that existing helper?

> +
> +void netdevsim_destroy(unsigned int id)
> +{
> +	echo("/sys/bus/netdevsim/del_device", "%u", id);
> +}
> +
> +static int create_new_device(void)
> +{
> +	unsigned int id;
> +	int err;
> +
> +	/* if 10K is not enough, then something is clearly not right */
> +	for (id = 0; id < 10000; id++) {
> +		err = echo("/sys/bus/netdevsim/new_device", "%u", id);
> +		if (!err)
> +			return id;
> +		if (err != -ENOSPC)
> +			return err;
> +	}
> +
> +	return -ENOSPC;
> +}
> +
> +static int open_link_socket(void)
> +{
> +	struct sockaddr_nl addr = {
> +		.nl_family = AF_NETLINK,
> +		.nl_groups = RTMGRP_LINK,
> +	};
> +	int fd;
> +
> +	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
> +	if (fd < 0)
> +		return -errno;
> +	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
> +		int err = -errno;
> +
> +		close(fd);
> +		return err;
> +	}
> +
> +	return fd;
> +}

The subsystem guide also flags this pattern: open_link_socket() appears
to duplicate rtnl_open(&rth, RTMGRP_LINK) from netlink_helpers.c, which
does the same socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE)
plus bind() with nl_groups set to the subscriptions parameter.

In particular, it looks structurally similar to genl_open() in
netlink_helpers.c, which the immediately preceding commit in this series
(a1205972510b7 "selftests/bpf: Extract some helpers from tests to the
netlink library") added explicitly for sharing netlink plumbing.

The re-implementation also appears to omit the SO_RCVBUF = 1024 * 1024
setting that rtnl_open_byproto() sets in netlink_helpers.c, so the new
socket runs on the default net.core.rmem_default receive buffer.

Similarly, the receive/poll loop in recv_device_ifindex() appears to
hand-roll what rtnl_recvmsg()/__rtnl_recvmsg() in netlink_helpers.c
already do. Notably, those use MSG_PEEK | MSG_TRUNC to size the receive
buffer, whereas the new loop uses a fixed 16 KiB buffer with a plain
recv(fd, buf, sizeof(buf), 0) and no MSG_TRUNC check. Additionally,
__rtnl_recvmsg() retries on EINTR/EAGAIN where the implementation below
returns -errno.

The agent notes that functionally these hand-rolled versions are correct
for their specific use case, and this is selftest-only code. However,
could the new helpers reuse the existing netlink infrastructure?

> +
> +static int remaining_timeout_ms(const struct timespec *deadline)
> +{
> +	struct timespec now;
> +	long long remaining;
> +
> +	if (clock_gettime(CLOCK_MONOTONIC, &now))
> +		return -errno;
> +
> +	remaining = (deadline->tv_sec - now.tv_sec) * 1000 +
> +		    (deadline->tv_nsec - now.tv_nsec) / 1000000;
> +
> +	return remaining > 0 ? remaining : 0;
> +}

This isn't a bug, but since clock_gettime(CLOCK_MONOTONIC, ...) on a
valid stack timespec can't really fail, would it be simpler to have
remaining_timeout_ms() just return milliseconds? That way the timeout
check at the end of recv_device_ifindex() (which currently needs
`return timeout < 0 ? timeout : -ETIMEDOUT;` to forward the
clock_gettime error) could be a plain `return -ETIMEDOUT;`.

> +
> +static int recv_device_ifindex(int fd, unsigned int id, unsigned int *ifindex)
> +{
> +	char parent_name[32], buf[16 * 1024];
> +	struct pollfd pfd = {
> +		.fd = fd,
> +		.events = POLLIN,
> +	};
> +	struct timespec deadline;
> +	struct nlmsghdr *nlh;
> +	int len, ret, timeout;
> +
> +	snprintf(parent_name, sizeof(parent_name), "netdevsim%u", id);
> +	if (clock_gettime(CLOCK_MONOTONIC, &deadline))
> +		return -errno;
> +	deadline.tv_sec += 5;
> +
> +	for (timeout = remaining_timeout_ms(&deadline); timeout > 0;
> +	     timeout = remaining_timeout_ms(&deadline)) {
> +		ret = poll(&pfd, 1, timeout);
> +		if (ret < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			return -errno;
> +		}
> +		if (!ret)
> +			return -ETIMEDOUT;
> +		if (!(pfd.revents & POLLIN))
> +			return -EIO;
> +
> +		len = recv(fd, buf, sizeof(buf), 0);
> +		if (len < 0)
> +			return -errno;
> +
> +		for (nlh = (struct nlmsghdr *)buf; NLMSG_OK(nlh, len);
> +		     nlh = NLMSG_NEXT(nlh, len)) {
> +			struct ifinfomsg *ifm;
> +			struct rtattr *attr;
> +			int attr_len;
> +
> +			if (nlh->nlmsg_type != RTM_NEWLINK)
> +				continue;
> +
> +			ifm = NLMSG_DATA(nlh);
> +			attr = IFLA_RTA(ifm);
> +			attr_len = IFLA_PAYLOAD(nlh);
> +			for (; RTA_OK(attr, attr_len);
> +			     attr = RTA_NEXT(attr, attr_len)) {
> +				if (attr->rta_type != IFLA_PARENT_DEV_NAME)
> +					continue;
> +				if (strcmp(RTA_DATA(attr), parent_name))
> +					continue;
> +
> +				*ifindex = ifm->ifi_index;
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return timeout < 0 ? timeout : -ETIMEDOUT;
> +}
> +
> +int netdevsim_create(unsigned int *ifindex)
> +{
> +	int fd, id, err;
> +
> +	fd = open_link_socket();
> +	if (fd < 0)
> +		return fd;
> +
> +	id = create_new_device();
> +	if (id < 0) {
> +		close(fd);
> +		return id;
> +	}
> +
> +	err = recv_device_ifindex(fd, id, ifindex);
> +	close(fd);
> +	if (err) {
> +		netdevsim_destroy(id);
> +		return err;
> +	}
> +
> +	return id;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074
--===============5368566537779779122==--
