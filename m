Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481037;
	b=UyiyazOh2WRjwHRaq2kVJtQJ6SCL6A4BDjnMQVoMrbASz8lTciFCTyaUpufvt7Skq3BW
	 GcDkCR9ILWy9IoG4zJjc/5ntscoulgtIjuuUSBp6BJsjsGywLXqSafVHGx798z43pR1a2
	 Vc17BlchTowziV3hT/nKPm2J+QTiHBxJF6bJzcx1b5fHwvcHmlrGbM+MGKHUSTCY9aV4b
	 6/K/wzGEJQy+cfNvUG4lXtcyN7R1BKB6ZaVc2Ra9IE12v6cJdJz568zomrCf8OayPT7WH
	 9PvwoPWh3C8h0eg1PCtztRyzSPXjoOSSPX0l7h7ZBwvW1TCVrpLmWicXtYggT+yR7HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481037;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6x3KS81Te4KDKsrtlqBV3wwienvY6Lov0v5ELrnKB/U=;
	b=IVc2NRjSVMFnOm2WY6CT2C+w4kO9Zj0969TD6PlEzspX3mGaxBzznP2kVLCX8VPz2mCh
	 nAZm3u/SdhNg+FAvohRrI9T65hisWvK4DV0DzKtUhukV5BZtLtYf/GrnwgadEDMrxGTSB
	 Jowx0S24o2MhfzR0NPfj1fRXpFoDiSyXGJcHyDo9/Q2iDNPt0n3iO9mVIfyrzaZKzJfiV
	 oDT1q8UDlEHq35bGDd97ReVxgs7pPR7r13z7p7Gx80YLKLp3HHegGTVufZS6Rcq0+2pSs
	 /xj37JCHYqatflN+im8Y/dI55pd+mOaMwRBXGX2R+aURGDPhgrCWp21XZ2O1wu6497A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTU+82YF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F371606A31C;
	Sat, 31 Oct 2026 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTU+82YF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F3E1F00919;
	Sat, 31 Oct 2026 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481036;
	bh=6x3KS81Te4KDKsrtlqBV3wwienvY6Lov0v5ELrnKB/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTU+82YFl8ci5g9tdM1tlMrGvwu1LkY3ZrRIdpAdEhdOtJH72xWkM+tjj7jzQOfz3
	 /oHJI9uB6l7DkXstKdikD00iMHQbXASeXsfXqwd7LUxroZRA7ojoV/TxKIDlmWd1Dy
	 JysYpvNJJj4arzzEBXnUf/SfPj5DX7d0P6EbeG244UqrSoE14SAzFR2hnkojH1XNSz
	 FL6pFzADH/StMF0+zszl9cnZPPhtrz94KXUKCwvRTK0rg7govWUsf5tMKzOzxjytMA
	 ra141yh1rszwOOR+HmmJxJsZJP/gyTrQ20yU+fvj6hEnkTfZuhWlRKocuQb9738LXl
	 MvUSy8WKoJ3qw==
Message-ID: <sashiko-outbox-192153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] gen_init_cpio: add support for file metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Hu" <dannyhu@arista.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>
Cc: "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Dmitry
 Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric Snowberg" <eric.snowberg@oracle.com>, "Jan
 Kara" <jack@suse.cz>, "Victor Kamensky" <kamensky@cisco.com>, "Taras
 Kondratiuk" <takondra@cisco.com>, "Tianxing Zhang" <zhangtianxing3@huawei.com>, "Zheng
 Zengkai" <zhengzengkai@huawei.com>, zhoushuiqing <zhoushuiqing2@huawei.com>, zhangguangzhi <zhangguangzhi3@huawei.com>, "Jason
 Yan" <yanaijie@huawei.com>, silviu.vlasceanu@huawei.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com, pierre@arista.com, julien@arista.com, kbharathi@arista.com, erosca@de.adit-jv.com, alexandr.lobakin@intel.com, jim_baxter@mentor.com, linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, bug-cpio@gnu.org, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261030210944.2143778-5-dannyhu@arista.com>
References: <20261030210944.2143778-1-dannyhu@arista.com>
 <20261030210944.2143778-5-dannyhu@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:10:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] initramfs: NULL path passed to llistxattr() in write_xattrs()
- [Low] initramfs: undefined __packed macro in host tool usr/gen_init_cpio.c
--

commit f793fe8aaa70c6c2c7baf3bf7456e36e56bc7fcf
Author: Roberto Sassu <roberto.sassu@huawei.com>

gen_init_cpio: add support for file metadata

This commit adds support for including extended attribute (TYPE_XATTR) file
metadata in initramfs cpio archives as separate METADATA!!! entries when
configured via CONFIG_INITRAMFS_FILE_METADATA.

> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index b7296edc6626f..f07be54c9219e 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -6,6 +6,7 @@
>  #include <stdbool.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/xattr.h>
>  #include <string.h>
>  #include <unistd.h>
>  #include <time.h>
> @@ -13,6 +14,7 @@
>  #include <errno.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include "../include/linux/initramfs.h"

[Severity: Low]
Since usr/gen_init_cpio.c is compiled as a host userspace program with HOST=
CC
and standard libc headers, is the kernel __packed macro defined when
including ../include/linux/initramfs.h?

In include/linux/initramfs.h:

	struct metadata_hdr {
		char c_size[8];     /* total size including c_size field */
		char c_version;     /* header version */
		char c_type;        /* metadata type */
		char c_metadata[];  /* metadata */
	} __packed;

Without a definition for __packed, the host compiler leaves struct
metadata_hdr unpacked and instead parses __packed as a tentative definition
of a global variable named __packed of type struct metadata_hdr.

Should __packed be defined before including initramfs.h (or compiler_attrib=
utes.h
included)?

> @@ -37,12 +39,126 @@ static bool do_file_mtime;
[ ... ]
> +static int write_xattrs(const char *path)
> +{
> +	struct metadata_hdr hdr =3D { .c_version =3D 1, .c_type =3D TYPE_XATTR =
};
> +	char str[sizeof(hdr.c_size) + 1];
> +	char *xattr_list, *list_ptr;
> +	char *xattr_value =3D NULL;
> +	ssize_t list_len, name_len, value_len, len;
> +	int ret =3D -EINVAL;
> +
> +	if (metadata_fd < 0)
> +		return 0;
> +
> +	if (path =3D=3D metadata_path)
> +		return 0;
> +
> +	list_len =3D llistxattr(path, NULL, 0);

[Severity: Medium]
Can path be NULL when passed to llistxattr() in write_xattrs()?

For non-regular cpio list entries (slink, dir, pipe, sock, and nod), the
source location field is optional and is omitted in standard list files such
as usr/default_cpio_list. When location is omitted, cpio_mkslink_line(),
cpio_mkgeneric_line(), and cpio_mknod_line() pass NULL as location:

	cpio_mkgeneric_line()
	  cpio_mkgeneric(name,
			 nfields =3D=3D 5 ? cpio_replace_env(location) : NULL,
			 mode, uid, gid)
	    write_xattrs(location)

When gen_init_cpio is invoked with -e xattr, metadata_fd is valid and
write_xattrs() only checks if (metadata_fd < 0) and if (path =3D=3D metadat=
a_path)
before calling llistxattr(NULL, NULL, 0).

Passing a NULL path to llistxattr() violates the glibc nonnull attribute on
the first parameter (triggering UBSan failures) and can cause a segmentation
fault under LD_PRELOAD environments such as fakeroot or pseudo that
dereference the path string in userspace.

Should write_xattrs() also return 0 if !path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030210944.2143=
778-1-dannyhu@arista.com?part=3D4
