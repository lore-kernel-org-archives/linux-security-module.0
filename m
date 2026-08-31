Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466853BCD05
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180292; cv=none; b=k1rQePtifQtdp2WUaO+WeOpL6aywkA1SHkM20fEXpjhq4sAD7Q5lDMqgu/soNsEhAJ8y5jFXtTocjmlVtn52eCgbnj2EBLWNpME+htwOa+FD0msA0e7xQMp5a0XwoAIxZ+rKIFkoLBjl2tQJ1TtobqNKEb9ng8vJxGjWVQwRAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180292; c=relaxed/simple;
	bh=Y+GcS7MKcJ9WAWTld827Ee0hYnv+7LO8P4Co49AR2Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgeIapPtPAjQ9Kh3ve6nv+sbCSPJNWSVe7R3JcAh70HKoM1+GynlsXKWWIBcR7iUg1vwdD37x7KVyVAiU/CIFCwUz4Mk1J2+0SjF4V0VP4Mf5KY/J6WFZOYVVZzJTfegMJZljat3kVEzFnjF3YwBCs/D26Nsg5piXs2TpM4bWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqae6pdY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqae6pdY"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2531f453eeso523698566b.3
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180285; x=1788785085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+l/jYcEEQatfIkpil8/A0aHb7dyDh4iAxN5e3uvmv9w=;
        b=Dqae6pdYS2n/1ija5OQhFQ2C+HJnd1GYvzGu2seIYGoD1As2C40jXggHi1KYWdxhs7
         /up588NDSvIxZOzQhDbokQmSjLOxs3MHfqLyOmpRPzcf+G0bJKXJjdrV5/WWGksgsuvH
         5OlioJrRYZtnOedrsPW4m/i/EKps6lZVsnZKdMHHLyZL8/QxD3HXEeM0GIl1q0anVHnO
         RgUUfWT3E49PoL2S+A5onL4eekUSG2WBx4aBSz9J7k8r2CsQ45hu2+3DIPHC8180frrv
         +NCd2n5mAcoSVSR01jfDVmWa2kY+wKiWxEPHm5YxmeB1NL1Uj6HPnOpGh4/Byd0JVHHJ
         XEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180285; x=1788785085;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+l/jYcEEQatfIkpil8/A0aHb7dyDh4iAxN5e3uvmv9w=;
        b=CRSyylge9XESPlg++n1prkC0ymdt+Rdyn6SWPAC+b9F01IPK6S11sJdZbm9t8IrBOm
         0Xl6Mx4pCb1B5+sFY8sTpS8EpWgkrmjyxd2M88ci6SbA4UZXlVqZsQIsxxuc+9UYVCHQ
         T9BDUWPiTNN+dDHqof2h3DzO3o34KXCwjEjaHR/7eeSXmnfsGBMed6aFgj2/VPgkUbP5
         GC4vIJrIeqGBrMI4KZqEI3pXlncu6vmsaWYlKP6/J7zmbYYDlL/+ebliaN5zaMlAHXzI
         dT4e+i3lK4+r3uZkqv5Akd5ubp0YlrZ9raK8odC2JKEe9kfRHUW9ulWUhTJlnfhuCNgj
         4d2g==
X-Forwarded-Encrypted: i=1; AHgh+Rr2sAzXlvGDuSapAOaToPxJ1mE5JxaPxVwDDCKT1lyK0oypA97JQMkfJR7TfOXT0vrq42xGvRtkeID4/fkPStezTn6o38A=@vger.kernel.org
X-Gm-Message-State: AFuF++ndDHE5qCyck8Sgz/MslwGnE3oDi3toEMqysixklX1gqByBRcDa
	jqSKGSlHg9+1eGs2JKz7ja7+wn5Se5FosAds7h/3XTNZJ8y1yloL/xAv
X-Gm-Gg: AR+sD11WeYIIZBAUFeHpxUiuGntSz0B6d82MN/0OlzxP7m3w+Abq7oO5DXTLcTWX+ax
	fVigTBxe+Ho0eWOIslfejCygnWqb8bxWXiZ4jhTGfHm/3XHpc98uIJy1Ou3F/tecFc8yJDmLOeg
	c/gSWya7MYHlyV0DyZ3kn0LHEMni2YHAso18gGLVSgmwoTXk/64qjbzzVi96J6HR0UG2kqKuWZP
	mZtI6UxZBQvUVd7xf0ljAQY2yPDdqZsRYpuTtZyD+v1SROTBoFHFZSzMt8UV5fNppBzNMLRIgfH
	kwrV90g05c4B5RXrS/Bg7TEbf+QnTpNiyDNc+5oBDhTRA8htbkj7QuZeBijWZ7s89yvo1X9GG65
	XQgSTrpOYzDnFN7SJHYRu9D4kIujC5bzG4MiNNYELF03UUVF4g2Xp6eNVtmLYmiz6cK48DpUhNz
	RVCZPUgS9uehaXOOtGpQC4SgRd62XlE1TOIAE0CGkBgY7pm7QS67tmmgbmzgYN+BGV12Ee
