Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481032;
	b=VNmtIxXQ7nV6+i9JqdWuX8ijdL7K/BP5ybJLtayRwdlis8gqJbxCZ0Y2lCmqZIM7F2UJ
	 88CkoAnDfRB9mG3ce2wu9OfqbKYJaMTyw/n3P8iD9vp/gBeEC311FhZfTJtFKAtIq+CZS
	 dcdLersR/h8TZd/V+6S7WgNcJCUl7Jix1bArk9L1XDcIzkyx8DA7D83T5zFfs0/IAiP6q
	 vGhCF5CHHH0jPGyJEilG7oXEuFqvDKeyWS5kaA3EkQOjAd3yaEsdtJgLia/0onyP0TLaR
	 TrIWrYVF2NhP+jLL3LMW0Gu21RHjuVvomsw7DYdnwH9xuFjnJ0qGk/riyfIpsZh5QXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VYn6HO4Ntt0suu764wFEemFVKHyiR2045DMjiOtHR60=;
	b=gWxqrqYXvTUmSzjN6YQD4n6Krep43hLFj2Ds8nwXcb08E4L6lk/YLdPhx2bPZaET720N
	 qXl0dvZxNPK/QqEahmark52et1bbkGrFwRKayIi7ER3dcZub3Z6NxkgQkFsH04wtVbIWm
	 mJIoNLRBMwYXrMgoCfOVrSQyG0jtBLDFoB0v6khYcspEgDmBvlQxM+fqJwYLF5rryx6mH
	 oS4MNs/AGgzRKNtAurA5oDGmR9j1gxPsCUJNWAjjvzX4bw5AC+Egb5ay0iBb/sFKL98/y
	 ObBEpcBm8m3HhHWIBCKX/qVQ0Hva01f+NVjq6ryoqFvVZVo6O21reNqtDmYEbN3bU9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SOunHr0/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD05606A31A;
	Sat, 31 Oct 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOunHr0/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED711F00919;
	Sat, 31 Oct 2026 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481032;
	bh=VYn6HO4Ntt0suu764wFEemFVKHyiR2045DMjiOtHR60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOunHr0/cxkiGOn6tIpjJWzLqzd19JvjDnglMARUTBMIE+O+bz5L9v2w3Rw0N0dg4
	 RpvW0VsCTETVaL+zY/6sOxciEmdB/66Z/01EST32BwUFDGsisVSiRYCgoYMkahuFmU
	 zdYxRT271DLR/kEhFUv124d1OZMwldDyqsEWcXLovTremP4o3HsZ3rvT8OT6Aya0fH
	 NBCPX04OMiYr9R3Gpoz4Y6rt+SJIn7xAmZWzstdVaW1vb3h0ZZ+etfhKzbydDKha3i
	 0Voz+koHCfFXFRiCIsaUF+2hfGQuxjbGmilKOPvLuaQZwWPbfkCIQrPsBIDDWL+cNk
	 OPO53FiFwvpOA==
Message-ID: <sashiko-outbox-192151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] initramfs: add file metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Hu" <dannyhu@arista.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>
Cc: "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Dmitry
 Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric Snowberg" <eric.snowberg@oracle.com>, "Jan
 Kara" <jack@suse.cz>, "Victor Kamensky" <kamensky@cisco.com>, "Taras
 Kondratiuk" <takondra@cisco.com>, "Tianxing Zhang" <zhangtianxing3@huawei.com>, "Zheng
 Zengkai" <zhengzengkai@huawei.com>, zhoushuiqing <zhoushuiqing2@huawei.com>, zhangguangzhi <zhangguangzhi3@huawei.com>, "Jason
 Yan" <yanaijie@huawei.com>, silviu.vlasceanu@huawei.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com, pierre@arista.com, julien@arista.com, kbharathi@arista.com, erosca@de.adit-jv.com, alexandr.lobakin@intel.com, jim_baxter@mentor.com, linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, bug-cpio@gnu.org, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261030210944.2143778-3-dannyhu@arista.com>
References: <20261030210944.2143778-1-dannyhu@arista.com>
 <20261030210944.2143778-3-dannyhu@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:10:30 +0000
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
- [High] initramfs: pointer arithmetic overflow in do_parse_metadata() boun=
ds checks
- [Medium] initramfs: do_setxattrs() rejects POSIX ACLs and skips xattr siz=
e limits
--

commit a61596ea347667fb16df9d8f6201e38b916f632c
Author: Mimi Zohar <zohar@linux.vnet.ibm.com>

initramfs: add file metadata

This commit introduces do_parse_metadata() and do_setxattrs() to parse
metadata records from a buffer and restore extended attributes onto files
in the initramfs.

> diff --git a/init/initramfs.c b/init/initramfs.c
> index ebddde9c8f0d9..36254dba78226 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c

[ ... ]

