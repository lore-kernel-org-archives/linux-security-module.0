Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565724;
	b=1xy2QBCvqS2MCbrfnkVApTjtdUYnpDwMc4AGKpbCkDcGRo7vfkOhNSECKVtQ+ZAqyKDY
	 BC8/SW043+WHAwJw3c6RGpq7vqXLNq/A2y4ixOgAkeFpy89qJKJl44Ucxfb3MrX2b0/Wb
	 YBBOsbCyQqdBAbWfH6J1bYkFQbJUALCpi0G4X7V19si9JeJMTDODQjQc4eWi8O4n7FNkw
	 y68ecEFcaDGgXlz0wggfWNsYWwOBkHKpN+kjsTvdy+ZwfrZus3EPFOi1dbcCaeXo+7EQk
	 lbvkrjiDI6k+43PuuQxFBt/E8CJaF0kZgecD0iEblU9797Lu5iylpnZD7xtleLAQrTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=HIAZ+a2RY8snYu8gjwIzGL7aFLB+UDjcbceUrGWDUl0=;
	b=GhHadvRGxPTp0eLv2G2uIIMpGd8uLfiKrHSIOKUMYsyaPE/d3cm5gxlN3mwnyxJM7QWt
	 GD2kRYGmBvgT25LgUZbjs8v9zpNeZ0fjQ0sk32G9IdAcNtBxeo9tBQ657/JuxUIm2NVaX
	 PO6iWSTMYjhZYwni0Bz4LkYhr4Wl1d2BzT5qamJid6i+3AEt9oMCJAScYenyGP3iMrZWO
	 7/CsdlIycaxgdEnDyXBYN9qA22FXQ93pTMOV7KCxz9KPBi22xzbZU+M8AhXs2lKCYjgoP
	 cbk8VyoX/bBBSZhnu8i+JMiaJOVlLpQdQd1O4MqffxbvL+lWBjBjQNSOlmNU9l/XCBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QLWbUp+2;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9320606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9320606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QLWbUp+2
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so11958695e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565721; x=1795170521; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HIAZ+a2RY8snYu8gjwIzGL7aFLB+UDjcbceUrGWDUl0=;
        b=QLWbUp+2qzwX+GoUWHB95sxpbKOTowUKZjnO4OEMj4RsWHB//vUyhRWuLB9yqPVjwR
         fGfqk9OxkJbXk3/6ZWLxC/IKeJNDS3X7DwaIxHW3gRESTvAv4Eekp7DUUiFI0RSTWMhb
         YiU9Qv30iKrXVu42etYewrW/BDRHybe1f3LGYRy3QFZ2Wnd8qVwamSUTOZX8RhksnWiH
         hmYW5qsE6/zg5Kf2usKXzo1eH7FntpSlFp2sNzw5FIg/KyF4iGjfFDBfgH19X1pwvutT
         tSuhIJwUn7q5sVMjoXkVH4kwJhDC2fhwLRQKR4CrsIY9+cK6cretlw8Xmg1Zun/gLJLF
         1IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565721; x=1795170521;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HIAZ+a2RY8snYu8gjwIzGL7aFLB+UDjcbceUrGWDUl0=;
        b=ULuwkFxedDZ6wVVN4aYoWwEFgEsdIrNKulnw42AxmGr/JzoJDKPdaIcPKSkQG9n/Lb
         ibLZns6Acg4YRH7j+ouYs4oumXrEfIJkZSZEqkYDbunHkLJ+7bIRaTi+u9gG+23aCX3C
         PoImShiscxRG8jcGObJQsYX8OQWQRJmW8M8StODHf5go0DJRB/JsuxMlcZPH10+ZYdxR
         0aPn0j18TWgFK4RJptCeTPrpGC3GdvDLrFWm5RWcdHu22ox193okq9UeK8gIvQfLT8JQ
         CRPd5zE5IbPuB39nI7A/UHYarJJj+pZrW3Tv4bEQhCBs6NFLrKrZ1LeYGQ2ECjtv3REX
         qAWw==