X-Received: by 2002:a17:907:9345:b0:c15:e8c8:340 with SMTP id a640c23a62f3a-c25b3df5160mr9312866b.23.1788180285109;
        Mon, 31 Aug 2026 05:44:45 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee288afsm424015266b.23.2026.08.31.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:44:44 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:55:25 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kpsingh@kernel.org, matt@bobrowski.net, john.fastabend@gmail.com,
	brauner@kernel.org, paul@paul-moore.com,
	torvalds@linux-foundation.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Add netdevsim helper library
Message-ID: <apV5ve1dvk5KUkCm@mail.gmail.com>
References: <20260831110934.241898-6-a.s.protopopov@gmail.com>
 <e2e1c4e876bd26ab17b88d70f0eb96cb56b81ed16358f3ef529a3b224324634f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e1c4e876bd26ab17b88d70f0eb96cb56b81ed16358f3ef529a3b224324634f@mail.kernel.org>

On 26/08/31 12:07PM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index b481b867f372e..c21f89dbe70c0 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -862,6 +862,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
> >  			 unpriv_helpers.c 	\
> >  			 sysctl_helpers.c	\
> >  			 netlink_helpers.c	\
> > +			 netdevsim_helpers.c	\
> >  			 jit_disasm_helpers.c	\
> >  			 io_helpers.c		\
> >  			 test_loader.c		\
> > diff --git a/tools/testing/selftests/bpf/netdevsim_helpers.c b/tools/testing/selftests/bpf/netdevsim_helpers.c
> > new file mode 100644
> > index 0000000000000..fbed7442b2e8d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/netdevsim_helpers.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <linux/rtnetlink.h>
> > +#include <poll.h>
> > +#include <stdarg.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <sys/socket.h>
> > +#include <time.h>
> > +#include <unistd.h>
> > +
> > +#include "netdevsim_helpers.h"
> > +
> > +static int echo(const char *path, const char *fmt, ...)
> > +{
> > +	char buf[64];
> > +	va_list ap;
> > +	int fd, len, err = 0;
> > +
> > +	va_start(ap, fmt);
> > +	len = vsnprintf(buf, sizeof(buf), fmt, ap);
> > +	va_end(ap);
> > +
> > +	fd = open(path, O_WRONLY);
> > +	if (fd < 0)
> > +		return -errno;
> > +	if (write(fd, buf, len) != len)
> > +		err = -errno;
> > +	close(fd);
> > +
> > +	return err;
> > +}
> 
> A subsystem pattern flags this as potentially concerning: the guide
> directs reporting when a test hand-rolls sysfs/file I/O instead of using
> existing utilities that the subsystem already provides.
> 
> Looking at echo(), it implements the open(O_WRONLY)/write()/close()
> sequence that write_sysctl() in test_progs.c already performs for BPF
> selftests. Could this reuse that existing helper?

Thanks robot, all comments here and below make sense.
I will simplify this in v2.

