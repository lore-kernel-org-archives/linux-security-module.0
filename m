Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481034;
	b=k+OxKEjfJPLU0RY74LwBV2cjTlHSkYN0pFKXYHlb6TELVTmr/cmcSVzoS/rr7bogSXLl
	 rwiXLaEwBC53TlmhBRAfp17sVcvIq1ALyRDses26uClzZBgbJ2qDHBSmbnsCnvHOybg13
	 pADh0NnFovhU3X3aVtv+ztPmu3iYyloC+tfn8bkPxJfiQZ3EvSyfHLcpfMZ2bZlkYTGwZ
	 hnNLDUrdM5yC3larbppMYLDX+HAOddgDp5Nb8zQXpMA5zS2eBNjczciC/WyXlCPFOh3Zr
	 iOLGfn8ASuV3aDbI7QJFPj0IBb0gx+ERf/9HBhQzEUrlrXGQVcf67P3xmYKCrFQG85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QmGsf7izUBb/fkI7bQs6MNedebQLL0nz02LTM6vnduI=;
	b=NPz1R13sZsv9FpHYogY6NJ4uUzQLfyX0Q9jsiNayfZQjl6PSpFZUwKLqhg42Op8bB+2P
	 ze4mpp7zP4AKWciXrKIVCLnP6SVMJvXddYENH9I0a4GsUtgxoK8C1bFcU/0rKOGJw3h5W
	 DAXorTFYx9FndVFA70zoxVzpnUgeXiDNGIPOdoiOSH6fiaQnV4HZyNjouSAIZ+oFiw060
	 tMscVGAHJylaf/eS+uYyavhqmnneHzccUHuiGI6GiDCyAQarnVwV/7uXZ4sYhvztV7v/c
	 uJYNr+VxBewzLn7XgaR+OAICA5YCTMxrnVuVgkl+F8MAeMFlMx8bahzxKgIT2IepjLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhhwtdpO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0C606A321;
	Sat, 31 Oct 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhhwtdpO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A691F000C1;
	Sat, 31 Oct 2026 21:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481034;
	bh=QmGsf7izUBb/fkI7bQs6MNedebQLL0nz02LTM6vnduI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mhhwtdpOYeAQNCYpLj+9tsf7o1ZiOpXB7+zTlu59wEr9lxUBfENzzBWOFrHa1EwQA
	 y/cs13+4YUuEEt351+fzcMSQ/Vqbhy8Xs9msPZ2CbXP6Xen2j/jpm1Xot6Sk7ymYP0
	 82XabwU2rF7ioDfMfHgJs6HNkGHeIaL6f6FHUdz9zUjhPYkbV8HlLMTg4NxTFyIoM+
	 4KBbn/QXXJHNEU/FCOnKnZUsVRlikfgAOueUntqH+CP4zWWe9f1qNJoM1djvNnLMJ1
	 5gWZ7kxlqdoaJlciBp2hp+7sPG0i9APy7/2mv/E35Bzr4aVMBfT2hk7y7PrsPnT6Y7
	 qvwmNx017E4UQ==
Message-ID: <sashiko-outbox-192152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] initramfs: read metadata from special file
 METADATA!!!
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Hu" <dannyhu@arista.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>
Cc: "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Dmitry
 Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric Snowberg" <eric.snowberg@oracle.com>, "Jan
 Kara" <jack@suse.cz>, "Victor Kamensky" <kamensky@cisco.com>, "Taras
 Kondratiuk" <takondra@cisco.com>, "Tianxing Zhang" <zhangtianxing3@huawei.com>, "Zheng
 Zengkai" <zhengzengkai@huawei.com>, zhoushuiqing <zhoushuiqing2@huawei.com>, zhangguangzhi <zhangguangzhi3@huawei.com>, "Jason
 Yan" <yanaijie@huawei.com>, silviu.vlasceanu@huawei.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com, pierre@arista.com, julien@arista.com, kbharathi@arista.com, erosca@de.adit-jv.com, alexandr.lobakin@intel.com, jim_baxter@mentor.com, linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, bug-cpio@gnu.org, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261030210944.2143778-4-dannyhu@arista.com>
References: <20261030210944.2143778-1-dannyhu@arista.com>
 <20261030210944.2143778-4-dannyhu@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:10:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] initramfs: METADATA!!! extracted as real file in rootfs by do_name=