X-Forwarded-Encrypted: i=1; AL+hErGs2/PR/26dJ8hb0/O0cfpsaEbsCLYHycuU/nL5LuPd/tj3noQc6oVw46QyZzF6BAC6+AlDW0+BuNdHsis3pKDqnmYGx6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LPh50FOcqxmJiFewbymWSps1+BX4B3sfkUt7b3gktvMinu3Tu
	M3xOsA88cPes/2JzPrJD0FxGgTH4r524hjQGb0bCObBzCo/nlivzmIRCJMvoC1fQzWnu
X-Gm-Gg: AYBFou0z3Li46Gz9rmCtfXLpQu0lhApd58jjwIh9yN5VDtm4uLKnXSsO1MrkC1idaWt
	tJlpnXq94Qly5AthB8MWYz47kP86c18+CBSsYjG3kAEeegCatyL0udW/dL6u7t6YaFV12FFTxNn
	E6vxS8NlsdAloNVQm0s70djOjKWxyBRTkeCGJai5gxUetaxlgnJEmKirbmekg8vhRBhie6vedcM
	SMwCnXYIFBk4byxYfWCUPVJMXTpPDpJs85F4fhfeYPOSdofGKgpOlx/aD237TDaiXcpz6WJmovF
	PbhdyR3FcqFhSBpvREdP2OpKp/hXPMtg4Hc1g76pZBzHZy3UaH8SAQ02C89K9Dmg2Urml/Y6hBq
	t3QcM/rlkCHDlpJH4yxnWPjURJHPPUF0PsX+GnhY9vZfj8klvC44fLEdVBSkjZkb2TZZkQH6z1I
	qK7p/oA7fubyJfRKPjzWeHmtTro06vEoLmFrFEx92DlVNIsu48c7s0TyyhbnuI5pA+cqpiN0UMl
	WIaQd2z6lnbNWwkOzHcC/VwV66IeAqv4eUldm/rBS9pHHpSlsDrRM05lwV4ze0nF4fzaiZRLJhU
	cdC4DYpR1+FhZfV9XM1yq33nhD75ORsMBH4mA5/qaA9dtrj+jm1NBXuzGV1sIrY=
X-Received: by 2002:a05:600c:428c:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4bb55aabd53mr26666375e9.29.1794565721222;
        Fri, 13 Nov 2026 02:28:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm152260095e9.2.2026.11.13.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:28:40 -0800 (PST)
Message-ID: <ae5a09a7dc0ab5d01e78114c38e90b39af32362c.camel@amutable.com>
Subject: Re: [PATCH RFC 41/41] selftests/filesystems: add backing file tests
 for pseudo files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:28:38 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-41-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-41-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Add tests that files on pseudo filesystems can't be used as storage:
>=20
> - a procfs file attached read-only to a loop device
> - sysfs files attached read-only and read-write to a loop device
> - a sysfs file behind a lower-only overlayfs attached to a loop
> device
> - a sysfs file as the backing file of a usb mass storage gadget LUN
> - a sysfs file as the source of a file-backed erofs mount
>=20
> And make sure that a memfd and another loop device still work as loop
> backing files and that loop refuses a backing file that isn't open
> for
> reading.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0tools/testing/selftests/filesystems/.gitignore=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0tools/testing/selftests/filesystems/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0tools/testing/selftests/filesystems/config=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> =C2=A0.../selftests/filesystems/pseudo_backing_test.c=C2=A0=C2=A0=C2=A0 |=
 274