> @@ -365,6 +368,90 @@ static int __init maybe_link(void)
>  	return 0;
>  }
> =20
> +static int __init do_setxattrs(char *pathname, char *buf, size_t size)
> +{
> +	struct path path;
> +	char *xattr_name, *xattr_value;
> +	uint32_t xattr_name_size, xattr_value_size;
> +	int ret;
> +
> +	xattr_name =3D buf;
> +	xattr_name_size =3D strnlen(xattr_name, size);
> +	if (xattr_name_size =3D=3D size) {
> +		error("malformed xattrs");
> +		return -EINVAL;
> +	}
> +
> +	xattr_value =3D xattr_name + xattr_name_size + 1;
> +	xattr_value_size =3D buf + size - xattr_value;
> +
> +	ret =3D kern_path(pathname, 0, &path);
> +	if (!ret) {
> +		ret =3D vfs_setxattr(&nop_mnt_idmap, path.dentry, xattr_name, xattr_va=
lue,
> +				   xattr_value_size, 0);
> +
> +		path_put(&path);
> +	}

[Severity: Medium]
What happens when a metadata record in the initramfs contains POSIX ACL
extended attributes (system.posix_acl_access or system.posix_acl_default),
or when xattr_name_size or xattr_value_size exceeds the standard VFS
limits?

In fs/xattr.c, the normal setxattr path (do_setxattr()) checks
is_posix_acl_xattr() and dispatches POSIX ACLs to do_set_acl(), whereas
vfs_setxattr() -> __vfs_setxattr_locked() -> __vfs_setxattr_noperm() ->
__vfs_setxattr() explicitly rejects them:

    if (is_posix_acl_xattr(name))
        return -EOPNOTSUPP;

Because gen_init_cpio collects all extended attributes via llistxattr()
and lgetxattr(), any POSIX ACLs packed into the archive will fail to be
restored on rootfs (when CONFIG_TMPFS_POSIX_ACL=3Dy) with -EOPNOTSUPP.

In addition, unlike import_xattr_name() and setxattr_copy(), which enforce
a non-empty name up to XATTR_NAME_MAX (255) and a value up to
XATTR_SIZE_MAX (65536), do_setxattrs() only checks xattr_name_size =3D=3D s=
ize
before calling vfs_setxattr(). On tmpfs/rootfs, shmem_xattr_handler_set() ->
simple_xattr_set() will allocate and insert oversized names or values into
the inode xattr list, after which userspace getxattr(2) and removexattr(2)
calls fail with -E2BIG or -ERANGE.

Should do_setxattrs() validate xattr_name_size (1..XATTR_NAME_MAX) and
xattr_value_size (<=3D XATTR_SIZE_MAX), and dispatch POSIX ACL xattrs via
vfs_set_acl() (or use the VFS helper that handles both)?

> +
> +	pr_debug("%s: %s size: %u (ret: %d)\n", pathname, xattr_name,
> +		 xattr_value_size, ret);
> +	print_hex_dump_debug("xattr value: ", DUMP_PREFIX_OFFSET,
> +			     16, 1, xattr_value, xattr_value_size, false);
> +
> +	return ret;
> +}
> +
> +static int __init __maybe_unused do_parse_metadata(char *pathname)
> +{
> +	char *buf =3D metadata_buf;
> +	char *bufend =3D metadata_buf + metadata_len;
> +	struct metadata_hdr *hdr;
> +	char str[sizeof(hdr->c_size) + 1];
> +	uint32_t entry_size;
> +
> +	if (!metadata_len)
> +		return 0;
> +
> +	str[sizeof(hdr->c_size)] =3D 0;
> +
> +	while (buf < bufend) {
> +		int ret;
> +
> +		if (buf + sizeof(*hdr) > bufend) {
> +			error("malformed metadata");
> +			break;
> +		}
> +
> +		hdr =3D (struct metadata_hdr *)buf;
> +		if (hdr->c_version !=3D 1) {
> +			pr_debug("Unsupported header version\n");
> +			break;
> +		}
> +
> +		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
> +		ret =3D kstrtou32(str, 16, &entry_size);
> +		if (ret || buf + entry_size > bufend ||
> +		    entry_size < sizeof(*hdr)) {
> +			error("malformed xattrs");
> +			break;
> +		}
> +
> +		switch (hdr->c_type) {
> +		case TYPE_XATTR:
> +			do_setxattrs(pathname, buf + sizeof(*hdr),
> +				     entry_size - sizeof(*hdr));
> +			break;
> +		default:
> +			pr_debug("Unsupported metadata type\n");
> +			break;
> +		}
> +
> +		buf +=3D entry_size;
> +	}

[Severity: High]
Can adding entry_size to buf in do_parse_metadata() overflow pointer
arithmetic and bypass the bounds check?

kstrtou32(str, 16, &entry_size) parses an 8-character hex value from
hdr->c_size into a 32-bit unsigned integer up to 0xffffffff. On 32-bit
architectures (where kernel virtual addresses reside in the upper address
space, such as >=3D 0xc0000000 or >=3D 0x80000000), or on 64-bit architectu=
res
if metadata_buf lies in the top 4 GiB of the address space, adding a large
entry_size to buf wraps around the address space to an address lower than
bufend.

When that wraparound occurs, both buf + entry_size > bufend and
entry_size < sizeof(*hdr) evaluate to false, passing a huge out-of-bounds
length (entry_size - sizeof(*hdr)) to do_setxattrs() for strnlen(),
vfs_setxattr(), and print_hex_dump_debug(), and then advancing buf to the
wrapped address below bufend.

Since the loop condition while (buf < bufend) guarantees bufend > buf,
should the bounds checks compare sizes against bufend - buf instead, i.e.
bufend - buf < sizeof(*hdr) and entry_size > bufend - buf?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030210944.2143=
778-1-dannyhu@arista.com?part=3D2