()
- [High] initramfs: stale metadata flag in do_name() when CopyFile is skipp=
ed
- [High] initramfs: uninitialized or stale previous_name_buf in do_parse_me=
tadata()
- [High] initramfs: pointer overflow on entry_size check in do_parse_metada=
ta()
--

commit 5bc33bcd28bade616f8daa53d99ada76540074e5
Author: Roberto Sassu <roberto.sassu@huawei.com>

initramfs: read metadata from special file METADATA!!!

This commit adds support for extracting file metadata from special CPIO
archive entries named METADATA!!! that immediately follow the target file.
When a METADATA!!! entry is encountered, its contents are buffered in
do_process_metadata() and passed to do_parse_metadata() to apply extended
attributes to the preceding pathname.

> diff --git a/init/initramfs.c b/init/initramfs.c
> index 36254dba78226..a1744cc9523c2 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c

[ ... ]

> @@ -471,6 +472,10 @@ static int __init do_name(void)
>  	if (strcmp(collected, "TRAILER!!!") =3D=3D 0) {
>  		free_hash();
>  		return 0;
> +	} else if (strcmp(collected, METADATA_FILENAME) =3D=3D 0) {
> +		metadata =3D 1;
> +	} else {
> +		memcpy(previous_name_buf, collected, strlen(collected) + 1);
>  	}
>  	clean_path(collected, mode);
>  	if (S_ISREG(mode)) {

[Severity: High]
When collected matches METADATA_FILENAME in do_name(), metadata is set to 1,
but execution then falls through into clean_path(), maybe_link(), and
filp_open():

init/initramfs.c:do_name() {
	...
	if (S_ISREG(mode)) {
		int ml =3D maybe_link();
		if (ml >=3D 0) {
			int openflags =3D O_WRONLY|O_CREAT|O_LARGEFILE;
			if (ml !=3D 1)
				openflags |=3D O_TRUNC;
			wfile =3D filp_open(collected, openflags, mode);
			...
			state =3D CopyFile;
		}
	}
}

In do_copy(), xwrite() writes the raw metadata stream into wfile, and neith=
er
do_copy() nor unpack_to_rootfs() unlinks METADATA_FILENAME afterwards. Also,
if multiple METADATA!!! entries share the same inode number with nlink >=3D=
 2,
maybe_link() calls clean_path("METADATA!!!", 0) to unlink the file and then
calls init_link("METADATA!!!", "METADATA!!!"), which fails with -ENOENT and
returns -1.

Should METADATA!!! entries be consumed in memory without creating and leavi=
ng
behind a /METADATA!!! file in rootfs?

[Severity: High]
What happens if a METADATA_FILENAME entry does not transition state to
CopyFile in do_name()?

In do_name(), metadata =3D 1 is set before checking S_ISREG(mode), maybe_li=
nk(),
and filp_open(), while metadata is only reset to 0 inside
do_process_metadata() (called from do_copy()) or at the end of
unpack_to_rootfs().

If an entry named METADATA!!! is not a regular file, or if maybe_link()
returns -1, or if filp_open() returns an error, do_name() returns with state
left as SkipIt and metadata still set to 1. When the next regular file in t=
he
archive is processed by do_name(), the else branch updates previous_name_buf
without clearing metadata, causing do_copy() to pass that regular file's
contents to do_process_metadata() as metadata for itself.

Should metadata be reset at the start of do_name() or only set once the ent=
ry
is ready to be processed?

> @@ -508,11 +513,47 @@ static int __init do_name(void)
>  	return 0;
>  }
> =20
> +static int __init do_process_metadata(char *buf, int len, bool last)
> +{
> +	int ret =3D 0;
> +
> +	if (!metadata_buf) {
> +		metadata_buf_ptr =3D metadata_buf =3D kmalloc(body_len, GFP_KERNEL);
> +		if (!metadata_buf_ptr) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +
> +		metadata_len =3D body_len;
> +	}
> +
> +	if (metadata_buf_ptr + len > metadata_buf + metadata_len) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	memcpy(metadata_buf_ptr, buf, len);
> +	metadata_buf_ptr +=3D len;
> +
> +	if (last)
> +		do_parse_metadata(previous_name_buf);

[Severity: High]
When do_process_metadata() calls do_parse_metadata(), can the entry_size
bounds check wrap around on 32-bit architectures?

Looking at do_parse_metadata():

init/initramfs.c:do_parse_metadata() {
	...
		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
		ret =3D kstrtou32(str, 16, &entry_size);
		if (ret || buf + entry_size > bufend ||
		    entry_size < sizeof(*hdr)) {
			error("malformed xattrs");
			break;
		}

		switch (hdr->c_type) {
		case TYPE_XATTR:
			do_setxattrs(pathname, buf + sizeof(*hdr),
				     entry_size - sizeof(*hdr));
			break;
	...
}

Because entry_size is a 32-bit unsigned integer parsed from the 8-byte hex
hdr->c_size field, a large value such as 0xffffffff on a 32-bit system can
cause buf + entry_size to wrap around the address space to buf - 1, compari=
ng
less than or equal to bufend. That passes entry_size - sizeof(*hdr) to
do_setxattrs(), reading past the end of metadata_buf in strnlen() and
vfs_setxattr().

Should do_parse_metadata() check entry_size > bufend - buf instead of
buf + entry_size > bufend?

> +out:
> +	if (ret < 0 || last) {
> +		kfree(metadata_buf);
> +		metadata_buf =3D NULL;
> +		metadata =3D 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int __init do_copy(void)
>  {
>  	if (byte_count >=3D body_len) {
>  		if (xwrite(wfile, victim, body_len, &wfile_pos) !=3D body_len)
>  			error("write error");
> +		if (metadata)
> +			do_process_metadata(victim, body_len, true);
> =20
>  		do_utime_path(&wfile->f_path, mtime);
>  		fput(wfile);

[Severity: High]
In do_copy(), do_process_metadata(victim, body_len, true) is called before =
the
data checksum verification:

		if (csum_present && io_csum !=3D hdr_csum)
			error("bad data checksum");

In 070702 archives with csum_present, doesn't this parse and apply the xatt=
rs
via vfs_setxattr() before verifying that io_csum matches hdr_csum?

[ ... ]

> @@ -614,6 +658,7 @@ char * __init unpack_to_rootfs(char *buf, unsigned lo=
ng len)
>  		char header[CPIO_HDRLEN];
>  		char symlink[PATH_MAX + N_ALIGN(PATH_MAX) + 1];
>  		char name[N_ALIGN(PATH_MAX)];
> +		char prev_name[PATH_MAX + N_ALIGN(PATH_MAX) + 1];
>  	} *bufs =3D kmalloc_obj(*bufs);
> =20
>  	if (!bufs)
> @@ -622,6 +667,7 @@ char * __init unpack_to_rootfs(char *buf, unsigned lo=
ng len)
>  	header_buf =3D bufs->header;
>  	symlink_buf =3D bufs->symlink;
>  	name_buf =3D bufs->name;
> +	previous_name_buf =3D bufs->prev_name;

[Severity: High]
Can do_process_metadata() pass an uninitialized or stale previous_name_buf =
to
do_parse_metadata()?

In unpack_to_rootfs(), bufs is allocated with kmalloc_obj(*bufs) without
initializing bufs->prev_name. If METADATA!!! is the first entry in the
archive (or is preceded only by TRAILER!!! or entries skipped in do_header(=
)),
do_name() sets metadata =3D 1 without writing to previous_name_buf. When
do_process_metadata() then calls:

do_parse_metadata(previous_name_buf)
  -> do_setxattrs()
    -> kern_path(pathname, 0, &path)

kern_path() and pr_debug() read uninitialized memory from bufs->prev_name a=
nd
can read past the end of the slab allocation if no NUL terminator is presen=
t.

Similarly, if the entry immediately before METADATA!!! is skipped in
do_header() (for example when name_len > PATH_MAX, S_ISLNK(mode) with
body_len > PATH_MAX, or a non-regular non-symlink entry has body_len > 0) or
fails to be created in do_name(), previous_name_buf is not cleared and still
holds the pathname of an earlier file in the archive, so the metadata would=
 be
applied to the wrong file.

Should previous_name_buf be initialized (and cleared whenever an entry is
skipped or fails, or after metadata is consumed), and checked before parsing
metadata?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030210944.2143=
778-1-dannyhu@arista.com?part=3D3