> +++++++++++++++++++++
> =C2=A04 files changed, 285 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/filesystems/.gitignore
> b/tools/testing/selftests/filesystems/.gitignore
> index cf79000e4092..8df38eabb125 100644
> --- a/tools/testing/selftests/filesystems/.gitignore
> +++ b/tools/testing/selftests/filesystems/.gitignore
> @@ -7,3 +7,4 @@ kernfs_test
> =C2=A0idmapped_tmpfile
> =C2=A0ustat_test
> =C2=A0rw_hint_test
> +pseudo_backing_test
> diff --git a/tools/testing/selftests/filesystems/Makefile
> b/tools/testing/selftests/filesystems/Makefile
> index fbd5c27505ef..0ebb9005bcd2 100644
> --- a/tools/testing/selftests/filesystems/Makefile
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -2,7 +2,7 @@
> =C2=A0
> =C2=A0CFLAGS +=3D $(KHDR_INCLUDES)
> =C2=A0TEST_GEN_PROGS :=3D devpts_pts anon_inode_test kernfs_test fclog
> ustat_test rw_hint_test
> -TEST_GEN_PROGS +=3D idmapped_tmpfile
> +TEST_GEN_PROGS +=3D idmapped_tmpfile pseudo_backing_test
> =C2=A0TEST_GEN_PROGS_EXTENDED :=3D dnotify_test
> =C2=A0
> =C2=A0include ../lib.mk
> diff --git a/tools/testing/selftests/filesystems/config
> b/tools/testing/selftests/filesystems/config
> index 9f45bc493a30..228196160d29 100644
> --- a/tools/testing/selftests/filesystems/config
> +++ b/tools/testing/selftests/filesystems/config
> @@ -6,3 +6,12 @@ CONFIG_NET=3Dy
> =C2=A0CONFIG_NET_NS=3Dy
> =C2=A0CONFIG_INET=3Dy
> =C2=A0CONFIG_SYSFS=3Dy
> +CONFIG_BLK_DEV_LOOP=3Dy
> +CONFIG_OVERLAY_FS=3Dy
> +CONFIG_TMPFS=3Dy
> +CONFIG_CONFIGFS_FS=3Dy
> +CONFIG_USB_GADGET=3Dy
> +CONFIG_USB_CONFIGFS=3Dy
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
> +CONFIG_EROFS_FS=3Dy
> +CONFIG_EROFS_FS_BACKED_BY_FILE=3Dy
> diff --git
> a/tools/testing/selftests/filesystems/pseudo_backing_test.c
> b/tools/testing/selftests/filesystems/pseudo_backing_test.c
> new file mode 100644
> index 000000000000..bc8e17ab8e6e
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/pseudo_backing_test.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/loop.h>
> +#include <linux/magic.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/vfs.h>
> +
> +#include "kselftest_harness.h"
> +#include "wrappers.h"
> +
> +/*
> + * Put @fd behind a free loop device. The device is set up with
> + * LO_FLAGS_AUTOCLEAR and goes away again when it is closed here.
> + */
> +static int loop_attach(int fd, bool rw, char *dev, size_t len)
> +{
> +	struct loop_config cfg =3D {};
> +	int ctl, nr, lfd, ret =3D 0;
> +
> +	ctl =3D open("/dev/loop-control", O_RDWR | O_CLOEXEC);
> +	if (ctl < 0)
> +		return -errno;
> +	nr =3D ioctl(ctl, LOOP_CTL_GET_FREE);
> +	if (nr < 0)
> +		ret =3D -errno;
> +	close(ctl);
> +	if (ret)
> +		return ret;
> +
> +	snprintf(dev, len, "/dev/loop%d", nr);
> +	lfd =3D open(dev, (rw ? O_RDWR : O_RDONLY) | O_CLOEXEC);
> +	if (lfd < 0)
> +		return -errno;
> +
> +	cfg.fd =3D fd;
> +	cfg.info.lo_flags =3D LO_FLAGS_AUTOCLEAR;
> +	if (!rw)
> +		cfg.info.lo_flags |=3D LO_FLAGS_READ_ONLY;
> +	if (ioctl(lfd, LOOP_CONFIGURE, &cfg)) {
> +		ret =3D -errno;
> +		close(lfd);
> +	} else {
> +		ret =3D lfd;
> +	}
> +	return ret;
> +}
> +
> +static int attach_path(const char *path, bool rw)
> +{
> +	char dev[PATH_MAX];
> +	int fd, ret;
> +
> +	fd =3D open(path, (rw ? O_RDWR : O_RDONLY) | O_CLOEXEC);
> +	if (fd < 0)
> +		return -errno;
> +	ret =3D loop_attach(fd, rw, dev, sizeof(dev));
> +	close(fd);
> +	if (ret >=3D 0) {
> +		close(ret);
> +		ret =3D 0;
> +	}
> +	return ret;
> +}
> +
> +static bool can_use_loop(void)
> +{
> +	return geteuid() =3D=3D 0 && access("/dev/loop-control", R_OK |
> W_OK) =3D=3D 0;
> +}
> +
> +TEST(memfd_backing_file)
> +{
> +	char dev[PATH_MAX];
> +	int fd, lfd;
> +
> +	if (!can_use_loop())
> +		SKIP(return, "loop devices unavailable");
> +
> +	fd =3D memfd_create("pseudo_backing_test", MFD_CLOEXEC);
> +	ASSERT_GE(fd, 0);
> +	ASSERT_EQ(ftruncate(fd, 1 << 20), 0);
> +
> +	lfd =3D loop_attach(fd, true, dev, sizeof(dev));
> +	ASSERT_GE(lfd, 0);
> +	EXPECT_EQ(close(lfd), 0);
> +	EXPECT_EQ(close(fd), 0);
> +}
> +
> +TEST(loop_device_backing_file)
> +{
> +	char dev[PATH_MAX], dev2[PATH_MAX];
> +	int fd, lfd, bfd, lfd2;
> +
> +	if (!can_use_loop())
> +		SKIP(return, "loop devices unavailable");
> +
> +	fd =3D memfd_create("pseudo_backing_test", MFD_CLOEXEC);
> +	ASSERT_GE(fd, 0);
> +	ASSERT_EQ(ftruncate(fd, 1 << 20), 0);
> +	lfd =3D loop_attach(fd, true, dev, sizeof(dev));
> +	ASSERT_GE(lfd, 0);
> +
> +	/* A block device stays fine as a backing file. */
> +	bfd =3D open(dev, O_RDWR | O_CLOEXEC);
> +	ASSERT_GE(bfd, 0);
> +	lfd2 =3D loop_attach(bfd, true, dev2, sizeof(dev2));
> +	ASSERT_GE(lfd2, 0);
> +
> +	EXPECT_EQ(close(lfd2), 0);
> +	EXPECT_EQ(close(bfd), 0);
> +	EXPECT_EQ(close(lfd), 0);
> +	EXPECT_EQ(close(fd), 0);
> +}
> +
> +TEST(write_only_backing_file)
> +{
> +	char dev[PATH_MAX], path[PATH_MAX];
> +	int fd, wfd, lfd;
> +
> +	if (!can_use_loop())
> +		SKIP(return, "loop devices unavailable");
> +
> +	fd =3D memfd_create("pseudo_backing_test", MFD_CLOEXEC);
> +	ASSERT_GE(fd, 0);
> +	ASSERT_EQ(ftruncate(fd, 1 << 20), 0);
> +
> +	/* Loop reads from its backing file so it must be open for
> reading. */
> +	snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
> +	wfd =3D open(path, O_WRONLY | O_CLOEXEC);
> +	ASSERT_GE(wfd, 0);
> +
> +	lfd =3D loop_attach(wfd, true, dev, sizeof(dev));
> +	if (lfd >=3D 0)
> +		close(lfd);
> +	EXPECT_EQ(lfd, -EBADF);
> +	EXPECT_EQ(close(wfd), 0);
> +	EXPECT_EQ(close(fd), 0);
> +}
> +
> +TEST(procfs_backing_file)
> +{
> +	if (!can_use_loop())
> +		SKIP(return, "loop devices unavailable");
> +
> +	ASSERT_EQ(attach_path("/proc/cpuinfo", false), -EINVAL);
> +}
> +
> +TEST(sysfs_backing_file)
> +{
> +	if (!can_use_loop())
> +		SKIP(return, "loop devices unavailable");
> +
> +	ASSERT_EQ(attach_path("/sys/kernel/warn_count", false), -
> EINVAL);
> +
> +	if (access("/sys/kernel/reboot/mode", F_OK))
> +		SKIP(return, "no /sys/kernel/reboot/mode");
> +	ASSERT_EQ(attach_path("/sys/kernel/reboot/mode", true), -
> EINVAL);
> +}
> +
> +TEST(overlayfs_on_sysfs_backing_file)
> +{
> +	if (!can_use_loop())
> +		SKIP(return, "loop devices unavailable");
> +
> +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL),
> 0);
> +	ASSERT_EQ(mount("tmpfs", "/tmp", "tmpfs", 0, NULL), 0);
> +	ASSERT_EQ(mkdir("/tmp/empty", 0755), 0);
> +	ASSERT_EQ(mkdir("/tmp/merged", 0755), 0);
> +
> +	/* A lower-only overlayfs serves reads from sysfs. */
> +	if (mount("overlay", "/tmp/merged", "overlay", MS_RDONLY,
> +		=C2=A0 "lowerdir=3D/sys/kernel:/tmp/empty"))
> +		SKIP(return, "no overlayfs on top of sysfs: %s",
> strerror(errno));
> +
> +	ASSERT_EQ(attach_path("/tmp/merged/warn_count", false), -
> EINVAL);
> +}
> +
> +#define CONFIGFS_DIR "/sys/kernel/config"
> +#define GADGET_DIR CONFIGFS_DIR "/usb_gadget/pseudo_backing_test"
> +#define MASS_STORAGE_DIR GADGET_DIR "/functions/mass_storage.0"
> +
> +TEST(usb_mass_storage_backing_file)
> +{
> +	const char *path =3D "/sys/kernel/warn_count";
> +	struct statfs sfs;
> +	ssize_t ret;
> +	int fd, err;
> +
> +	if (geteuid())
> +		SKIP(return, "needs root");
> +
> +	/* Mounting configfs on top of itself fails with EBUSY. */
> +	if (statfs(CONFIGFS_DIR, &sfs) || sfs.f_type !=3D
> CONFIGFS_MAGIC) {
> +		ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +		ASSERT_EQ(mount(NULL, "/", NULL, MS_REC |
> MS_PRIVATE, NULL), 0);
> +		if (mount("configfs", CONFIGFS_DIR, "configfs", 0,
> NULL))
> +			SKIP(return, "no configfs: %s",
> strerror(errno));
> +	}
> +
> +	if (mkdir(GADGET_DIR, 0755))
> +		SKIP(return, "no usb gadget configfs: %s",
> strerror(errno));
> +	if (mkdir(MASS_STORAGE_DIR, 0755)) {
> +		err =3D errno;
> +		rmdir(GADGET_DIR);
> +		SKIP(return, "no usb mass storage function: %s",
> strerror(err));
> +	}
> +
> +	/* Writing the path opens the LUN's backing file right away.
> */
> +	fd =3D open(MASS_STORAGE_DIR "/lun.0/file", O_WRONLY |
> O_CLOEXEC);
> +	EXPECT_GE(fd, 0);
> +	if (fd >=3D 0) {
> +		ret =3D write(fd, path, strlen(path));
> +		err =3D errno;
> +		EXPECT_EQ(ret, -1);
> +		EXPECT_EQ(err, EINVAL);
> +		EXPECT_EQ(close(fd), 0);
> +	}
> +
> +	EXPECT_EQ(rmdir(MASS_STORAGE_DIR), 0);
> +	EXPECT_EQ(rmdir(GADGET_DIR), 0);
> +}
> +
> +TEST(erofs_backing_file)
> +{
> +	bool refused =3D false;
> +	char buf[256];
> +	int fsfd, ret, err;
> +	ssize_t n;
> +
> +	if (geteuid())
> +		SKIP(return, "needs root");
> +
> +	fsfd =3D sys_fsopen("erofs", FSOPEN_CLOEXEC);
> +	if (fsfd < 0)
> +		SKIP(return, "no erofs: %s", strerror(errno));
> +
> +	ASSERT_EQ(sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/sys/kernel/warn_count", 0), 0)=
;
> +	ret =3D sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL,
> 0);
> +	err =3D errno;
> +	if (ret && err =3D=3D ENOTBLK) {
> +		close(fsfd);
> +		SKIP(return, "no file-backed erofs mounts");
> +	}
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(err, EINVAL);
> +
> +	/*
> +	 * Something that isn't an erofs image fails with EINVAL as
> well so
> +	 * check that the source itself was refused.
> +	 */
> +	while ((n =3D read(fsfd, buf, sizeof(buf) - 1)) > 0) {
> +		buf[n] =3D '\0';
> +		if (strstr(buf, "pseudo filesystem"))
> +			refused =3D true;
> +	}
> +	EXPECT_TRUE(refused);
> +	EXPECT_EQ(close(fsfd), 0);
> +}
> +
> +TEST_HARNESS_MAIN