> > +
> > +void netdevsim_destroy(unsigned int id)
> > +{
> > +	echo("/sys/bus/netdevsim/del_device", "%u", id);
> > +}
> > +
> > +static int create_new_device(void)
> > +{
> > +	unsigned int id;
> > +	int err;
> > +
> > +	/* if 10K is not enough, then something is clearly not right */
> > +	for (id = 0; id < 10000; id++) {
> > +		err = echo("/sys/bus/netdevsim/new_device", "%u", id);
> > +		if (!err)
> > +			return id;
> > +		if (err != -ENOSPC)
> > +			return err;
> > +	}
> > +
> > +	return -ENOSPC;
> > +}
> > +
> > +static int open_link_socket(void)
> > +{
> > +	struct sockaddr_nl addr = {
> > +		.nl_family = AF_NETLINK,
> > +		.nl_groups = RTMGRP_LINK,
> > +	};
> > +	int fd;
> > +
> > +	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
> > +	if (fd < 0)
> > +		return -errno;
> > +	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
> > +		int err = -errno;
> > +
> > +		close(fd);
> > +		return err;
> > +	}
> > +
> > +	return fd;
> > +}
> 
> The subsystem guide also flags this pattern: open_link_socket() appears
> to duplicate rtnl_open(&rth, RTMGRP_LINK) from netlink_helpers.c, which
> does the same socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE)
> plus bind() with nl_groups set to the subscriptions parameter.
> 
> In particular, it looks structurally similar to genl_open() in
> netlink_helpers.c, which the immediately preceding commit in this series
> (a1205972510b7 "selftests/bpf: Extract some helpers from tests to the
> netlink library") added explicitly for sharing netlink plumbing.
> 
> The re-implementation also appears to omit the SO_RCVBUF = 1024 * 1024
> setting that rtnl_open_byproto() sets in netlink_helpers.c, so the new
> socket runs on the default net.core.rmem_default receive buffer.
> 
> Similarly, the receive/poll loop in recv_device_ifindex() appears to
> hand-roll what rtnl_recvmsg()/__rtnl_recvmsg() in netlink_helpers.c
> already do. Notably, those use MSG_PEEK | MSG_TRUNC to size the receive
> buffer, whereas the new loop uses a fixed 16 KiB buffer with a plain
> recv(fd, buf, sizeof(buf), 0) and no MSG_TRUNC check. Additionally,
> __rtnl_recvmsg() retries on EINTR/EAGAIN where the implementation below
> returns -errno.
> 
> The agent notes that functionally these hand-rolled versions are correct
> for their specific use case, and this is selftest-only code. However,
> could the new helpers reuse the existing netlink infrastructure?
> 
> > +
> > +static int remaining_timeout_ms(const struct timespec *deadline)
> > +{
> > +	struct timespec now;
> > +	long long remaining;
> > +
> > +	if (clock_gettime(CLOCK_MONOTONIC, &now))
> > +		return -errno;
> > +
> > +	remaining = (deadline->tv_sec - now.tv_sec) * 1000 +
> > +		    (deadline->tv_nsec - now.tv_nsec) / 1000000;
> > +
> > +	return remaining > 0 ? remaining : 0;
> > +}
> 
> This isn't a bug, but since clock_gettime(CLOCK_MONOTONIC, ...) on a
> valid stack timespec can't really fail, would it be simpler to have
> remaining_timeout_ms() just return milliseconds? That way the timeout
> check at the end of recv_device_ifindex() (which currently needs
> `return timeout < 0 ? timeout : -ETIMEDOUT;` to forward the
> clock_gettime error) could be a plain `return -ETIMEDOUT;`.
> 
> > +
> > +static int recv_device_ifindex(int fd, unsigned int id, unsigned int *ifindex)
> > +{
> > +	char parent_name[32], buf[16 * 1024];
> > +	struct pollfd pfd = {
> > +		.fd = fd,
> > +		.events = POLLIN,
> > +	};
> > +	struct timespec deadline;
> > +	struct nlmsghdr *nlh;
> > +	int len, ret, timeout;
> > +
> > +	snprintf(parent_name, sizeof(parent_name), "netdevsim%u", id);
> > +	if (clock_gettime(CLOCK_MONOTONIC, &deadline))
> > +		return -errno;
> > +	deadline.tv_sec += 5;
> > +
> > +	for (timeout = remaining_timeout_ms(&deadline); timeout > 0;
> > +	     timeout = remaining_timeout_ms(&deadline)) {
> > +		ret = poll(&pfd, 1, timeout);
> > +		if (ret < 0) {
> > +			if (errno == EINTR)
> > +				continue;
> > +			return -errno;
> > +		}
> > +		if (!ret)
> > +			return -ETIMEDOUT;
> > +		if (!(pfd.revents & POLLIN))
> > +			return -EIO;
> > +
> > +		len = recv(fd, buf, sizeof(buf), 0);
> > +		if (len < 0)
> > +			return -errno;
> > +
> > +		for (nlh = (struct nlmsghdr *)buf; NLMSG_OK(nlh, len);
> > +		     nlh = NLMSG_NEXT(nlh, len)) {
> > +			struct ifinfomsg *ifm;
> > +			struct rtattr *attr;
> > +			int attr_len;
> > +
> > +			if (nlh->nlmsg_type != RTM_NEWLINK)
> > +				continue;
> > +
> > +			ifm = NLMSG_DATA(nlh);
> > +			attr = IFLA_RTA(ifm);
> > +			attr_len = IFLA_PAYLOAD(nlh);
> > +			for (; RTA_OK(attr, attr_len);
> > +			     attr = RTA_NEXT(attr, attr_len)) {
> > +				if (attr->rta_type != IFLA_PARENT_DEV_NAME)
> > +					continue;
> > +				if (strcmp(RTA_DATA(attr), parent_name))
> > +					continue;
> > +
> > +				*ifindex = ifm->ifi_index;
> > +				return 0;
> > +			}
> > +		}
> > +	}
> > +
> > +	return timeout < 0 ? timeout : -ETIMEDOUT;
> > +}
> > +
> > +int netdevsim_create(unsigned int *ifindex)
> > +{
> > +	int fd, id, err;
> > +
> > +	fd = open_link_socket();
> > +	if (fd < 0)
> > +		return fd;
> > +
> > +	id = create_new_device();
> > +	if (id < 0) {
> > +		close(fd);
> > +		return id;
> > +	}
> > +
> > +	err = recv_device_ifindex(fd, id, ifindex);
> > +	close(fd);
> > +	if (err) {
> > +		netdevsim_destroy(id);
> > +		return err;
> > +	}
> > +
> > +	return id;
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074

